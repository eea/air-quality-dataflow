xquery version "3.0" encoding "UTF-8";
(:
 : Module Name: Implementing Decision 2011/850/EU: AQ info exchange & reporting (Library module)
 :
 : Version:     $Id$
 : Created:     9 November 2017
 : Copyright:   European Environment Agency
 :
 : XQuery script implements dataflow K checks.
 :
 : @author Claudia Ifrim
 :)

module namespace dataflowK = "http://converters.eionet.europa.eu/dataflowK";

import module namespace c = "aqd-common" at "aqd-common.xquery";
import module namespace html = "aqd-html" at "aqd-html.xquery";
import module namespace sparqlx = "aqd-sparql" at "aqd-sparql.xquery";
import module namespace labels = "aqd-labels" at "aqd-labels.xquery";
import module namespace vocabulary = "aqd-vocabulary" at "aqd-vocabulary.xquery";
import module namespace query = "aqd-query" at "aqd-query.xquery";
import module namespace errors = "aqd-errors" at "aqd-errors.xquery";
import module namespace filter = "aqd-filter" at "aqd-filter.xquery";
import module namespace dd = "aqd-dd" at "aqd-dd.xquery";
import module namespace schemax = "aqd-schema" at "aqd-schema.xquery";
import module namespace geox = "aqd-geo" at "aqd-geo.xquery";

declare namespace aqd = "http://dd.eionet.europa.eu/schemaset/id2011850eu-1.0";
declare namespace gml = "http://www.opengis.net/gml/3.2";
declare namespace am = "http://inspire.ec.europa.eu/schemas/am/3.0";
declare namespace ef = "http://inspire.ec.europa.eu/schemas/ef/3.0";
declare namespace base = "http://inspire.ec.europa.eu/schemas/base/3.3";
declare namespace ad = "urn:x-inspire:specification:gmlas:Addresses:3.0";
declare namespace gn = "urn:x-inspire:specification:gmlas:GeographicalNames:3.0";
declare namespace base2 = "http://inspire.ec.europa.eu/schemas/base2/1.0";
declare namespace xlink = "http://www.w3.org/1999/xlink";
declare namespace om = "http://www.opengis.net/om/2.0";
declare namespace swe = "http://www.opengis.net/swe/2.0";
declare namespace ompr="http://inspire.ec.europa.eu/schemas/ompr/2.0";
declare namespace sams="http://www.opengis.net/samplingSpatial/2.0";
declare namespace sam = "http://www.opengis.net/sampling/2.0";
declare namespace gmd = "http://www.isotc211.org/2005/gmd";
declare namespace gco = "http://www.isotc211.org/2005/gco";

declare namespace sparql = "http://www.w3.org/2005/sparql-results#";
declare namespace skos = "http://www.w3.org/2004/02/skos/core#";
declare namespace adms = "http://www.w3.org/ns/adms#";
declare namespace prop = "http://dd.eionet.europa.eu/property/";
declare namespace rdf = "http://www.w3.org/1999/02/22-rdf-syntax-ns#";

declare variable $dataflowK:ISO2_CODES as xs:string* := ("AL","AT","BA","BE","BG","CH","CY","CZ","DE","DK","DZ","EE","EG","ES","FI",
    "FR","GB","GR","HR","HU","IE","IL","IS","IT","JO","LB","LI","LT","LU","LV","MA","ME","MK","MT","NL","NO","PL","PS","PT",
     "RO","RS","SE","SI","SK","TN","TR","XK","UK");

declare variable $dataflowK:OBLIGATIONS as xs:string* := ($vocabulary:ROD_PREFIX || "683");

(: These attributes should be unique :)
declare variable $dataflowK:UNIQUE_IDS as xs:string* := (
  "gml:id",
  "ef:inspireId",
  "aqd:inspireId"
);

