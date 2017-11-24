xquery version "3.0" encoding "UTF-8";
(:
 : Module Name: Implementing Decision 2011/850/EU: AQ info exchange & reporting (Library module)
 :
 : Version:     $Id$
 : Created:     9 November 2017
 : Copyright:   European Environment Agency
 :
 : XQuery script implements dataflow j checks.
 :
 : @author Claudia Ifrim
 :)

module namespace dataflowJ = "http://converters.eionet.europa.eu/dataflowJ";

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

declare variable $dataflowJ:ISO2_CODES as xs:string* := ("AL","AT","BA","BE","BG","CH","CY","CZ","DE","DK","DZ","EE","EG","ES","FI",
    "FR","GB","GR","HR","HU","IE","IL","IS","IT","JO","LB","LI","LT","LU","LV","MA","ME","MK","MT","NL","NO","PL","PS","PT",
     "RO","RS","SE","SI","SK","TN","TR","XK","UK");

declare variable $dataflowJ:OBLIGATIONS as xs:string* := ($vocabulary:ROD_PREFIX || "682");

(: Rule implementations :)
declare function dataflowJ:checkReport($source_url as xs:string, $countryCode as xs:string) as element(table) {

let $docRoot := doc($source_url)
let $reportingYear := c:getReportingYear($docRoot)

(: Check prefix and namespaces of the gml:featureCollection according to expected root elements
(More information at http://www.eionet.europa.eu/aqportal/datamodel)

Prefix/namespaces check
:)

let $NSinvalid := try {
    let $XQmap := inspect:static-context((), 'namespaces')
    let $fileMap := map:merge(
        for $x in in-scope-prefixes($docRoot/*)
        return map:entry($x, string(namespace-uri-for-prefix($x, $docRoot/*)))
    )

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

(: J0
Check if delivery if this is a new delivery or updated delivery (via reporting year)

Checks if this delivery is new or an update (on same reporting year)
:)

let $J0 := try {
    if ($reportingYear = "")
    then
        c:checkDeliveryReport($errors:ERROR, "Reporting Year is missing.")
    else
        if(query:deliveryExists($dataflowJ:OBLIGATIONS, $countryCode, "j/", $reportingYear))
        then
                c:checkDeliveryReport($errors:WARNING, "Updating delivery for " || $reportingYear)
            else
                c:checkDeliveryReport($errors:WARNING, "New delivery for " || $reportingYear)


} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: J01
Compile & feedback upon the total number of plans records included in the delivery

Number of AQ Plans reported
:)

let $countEvaluationScenario := count($docRoot//aqd:AQD_EvaluationScenario)
let $J01 := try {
    for $rec in $docRoot//aqd:AQD_EvaluationScenario
    let $el := $rec/aqd:inspireId/base:Identifier
    return
        c:conditionalReportRow(
        true(),
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

(: J02
Compile & feedback upon the total number of new EvaluationScenarios records included in the delivery.
ERROR will be returned if XML is a new delivery and localId are not new compared to previous deliveries.

Number of new EvaluationScenarios compared to previous report.
:)

let $j02 := try {
    let $el := $docRoot//aqd:AQD_EvaluationScenario

    return ()

} catch * {
    html:createErrorRow($err:code, $err:description)
}

return
(
    <table class="maintable hover">
        {html:build2("NS", $labels:NAMESPACES, $labels:NAMESPACES_SHORT, $NSinvalid, "All values are valid", "record", $errors:NS)}
        {html:build3("J0", $labels:J0, $labels:J0_SHORT, $J0, string($J0/td), errors:getMaxError($J0))}
        {html:build1("J01", $labels:J01, $labels:J01_SHORT, $J01, "", string($countEvaluationScenario), "", "", $errors:J01)}
        <!--{html:buildSimple("J02", $labels:J02, $labels:J02_SHORT, $J02, "", "", $J02errorLevel)} -->

    </table>
)
};

(:


        {html:buildSimple("K03", $labels:K03, $labels:K03_SHORT, $K03table, "", "", $K03errorLevel)}
        {html:build1("K04", $labels:K04, $labels:K04_SHORT, $K04table, "", string(count($K04table)), " ", "", $errors:K04)}
        {html:build2("K07", $labels:K07, $labels:K07_SHORT, $K07, "No duplicate values found", " duplicate value", $errors:K07)}
        {html:build2("K08", $labels:K08, $labels:K08_SHORT, $K08invalid, "No duplicate values found", " duplicate value", $errors:K08)}
        {html:build2("K09", $labels:K09, $labels:K09_SHORT, $K09table, "namespace", "", $errors:K09)}
        {html:build2("K10", $labels:K10, $labels:K10_SHORT, $K10invalid, "All values are valid", " not conform to vocabulary", $errors:K10)}
        {html:build2("K11", $labels:K11, $labels:K11_SHORT, $K11, "All values are valid", "needs valid input", $errors:K11)}
        {html:build2("K12", $labels:K12, $labels:K12_SHORT, $K12, "All values are valid", "needs valid input", $errors:K12)}
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
        {html:build2("K31", $labels:K31, $labels:K31_SHORT, $K31, "All values are valid", "not valid", $errors:K31)}
        {html:build2("K33", $labels:K33, $labels:K33_SHORT, $K33, "All values are valid", "not valid", $errors:K33)}
        {html:build2("K34", $labels:K34, $labels:K34_SHORT, $K34, "All values are valid", "not valid", $errors:K34)}
        {html:build2("K35", $labels:K35, $labels:K35_SHORT, $K35, "All values are valid", "not valid", $errors:K35)}
        {html:build2("K36", $labels:K36, $labels:K36_SHORT, $K36, "All values are valid", "not valid", $errors:K36)}
        {html:build2("K37", $labels:K37, $labels:K37_SHORT, $K37, "All values are valid", "not valid", $errors:K37)}
        {html:build2("K38", $labels:K38, $labels:K38_SHORT, $K38, "All values are valid", "not valid", $errors:K38)}
        {html:build2("K39", $labels:K39, $labels:K39_SHORT, $K39, "All values are valid", "not valid", $errors:K39)}:)



declare function dataflowJ:proceed($source_url as xs:string, $countryCode as xs:string) as element(div) {

let $countZones := count(doc($source_url)//aqd:AQD_EvaluationScenario)
let $result := if ($countZones > 0) then dataflowJ:checkReport($source_url, $countryCode) else ()
let $meta := map:merge((
    map:entry("count", $countZones),
    map:entry("header", "Check air quality zones"),
    map:entry("dataflow", "Dataflow J"),
    map:entry("zeroCount", <p>No aqd:AQD_EvaluationScenario elements found in this XML.</p>),
    map:entry("report", <p>This check evaluated the delivery by executing tier-1 tests on air quality zones data in Dataflow J as specified in <a href="http://www.eionet.europa.eu/aqportal/qaqc/">e-reporting QA/QC rules documentation</a>.</p>)
))
return
    html:buildResultDiv($meta, $result)
};

