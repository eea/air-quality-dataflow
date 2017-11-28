xquery version "3.0" encoding "UTF-8";
(:
 : Module Name: Implementing Decision 2011/850/EU: AQ info exchange & reporting (Library module)
 :
 : Version:     $Id$
 : Created:     9 November 2017
 : Copyright:   European Environment Agency
 :
 : XQuery script implements dataflow H checks.
 :
 : @author Claudia Ifrim
 :)

module namespace dataflowH = "http://converters.eionet.europa.eu/dataflowH";

import module namespace common = "aqd-common" at "aqd-common.xquery";
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

declare variable $dataflowH:ISO2_CODES as xs:string* := ("AL","AT","BA","BE","BG","CH","CY","CZ","DE","DK","DZ","EE","EG","ES","FI",
    "FR","GB","GR","HR","HU","IE","IL","IS","IT","JO","LB","LI","LT","LU","LV","MA","ME","MK","MT","NL","NO","PL","PS","PT",
     "RO","RS","SE","SI","SK","TN","TR","XK","UK");

declare variable $dataflowH:OBLIGATIONS as xs:string* := ($vocabulary:ROD_PREFIX || "680");

(: Rule implementations :)
declare function dataflowH:checkReport($source_url as xs:string, $countryCode as xs:string) as element(table) {

let $envelopeUrl := common:getEnvelopeXML($source_url)
let $docRoot := doc($source_url)
let $cdrUrl := common:getCdrUrl($countryCode)
let $reportingYear := common:getReportingYear($docRoot)
let $latestEnvelopeByYearH := query:getLatestEnvelope($cdrUrl || "k/", $reportingYear)

let $nameSpaces := distinct-values($docRoot//base:namespace)

(: File prefix/namespace check :)
let $NSinvalid := try {
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

(: H0 Checks if this delivery is new or an update (on same reporting year) :)

let $H0 := try {
    if ($reportingYear = "")
    then
        common:checkDeliveryReport($errors:ERROR, "Reporting Year is missing.")
    else
        if (query:deliveryExists($dataflowH:OBLIGATIONS, $countryCode, "h/", $reportingYear))
        then
            common:checkDeliveryReport($errors:WARNING, "Updating delivery for " || $reportingYear)
        else
            common:checkDeliveryReport($errors:INFO, "New delivery for " || $reportingYear)
} catch * {
    html:createErrorRow($err:code, $err:description)
}

let $isNewDelivery := errors:getMaxError($H0) = $errors:INFO

(: H01 Number of AQ Plans reported :)

let $countPlans := count($docRoot//aqd:AQD_Plan)
let $H01 := try {
    for $rec in $docRoot//aqd:AQD_Plan
    let $el := $rec/aqd:inspireId/base:Identifier
    return
        common:conditionalReportRow(
                false(),
                [
                ("gml:id", data($rec/@gml:id)),
                ("base:localId", data($el/base:localId)),
                ("base:namespace", data($el/base:namespace)),
                ("base:versionId", data($el/base:versionId))
                ]
        )

} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: H03 Number of existing Plans compared to previous report (same reporting year). Blocker will be returned if
XML is an update and ALL localId (100%) are different to previous delivery (for the same YEAR). :)

let $H03 := try {
    let $main := $docRoot//aqd:AQD_Plan
    for $x in $main/aqd:inspireId/base:Identifier
    let $inspireId := concat(data($x/base:namespace), "/", data($x/base:localId))
    let $ok := not(query:existsViaNameLocalId($inspireId, 'AQD_Plan'))
    return
        common:conditionalReportRow(
                $ok,
                [
                ("gml:id", data($main/@gml:id)),
                ("aqd:inspireId", $inspireId)
                ]
        )
} catch * {
    html:createErrorRow($err:code, $err:description)
}
let $H03errorLevel :=
    if (not($isNewDelivery) and count($H03) = 0)
    then
        $errors:K03
    else
        $errors:INFO

(: H4

Compile & feedback a list of the unique identifier information for all Plans records included in the delivery.
Feedback report shall include the gml:id attribute, ./aqd:inspireId, ./aqd:pollutant, ./aqd:protectionTarget,
/gml:FeatureCollection/gml:featureMember/aqd:AQD_Plan/aqd:firstExceedanceYear,


List of unique identifier information for all Plan records. Blocker if no Plans.
:)

let $H04 := try {
    let $gmlIds := $docRoot//aqd:AQD_Plan/lower-case(normalize-space(@gml:id))
    let $inspireIds := $docRoot//aqd:AQD_Plan/lower-case(normalize-space(aqd:inspireId))
    for $x in $docRoot//aqd:AQD_Plan
    let $id := $x/@gml:id
    let $inspireId := $x/aqd:inspireId
    let $aqdinspireId := concat($x/aqd:inspireId/base:Identifier/base:localId, "/", $x/aqd:inspireId/base:Identifier/base:namespace)
    let $ok := (count(index-of($gmlIds, lower-case(normalize-space($id)))) = 1
            and
            count(index-of($inspireIds, lower-case(normalize-space($inspireId)))) = 1
    )
    return common:conditionalReportRow(
            not($ok),
            [
            ("gml:id", data($x/@gml:id)),
            ("aqd:inspireId", distinct-values($aqdinspireId)),
            ("aqd:pollutant", data($x/aqd:pollutant)),
            ("aqd:protectionTarget", data($x/aqd:protectionTarget)),
            ("aqd:firstExceedanceYear", data($x/aqd:firstExceedanceYear))
            ]
    )
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: H05 RESERVE :)

let $H05 := ()

(: H06 RESERVE :)

let $H06 := ()

(: H07

    All gml:id attributes, ef:inspireId and aqd:inspireId elements shall have
    unique content

    All gml ID attributes shall have unique code

    BLOCKER
:)

let $H07 := try {
    let $checks := ('gml:id', 'aqd:inspireId', 'ef:inspireId')

    let $errors := array {

        for $name in $checks
        let $name := lower-case(normalize-space($name))
        let $values := $docRoot//aqd:AQD_Plan//(*[lower-case(normalize-space(name())) = $name] |
                @*[lower-case(normalize-space(name())) = $name])
        return
            for $v in distinct-values($values)
            return
                if (common:has-one-node($values, $v))
                then
                    ()
                else
                    [$name, data($v)]
    }
    return common:conditionalReportRow(
            array:size($errors) = 0,
            $errors
    )
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: H08

    ./aqd:inspireId/base:Identifier/base:localId must be unique code for the
    Plans records

    Local Id must be unique for the Plans records

    BLOCKER
:)

let $H08:= try {
    let $localIds := $docRoot//aqd:AQD_Plan/aqd:inspireId/base:Identifier/lower-case(normalize-space(base:localId))
    for $x in $docRoot//aqd:AQD_Plan
    let $localID := $x/aqd:inspireId/base:Identifier/base:localId
    let $aqdinspireId := concat($x/aqd:inspireId/base:Identifier/base:localId, "/", $x/aqd:inspireId/base:Identifier/base:namespace)
    let $ok := (
        count(index-of($localIds, lower-case(normalize-space($localID)))) = 1
                and
                functx:if-empty($localID/text(), "") != ""
    )
    return common:conditionalReportRow(
            $ok,
            [
            ("gml:id", data($x/@gml:id)),
            ("aqd:inspireId", distinct-values($aqdinspireId))
            ]
    )
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: H09
 ./aqd:inspireId/base:Identifier/base:namespace List base:namespace
 and count the number of base:localId assigned to each base:namespace.

 List unique namespaces used and count number of elements
:)

let $H09 := try {
    for $namespace in distinct-values($docRoot//aqd:AQD_Plan/aqd:inspireId/base:Identifier/base:namespace)
    let $localIds := $docRoot//aqd:AQD_Plan/aqd:inspireId/base:Identifier[base:namespace = $namespace]/base:localId
    let $ok := false()
    return common:conditionalReportRow(
            $ok,
            [
            ("base:namespace", $namespace),
            ("base:localId", count($localIds))
            ]
    )
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: H10
Check that namespace is registered in vocabulary (http://dd.eionet.europa.eu/vocabulary/aq/namespace/view)

Check namespace is registered
:)

let $H10 := try {
    let $vocDoc := doc($vocabulary:NAMESPACE || "rdf")
    let $prefLabel := $vocDoc//skos:Concept[adms:status/@rdf:resource = $dd:VALIDRESOURCE
            and @rdf:about = concat($vocabulary:NAMESPACE, $countryCode)]/skos:prefLabel[1]
    let $altLabel := $vocDoc//skos:Concept[adms:status/@rdf:resource = $dd:VALIDRESOURCE
            and @rdf:about = concat($vocabulary:NAMESPACE, $countryCode)]/skos:altLabel[1]
    for $x in distinct-values($docRoot//base:namespace)
    let $ok := (
        $x = $prefLabel
                and
                $x = $altLabel
    )
    return common:conditionalReportRow(
            $ok,
            [
            ("base:namespace", $x)
            ]
    )
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: H13 RESERVE :)

let $H13 := ()

(: H14
aqd:AQD_Plan/aqd:code should begin with with the 2-digit country code according to ISO 3166-1.

We recommend you start you codes with the 2-digit country code according to ISO 3166-1.
:)

let $H14 := try {
    let $el := $docRoot//aqd:AQD_Plan/aqd:code
    let $ok := fn:lower-case($countryCode) = fn:lower-case(fn:substring(data($el), 1, 2))
    return common:conditionalReportRow(
            $ok,
            [
            (node-name($el), $el)
            ]
    )
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: H15 RESERVE :)

let $H15 := ()

(: H30
aqd:AQD_Plan/aqd:publication/aqd:Publication/aqd:description must contain a text string describing the publication

Brief textual description of the published AQ Plan should be provided. If available, include the ISBN number.
:)

let $H30 := try {
    let $main := $docRoot//aqd:AQD_Plan/aqd:publication/aqd:Publication/aqd:description
    for $el in $main
    let $ok := (data($el) castable as xs:string
            and
            functx:if-empty(data($el), "" != "")
    )
    return common:conditionalReportRow(
            $ok,
            [
            (node-name($el), $el)
            ]
    )
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: H31
aqd:AQD_Plan/aqd:publication/aqd:Publication/aqd:title must contain the title of the publication

Title as written in the published AQ Plan.
:)

let $H31 := try {
    let $main := $docRoot//aqd:AQD_Plan/aqd:publication/aqd:Publication/aqd:title
    for $el in $main
    let $ok := (data($el) castable as xs:string
            and
            functx:if-empty(data($el), "" != "")
    )
    return common:conditionalReportRow(
            $ok,
            [
            (node-name($el), $el)
            ]
    )
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: H32
aqd:AQD_Plan/aqd:publication/aqd:Publication/aqd:author must contain the author(s) of the publication

Author(s) should be provided as text (If there are multiple authors, please provide in one field separated by commas)
:)

let $H32 := try {
    let $main := $docRoot//aqd:AQD_Plan/aqd:publication/aqd:Publication/aqd:author
    for $el in $main
    let $ok := (data($el) castable as xs:string
            and
            functx:if-empty(data($el), "" != "")
    )
    return common:conditionalReportRow(
            $ok,
            [
            (node-name($el), $el)
            ]
    )
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: H33
aqd:AQD_Plan/aqd:publication/aqd:Publication/aqd:publicationDate/gml:TimeInstant/gml:timePosition must contaong the
date of publication in yyyy-mm-dd format

The publication date of the AQ Plan should be provided in yyyy or yyyy-mm-dd format
:)

let $H33 := try {
    let $main := $docRoot//aqd:AQD_Plan/aqd:publication/aqd:Publication/aqd:publicationDate/gml:TimeInstant/gml:timePosition
    for $node in $main
    let $ok := (
        $node castable as xs:date
                or
                $node castable as xs:gYear
    )
    return common:conditionalReportRow(
            $ok,
            [
            (node-name($node), data($node))
            ]
    )
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: H34
aqd:AQD_Plan/aqd:publication/aqd:Publication/aqd:publisher must container a text string describing the publisher

Publisher should be provided as a text (Publishing institution, academic jourmal, etc.)
:)

let $H34 := try {
    let $main := $docRoot//aqd:AQD_Plan/aqd:publication/aqd:Publication/aqd:publisher
    for $el in $main
    let $ok := (data($el) castable as xs:string
            and
            functx:if-empty(data($el), "" != "")
    )
    return common:conditionalReportRow(
            $ok,
            [
            (node-name($el), $el)
            ]
    )
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: H35
aqd:AQD_Plan/aqd:publication/aqd:Publication/aqd:webLink must contain a URL to document  or web resource
describing the last version of full air quality plan

Provided url to the published AQ Plan should be valid
:)

let $H35 := try {
    let $main :=  $docRoot//aqd:AQD_Plan/aqd:publication/aqd:Publication/aqd:webLink
    for $el in $main
    let $ok := (
        functx:if-empty(data($el), "") != "")
            and
            common:includesURL(data($el)
            )
    return common:conditionalReportRow(
            $ok,
            [
            (node-name($el), $el)
            ]
    )

} catch * {
    html:createErrorRow($err:code, $err:description)
}

return
    <table class="maintable hover">
        {html:build2("NS", $labels:NAMESPACES, $labels:NAMESPACES_SHORT, $NSinvalid, "All values are valid", "record", $errors:NS)}
        {html:build3("H0", $labels:H0, $labels:H0_SHORT, $H0, string($H0/td), errors:getMaxError($H0))}
        {html:build1("H01", $labels:H01, $labels:H01_SHORT, $H01, "", string($countPlans), "", "", $errors:H01)}
        {html:buildSimple("H03", $labels:H03, $labels:H03_SHORT, $H03, "", "", $H03errorLevel)}
        {html:build1("H04", $labels:H04, $labels:H04_SHORT, $H04, "", string(count($H04)), " ", "", $errors:H04)}
        {html:build1("H05", $labels:H05, $labels:H05_SHORT, $H05, "RESERVE", "RESERVE", "RESERVE", "RESERVE", $errors:H05)}
        {html:build1("H06", $labels:H06, $labels:H06_SHORT, $H06, "RESERVE", "RESERVE", "RESERVE", "RESERVE", $errors:H06)}
        {html:build2("H07", $labels:H07, $labels:H07_SHORT, $H07, "No duplicate values found", " duplicate value", $errors:H07)}
        {html:build2("H08", $labels:H08, $labels:H08_SHORT, $H08, "No duplicate values found", " duplicate value", $errors:H08)}
        {html:buildUnique("H09", $labels:H09, $labels:H09_SHORT, $H09, "namespace", $errors:H09)}
        {html:build2("H10", $labels:H10, $labels:H10_SHORT, $H10, "All values are valid", " not conform to vocabulary", $errors:H10)}
        {html:build1("H13", $labels:H13, $labels:H13_SHORT, $H13, "RESERVE", "RESERVE", "RESERVE", "RESERVE", $errors:H13)}
        {html:build2("H14", $labels:H14, $labels:H14_SHORT, $H14, "All values are valid", " not valid", $errors:H14)}
        {html:build1("H15", $labels:H15, $labels:H15_SHORT, $H15, "RESERVE", "RESERVE", "RESERVE", "RESERVE", $errors:H15)}
        {html:build2("H30", $labels:H30, $labels:H30_SHORT, $H30, "All values are valid", "needs valid input", $errors:H30)}
        {html:build2("H31", $labels:H31, $labels:H31_SHORT, $H31, "All values are valid", "needs valid input", $errors:H31)}
        {html:build2("H32", $labels:H32, $labels:H32_SHORT, $H32, "All values are valid", "needs valid input", $errors:H32)}
        {html:build2("H33", $labels:H33, $labels:H33_SHORT, $H33, "All values are valid", "not valid", $errors:H33)}
        {html:build2("H34", $labels:H34, $labels:H34_SHORT, $H34, "All values are valid", "needs valid input", $errors:H34)}
        {html:build2("H35", $labels:H35, $labels:H35_SHORT, $H35, "All values are valid", "not valid", $errors:H35)}
    </table>
};

declare function dataflowH:proceed($source_url as xs:string, $countryCode as xs:string) as element(div) {

let $countZones := count(doc($source_url)//aqd:AQD_Plan)
let $result := if ($countZones > 0) then dataflowH:checkReport($source_url, $countryCode) else ()
let $meta := map:merge((
    map:entry("count", $countZones),
    map:entry("header", "Check air quality zones"),
    map:entry("dataflow", "Dataflow H"),
    map:entry("zeroCount", <p>No aqd:AQD_Plan elements found in this XML.</p>),
    map:entry("report", <p>This check evaluated the delivery by executing tier-1 tests on air quality zones data in Dataflow H as specified in <a href="http://www.eionet.europa.eu/aqportal/qaqc/">e-reporting QA/QC rules documentation</a>.</p>)
))
return
    html:buildResultDiv($meta, $result)
};