declare function dataflowK:findDuplicateAttributes(
  $elRoot as node(),
  $attrNames as xs:string*
) as xs:string* {

  for $attrName in $attrNames
    let $igna := trace($attrName, "attr name: ")
    let $c :=
      for $v in distinct-values($elRoot//descendant::*[name()=$attrName])
         let $ign := trace($v, 'value: ')
         let $x := trace(
           count($elRoot//descendant::*[$attrName=$v])
           , "count of: "
         )
         return $x

    return
      if (
        some $i in $c
        satisfies ($i > 1)
      )
      then
        $attrName
      else
        ()
};



(: Rule implementations :)
declare function dataflowK:checkReport($source_url as xs:string, $countryCode as xs:string) as element(table) {

let $envelopeUrl := c:getEnvelopeXML($source_url)
let $docRoot := doc($source_url)
let $cdrUrl := c:getCdrUrl($countryCode)
let $bdir := if (contains($source_url, "k_preliminary")) then "k_preliminary/" else "k/"
let $reportingYear := c:getReportingYear($docRoot)
let $latestEnvelopeB := query:getLatestEnvelope($cdrUrl || $bdir, $reportingYear)
let $nameSpaces := distinct-values($docRoot//base:namespace)
let $zonesNamespaces := distinct-values($docRoot//aqd:AQD_Zone/am:inspireId/base:Identifier/base:namespace)

let $latestEnvelopeByYearK := query:getLatestEnvelope($cdrUrl || "k/", $reportingYear)

let $namespaces := distinct-values($docRoot//base:namespace)
let $allMeasures := query:getAllMeasuresIds($namespaces)

(: File prefix/namespace check :)
let $NSinvalid :=
    try {
        let $XQmap := inspect:static-context((), 'namespaces')
        let $fileMap := map:merge((
            for $x in in-scope-prefixes($docRoot/*)
            return map:entry($x, string(namespace-uri-for-prefix($x, $docRoot/*)))))

        return map:for-each($fileMap, function($a, $b) {
            let $x := map:get($XQmap, $a)
            return
                if ($x != "" and not($x = $b)) then
                    <tr>
                        <td title="Prefix">{$a}</td>
                        <td title="File namespace">{$b}</td>
                        <td title="XQuery namespace">{$x}</td>
                    </tr>
                else
                    ()
        })
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: K0 :)
(:let $K0table :=
    try {
        let $all := dd:getValidConcepts($vocabulary:ZONETYPE_VOCABULARY || "rdf")
        for $x in $docRoot//aqd:aqdZoneType
        where not($x/@xlink:href = $all)
        return
            <tr>
                <td title="aqd:AQD_Zone">{string($x/../am:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:aqdZoneType">{data($x/@xlink:href)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }:)

(: K0 Checks if this delivery is new or an update (on same reporting year) :)
let $K0table :=
    try {
        if ($reportingYear = "") then
            <tr class="{$errors:ERROR}">
                <td title="Status">Reporting Year is missing.</td>
            </tr>
        else if (query:deliveryExists($dataflowK:OBLIGATIONS, $countryCode, "k/", $reportingYear)) then
            <tr class="{$errors:WARNING}">
                <td title="Status">Updating delivery for {$reportingYear}</td>
            </tr>
        else
            <tr class="{$errors:INFO}">
                <td title="Status">New delivery for {$reportingYear}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
let $isNewDelivery := errors:getMaxError($K0table) = $errors:INFO
let $knownMeasures :=
    if ($isNewDelivery) then
        distinct-values(data(sparqlx:run(query:getMeasures($cdrUrl || "k/"))//sparql:binding[@name='inspireLabel']/sparql:literal))
    else
        distinct-values(data(sparqlx:run(query:getMeasures($latestEnvelopeByYearK))//sparql:binding[@name='inspireLabel']/sparql:literal))

(: K01 Number of Measures reported :)
let $countMeasures := count($docRoot//aqd:AQD_Measures)
let $tblAllMeasures :=
    try {
        for $rec in $docRoot//aqd:AQD_Measures
        return
            <tr>
                <td title="gml:id">{data($rec/@gml:id)}</td>
                <td title="base:localId">{data($rec/aqd:inspireId/base:Identifier/base:localId)}</td>
                <td title="base:namespace">{data($rec/aqd:inspireId/base:Identifier/base:namespace)}</td>
                <td title="base:versionId">{data($rec/aqd:inspireId/base:Identifier/base:versionId)}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: K02 Compile & feedback upon the total number of new Measures records included in the delivery.
ERROR will be returned if XML is a new delivery and localId are not new compared to previous deliveries. :)
let $K02table :=
    try {
        for $x in $docRoot//aqd:AQD_Measures
        let $inspireId := concat(data($x/aqd:inspireId/base:Identifier/base:namespace), "/", data($x/aqd:inspireId/base:Identifier/base:localId))
        where (not($inspireId = $knownMeasures))
        return
            <tr>
                <td title="gml:id">{data($x/@gml:id)}</td>
                <td title="aqd:inspireId">{$inspireId}</td>
                <td title="aqd:classification">{c:checkLink(distinct-values(data($x/aqd:classification/@xlink:href)))}</td>
                <td title="aqd:measureType">{c:checkLink(distinct-values(data($x/aqd:measureType/@xlink:href)))}</td>
                <td title="aqd:administrativeLevel">{c:checkLink(distinct-values(data($x/aqd:administrativeLevel/@xlink:href)))}</td>
                <td title="aqd:timeScale">{c:checkLink(distinct-values(data($x/aqd:timeScale/@xlink:href)))}</td>
                <td title="aqd:sourceSectors">{c:checkLink(distinct-values(data($x/aqd:sourceSectors/@xlink:href)))}</td>
                <td title="aqd:exceedanceAffected">{c:checkLink(distinct-values(data($x/aqd:exceedanceAffected/@xlink:href)))}</td>
                <td title="aqd:usedForScenario">{c:checkLink(distinct-values(data($x/aqd:usedForScenario/@xlink:href)))}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
let $K02errorLevel :=
    if ($isNewDelivery and count(
        for $x in $docRoot//aqd:AQD_Measures
            let $id := $x/aqd:inspireId/base:Identifier/base:namespace || "/" || $x/aqd:inspireId/base:Identifier/base:localId
        where ($allMeasures = $id)
        return 1) > 0) then
            $errors:K02
        else
            $errors:INFO

(: K03 Compile & feedback upon the total number of updated Measures included in the delivery.
ERROR will be returned if XML is an update and ALL localId (100%) are different to previous delivery (for the same YEAR). :)
let $K03table :=
    try {
        for $x in $docRoot//aqd:AQD_Measures
        let $inspireId := concat(data($x/aqd:inspireId/base:Identifier/base:namespace), "/", data($x/aqd:inspireId/base:Identifier/base:localId))
        where ($inspireId = $knownMeasures)
        return
            <tr>
                <td title="gml:id">{data($x/@gml:id)}</td>
                <td title="aqd:inspireId">{$inspireId}</td>
                <td title="aqd:classification">{c:checkLink(distinct-values(data($x/aqd:classification/@xlink:href)))}</td>
                <td title="aqd:measureType">{c:checkLink(distinct-values(data($x/aqd:measureType/@xlink:href)))}</td>
                <td title="aqd:administrativeLevel">{c:checkLink(distinct-values(data($x/aqd:administrativeLevel/@xlink:href)))}</td>
                <td title="aqd:timeScale">{c:checkLink(distinct-values(data($x/aqd:timeScale/@xlink:href)))}</td>
                <td title="aqd:sourceSectors">{c:checkLink(distinct-values(data($x/aqd:sourceSectors/@xlink:href)))}</td>
                <td title="aqd:exceedanceAffected">{c:checkLink(distinct-values(data($x/aqd:exceedanceAffected/@xlink:href)))}</td>
                <td title="aqd:usedForScenario">{c:checkLink(distinct-values(data($x/aqd:usedForScenario/@xlink:href)))}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
let $K03errorLevel :=
    if (not($isNewDelivery) and count($K03table) = 0)  then
        $errors:K03
    else
        $errors:INFO

(: K04 Compile & feedback a list of the unique identifier information for all Measures records included in the delivery.
Feedback report shall include the gml:id attribute, ./aqd:inspireId, aqd:AQD_SourceApportionment (via ./exceedanceAffected), aqd:AQD_Scenario (via aqd:usedForScenario) :)
let $K04table :=
    try {
        let $gmlIds := $docRoot//aqd:AQD_Measures/lower-case(normalize-space(@gml:id))
        let $inspireIds := $docRoot//aqd:AQD_Measures/lower-case(normalize-space(aqd:inspireId))
        for $x in $docRoot//aqd:AQD_Measures
            let $id := $x/@gml:id
            let $inspireId := $x/aqd:inspireId
            let $aqdinspireId := concat($x/aqd:inspireId/base:Identifier/base:localId, "/", $x/aqd:inspireId/base:Identifier/base:namespace)
        where count(index-of($gmlIds, lower-case(normalize-space($id)))) = 1
                    and count(index-of($inspireIds, lower-case(normalize-space($inspireId)))) = 1
        return
            <tr>
                <td title="gml:id">{data($x/@gml:id)}</td>
                <td title="aqd:inspireId">{distinct-values($aqdinspireId)}</td>
                <td title="aqd:AQD_SourceApportionment">{c:checkLink(distinct-values(data($x/aqd:exceedanceAffected/@xlink:href)))}</td>
                <td title="aqd:AQD_Scenario">{c:checkLink(distinct-values(data($x/aqd:usedForScenario/@xlink:href)))}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: K08 ./aqd:inspireId/base:Identifier/base:localId must be unique code for the Measure records :)
let $K08invalid:=
    try {
        let $localIds := $docRoot//aqd:AQD_Measures/aqd:inspireId/base:Identifier/lower-case(normalize-space(base:localId))
        for $x in $docRoot//aqd:AQD_Measures
            let $localID := $x/aqd:inspireId/base:Identifier/base:localId
            let $aqdinspireId := concat($x/aqd:inspireId/base:Identifier/base:localId, "/", $x/aqd:inspireId/base:Identifier/base:namespace)
        where (count(index-of($localIds, lower-case(normalize-space($localID)))) > 1 and not(empty($localID)))
        return
            <tr>
                <td title="gml:id">{data($x/@gml:id)}</td>
                <td title="aqd:inspireId">{distinct-values($aqdinspireId)}</td>
                <td title="aqd:AQD_SourceApportionment">{c:checkLink(distinct-values(data($x/aqd:exceedanceAffected/@xlink:href)))}</td>
                <td title="aqd:AQD_Scenario">{c:checkLink(distinct-values(data($x/aqd:usedForScenario/@xlink:href)))}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: K09 ./aqd:inspireId/base:Identifier/base:namespace List base:namespace and count the number of base:localId assigned to each base:namespace.  :)
let $K09table :=
    try {
        for $namespace in distinct-values($docRoot//aqd:AQD_Measures/aqd:inspireId/base:Identifier/base:namespace)
            let $localIds := $docRoot//aqd:AQD_Measures/aqd:inspireId/base:Identifier[base:namespace = $namespace]/base:localId

        return
            <tr>
                <td title="base:namespace">{$namespace}</td>
                <td title="base:localId">{count($localIds)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: K10 Check that namespace is registered in vocabulary (http://dd.eionet.europa.eu/vocabulary/aq/namespace/view) :)

(: TODO: should be "and" or "or" in where clause?? :)
let $K10invalid :=
    try {
        let $vocDoc := doc($vocabulary:NAMESPACE || "rdf")
        let $prefLabel := $vocDoc//skos:Concept[adms:status/@rdf:resource = $dd:VALIDRESOURCE and @rdf:about = concat($vocabulary:NAMESPACE, $countryCode)]/skos:prefLabel[1]
        let $altLabel := $vocDoc//skos:Concept[adms:status/@rdf:resource = $dd:VALIDRESOURCE and @rdf:about = concat($vocabulary:NAMESPACE, $countryCode)]/skos:altLabel[1]
        for $x in distinct-values($docRoot//base:namespace)
        where (not($x = $prefLabel) and not($x = $altLabel))
        return
            <tr>
                <td title="base:namespace">{$x}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: TODO: requirement not clear :)
(: K11 aqd:AQD_Measures/aqd:exceedanceAffected MUST reference an existing Source Apportionment (I) document via namespace/localId :)

(: K13 aqd:AQD_Measures/aqd:code must be unique and should match base:localId

Unique code of the measure. This may be a unique local code for the measure or
may be identical to the unique code used in K2.1.


TODO: we implemented just first line of the requirement, the second line
contradicts it
:)

let $K13invalid :=
  try {
    for $node in $docRoot//aqd:AQD_Measures
      let $code := $node/aqd:code
      let $localId := $node/aqd:inspireId/base:Identifier/base:localId
    return
      if ($code ne $localId)
      then
        <tr>
            <td title="aqd:code">{$code}</td>
            <td title="base:localId">{$localId}</td>
        </tr>
      else
        ()
  }  catch * {
      <tr class="{$errors:FAILED}">
          <td title="Error code">{$err:code}</td>
          <td title="Error description">{$err:description}</td>
      </tr>
  }


(: K14 aqd:AQD_Measures/aqd:name must be populated with a text string
A short name for the measure :)
let $aqdname := $docRoot//aqd:AQD_Measures/aqd:name
let $K14invalid := c:needsValidString($docRoot//aqd:AQD_Measures, 'aqd:name')

(: K15 aqd:AQD_Measures/aqd:name must be populated with a text string
A short name for the measure :)
let $K15invalid := c:needsValidString($docRoot//aqd:AQD_Measures, 'aqd:description')

let $errorLevel := 'error'

(: K16 aqd:AQD_Measures/aqd:classification shall resolve to the codelist http://dd.eionet.europa.eu/vocabulary/aq/measureclassification/
Measure classification should conform to vocabulary :)
let $K16 := c:isInVocabularyReport(
        $docRoot//aqd:AQD_Measures/aqd:classification,
        $vocabulary:MEASURECLASSIFICATION_VOCABULARY
        )

(: K17 aqd:AQD_Measures/aqd:measureType shall resolve to the codelist http://dd.eionet.europa.eu/vocabulary/aq/measuretype/
Measure type should conform to vocabulary :)
let $K17 := c:isInVocabularyReport(
        $docRoot//aqd:AQD_Measures/aqd:measureType,
        $vocabulary:MEASURETYPE_VOCABULARY
        )


(: K18 aqd:AQD_Measures/aqd:administrativeLevel shall resolve to the codelist
http://dd.eionet.europa.eu/vocabulary/aq/administrativelevel/
Administrative level should conform to vocabulary
:)
let $K18 := c:isInVocabularyReport(
        $docRoot//aqd:AQD_Measures/aqd:administrativeLevel,
        $vocabulary:ADMINISTRATIVE_LEVEL_VOCABULARY
        )

(: K19
aqd:AQD_Measures/aqd:timeScale shall resolve to the codelist http://dd.eionet.europa.eu/vocabulary/aq/timescale/
The measure's timescale should conform to vocabulary
:)
let $K19 := c:isInVocabularyReport(
        $docRoot//aqd:AQD_Measures/aqd:timeScale,
        $vocabulary:TIMESCALE_VOCABULARY
        )


(: K20 aqd:AQD_Measures/aqd:costs/ should be provided
Information on the cost of the measure should be provided
:)
let $K20 := c:isNodeNotInParentReport($docRoot//aqd:AQD_Measures, 'aqd:costs')


(: K21
If aqd:costs provided
aqd:AQD_Measures/aqd:costs/aqd:Costs/aqd:estimatedImplementationCosts should be
an integer number. If voided /aqd:AQD_Measures/aqd:costs/aqd:Costs/aqd:comment
must be populated with an explanation of why no costs are available.

The estimated total costs should be provided. If not, an explanation on the
reasons for not providing it should be included.
:)

let $K21 :=
try {
    let $root := $docRoot//aqd:AQD_Measures
    let $implCosts := $root/aqd:costs/aqd:Costs/aqd:estimatedImplementationCosts
    let $comment := $root/aqd:costs/aqd:Costs/aqd:comment/text()
    let $costsRoot := $docRoot//aqd:AQD_Measures/aqd:costs/aqd:Costs

    let $isValidCost := c:is-a-number(data($implCosts))
    let $hasCost := c:isNodeInParent($costsRoot, 'aqd:estimatedImplementationCosts')

    return
        if (c:isNodeInParent($root, 'aqd:costs'))
        then (
            if (not($isValidCost))
            then
                if (empty($comment))
                then
                    if ($hasCost)
                    then
                        (
                         <tr> <td title="aqd:estimatedImplementationCosts">{$errors:K21}</td> </tr>
                        )
                    else
                        ( <tr><td title="aqd:comment">{$errors:K21}</td></tr>)
                else
                    ()  (: ok, we have a comment :)
            else
                ()      (: ok, cost is a number :)
        )
        else
            <tr><td title="acq:costs">{$errors:K21}</td></tr>

} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: K22
If populated,
/aqd:AQD_Measures/aqd:costs/aqd:Costs/aqd:finalImplementationCosts should be an
integer number
If the final total costs of the measure is provided, this nneeds to be a number

let $K22 := c:maybeNodeValueIsIntegerReport(
    $docRoot//aqd:AQD_Measures/aqd:costs/aqd:Costs,
    'aqd:finalImplementationCosts'
)
:)

let $K22 := c:validatePossibleNodeValueReport(
    $docRoot//aqd:AQD_Measures/aqd:costs/aqd:Costs,
    'aqd:finalImplementationCosts',
    c:is-a-number#1
)

(: K23
If aqd:AQD_Measures/aqd:costs/aqd:Costs/aqd:estimatedImplementationCosts is
populated aqd:AQD_Measures/aqd:costs/aqd:Costs/aqd:currency must be populated
and shall resolve to the codelist
http://dd.eionet.europa.eu/vocabulary/common/currencies/

If estimated costs are provided, the currency must be provided conforming to
vocabulary

:)

let $K23 := c:validateMaybeNodeWithValueReport(
    $docRoot//aqd:AQD_Measures/aqd:costs/aqd:Costs,
    'aqd:estimatedImplementationCosts',
    c:isInVocabulary(
        $docRoot//aqd:AQD_Measures/aqd:costs/aqd:Costs/aqd:currency,
        $vocabulary:CURRENCIES
    )
)


(: K24
aqd:AQD_Measures/aqd:sourceSectors shall resolve to the codelist http://dd.eionet.europa.eu/vocabulary/aq/sourcesectors/

Source sector should conform to vocabulary
:)

let $K24 := c:isInVocabularyReport(
    $docRoot//aqd:AQD_Measures/aqd:sourceSectors,
    $vocabulary:SOURCESECTORS_VOCABULARY
    )

(: K25
aqd:AQD_Measures/aqd:spatialScale shall resolve to the codelist http://dd.eionet.europa.eu/vocabulary/aq/spatialscale/

Spatial scale should conform to vocabulary
:)

let $K25 := c:isInVocabularyReport(
    $docRoot//aqd:AQD_Measures/aqd:spatialScale,
    $vocabulary:SPACIALSCALE_VOCABULARY
    )

(: K26
aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:status shall resolve to the codelist
http://dd.eionet.europa.eu/vocabulary/aq/measureimplementationstatus/

Measure Implementation Status should conform to vocabulary
:)

let $K26 := c:isInVocabularyReport(
    $docRoot//aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:status,
    $vocabulary:MEASUREIMPLEMENTATIONSTATUS_VOCABULARY
    )

(: K27
aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:implementationPlannedTimePeriod/gml:TimePeriod/gml:beginPosition
must be a date in full ISO date format

The planned start date for the measure should be provided
:)

let $K27 := c:isDateFullISOReport(
    $docRoot//aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:implementationPlannedTimePeriod/gml:TimePeriod/gml:beginPosition
)

(: K28
If not voided, aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:implementationPlannedTimePeriod/gml:TimePeriod/gml:endPosition
must be a date in full ISO format
and must be after aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:implementationPlannedTimePeriod/gml:TimePeriod/gml:beginPosition.
If voided it should be indeterminatePosition="unknown"

The planned end  date for the measure should be provided in the right format,
if unknown voided using indeterminatePosition="unknown"
:)

let $K28 :=
try {
    let $begin := $docRoot//aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:implementationPlannedTimePeriod/gml:TimePeriod/gml:beginPosition
    let $end := $docRoot//aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:implementationPlannedTimePeriod/gml:TimePeriod/gml:endPosition

    return
    if (c:isEndDateAfterBeginDate(
        $begin,
        $end)
    )
    then
        ()
    else
        <tr>
            <td title="indeterminatePosition">unknown</td>
            <td title="gml:beginPosition">{data($begin)}</td>
            <td title="gml:endPosition">{data($end)}</td>
        </tr>
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: K29
aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:implementationActualTimePeriod/gml:TimePeriod/gml:beginPosition must be a date in full ISO date format

The planned start date for the measure should be provided
:)
let $K29 := c:isDateFullISOReport(
        $docRoot//aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:implementationActualTimePeriod/gml:TimePeriod/gml:beginPosition
)

(: K30
If not voided, aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:implementationActualTimePeriod/gml:TimePeriod/gml:endPosition must be a date in full ISO format
and must be after aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:implementationActualTimePeriod/gml:TimePeriod/gml:beginPosition.

If voided it should be indeterminatePosition="unknown" 	The planned end  date for the measure should be provided in the right format,
if unknown voided using indeterminatePosition="unknown"
:)
let $K30 :=
try {
    let $begin := $docRoot//aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:implementationActualTimePeriod/gml:TimePeriod/gml:beginPosition
    let $end := $docRoot//aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:implementationActualTimePeriod/gml:TimePeriod/gml:endPosition

    return
    if (c:isEndDateAfterBeginDate(
        $begin,
        $end)
    )
    then
        ()
    else
        <tr>
            <td title="indeterminatePosition">unknown</td>
            <td title="gml:beginPosition">{data($begin)}</td>
            <td title="gml:endPosition">{data($end)}</td>
        </tr>
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: K31
aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:plannedFullEffectDate/gml:TimeInstant/gml:timePosition
to be provided in the following format yyyy or yyyy-mm-dd

The full effect date of the measure must be provided and the format to be yyyy or yyyy-mm-dd
:)

let $K31 := ()

(: validateNodeReport(node, validator) :)

(: K07 -
All attributes
  - gml:id
  - ef:inspireId
  - aqd:inspireId
elements shall have unique content
:)

(:~ Given a seq of attribute names, returns a seq of names for the attributes
where the values are not unique.

Usage: find attributes that are not unique but need to be unique (for ex: ids)
:)


(:
let $K07base := (
  count(dataflowK:findDuplicateAttributes($docRoot,
                                          $dataflowK:UNIQUE_IDS)) > 0
)
:)

(:let $K07base := dataflowK:findDuplicateAttributes(
  $docRoot, $dataflowK:UNIQUE_IDS
)

let $K07table := (
<tr>
  <td>
  hello
  {
  for $k in $K07base
    return
      <div>Duplicate: {$k}</div>
  }
  world
  </td>
</tr>
)


let $K07invalid := ()
let $K07errorLevel := $errors:INFO:)

(: {html:buildSimple("K07", $labels:K07, $labels:K07_SHORT, $K07table, "", "", $K07errorLevel)} :)

return
(
    <table class="maintable hover">
        {html:build2("NS", $labels:NAMESPACES, $labels:NAMESPACES_SHORT, $NSinvalid, "All values are valid", "record", $errors:NS)}
        {html:build3("K0", $labels:K0, $labels:K0_SHORT, $K0table, string($K0table/td), errors:getMaxError($K0table))}
        {html:build1("K01", $labels:K01, $labels:K01_SHORT, $tblAllMeasures, "", string($countMeasures), "", "", $errors:K01)}
        {html:buildSimple("K02", $labels:K02, $labels:K02_SHORT, $K02table, "", "", $K02errorLevel)}
        {html:buildSimple("K03", $labels:K03, $labels:K03_SHORT, $K03table, "", "", $K03errorLevel)}
        {html:build1("K04", $labels:K04, $labels:K04_SHORT, $K04table, "", string(count($K04table)), " ", "", $errors:K04)}
        {html:build2("K08", $labels:K08, $labels:K08_SHORT, $K08invalid, "No duplicate values found", " duplicate value", $errors:K08)}
        {html:buildUnique("K09", $labels:K09, $labels:K09_SHORT, $K09table, "namespace", $errors:K09)}
        {html:build2("K10", $labels:K10, $labels:K10_SHORT, $K10invalid, "All values are valid", " invalid namespaces", $errors:K10)}

        {html:build2("K13", $labels:K13, $labels:K13_SHORT, $K13invalid, "All values are valid", " code not equal", $errors:K13)}
        {html:build2("K14", $labels:K14, $labels:K14_SHORT, $K14invalid, "All values are valid", "needs valid input", $errors:K14)}
        {html:build2("K15", $labels:K15, $labels:K15_SHORT, $K15invalid, "All values are valid", "needs valid input", $errors:K15)}
        {html:build2("K16", $labels:K16, $labels:K16_SHORT, $K16, "All values are valid", "not conform to vocabulary",$errors:K16)}
        {html:build2("K17", $labels:K17, $labels:K17_SHORT, $K17, "All values are valid", "not conform to vocabulary",$errors:K17)}
        {html:build2("K18", $labels:K18, $labels:K18_SHORT, $K18, "All values are valid", "not conform to vocabulary",$errors:K18)}
        {html:build2("K19", $labels:K19, $labels:K19_SHORT, $K19, "All values are valid", "not conform to vocabulary", $errors:K19)}
        {html:build2("K20", $labels:K20, $labels:K20_SHORT, $K20, "All values are valid", " needs valid input", $errors:K20)}
        {html:build2("K21", $labels:K21, $labels:K21_SHORT, $K21, "All values are valid", " needs valid input", $errors:K21)}
        {html:build2("K22", $labels:K22, $labels:K22_SHORT, $K22, "All values are valid", " needs valid input", $errors:K22)}
        {html:build2("K23", $labels:K23, $labels:K23_SHORT, $K23, "All values are valid", " needs valid input", $errors:K23)}
        {html:build2("K24", $labels:K24, $labels:K24_SHORT, $K24, "All values are valid", "not conform to vocabulary", $errors:K24)}
        {html:build2("K25", $labels:K25, $labels:K25_SHORT, $K25, "All values are valid", "not conform to vocabulary", $errors:K25)}
        {html:build2("K26", $labels:K26, $labels:K26_SHORT, $K26, "All values are valid", "not conform to vocabulary", $errors:K26)}
        {html:build2("K27", $labels:K27, $labels:K27_SHORT, $K27, "All values are valid", "not full ISO format", $errors:K27)}
        {html:build2("K28", $labels:K28, $labels:K28_SHORT, $K28, "All values are valid", "not valid", $errors:K28)}
        {html:build2("K29", $labels:K29, $labels:K29_SHORT, $K29, "All values are valid", "not full ISO format", $errors:K29)}
        {html:build2("K30", $labels:K30, $labels:K30_SHORT, $K30, "All values are valid", "not valid", $errors:K30)}

        <tr>
        <td colspan="4">
        <div>
        {
            $docRoot//aqd:AQD_Measures/aqd:costs
        }
        </div>
        </td>
        </tr>

    </table>
)

};

declare function dataflowK:proceed($source_url as xs:string, $countryCode as xs:string) as element(div) {

let $countZones := count(doc($source_url)//aqd:AQD_Measures)
let $result := if ($countZones > 0) then dataflowK:checkReport($source_url, $countryCode) else ()
let $meta := map:merge((
    map:entry("count", $countZones),
    map:entry("header", "Check air quality zones"),
    map:entry("dataflow", "Dataflow K"),
    map:entry("zeroCount", <p>No aqd:AQD_Measures elements found in this XML.</p>),
    map:entry("report", <p>This check evaluated the delivery by executing tier-1 tests on air quality zones data in Dataflow K as specified in <a href="http://www.eionet.europa.eu/aqportal/qaqc/">e-reporting QA/QC rules documentation</a>.</p>)
))
return
    html:buildResultDiv($meta, $result)
};
