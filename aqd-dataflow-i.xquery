xquery version "3.0" encoding "UTF-8";
(:
 : Module Name: Implementing Decision 2011/850/EU: AQ info exchange & reporting (Library module)
 :
 : Version:     $Id$
 : Created:     9 November 2017
 : Copyright:   European Environment Agency
 :
 : XQuery script implements dataflow I checks.
 :
 : @author Claudia Ifrim
 :)

module namespace dataflowI = "http://converters.eionet.europa.eu/dataflowI";

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
import module namespace functx = "http://www.functx.com" at "functx-1.0-doc-2007-01.xq";

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

declare variable $dataflowI:ISO2_CODES as xs:string* := ("AL","AT","BA","BE","BG","CH","CY","CZ","DE","DK","DZ","EE","EG","ES","FI",
    "FR","GB","GR","HR","HU","IE","IL","IS","IT","JO","LB","LI","LT","LU","LV","MA","ME","MK","MT","NL","NO","PL","PS","PT",
     "RO","RS","SE","SI","SK","TN","TR","XK","UK");

declare variable $dataflowI:OBLIGATIONS as xs:string* :=
    ($vocabulary:ROD_PREFIX || "681");

(: Rule implementations :)
declare function dataflowI:checkReport(
    $source_url as xs:string,
    $countryCode as xs:string
) as element(table) {

    let $envelopeUrl := c:getEnvelopeXML($source_url)
    let $docRoot := doc($source_url)
    let $cdrUrl := c:getCdrUrl($countryCode)

    let $reportingYear := c:getReportingYear($docRoot)
    let $namespaces := distinct-values($docRoot//base:namespace)

    let $latestEnvelopeByYearI := query:getLatestEnvelope($cdrUrl || "i/", $reportingYear)

    let $node-name := 'aqd:AQD_SourceApportionment'
    let $sources := $docRoot//aqd:AQD_SourceApportionment
    let $allSources := query:sparql-objects-ids($namespaces, $node-name)

    (: NS Check
    Check prefix and namespaces of the gml:featureCollection according to
    expected root elements (More information at
    http://www.eionet.europa.eu/aqportal/datamodel)

    File prefix/namespace check

    BLOCKER
    :)
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
            html:createErrorRow($err:code, $err:description)
        }

    (: I0 Check
    Check if delivery if this is a new delivery or updated delivery (via
    reporting year)

    Checks if this delivery is new or an update (on same reporting year)

    WARNING
    :)

    let $I0table :=
        try {
            if ($reportingYear = "") then
                <tr class="{$errors:ERROR}">
                    <td title="Status">Reporting Year is missing.</td>
                </tr>
            else if (query:deliveryExists($dataflowI:OBLIGATIONS, $countryCode, "i/", $reportingYear)) then
                <tr class="{$errors:WARNING}">
                    <td title="Status">Updating delivery for {$reportingYear}</td>
                </tr>
            else
                <tr class="{$errors:INFO}">
                    <td title="Status">New delivery for {$reportingYear}</td>
                </tr>
        } catch * {
            html:createErrorRow($err:code, $err:description)
        }

    let $isNewDelivery := errors:getMaxError($I0table) = $errors:INFO

    let $deliveries := sparqlx:run(
        query:sparql-objects-in-subject($cdrUrl || "g/", $node-name)
    )//sparql:binding[@name='inspireLabel']/sparql:literal

    let $latest-delivery := sparqlx:run(
        query:sparql-objects-in-subject(
            $latestEnvelopeByYearI,
            $node-name
        )
    )//sparql:binding[@name='inspireLabel']/sparql:literal

    let $knownSources :=
        if ($isNewDelivery) then
            distinct-values(data($deliveries))
        else
            distinct-values(data($latest-delivery))

    (: I1

    Compile & feedback upon the total number of Source Apportionments included
    in the delivery

    Number of Source Apportionments reported
    :)
    let $countSources := count($sources)
    let $tblAllSources :=
        try {
            for $rec in $sources
            return
                <tr>
                    <td title="gml:id">{data($rec/@gml:id)}</td>
                    <td title="base:localId">{data($rec/aqd:inspireId/base:Identifier/base:localId)}</td>
                    <td title="base:namespace">{data($rec/aqd:inspireId/base:Identifier/base:namespace)}</td>
                </tr>
        }  catch * {
            html:createErrorRow($err:code, $err:description)
        }

    (: I02

    Compile & feedback upon the total number of new  Source Apportionments
    records included in the delivery. ERROR will be returned if XML is a new
    delivery and localId are not new compared to previous deliveries.

    Number of new  Source Apportionments compared to previous report. ERROR
    will be returned if XML is a new delivery and localId are not new compared
    to previous deliveries

    BLOCKER

    :)
    let $I02table :=
        try {
            for $x in $sources
            let $inspireId := concat(
                data($x/aqd:inspireId/base:Identifier/base:namespace),
                "/",
                data($x/aqd:inspireId/base:Identifier/base:localId)
            )
            where (not($inspireId = $knownSources))
            return
                <tr>
                    <td title="gml:id">{data($x/@gml:id)}</td>
                    <td title="aqd:inspireId">{$inspireId}</td>
                </tr>
        } catch * {
            html:createErrorRow($err:code, $err:description)
        }
    let $I02errorLevel :=
        if ($isNewDelivery and count(
            for $x in $sources
                let $id := $x/aqd:inspireId/base:Identifier/base:namespace
                            || "/"
                            || $x/aqd:inspireId/base:Identifier/base:localId
            where ($allSources = $id)
            return 1) > 0) then
                $errors:I02
            else
                $errors:INFO

    (: I03

    Compile & feedback upon the total number of updated Source Apportionments
    included in the delivery. ERROR will be returned if XML is an update and
    ALL localId (100%) are different to previous delivery (for the same YEAR).

    Number of existing Plans compared to previous report. ERROR will be
    returned if XML is an update and ALL localId (100%) are different to
    previous delivery (for the same YEAR).

    BLOCKER

    TODO: please check

    - :)
    let $I03table :=
        try {
            for $x in $sources
            let $inspireId := data($x/aqd:inspireId/base:Identifier/base:namespace)
                                ||  "/"
                                || data($x/aqd:inspireId/base:Identifier/base:localId)
            where ($inspireId = $knownSources)
            return
                <tr>
                    <td title="gml:id">{data($x/@gml:id)}</td>
                    <td title="aqd:inspireId">{$inspireId}</td>
                </tr>
        } catch * {
            html:createErrorRow($err:code, $err:description)
        }
    let $I03errorLevel :=
        if (not($isNewDelivery) and count($I03table) = 0) then
            $errors:I03
        else
            $errors:INFO

    (: I04

    Compile & feedback a list of the unique identifier information for all
    Source Apportionments records included in the delivery. Feedback report
    shall include the:

    * gml:id attribute,
    * ./aqd:inspireId,
    * aqd:AQD_Plan (via ./usedInPlan),
    * aqd:AQD_Attainment (via aqd:parentExceedanceSituation),
    * aqd:pollutant (via Attainment link under aqd:parentExceedanceSituation)

    List of unique identifier information for all Source Apportionments
    records. Error, if no SA(s)

    BLOCKER

    :)
    let $I04table :=
        try {
            let $gmlIds := $sources/lower-case(normalize-space(@gml:id))
            let $inspireIds := $sources/lower-case(normalize-space(aqd:inspireId))

            for $x in $sources
                let $id := $x/@gml:id
                let $inspireId := $x/aqd:inspireId
                let $aqdinspireId := concat($x/aqd:inspireId/base:Identifier/base:localId, "/", $x/aqd:inspireId/base:Identifier/base:namespace)
                let $one-gmlid := count(index-of($gmlIds, lower-case(normalize-space($id)))) = 1
                let $one-inspireid := count(index-of($inspireIds, lower-case(normalize-space($inspireId)))) = 1

                let $att-url := $x/aqd:parentExceedanceSituation/@xlink:href
                let $pollutant-code := query:get-pollutant-for-attainment($att-url)
                let $pollutant := dd:getNameFromPollutantCode($pollutant-code)

            where $one-gmlid and $one-inspireid
            return
                <tr>
                    <td title="gml:id">
                        {distinct-values($x/@gml:id)}
                    </td>
                    <td title="aqd:inspireId">
                        {distinct-values($aqdinspireId)}
                    </td>
                    <td title="aqd:usedInPlan">
                        {c:checkLink(distinct-values(data($x/aqd:usedInPlan/@xlink:href)))}
                    </td>
                    <td title="aqd:parentExceedanceSituation">
                        {c:checkLink(distinct-values(data($att-url)))}
                    </td>
                    <td title="aqd:pollutant">{$pollutant}</td>
                </tr>
        } catch * {
            html:createErrorRow($err:code, $err:description)
        }

    (: I05 reserved :)
    let $I05 := ()

    (: I06 reserved :)
    let $I06 := ()

    (: I07

    All gml:id attributes, ef:inspireId and aqd:inspireId elements shall have
    unique content

    All gml ID attributes shall have unique code

    BLOCKER

    :)
    let $I07 := try {
        let $checks := ('gml:id', 'aqd:inspireId', 'ef:inspireId')

        let $errors := array {

            for $name in $checks
                let $name := lower-case(normalize-space($name))
                let $values := $sources//(*[lower-case(normalize-space(name())) = $name] |
                                            @*[lower-case(normalize-space(name())) = $name])
                return
                    for $v in distinct-values($values)
                        return
                            if (c:has-one-node($values, $v))
                            then
                                ()
                            else
                                [$name, data($v)]
        }
        return c:conditionalReportRow(
            array:size($errors) = 0,
            $errors
        )
    } catch * {
        html:createErrorRow($err:code, $err:description)
    }

    (: I08

    ./aqd:inspireId/base:Identifier/base:localId must be unique code for the
    Plans records

    Local Id must be unique for the Plans records

    BLOCKER
    :)
    let $I08invalid:= try {
        let $localIds := $sources/aqd:inspireId/base:Identifier/lower-case(normalize-space(base:localId))
        for $x in $sources
            let $localID := $x/aqd:inspireId/base:Identifier/base:localId
            let $aqdinspireId := concat($x/aqd:inspireId/base:Identifier/base:localId, "/", $x/aqd:inspireId/base:Identifier/base:namespace)
            let $ok := (
                count(index-of($localIds, lower-case(normalize-space($localID)))) = 1
                and
                functx:if-empty($localID/text(), "") != ""
            )
            return c:conditionalReportRow(
                $ok,
                [
                    ("gml:id", data($x/@gml:id)),
                    ("aqd:inspireId", distinct-values($aqdinspireId))
                ]
            )
    } catch * {
        html:createErrorRow($err:code, $err:description)
    }


    (: I09

    ./aqd:inspireId/base:Identifier/base:namespace

    List base:namespace and count the number of base:localId assigned to each
    base:namespace.

    List unique namespaces used and count number of elements

    BLOCKER
    :)

    let $I09table := try {
        for $namespace in distinct-values($sources/aqd:inspireId/base:Identifier/base:namespace)
            let $localIds := $sources/aqd:inspireId/base:Identifier[base:namespace = $namespace]/base:localId
            let $ok := false()
            return c:conditionalReportRow(
                $ok,
                [
                    ("base:namespace", $namespace),
                    ("base:localId count", count($localIds))
                ]
            )
    } catch * {
        html:createErrorRow($err:code, $err:description)
    }

    (: I10

    Check that namespace is registered in vocabulary
    (http://dd.eionet.europa.eu/vocabulary/aq/namespace/view)

    Check namespace is registered

    ERROR
    :)

    let $I10invalid := try {

        let $vocDoc := doc($vocabulary:NAMESPACE || "rdf")
        let $concept := $vocDoc//skos:Concept[
            adms:status/@rdf:resource = $dd:VALIDRESOURCE
            and
            @rdf:about = concat($vocabulary:NAMESPACE, $countryCode)
        ]
        let $prefLabel := $concept/skos:prefLabel[1]
        let $altLabel := $concept/skos:altLabel[1]

        for $x in distinct-values($docRoot//base:namespace)
            let $ok := ($x = $prefLabel and $x = $altLabel)
            return c:conditionalReportRow(
                $ok,
                [
                    ("base:namespace", $x)
                ]
            )
    } catch * {
        html:createErrorRow($err:code, $err:description)
    }

    (: I11

    aqd:AQD_SourceApportionment/aqd:usedInPlan shall reference an existing
    H document for the same reporting year same year via namespace/localId

    You must provide a reference to a plan document from data flow H via its
    namespace & localId. The plan document must have the same reporting year as
    the source apportionment document.

    BLOCKER
    :)
    let $I11 := try{
        for $el in $sources/aqd:usedInPlan

            let $label := data($el/@xlink:href)
            let $ok := query:existsViaNameLocalIdYear(
                $label,
                'AQD_Plan',
                $reportingYear
            )

        return c:conditionalReportRow(
            $ok,
            [
                (node-name($el), $el/@xlink:href)
            ]
        )
    } catch * {
        html:createErrorRow($err:code, $err:description)
    }


    (: I11b

    aqd:AQD_SourceApportionment/aqd:parentExceedanceSituation shall reference
    an existing exceedance situation delivered within a data flow G  and the
    reporting year of G & I shall be the same year via namespace/localId.

    You must provide a reference to an exceedance situation from data flow G.
    The exceedance situation must have the same reporting year as the source
    apportionment and refer to the same pollutant.

    TODO: this needs to be implemented properly

    BLOCKER
    :)
    let $I11b := try{
        for $el in $sources/aqd:parentExceedanceSituation
            let $label := data($el/@xlink:href)
            let $ok := query:existsViaNameLocalId($label, 'AQD_Attainment')
            (:
            aqd:AQD_Attainment[aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription]
            :)

            (: TODO: check that the reporting year is for same year :)

        return c:conditionalReportRow(
            $ok,
            [
                (node-name($el), $el/@xlink:href)
            ]
        )
    } catch * {
        html:createErrorRow($err:code, $err:description)
    }

    (: I12

    aqd:AQD_SourceApportionment/aqd:referenceYear/gml:TimeInstant/gml:timePosition
    shall be a calendar year in yyyy format

    Reference year must be a calendar year in yyyy format

    BLOCKER
    :)

    let $I12 := try {
        for $el in $sources/aqd:referenceYear/gml:TimeInstant/gml:timePosition
            let $ok := $el castable as xs:gYear

        return c:conditionalReportRow(
            $ok,
            [
                (node-name($el), data($el))
            ]
        )
    } catch * {
        html:createErrorRow($err:code, $err:description)
    }

    (: I13, I14 are missing in xls file :)

    (: I15

    Across all the delivery, check that the element
    aqd:QuantityCommented/aqd:quantity is
    * an integer or
    * floating point numeric >= 0
    if attribute xsi:nil="false"
    (example:
        <aqd:quantity uom="http://dd.eionet.europa.eu/vocabulary/uom/concentration/ug.m-3" xsi:nil="false">4.03038</aqd:quantity>
    )

    Source apportionments should be provided as an integer

    BLOCKER
    :)
    let $I15 := try {
        let $nodes := $sources//aqd:QuantityCommented/aqd:quantity[@xsi:nil="false"]
        let $errors := array {
            for $node in $nodes
            return
                if (not(c:is-a-number(data($node))))
                then
                    [node-name($node), data($node)]
                else
                    ()
        }

        return c:conditionalReportRow(
            array:size($errors) = 0,
            $errors
        )
    } catch * {
        html:createErrorRow($err:code, $err:description)
    }

    (: I16

    Across all the delivery, check that the element
    aqd:QuantityCommented/aqd:quantity is empty
    if attribute xsi:nil="unpopulated" or "unknown" or "withheld"
    (example:
    <aqd:quantity uom="Unknown" nilReason="Unpopulated" xsi:nil="true"/>
    )

    If quantification is either "unpopulated" or "unknown" or "withheld",
    the element should be empty

    BLOCKER
    :)

    let $I16 := try {
        for $node in $docRoot//aqd:QuantityCommented/aqd:quantity
            let $reason := $node/@nilReason
            let $isnil := lower-case($node/@xsi:nil) = "true"
            let $unpop := lower-case($reason) = ("unknown", "unpopulated", "withheld")

            let $ok :=
                if ($isnil)
                then
                    functx:all-whitespace($node) and $unpop
                else
                    true()

        return c:conditionalReportRow(
            $ok,
            [
                (node-name($node), data($node)),
                (name($node/@nilReason), data($node/@nilReason))
            ]
        )
    } catch * {
        html:createErrorRow($err:code, $err:description)
    }

    (: I17

    Across all the delivery, If aqd:QuantityCommented/aqd:quantity attribute
    xsi:nil="true" aqd:QuantityCommented/aqd:comment must be populated

    If the quantification is voided an explanation is required in aqd:comment

    TODO: fix this
    ERROR
    :)

    let $I17 := try {
        for $el in $docRoot//aqd:QuantityCommented
            let $isnil := $el/aqd:quantity[@xsi:nil = "true"]
            let $hascomment := not(functx:all-whitespace($el/aqd:comment))

            let $ok := ($isnil and $hascomment) or true()

        return c:conditionalReportRow(
            $ok,
            [
                (node-name($el), "needs comment")
            ]
        )
    } catch * {
        html:createErrorRow($err:code, $err:description)
    }


    (: I18

    Across all the delivery, check that the unit attribute
    (.../aqd:QuantityCommented/aqd:quantity@uom)
    corresponds to the recommended unit (via vocabulary) of the
    pollutant found at aqd:AQD_Attainment/aqd:pollutant xlink:href attribute
    for the
    AQD_Attainment record cited by ./aqd:parentExceedanceSituation

    The unit of measurement of the Source Apportioment must match recommended
    unit for the pollutant

                let $polutant := data($node/aqd:usedInPlan/@xlink:href)
                let $uom-term := dd:get-uri-for-term($uom)

    TODO: check code, implement checks

    BLOCKER
    :)

    let $I18 := try {

        let $errors := array {
            for $x in $sources
                let $quants := $x//aqd:QuantityCommented/aqd:quantity
                let $uom := $quants/@uom
                let $att-url := data($x/aqd:parentExceedanceSituation/@xlink:href)
                let $pollutant-code := query:get-pollutant-for-attainment($att-url)
                let $pollutant := dd:getNameFromPollutantCode($pollutant-code)
                let $rec-uom := dd:getRecommendedUnit($pollutant-code)

                return
                    if ($uom != $rec-uom)
                    then
                        [node-name($x), $uom]
                    else
                        ()
        }

        return c:conditionalReportRow(
            array:size($errors) = 0,
            $errors
        )
    } catch * {
        html:createErrorRow($err:code, $err:description)
    }

    (: I19

    aqd:AQD_SourceApportionment/aqd:regionalBackground/aqd:RegionalBackground/aqd:total/aqd:QuantityCommented/aqd:quantity
    must equal to the sum of
    aqd:regionalBackground/aqd:RegionalBackground/aqd:fromWithinMS/aqd:QuantityCommented/aqd:quantity
    + aqd:regionalBackground/aqd:RegionalBackground/aqd:transboundary/aqd:QuantityCommented/aqd:quantity
    + aqd:regionalBackground/aqd:RegionalBackground/aqd:natural/aqd:QuantityCommented/aqd:quantity
    + aqd:regionalBackground/aqd:RegionalBackground/aqd:other/aqd:QuantityCommented/aqd:quantity

    The total regional background source contribution must be equal to the sum
    of its components.

    BLOCKER

    :)

    let $I19 := try {
        let $errors := array {
            for $x in $sources
                let $rb := $x/aqd:regionalBackground/aqd:RegionalBackground
                let $total := data($rb/aqd:total/aqd:QuantityCommented/aqd:quantity)
                let $sum := sum((
                    $rb/aqd:fromWithinMS/aqd:QuantityCommented/aqd:quantity,
                    $rb/aqd:transboundary/aqd:QuantityCommented/aqd:quantity,
                    $rb/aqd:natural/aqd:QuantityCommented/aqd:quantity,
                    $rb/aqd:other/aqd:QuantityCommented/aqd:quantity
                ))

                let $ok := $sum = $total

            return
                if (not($ok))
                then
                    [node-name($x), $x]
                else
                    ()
        }
        return c:conditionalReportRow(
            array:size($errors) = 0,
            $errors
        )
    } catch * {
        html:createErrorRow($err:code, $err:description)
    }

    (: I20

    aqd:AQD_SourceApportionment/aqd:urbanBackground/aqd:UrbanBackground/aqd:total/aqd:QuantityCommented/aqd:quantity
    must equal the sum of
      aqd:urbanBackground/aqd:UrbanBackground/aqd:traffic/aqd:QuantityCommented/aqd:quantity
    + aqd:urbanBackground/aqd:UrbanBackground/aqd:heatAndPowerProduction/aqd:QuantityCommented/aqd:quantity
    + aqd:urbanBackground/aqd:UrbanBackground/aqd:agriculture/aqd:QuantityCommented/aqd:quantity
    + aqd:urbanBackground/aqd:UrbanBackground/aqd:commercialAndResidential/aqd:QuantityCommented/aqd:quantity
    + aqd:urbanBackground/aqd:UrbanBackground/aqd:shipping/aqd:QuantityCommented/aqd:quantity
    + aqd:urbanBackground/aqd:UrbanBackground/aqd:offRoadMobileMachinery/aqd:QuantityCommented/aqd:quantity
    + aqd:urbanBackground/aqd:UrbanBackground/aqd:natural/aqd:QuantityCommented/aqd:quantity
    + aqd:urbanBackground/aqd:UrbanBackground/aqd:transboundary/aqd:QuantityCommented/aqd:quantity
    + aqd:urbanBackground/aqd:UrbanBackground/aqd:other/aqd:QuantityCommented/aqd:quantity

    The total urban background source contribution must be equal to the sum of its components.

    BLOCKER

    :)

    let $I20 := try {
        let $errors := array {
            for $x in $sources
                let $ub := $x/aqd:urbanBackground/aqd:UrbanBackground
                let $total := data($ub/aqd:total/aqd:QuantityCommented/aqd:quantity)
                let $sum := sum((
                    $ub/aqd:traffic/aqd:QuantityCommented/aqd:quantity,
                    $ub/aqd:heatAndPowerProduction/aqd:QuantityCommented/aqd:quantity,
                    $ub/aqd:agriculture/aqd:QuantityCommented/aqd:quantity,
                    $ub/aqd:commercialAndResidential/aqd:QuantityCommented/aqd:quantity,
                    $ub/aqd:shipping/aqd:QuantityCommented/aqd:quantity,
                    $ub/aqd:offRoadMobileMachinery/aqd:QuantityCommented/aqd:quantity,
                    $ub/aqd:natural/aqd:QuantityCommented/aqd:quantity,
                    $ub/aqd:transboundary/aqd:QuantityCommented/aqd:quantity,
                    $ub/aqd:other/aqd:QuantityCommented/aqd:quantity
                ))

                let $ok := $total = $sum

            return
                if (not($ok))
                then
                    [node-name($x), $x]
                else
                    ()
        }
        return c:conditionalReportRow(
            array:size($errors) = 0,
            $errors
        )
    } catch * {
        html:createErrorRow($err:code, $err:description)
    }

    (: I21

    aqd:AQD_SourceApportionment/aqd:localIncrement/aqd:LocalIncrement/aqd:total/aqd:QuantityCommented/aqd:quantity
    must equal to the sum of
    aqd:localIncrement/aqd:LocalIncrement/aqd:traffic/aqd:QuantityCommented/aqd:quantity
    + aqd:localIncrement/aqd:LocalIncrement/aqd:heatAndPowerProduction/aqd:QuantityCommented/aqd:quantity
    + aqd:localIncrement/aqd:LocalIncrement/aqd:agriculture/aqd:QuantityCommented/aqd:quantity
    + aqd:localIncrement/aqd:LocalIncrement/aqd:commercialAndResidential/aqd:QuantityCommented/aqd:quantity
    + aqd:localIncrement/aqd:LocalIncrement/aqd:shipping/aqd:QuantityCommented/aqd:quantity
    + aqd:localIncrement/aqd:LocalIncrement/aqd:offRoadMobileMachinery/aqd:QuantityCommented/aqd:quantity
    + aqd:localIncrement/aqd:LocalIncrement/aqd:natural/aqd:QuantityCommented/aqd:quantity
    + aqd:localIncrement/aqd:LocalIncrement/aqd:transboundary/aqd:QuantityCommented/aqd:quantity
    + aqd:localIncrement/aqd:LocalIncrement/aqd:other/aqd:QuantityCommented/aqd:quantity

    The total local increment source contribution must be equal to the sum of
    its components.

    BLOCKER

    :)

    let $I21 := try {
        let $errors := array {
            for $x in $sources
                let $li := $x/aqd:localIncrement/aqd:LocalIncrement
                let $total := data($li/aqd:total/aqd:QuantityCommented/aqd:quantity)
                let $sum := sum((
                    $li/aqd:heatAndPowerProduction/aqd:QuantityCommented/aqd:quantity,
                    $li/aqd:agriculture/aqd:QuantityCommented/aqd:quantity,
                    $li/aqd:commercialAndResidential/aqd:QuantityCommented/aqd:quantity,
                    $li/aqd:shipping/aqd:QuantityCommented/aqd:quantity,
                    $li/aqd:offRoadMobileMachinery/aqd:QuantityCommented/aqd:quantity,
                    $li/aqd:natural/aqd:QuantityCommented/aqd:quantity,
                    $li/aqd:transboundary/aqd:QuantityCommented/aqd:quantity,
                    $li/aqd:other/aqd:QuantityCommented/aqd:quantity
                ))

                let $ok := $total = $sum
            return
                if (not($ok))
                then
                    [node-name($x), $x]
                else
                    ()
        }
        return c:conditionalReportRow(
            array:size($errors) = 0,
            $errors
        )
    } catch * {
        html:createErrorRow($err:code, $err:description)
    }



    (: I22

    aqd:AQD_SourceApportionment/aqd:macroExceedanceSituation must be presented
    and must not be an empty tag

    The macro exceedance situation relevant to the source apportionment must be
    populated

    Blocker

    :)

    let $I22 := try {
        let $errors := array {
            for $x in $sources
                let $ok := not(empty($x/aqd:macroExceedanceSituation))

            return
                if (not($ok))
                then
                    [node-name($x), $x]
                else
                    ()
        }
        return c:conditionalReportRow(
            array:size($errors) = 0,
            $errors
        )
    } catch * {
        html:createErrorRow($err:code, $err:description)
    }


    (: I23

    Either
    aqd:AQD_SourceApportionment/aqd:macroExceedanceSituation/aqd:numericalExceedance
    OR
    aqd:AQD_SourceApportionment/aqd:macroExceedanceSituation/aqd:numberExceedances
    must be provided (just one or the other) AS an integer or floating point
    numeric > 0, no more that 2 decimal places expected

    numericalExceedance or numberExceedances must be provided

    ERROR

    TODO: check a better replacement for is-a-number

    :)
    let $I23 := try {
        let $errors := array {
            for $x in $sources
                let $a := data($x/aqd:macroExceedanceSituation/aqd:numericalExceedance)
                let $b := data($x/aqd:macroExceedanceSituation/aqd:numberExceedances)

                let $ok := c:is-a-number($a) or c:is-a-number($b)

            return
                if (not($ok))
                then
                    [node-name($x), $x]
                else
                    ()
        }
        return c:conditionalReportRow(
            array:size($errors) = 0,
            $errors
        )
    } catch * {
        html:createErrorRow($err:code, $err:description)
    }

    (: I24

    The content of
    /aqd:macroExceedanceSituation/aqd:ExceedanceDescription/aqd:exceedanceArea/aqd:ExceedanceArea/aqd:areaClassification
    xlink:xref must be provided and must resolve to a areaClassification in
    http://dd.eionet.europa.eu/vocabulary/aq/areaclassification/

    Area Classification is mandatory and must conform to vocabulary

    BLOCKER

    :)
    let $I24 := c:isInVocabularyReport(
        $sources/aqd:macroExceedanceSituation/aqd:ExceedanceDescription/aqd:exceedanceArea/aqd:ExceedanceArea/aqd:areaClassification,
        $vocabulary:AREA_CLASSIFICATION_VOCABULARY
    )

    (: I25

    aqd:AQD_SourceApportionment/aqd:macroExceedanceSituation/aqd:ExceedanceDescription/aqd:exceedanceArea/aqd:ExceedanceArea/aqd:areaClassification
    xlink:href attribute shall match those
    /aqd:AQD_Attainment/aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:exceedanceArea/aqd:ExceedanceArea/aqd:areaClassification
    xlink:href attribute for the AQD_Attainment record cited by
    ./aqd:parentExceedanceSituation

    Area classification should match classification declared in the
    corresponding Attainment

    WARNING

    :)

    let $I25 := ()

    (: I26
    /aqd:macroExceedanceSituation/aqd:ExceedanceDescription/aqd:exceedanceArea/aqd:ExceedanceArea/aqd:surfaceArea
    uom attribute shall resolve to
    http://dd.eionet.europa.eu/vocabulary/uom/area/km2

    Exceedence area uom attribute must be in Square kilometers.

    ERROR
    :)

    let $I26 := ()
    (: I27

    /aqd:macroExceedanceSituation/aqd:ExceedanceDescription/aqd:exceedanceArea/aqd:ExceedanceArea/aqd:roadLength
    uom attribute shall be http://dd.eionet.europa.eu/vocabulary/uom/length/km

    Exceedence area uom attribute must be in Square kilometers.

    ERROR
    :)
    let $I27 := ()

    let $I28 := ()

    (: I29

    ./aqd:macroExceedanceSituation/aqd:ExceedanceDescription/aqd:exceedanceArea/aqd:ExceedanceArea/aqd:stationUsed
    OR
    ./aqd:macroExceedanceSituation/aqd:ExceedanceDescription/aqd:exceedanceArea/aqd:ExceedanceArea/aqd:modelUsed
    must be populated

    A link to the exceeding SamplingPoint(s) and/or Model(s) must be provided
    [at least one]

    ERROR

    :)
    let $I29 := ()

    (: I30

    If, aqd:stationUsed and/or aqd:modelUsed are populated, these must be valid
    elements:
    stationUsed must link To SamplingPoint via namespace/localid
    modelUsed must link to AQD_Model via namespace/ localid

    If SamplingPoint(s) and/or Model(s) are provided, these must be valid

    ERROR
    :)
    let $I30 := ()
    let $I31 := ()
    let $I32 := ()
    let $I33 := ()
    let $I34 := ()
    let $I35 := ()
    let $I36 := ()
    let $I37 := ()
    let $I38 := ()
    let $I39 := ()
    let $I40 := ()
    let $I41 := ()
    let $I42 := ()
    let $I43 := ()
    let $I44 := ()
    let $I45 := ()

    return
        <table class="maintable hover">

        {html:build2("NS", $labels:NAMESPACES, $labels:NAMESPACES_SHORT, $NSinvalid, "All values are valid", "record", $errors:NS)}
        {html:build3("I0", $labels:I0, $labels:I0_SHORT, $I0table, string($I0table/td), errors:getMaxError($I0table))}
        {html:build1("I01", $labels:I01, $labels:I01_SHORT, $tblAllSources, "", string($countSources), "", "", $errors:I01)}
        {html:buildSimple("I02", $labels:I02, $labels:I02_SHORT, $I02table, "", "report", $I02errorLevel)}
        {html:buildSimple("I03", $labels:I03, $labels:I03_SHORT, $I03table, "", "", $I03errorLevel)}
        {html:build1("I04", $labels:I04, $labels:I04_SHORT, $I04table, "", string(count($I04table)), " ", "", $errors:I04)}
        {html:build1("I05", $labels:I05, $labels:I05_SHORT, $I05, "RESERVE", "RESERVE", "RESERVE", "RESERVE", $errors:I05)}
        {html:build1("I06", $labels:I06, $labels:I06_SHORT, $I06, "RESERVE", "RESERVE", "RESERVE", "RESERVE", $errors:I06)}
        {html:build2("I07", $labels:I07, $labels:I07_SHORT, $I07, "No duplicate values found", " duplicate value", $errors:I07)}
        {html:build2("I08", $labels:I08, $labels:I08_SHORT, $I08invalid, "No duplicate values found", " duplicate value", $errors:I08)}
        {html:build2("I09", $labels:I09, $labels:I09_SHORT, $I09table, "namespace", "", $errors:I09)}
        (: TODO: I don't think the label is ok here :)
        {html:build2("I10", $labels:I10, $labels:I10_SHORT, $I10invalid, "All values are valid", " not conform to vocabulary", $errors:I10)}

        {html:build2("I11", $labels:I11, $labels:I11_SHORT, $I11,
                     "All values are valid", "needs valid input", $errors:I11a)}
        {html:build2("I11b", $labels:I11b, $labels:I11b_SHORT, $I11b,
                     "All values are valid", "needs valid input", $errors:I11b)}

        {html:build2("I12", $labels:I12, $labels:I12_SHORT, $I12, "All values are valid", "needs valid input", $errors:I12)}
        {html:build2("I15", $labels:I15, $labels:I15_SHORT, $I15, "All values are valid", "needs valid input", $errors:I15)}
        {html:build2("I16", $labels:I16, $labels:I16_SHORT, $I16, "All values are valid", "needs valid input", $errors:I16)}
        {html:build2("I17", $labels:I17, $labels:I17_SHORT, $I17, "All values are valid", "needs valid input", $errors:I17)}
        {html:build2("I18", $labels:I18, $labels:I18_SHORT, $I18, "All values are valid", "needs valid input", $errors:I18)}
        {html:build2("I19", $labels:I19, $labels:I19_SHORT, $I19, "All values are valid", "needs valid input", $errors:I19)}
        {html:build2("I21", $labels:I21, $labels:I21_SHORT, $I21, "All values are valid", "needs valid input", $errors:I21)}
        {html:build2("I22", $labels:I22, $labels:I22_SHORT, $I22, "All values are valid", "needs valid input", $errors:I22)}
        {html:build2("I23", $labels:I23, $labels:I23_SHORT, $I23, "All values are valid", "needs valid input", $errors:I23)}
        {html:build2("I24", $labels:I24, $labels:I24_SHORT, $I24, "All values are valid", "needs valid input", $errors:I24)}
        {html:build2("I25", $labels:I25, $labels:I25_SHORT, $I25, "All values are valid", "needs valid input", $errors:I25)}
        {html:build2("I26", $labels:I26, $labels:I26_SHORT, $I26, "All values are valid", "needs valid input", $errors:I26)}
        {html:build2("I27", $labels:I27, $labels:I27_SHORT, $I27, "All values are valid", "needs valid input", $errors:I27)}
        (: 28 is missing in XLS
        {html:build2("I28", $labels:I28, $labels:I28_SHORT, $I28, "All values are valid", "needs valid input", $errors:I28)}
        :)
        {html:build2("I29", $labels:I29, $labels:I29_SHORT, $I29, "All values are valid", "needs valid input", $errors:I29)}
        {html:build2("I30", $labels:I30, $labels:I30_SHORT, $I30, "All values are valid", "needs valid input", $errors:I30)}
        {html:build2("I31", $labels:I31, $labels:I31_SHORT, $I31, "All values are valid", "needs valid input", $errors:I31)}
        {html:build2("I32", $labels:I32, $labels:I32_SHORT, $I32, "All values are valid", "needs valid input", $errors:I32)}
        {html:build2("I33", $labels:I33, $labels:I33_SHORT, $I33, "All values are valid", "needs valid input", $errors:I33)}
        {html:build2("I34", $labels:I34, $labels:I34_SHORT, $I34, "All values are valid", "needs valid input", $errors:I34)}
        {html:build2("I35", $labels:I35, $labels:I35_SHORT, $I35, "All values are valid", "needs valid input", $errors:I35)}
        {html:build2("I36", $labels:I36, $labels:I36_SHORT, $I36, "All values are valid", "needs valid input", $errors:I36)}
        {html:build2("I37", $labels:I37, $labels:I37_SHORT, $I37, "All values are valid", "needs valid input", $errors:I37)}
        {html:build2("I38", $labels:I38, $labels:I38_SHORT, $I38, "All values are valid", "needs valid input", $errors:I38)}
        {html:build2("I39", $labels:I39, $labels:I39_SHORT, $I39, "All values are valid", "needs valid input", $errors:I39)}
        {html:build2("I40", $labels:I40, $labels:I40_SHORT, $I40, "All values are valid", "needs valid input", $errors:I40)}
        {html:build2("I41", $labels:I41, $labels:I41_SHORT, $I41, "All values are valid", "needs valid input", $errors:I41)}
        {html:build2("I42", $labels:I42, $labels:I42_SHORT, $I42, "All values are valid", "needs valid input", $errors:I42)}
        {html:build2("I43", $labels:I43, $labels:I43_SHORT, $I43, "All values are valid", "needs valid input", $errors:I43)}
        {html:build2("I44", $labels:I44, $labels:I44_SHORT, $I44, "All values are valid", "needs valid input", $errors:I44)}
        {html:build2("I45", $labels:I45, $labels:I45_SHORT, $I45, "All values are valid", "needs valid input", $errors:I45)}

        (:
        :)

    </table>
};


declare function dataflowI:proceed(
    $source_url as xs:string,
    $countryCode as xs:string
) as element(div) {

    let $countZones := count(doc($source_url)//aqd:AQD_SourceApportionment)
    let $result := if ($countZones > 0) then dataflowI:checkReport($source_url, $countryCode) else ()
    let $meta := map:merge((
        map:entry("count", $countZones),
        map:entry("header", "Check air quality zones"),
        map:entry("dataflow", "Dataflow I"),
        map:entry("zeroCount", <p>No aqd:AQD_SourceApportionment elements found in this XML.</p>),
        map:entry("report", <p>This check evaluated the delivery by executing tier-1 tests on air quality zones data in Dataflow I as specified in <a href="http://www.eionet.europa.eu/aqportal/qaqc/">e-reporting QA/QC rules documentation</a>.</p>)
    ))
    return
        html:buildResultDiv($meta, $result)
};
