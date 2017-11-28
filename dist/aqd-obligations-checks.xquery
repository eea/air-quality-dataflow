
xquery version "3.0" encoding "UTF-8";

declare namespace ad = "urn:x-inspire:specification:gmlas:Addresses:3.0";
declare namespace adms = "http://www.w3.org/ns/adms#";
declare namespace am = "http://inspire.ec.europa.eu/schemas/am/3.0";
declare namespace aqd = "http://dd.eionet.europa.eu/schemaset/id2011850eu-1.0";
declare namespace base = "http://inspire.ec.europa.eu/schemas/base/3.3";
declare namespace base2 = "http://inspire.ec.europa.eu/schemas/base2/1.0";
declare namespace common = "aqd-common";
declare namespace dataflowB = "http://converters.eionet.europa.eu/dataflowB";
declare namespace dataflowC = "http://converters.eionet.europa.eu/dataflowC";
declare namespace dataflowD = "http://converters.eionet.europa.eu/dataflowD";
declare namespace dataflowEa = "http://converters.eionet.europa.eu/dataflowEa";
declare namespace dataflowEb = "http://converters.eionet.europa.eu/dataflowEb";
declare namespace dataflowG = "http://converters.eionet.europa.eu/dataflowG";
declare namespace dataflowH = "http://converters.eionet.europa.eu/dataflowH";
declare namespace dataflowI = "http://converters.eionet.europa.eu/dataflowI";
declare namespace dataflowJ = "http://converters.eionet.europa.eu/dataflowJ";
declare namespace dataflowK = "http://converters.eionet.europa.eu/dataflowK";
declare namespace dataflowM = "http://converters.eionet.europa.eu/dataflowM";
declare namespace dcterms="http://purl.org/dc/terms/";
declare namespace dctype="http://purl.org/dc/dcmitype/";
declare namespace dd = "aqd-dd";
declare namespace ef = "http://inspire.ec.europa.eu/schemas/ef/3.0";
declare namespace envelope = "http://converters.eionet.europa.eu/aqd";
declare namespace errors = "aqd-errors";
declare namespace filter = "aqd-filter";
declare namespace functx = "http://www.functx.com";
declare namespace gco = "http://www.isotc211.org/2005/gco";
declare namespace geox = "aqd-geo";
declare namespace gmd = "http://www.isotc211.org/2005/gmd";
declare namespace gml = "http://www.opengis.net/gml/3.2";
declare namespace gn = "urn:x-inspire:specification:gmlas:GeographicalNames:3.0";
declare namespace html = "aqd-html";
declare namespace labels = "aqd-labels";
declare namespace obligations = "http://converters.eionet.europa.eu";
declare namespace om = "http://www.opengis.net/om/2.0";
declare namespace ompr="http://inspire.ec.europa.eu/schemas/ompr/2.0";
declare namespace owl="http://www.w3.org/2002/07/owl#";
declare namespace prop = "http://dd.eionet.europa.eu/property/";
declare namespace query = "aqd-query";
declare namespace rdf = "http://www.w3.org/1999/02/22-rdf-syntax-ns#";
declare namespace rdfs = "http://www.w3.org/2000/01/rdf-schema#";
declare namespace sam = "http://www.opengis.net/sampling/2.0";
declare namespace sams="http://www.opengis.net/samplingSpatial/2.0";
declare namespace schemax = "aqd-schema";
declare namespace skos = "http://www.w3.org/2004/02/skos/core#";
declare namespace sparql = "http://www.w3.org/2005/sparql-results#";
declare namespace sparqlx = "aqd-sparql";
declare namespace swe = "http://www.opengis.net/swe/2.0";
declare namespace vocabulary = "aqd-vocabulary";
declare namespace xlink = "http://www.w3.org/1999/xlink";
declare variable $common:SOURCE_URL_PARAM := "source_url=";
declare variable $dataflowB:invalidCount as xs:integer := 0;
declare variable $dataflowB:OBLIGATIONS as xs:string* := ($vocabulary:ROD_PREFIX || "670", $vocabulary:ROD_PREFIX || "693");
declare variable $dataflowC:VALID_POLLUTANT_IDS as xs:string* := ("1", "7", "8", "9", "5", "6001", "10","20", "5012", "5014", "5015", "5018", "5029");
declare variable $dataflowC:VALID_POLLUTANT_IDS_18 as xs:string* := ("5014", "5015", "5018", "5029");
declare variable $dataflowC:MANDATORY_POLLUTANT_IDS_8 as xs:string* := ("1","7","8","9","5","6001","10","20","5012","5014","5015","5018","5029");
declare variable $dataflowC:VALID_POLLUTANT_IDS_40 as xs:string* := ($dataflowC:MANDATORY_POLLUTANT_IDS_8, $dataflowC:UNIQUE_POLLUTANT_IDS_9);
declare variable $dataflowC:VALID_POLLUTANT_IDS_21 as xs:string* := ("1","8","9","10","5","6001","5014","5018","5015","5029","5012","20");
declare variable $dataflowC:OBLIGATIONS as xs:string* := ($vocabulary:ROD_PREFIX || "671", $vocabulary:ROD_PREFIX || "694");
declare variable $dataflowD:OBLIGATIONS as xs:string* := ($vocabulary:ROD_PREFIX || "672");
declare variable $dataflowEa:OBLIGATIONS as xs:string* := ($vocabulary:ROD_PREFIX || "673");
declare variable $dataflowEb:OBLIGATIONS as xs:string* := ($vocabulary:ROD_PREFIX || "674");
declare variable $dataflowEb:FEATURE_TYPES := ("aqd:AQD_Model", "aqd:AQD_ModelProcess", "aqd:AQD_ModelArea");
declare variable $dataflowG:OBLIGATIONS as xs:string* := ($vocabulary:ROD_PREFIX || "679");
declare variable $dataflowH:OBLIGATIONS as xs:string* := ($vocabulary:ROD_PREFIX || "680");
declare variable $dataflowJ:OBLIGATIONS as xs:string* := ($vocabulary:ROD_PREFIX || "682");
declare variable $dataflowK:OBLIGATIONS as xs:string* := ($vocabulary:ROD_PREFIX || "683");
declare variable $dataflowM:FEATURE_TYPES := ("aqd:AQD_Model", "aqd:AQD_ModelProcess", "aqd:AQD_ModelArea");
declare variable $dataflowM:OBLIGATIONS as xs:string* := ($vocabulary:ROD_PREFIX || "672", $vocabulary:ROD_PREFIX || "742");
declare variable $dd:VALIDRESOURCE := "http://dd.eionet.europa.eu/vocabulary/datadictionary/status/valid";
declare variable $dd:VALIDPOLLUTANTS as xs:string* := dd:getValidPollutants();
declare variable $dd:QAQCMAP as element(QAQCMap) := dd:getQAQCMap();
declare variable $envelope:LIST_ITEM_SEP := "##";
declare variable $errors:XML := errors:getError("XML");
declare variable $errors:NS := errors:getError("NS");
declare variable $errors:B0 := errors:getError("B0");
declare variable $errors:B01 := errors:getError("B1");
declare variable $errors:B02 :=  errors:getError("B2");
declare variable $errors:B03 := errors:getError("B3");
declare variable $errors:B04 := errors:getError("B4");
declare variable $errors:B05 := errors:getError("B5");
declare variable $errors:B06a := errors:getError("B6a");
declare variable $errors:B06b := errors:getError("B6b");
declare variable $errors:B07 := errors:getError("B7");
declare variable $errors:B08 := errors:getError("B8");
declare variable $errors:B09 := errors:getError("B9");
declare variable $errors:B10 := errors:getError("B10");
declare variable $errors:B10.1 := errors:getError("B10.1");
declare variable $errors:B11 := errors:getError("B11");
declare variable $errors:B12 := errors:getError("B12");
declare variable $errors:B13 := errors:getError("B13");
declare variable $errors:B14 := errors:getError("B14");
declare variable $errors:B15 := errors:getError("B15");
declare variable $errors:B16 := errors:getError("B16");
declare variable $errors:B17 := errors:getError("B17");
declare variable $errors:B18 := errors:getError("B18");
declare variable $errors:B19 := errors:getError("B19");
declare variable $errors:B20 := errors:getError("B20");
declare variable $errors:B21 := errors:getError("B21");
declare variable $errors:B22 := errors:getError("B22");
declare variable $errors:B23 := errors:getError("B23");
declare variable $errors:B24 := errors:getError("B24");
declare variable $errors:B25 := errors:getError("B25");
declare variable $errors:B26 := errors:getError("B26");
declare variable $errors:B27 := errors:getError("B27");
declare variable $errors:B28 := errors:getError("B28");
declare variable $errors:B29 := errors:getError("B29");
declare variable $errors:B30 := errors:getError("B30");
declare variable $errors:B31 := errors:getError("B31");
declare variable $errors:B32 := errors:getError("B32");
declare variable $errors:B33 := errors:getError("B33");
declare variable $errors:B34 := errors:getError("B34");
declare variable $errors:B35 := errors:getError("B35");
declare variable $errors:B36 := errors:getError("B36");
declare variable $errors:B37 := errors:getError("B37");
declare variable $errors:B38 := errors:getError("B38");
declare variable $errors:B39a := errors:getError("B39a");
declare variable $errors:B39b := errors:getError("B39b");
declare variable $errors:B39c := errors:getError("B39c");
declare variable $errors:B40 := errors:getError("B40");
declare variable $errors:B41 := errors:getError("B41");
declare variable $errors:B42 := errors:getError("B42");
declare variable $errors:B43 := errors:getError("B43");
declare variable $errors:B44 := errors:getError("B44");
declare variable $errors:B45 := errors:getError("B45");
declare variable $errors:B46 := errors:getError("B46");
declare variable $errors:B47 := errors:getError("B47");
declare variable $errors:C0 := errors:getError("C0");
declare variable $errors:C01 := errors:getError("C01");
declare variable $errors:C02 := errors:getError("C02");
declare variable $errors:C03 := errors:getError("C03");
declare variable $errors:C04 := errors:getError("C04");
declare variable $errors:C05 := errors:getError("C05");
declare variable $errors:C06 := errors:getError("C06");
declare variable $errors:C06.1 := errors:getError("C06.1");
declare variable $errors:C07 := errors:getError("C07");
declare variable $errors:C08 := errors:getError("C08");
declare variable $errors:C09 := errors:getError("C09");
declare variable $errors:C10 := errors:getError("C10");
declare variable $errors:C11 := errors:getError("C11");
declare variable $errors:C12 := errors:getError("C12");
declare variable $errors:C13 := errors:getError("C13");
declare variable $errors:C14 := errors:getError("C14");
declare variable $errors:C15 := errors:getError("C15");
declare variable $errors:C16 := errors:getError("C16");
declare variable $errors:C17 := errors:getError("C17");
declare variable $errors:C18 := errors:getError("C18");
declare variable $errors:C19 := errors:getError("C19");
declare variable $errors:C20 := errors:getError("C20");
declare variable $errors:C21 := errors:getError("C21");
declare variable $errors:C22 := errors:getError("C22");
declare variable $errors:C23 := errors:getError("C23");
declare variable $errors:C23a := errors:getError("C23a");
declare variable $errors:C23b := errors:getError("C23b");
declare variable $errors:C24 := errors:getError("C24");
declare variable $errors:C25 := errors:getError("C25");
declare variable $errors:C26 := errors:getError("C26");
declare variable $errors:C27 := errors:getError("C27");
declare variable $errors:C28 := errors:getError("C28");
declare variable $errors:C29 := errors:getError("C29");
declare variable $errors:C31 := errors:getError("C31");
declare variable $errors:C32 := errors:getError("C32");
declare variable $errors:C33 := errors:getError("C33");
declare variable $errors:C35 := errors:getError("C35");
declare variable $errors:C37 := errors:getError("C37");
declare variable $errors:C38 := errors:getError("C38");
declare variable $errors:C40 := errors:getError("C40");
declare variable $errors:C41 := errors:getError("C41");
declare variable $errors:C42 := errors:getError("C42");
declare variable $errors:D0 := errors:getError("D0");
declare variable $errors:D01 := errors:getError("D01");
declare variable $errors:D02 := errors:getError("D02");
declare variable $errors:D03 := errors:getError("D03");
declare variable $errors:D04 := errors:getError("D04");
declare variable $errors:D05 := errors:getError("D05");
declare variable $errors:D06 := errors:getError("D06");
declare variable $errors:D07 := errors:getError("D07");
declare variable $errors:D07.1 := errors:getError("D07.1");
declare variable $errors:D08 := errors:getError("D08");
declare variable $errors:D09 := errors:getError("D09");
declare variable $errors:D10 := errors:getError("D10");
declare variable $errors:D11 := errors:getError("D11");
declare variable $errors:D12 := errors:getError("D12");
declare variable $errors:D14 := errors:getError("D14");
declare variable $errors:D15 := errors:getError("D15");
declare variable $errors:D16 := errors:getError("D16");
declare variable $errors:D16.1 := errors:getError("D16.1");
declare variable $errors:D17 := errors:getError("D17");
declare variable $errors:D18 := errors:getError("D18");
declare variable $errors:D19 := errors:getError("D19");
declare variable $errors:D20 := errors:getError("D20");
declare variable $errors:D21 := errors:getError("D21");
declare variable $errors:D23 := errors:getError("D23");
declare variable $errors:D24 := errors:getError("D24");
declare variable $errors:D26 := errors:getError("D26");
declare variable $errors:D27 := errors:getError("D27");
declare variable $errors:D28 := errors:getError("D28");
declare variable $errors:D29 := errors:getError("D29");
declare variable $errors:D30 := errors:getError("D30");
declare variable $errors:D31 := errors:getError("D31");
declare variable $errors:D32 := errors:getError("D32");
declare variable $errors:D32.1 := errors:getError("D32.1");
declare variable $errors:D33 := errors:getError("D33");
declare variable $errors:D34 := errors:getError("D34");
declare variable $errors:D35 := errors:getError("D35");
declare variable $errors:D36 := errors:getError("D36");
declare variable $errors:D37 := errors:getError("D37");
declare variable $errors:D40 := errors:getError("D40");
declare variable $errors:D41 := errors:getError("D41");
declare variable $errors:D42 := errors:getError("D42");
declare variable $errors:D43 := errors:getError("D43");
declare variable $errors:D44 := errors:getError("D44");
declare variable $errors:D44b := errors:getError("D44b");
declare variable $errors:D45 := errors:getError("D45");
declare variable $errors:D46 := errors:getError("D46");
declare variable $errors:D48 := errors:getError("D48");
declare variable $errors:D50 := errors:getError("D50");
declare variable $errors:D51 := errors:getError("D51");
declare variable $errors:D52 := errors:getError("D52");
declare variable $errors:D53 := errors:getError("D53");
declare variable $errors:D54 := errors:getError("D54");
declare variable $errors:D55 := errors:getError("D55");
declare variable $errors:D55.1 := errors:getError("D55.1");
declare variable $errors:D56 := errors:getError("D56");
declare variable $errors:D57 := errors:getError("D57");
declare variable $errors:D58 := errors:getError("D58");
declare variable $errors:D59 := errors:getError("D59");
declare variable $errors:D60a := errors:getError("D60a");
declare variable $errors:D60b := errors:getError("D60b");
declare variable $errors:D61 := errors:getError("D61");
declare variable $errors:D62 := errors:getError("D62");
declare variable $errors:D63 := errors:getError("D63");
declare variable $errors:D65 := errors:getError("D65");
declare variable $errors:D67a := errors:getError("D67a");
declare variable $errors:D67b := errors:getError("D67b");
declare variable $errors:D68 := errors:getError("D68");
declare variable $errors:D69 := errors:getError("D69");
declare variable $errors:D71 := errors:getError("D71");
declare variable $errors:D72 := errors:getError("D72");
declare variable $errors:D72.1 := errors:getError("D72.1");
declare variable $errors:D73 := errors:getError("D73");
declare variable $errors:D74 := errors:getError("D74");
declare variable $errors:D75 := errors:getError("D75");
declare variable $errors:D76 := errors:getError("D76");
declare variable $errors:D77 := errors:getError("D77");
declare variable $errors:D78 := errors:getError("D78");
declare variable $errors:D91 := errors:getError("D91");
declare variable $errors:D92 := errors:getError("D92");
declare variable $errors:D93 := errors:getError("D93");
declare variable $errors:D94 := errors:getError("D94");
declare variable $errors:E0 := errors:getError("E0");
declare variable $errors:E01a := errors:getError("E01a");
declare variable $errors:E01b := errors:getError("E01b");
declare variable $errors:E02 := errors:getError("E02");
declare variable $errors:E03 := errors:getError("E03");
declare variable $errors:E04 := errors:getError("E04");
declare variable $errors:E05 := errors:getError("E05");
declare variable $errors:E06 := errors:getError("E06");
declare variable $errors:E07 := errors:getError("E07");
declare variable $errors:E08 := errors:getError("E08");
declare variable $errors:E09 := errors:getError("E09");
declare variable $errors:E10 := errors:getError("E10");
declare variable $errors:E11 := errors:getError("E11");
declare variable $errors:E12 := errors:getError("E12");
declare variable $errors:E15 := errors:getError("E15");
declare variable $errors:E16 := errors:getError("E16");
declare variable $errors:E17 := errors:getError("E17");
declare variable $errors:E18 := errors:getError("E18");
declare variable $errors:E19 := errors:getError("E19");
declare variable $errors:E19b := errors:getError("E19b");
declare variable $errors:E20 := errors:getError("E20");
declare variable $errors:E21 := errors:getError("E21");
declare variable $errors:E22 := errors:getError("E22");
declare variable $errors:E23 := errors:getError("E23");
declare variable $errors:E24 := errors:getError("E24");
declare variable $errors:E25 := errors:getError("E25");
declare variable $errors:E26 := errors:getError("E26");
declare variable $errors:E27 := errors:getError("E27");
declare variable $errors:E28 := errors:getError("E28");
declare variable $errors:E29 := errors:getError("E29");
declare variable $errors:E30 := errors:getError("E30");
declare variable $errors:E31 := errors:getError("E31");
declare variable $errors:E32 := errors:getError("E32");
declare variable $errors:Eb0 := errors:getError("Eb0");
declare variable $errors:Eb01 := errors:getError("Eb01");
declare variable $errors:Eb02 := errors:getError("Eb02");
declare variable $errors:Eb03 := errors:getError("Eb03");
declare variable $errors:Eb04 := errors:getError("Eb04");
declare variable $errors:Eb05 := errors:getError("Eb05");
declare variable $errors:Eb06 := errors:getError("Eb06");
declare variable $errors:Eb07 := errors:getError("Eb07");
declare variable $errors:Eb08 := errors:getError("Eb08");
declare variable $errors:Eb09 := errors:getError("Eb09");
declare variable $errors:Eb10 := errors:getError("Eb10");
declare variable $errors:Eb11 := errors:getError("Eb11");
declare variable $errors:Eb12 := errors:getError("Eb12");
declare variable $errors:Eb13 := errors:getError("Eb13");
declare variable $errors:Eb14 := errors:getError("Eb14");
declare variable $errors:Eb14b := errors:getError("Eb14b");
declare variable $errors:Eb15 := errors:getError("Eb15");
declare variable $errors:Eb16 := errors:getError("Eb16");
declare variable $errors:Eb17 := errors:getError("Eb17");
declare variable $errors:Eb18 := errors:getError("Eb18");
declare variable $errors:Eb19 := errors:getError("Eb19");
declare variable $errors:Eb19b := errors:getError("Eb19b");
declare variable $errors:Eb20 := errors:getError("Eb20");
declare variable $errors:Eb21 := errors:getError("Eb21");
declare variable $errors:Eb22 := errors:getError("Eb22");
declare variable $errors:Eb23 := errors:getError("Eb23");
declare variable $errors:Eb24 := errors:getError("Eb24");
declare variable $errors:Eb25 := errors:getError("Eb25");
declare variable $errors:Eb26 := errors:getError("Eb26");
declare variable $errors:Eb27 := errors:getError("Eb27");
declare variable $errors:Eb28 := errors:getError("Eb28");
declare variable $errors:Eb29 := errors:getError("Eb29");
declare variable $errors:Eb30 := errors:getError("Eb30");
declare variable $errors:Eb31 := errors:getError("Eb31");
declare variable $errors:Eb32 := errors:getError("Eb32");
declare variable $errors:Eb35 := errors:getError("Eb35");
declare variable $errors:Eb36 := errors:getError("Eb36");
declare variable $errors:Eb37 := errors:getError("Eb37");
declare variable $errors:Eb38 := errors:getError("Eb38");
declare variable $errors:Eb39 := errors:getError("Eb39");
declare variable $errors:Eb40 := errors:getError("Eb40");
declare variable $errors:Eb41 := errors:getError("Eb41");
declare variable $errors:Eb42 := errors:getError("Eb42");
declare variable $errors:G0 := errors:getError("G0");
declare variable $errors:G01 := errors:getError("G01");
declare variable $errors:G02 := errors:getError("G02");
declare variable $errors:G03 := errors:getError("G03");
declare variable $errors:G04 := errors:getError("G04");
declare variable $errors:G05 := errors:getError("G05");
declare variable $errors:G06 := errors:getError("G06");
declare variable $errors:G07 := errors:getError("G07");
declare variable $errors:G08 := errors:getError("G08");
declare variable $errors:G09 := errors:getError("G08");
declare variable $errors:G09.1 := errors:getError("G09.1");
declare variable $errors:G10 := errors:getError("G10");
declare variable $errors:G11 := errors:getError("G11");
declare variable $errors:G12 := errors:getError("G12");
declare variable $errors:G13 := errors:getError("G13");
declare variable $errors:G13b := errors:getError("G13b");
declare variable $errors:G13c := errors:getError("G13c");
declare variable $errors:G14 := errors:getError("G14");
declare variable $errors:G14b := errors:getError("G14b");
declare variable $errors:G15 := errors:getError("G15");
declare variable $errors:G17 := errors:getError("G17");
declare variable $errors:G18 := errors:getError("G18");
declare variable $errors:G19 := errors:getError("G19");
declare variable $errors:G20 := errors:getError("G20");
declare variable $errors:G21 := errors:getError("G21");
declare variable $errors:G22 := errors:getError("G22");
declare variable $errors:G23 := errors:getError("G23");
declare variable $errors:G24 := errors:getError("G24");
declare variable $errors:G25 := errors:getError("G25");
declare variable $errors:G26 := errors:getError("G26");
declare variable $errors:G27 := errors:getError("G27");
declare variable $errors:G28 := errors:getError("G28");
declare variable $errors:G29 := errors:getError("G29");
declare variable $errors:G30 := errors:getError("G30");
declare variable $errors:G31 := errors:getError("G31");
declare variable $errors:G32 := errors:getError("G32");
declare variable $errors:G33 := errors:getError("G33");
declare variable $errors:G38 := errors:getError("G38");
declare variable $errors:G39 := errors:getError("G39");
declare variable $errors:G40 := errors:getError("G40");
declare variable $errors:G41 := errors:getError("G41");
declare variable $errors:G42 := errors:getError("G42");
declare variable $errors:G44 := errors:getError("G44");
declare variable $errors:G45 := errors:getError("G45");
declare variable $errors:G46 := errors:getError("G46");
declare variable $errors:G47 := errors:getError("G47");
declare variable $errors:G52 := errors:getError("G52");
declare variable $errors:G53 := errors:getError("G53");
declare variable $errors:G54 := errors:getError("G54");
declare variable $errors:G55 := errors:getError("G55");
declare variable $errors:G56 := errors:getError("G56");
declare variable $errors:G58 := errors:getError("G58");
declare variable $errors:G59 := errors:getError("G59");
declare variable $errors:G60 := errors:getError("G60");
declare variable $errors:G61 := errors:getError("G61");
declare variable $errors:G62 := errors:getError("G62");
declare variable $errors:G63 := errors:getError("G63");
declare variable $errors:G64 := errors:getError("G64");
declare variable $errors:G65 := errors:getError("G65");
declare variable $errors:G66 := errors:getError("G66");
declare variable $errors:G67 := errors:getError("G67");
declare variable $errors:G70 := errors:getError("G70");
declare variable $errors:G71 := errors:getError("G71");
declare variable $errors:G72 := errors:getError("G72");
declare variable $errors:G73 := errors:getError("G73");
declare variable $errors:G74 := errors:getError("G714");
declare variable $errors:G75 := errors:getError("G75");
declare variable $errors:G76 := errors:getError("G76");
declare variable $errors:G78 := errors:getError("G78");
declare variable $errors:G79 := errors:getError("G79");
declare variable $errors:G80 := errors:getError("G80");
declare variable $errors:G81 := errors:getError("G81");
declare variable $errors:G85 := errors:getError("G85");
declare variable $errors:G86 := errors:getError("G86");
declare variable $errors:H0 := errors:getError("H0");
declare variable $errors:H01 := errors:getError("H01");
declare variable $errors:H02 := errors:getError("H02");
declare variable $errors:H03 := errors:getError("H03");
declare variable $errors:H04 := errors:getError("H04");
declare variable $errors:H05 := errors:getError("H05");
declare variable $errors:H06 := errors:getError("H06");
declare variable $errors:H07 := errors:getError("H07");
declare variable $errors:H08 := errors:getError("H08");
declare variable $errors:H09 := errors:getError("H09");
declare variable $errors:H10 := errors:getError("H10");
declare variable $errors:H11 := errors:getError("H11");
declare variable $errors:H12 := errors:getError("H12");
declare variable $errors:H13 := errors:getError("H13");
declare variable $errors:H14 := errors:getError("H14");
declare variable $errors:H15 := errors:getError("H15");
declare variable $errors:H16 := errors:getError("H16");
declare variable $errors:H17 := errors:getError("H17");
declare variable $errors:H18 := errors:getError("H18");
declare variable $errors:H19 := errors:getError("H19");
declare variable $errors:H20 := errors:getError("H20");
declare variable $errors:H21 := errors:getError("H21");
declare variable $errors:H22 := errors:getError("H22");
declare variable $errors:H23 := errors:getError("H23");
declare variable $errors:H24 := errors:getError("H24");
declare variable $errors:H25 := errors:getError("H25");
declare variable $errors:H26 := errors:getError("H26");
declare variable $errors:H27 := errors:getError("H27");
declare variable $errors:H28 := errors:getError("H28");
declare variable $errors:H29 := errors:getError("H29");
declare variable $errors:H30 := errors:getError("H30");
declare variable $errors:H31 := errors:getError("H31");
declare variable $errors:H32 := errors:getError("H32");
declare variable $errors:H33 := errors:getError("H33");
declare variable $errors:H34 := errors:getError("H34");
declare variable $errors:H35 := errors:getError("H35");
declare variable $errors:I0 := errors:getError("I0");
declare variable $errors:I01 := errors:getError("I01");
declare variable $errors:I02 := errors:getError("I02");
declare variable $errors:I03 := errors:getError("I03");
declare variable $errors:I04 := errors:getError("I04");
declare variable $errors:I05 := errors:getError("I05");
declare variable $errors:I06 := errors:getError("I06");
declare variable $errors:I07 := errors:getError("I07");
declare variable $errors:I08 := errors:getError("I08");
declare variable $errors:I09 := errors:getError("I08");
declare variable $errors:I10 := errors:getError("I10");
declare variable $errors:I11a := errors:getError("I11a");
declare variable $errors:I11b := errors:getError("I11b");
declare variable $errors:I12 := errors:getError("I12");
declare variable $errors:I13 := errors:getError("I13");
declare variable $errors:I14 := errors:getError("I14");
declare variable $errors:I15 := errors:getError("I15");
declare variable $errors:I16 := errors:getError("I16");
declare variable $errors:I17 := errors:getError("I17");
declare variable $errors:I18 := errors:getError("I18");
declare variable $errors:I19 := errors:getError("I19");
declare variable $errors:I20 := errors:getError("I20");
declare variable $errors:I21 := errors:getError("I21");
declare variable $errors:I22 := errors:getError("I22");
declare variable $errors:I23 := errors:getError("I23");
declare variable $errors:I24 := errors:getError("I24");
declare variable $errors:I25 := errors:getError("I25");
declare variable $errors:I26 := errors:getError("I26");
declare variable $errors:I27 := errors:getError("I27");
declare variable $errors:I28 := errors:getError("I28");
declare variable $errors:I29 := errors:getError("I29");
declare variable $errors:I30 := errors:getError("I30");
declare variable $errors:I31 := errors:getError("I31");
declare variable $errors:I32 := errors:getError("I32");
declare variable $errors:I33 := errors:getError("I33");
declare variable $errors:I34 := errors:getError("I34");
declare variable $errors:I35 := errors:getError("I35");
declare variable $errors:I36 := errors:getError("I36");
declare variable $errors:I37 := errors:getError("I37");
declare variable $errors:I38 := errors:getError("I38");
declare variable $errors:I39 := errors:getError("I39");
declare variable $errors:I40 := errors:getError("I40");
declare variable $errors:I41 := errors:getError("I41");
declare variable $errors:I42 := errors:getError("I42");
declare variable $errors:I43 := errors:getError("I43");
declare variable $errors:I44 := errors:getError("I44");
declare variable $errors:I45 := errors:getError("I45");
declare variable $errors:J0 := errors:getError("J0");
declare variable $errors:J1 := errors:getError("J1");
declare variable $errors:J2 := errors:getError("J2");
declare variable $errors:J3 := errors:getError("J3");
declare variable $errors:J4 := errors:getError("J4");
declare variable $errors:J5 := errors:getError("J5");
declare variable $errors:J6 := errors:getError("J6");
declare variable $errors:J7 := errors:getError("J7");
declare variable $errors:J8 := errors:getError("J8");
declare variable $errors:J9 := errors:getError("J9");
declare variable $errors:J10 := errors:getError("J10");
declare variable $errors:J11 := errors:getError("J11");
declare variable $errors:J12 := errors:getError("J12");
declare variable $errors:J13 := errors:getError("J13");
declare variable $errors:J14 := errors:getError("J14");
declare variable $errors:J15 := errors:getError("J15");
declare variable $errors:J16 := errors:getError("J16");
declare variable $errors:J17 := errors:getError("J17");
declare variable $errors:J18 := errors:getError("J18");
declare variable $errors:J19 := errors:getError("J19");
declare variable $errors:J20 := errors:getError("J20");
declare variable $errors:J21 := errors:getError("J21");
declare variable $errors:J22 := errors:getError("J22");
declare variable $errors:J23 := errors:getError("J23");
declare variable $errors:J24 := errors:getError("J24");
declare variable $errors:J25 := errors:getError("J25");
declare variable $errors:J26 := errors:getError("J26");
declare variable $errors:J27 := errors:getError("J27");
declare variable $errors:J28 := errors:getError("J28");
declare variable $errors:J29 := errors:getError("J29");
declare variable $errors:J30 := errors:getError("J30");
declare variable $errors:J31 := errors:getError("J31");
declare variable $errors:J32 := errors:getError("J32");
declare variable $errors:K0 := errors:getError("K0");
declare variable $errors:K01 := errors:getError("K01");
declare variable $errors:K02 := errors:getError("K02");
declare variable $errors:K03 := errors:getError("K03");
declare variable $errors:K04 := errors:getError("K04");
declare variable $errors:K05 := errors:getError("K05");
declare variable $errors:K06 := errors:getError("K06");
declare variable $errors:K07 := errors:getError("K07");
declare variable $errors:K08 := errors:getError("K08");
declare variable $errors:K09 := errors:getError("K09");
declare variable $errors:K10 := errors:getError("K10");
declare variable $errors:K11 := errors:getError("K11");
declare variable $errors:K12 := errors:getError("K12");
declare variable $errors:K13 := errors:getError("K13");
declare variable $errors:K14 := errors:getError("K14");
declare variable $errors:K15 := errors:getError("K15");
declare variable $errors:K16 := errors:getError("K16");
declare variable $errors:K17 := errors:getError("K17");
declare variable $errors:K18 := errors:getError("K18");
declare variable $errors:K19 := errors:getError("K19");
declare variable $errors:K20 := errors:getError("K20");
declare variable $errors:K21 := errors:getError("K21");
declare variable $errors:K22 := errors:getError("K22");
declare variable $errors:K23 := errors:getError("K23");
declare variable $errors:K24 := errors:getError("K24");
declare variable $errors:K25 := errors:getError("K25");
declare variable $errors:K26 := errors:getError("K26");
declare variable $errors:K27 := errors:getError("K27");
declare variable $errors:K28 := errors:getError("K28");
declare variable $errors:K29 := errors:getError("K29");
declare variable $errors:K30 := errors:getError("K30");
declare variable $errors:K31 := errors:getError("K31");
declare variable $errors:K32 := errors:getError("K32");
declare variable $errors:K33 := errors:getError("K33");
declare variable $errors:K34 := errors:getError("K34");
declare variable $errors:K35 := errors:getError("K35");
declare variable $errors:K36 := errors:getError("K36");
declare variable $errors:K37 := errors:getError("K37");
declare variable $errors:K38 := errors:getError("K38");
declare variable $errors:K39 := errors:getError("K39");
declare variable $errors:K40 := errors:getError("K40");
declare variable $errors:M0 := errors:getError("M0");
declare variable $errors:M01 := errors:getError("M01");
declare variable $errors:M02 := errors:getError("M02");
declare variable $errors:M03 := errors:getError("M03");
declare variable $errors:M04 := errors:getError("M04");
declare variable $errors:M05 := errors:getError("M05");
declare variable $errors:M06 := errors:getError("M06");
declare variable $errors:M07 := errors:getError("M07");
declare variable $errors:M07.1 := errors:getError("M7.1");
declare variable $errors:M08 := errors:getError("M08");
declare variable $errors:M12 := errors:getError("M12");
declare variable $errors:M15 := errors:getError("M15");
declare variable $errors:M18 := errors:getError("M18");
declare variable $errors:M19 := errors:getError("M19");
declare variable $errors:M20 := errors:getError("M20");
declare variable $errors:M23 := errors:getError("M23");
declare variable $errors:M24 := errors:getError("M24");
declare variable $errors:M25 := errors:getError("M25");
declare variable $errors:M26 := errors:getError("M26");
declare variable $errors:M27 := errors:getError("M27");
declare variable $errors:M28 := errors:getError("M28");
declare variable $errors:M28.1 := errors:getError("M28.1");
declare variable $errors:M29 := errors:getError("M29");
declare variable $errors:M30 := errors:getError("M30");
declare variable $errors:M34 := errors:getError("M34");
declare variable $errors:M35 := errors:getError("M35");
declare variable $errors:M39 := errors:getError("M39");
declare variable $errors:M40 := errors:getError("M40");
declare variable $errors:M41 := errors:getError("M41");
declare variable $errors:M41.1 := errors:getError("M41.1");
declare variable $errors:M43 := errors:getError("M43");
declare variable $errors:M45 := errors:getError("M45");
declare variable $errors:M46 := errors:getError("M46");
declare variable $errors:C6.1 := "Check that namespace is registered in vocabulary";
declare variable $errors:WARNING := "warning";
declare variable $errors:ERROR := "error";
declare variable $errors:INFO := "info";
declare variable $errors:SKIPPED := "skipped";
declare variable $errors:UNKNOWN := "unknown";
declare variable $errors:BLOCKER := "blocker";
declare variable $errors:FAILED := "failed";
declare variable $errors:COLOR_WARNING := "orange";
declare variable $errors:COLOR_ERROR := "red";
declare variable $errors:COLOR_INFO := "deepskyblue";
declare variable $errors:COLOR_SKIPPED := "grey";
declare variable $errors:COLOR_UNKNOWN := "grey";
declare variable $errors:COLOR_BLOCKER := "firebrick";
declare variable $errors:COLOR_FAILED := "black";
declare variable $errors:LOW_LIMIT := 100;
declare variable $errors:MEDIUM_LIMIT := 250;
declare variable $errors:HIGH_LIMIT := 500;
declare variable $errors:HIGHER_LIMIT := 1000;
declare variable $errors:MAX_LIMIT := 1500;
declare variable $labels:SHOWRECORDS := "Show Records";
declare variable $labels:SHOWERRORS := "Show Errors";
declare variable $labels:SHOWCOMBINATIONS := "Show Combinations";
declare variable $labels:SKIPPED := "Check Skipped";
declare variable $labels:ENV1 := "aqd:AQD_ReportingHeader element must be present.";
declare variable $labels:ENV2 := "The (start) year value must be equal to the year specified in (aqd:AQD_ReportingHeader) in the XML file and it must be between $1 - $2.";
declare variable $labels:ENV3 := "aqd:AQD_ReportingHeader must include aqd:inspireId, aqd:reportingAuthority, aqd:change elements";
declare variable $labels:ENV4 := "For aqd:AQD_ReportingHeader, if aqd:change='true', the following information must also be provided: aqd:AQD_ReportingHeader/aqd:changeDescription and aqd:AQD_ReportingHeader/aqd:content";
declare variable $labels:ENV5 := "For aqd:AQD_ReportingHeader, if aqd:change='false', element aqd:content IS NOT expected.";
declare variable $labels:XML := labels:getDefinition("XML");
declare variable $labels:XML_SHORT := labels:getPrefLabel("XML");
declare variable $labels:NAMESPACES := labels:getDefinition("NS");
declare variable $labels:NAMESPACES_SHORT := labels:getPrefLabel("NS");
declare variable $labels:B0 := labels:getDefinition("B0");
declare variable $labels:B0_SHORT := labels:getPrefLabel("B0");
declare variable $labels:B01 := labels:getDefinition("B01");
declare variable $labels:B01_SHORT := labels:getPrefLabel("B01");
declare variable $labels:B02 := labels:getDefinition("B02");
declare variable $labels:B02_SHORT := labels:getPrefLabel("B02");
declare variable $labels:B03 := labels:getDefinition("B03");
declare variable $labels:B03_SHORT := labels:getPrefLabel("B03");
declare variable $labels:B04 := labels:getDefinition("B04");
declare variable $labels:B04_SHORT := labels:getPrefLabel("B04");
declare variable $labels:B05 := labels:getDefinition("B05");
declare variable $labels:B05_SHORT := labels:getPrefLabel("B05");
declare variable $labels:B06a := labels:getDefinition("B06a");
declare variable $labels:B06a_SHORT := labels:getPrefLabel("B06a");
declare variable $labels:B06b := labels:getDefinition("B06b");
declare variable $labels:B06b_SHORT := labels:getPrefLabel("B06b");
declare variable $labels:B07 := labels:getDefinition("B07");
declare variable $labels:B07_SHORT := labels:getPrefLabel("B07");
declare variable $labels:B08 := labels:getDefinition("B08");
declare variable $labels:B08_SHORT := labels:getPrefLabel("B08");
declare variable $labels:B09 := labels:getDefinition("B09");
declare variable $labels:B09_SHORT := labels:getPrefLabel("B09");
declare variable $labels:B10 := labels:getDefinition("B10");
declare variable $labels:B10_SHORT := labels:getPrefLabel("B10");
declare variable $labels:B10.1 := labels:getDefinition("B10.1");
declare variable $labels:B10.1_SHORT := labels:getPrefLabel("B10.1");
declare variable $labels:B11 := labels:getDefinition("B11");
declare variable $labels:B11_SHORT := labels:getPrefLabel("B11");
declare variable $labels:B12 := labels:getDefinition("B12");
declare variable $labels:B12_SHORT := labels:getPrefLabel("B12");
declare variable $labels:B13 := labels:getDefinition("B13");
declare variable $labels:B13_SHORT := labels:getPrefLabel("B13");
declare variable $labels:B14 := labels:getDefinition("B14");
declare variable $labels:B14_SHORT := labels:getPrefLabel("B14");
declare variable $labels:B15 := labels:getDefinition("B15");
declare variable $labels:B15_SHORT := labels:getPrefLabel("B15");
declare variable $labels:B16 := labels:getDefinition("B16");
declare variable $labels:B16_SHORT := labels:getPrefLabel("B16");
declare variable $labels:B17 := labels:getDefinition("B17");
declare variable $labels:B17_SHORT := labels:getPrefLabel("B17");
declare variable $labels:B18 := labels:getDefinition("B18");
declare variable $labels:B18_SHORT := labels:getPrefLabel("B18");
declare variable $labels:B19 := labels:getDefinition("B19");
declare variable $labels:B19_SHORT := labels:getPrefLabel("B19");
declare variable $labels:B20 := labels:getDefinition("B20");
declare variable $labels:B20_SHORT := labels:getPrefLabel("B20");
declare variable $labels:B21 := labels:getDefinition("B21");
declare variable $labels:B21_SHORT := labels:getPrefLabel("B21");
declare variable $labels:B22 := labels:getDefinition("B22");
declare variable $labels:B22_SHORT := labels:getPrefLabel("B22");
declare variable $labels:B23 := labels:getDefinition("B23");
declare variable $labels:B23_SHORT := labels:getPrefLabel("B23");
declare variable $labels:B24 := labels:getDefinition("B24");
declare variable $labels:B24_SHORT := labels:getPrefLabel("B24");
declare variable $labels:B25 := labels:getDefinition("B25");
declare variable $labels:B25_SHORT := labels:getPrefLabel("B25");
declare variable $labels:B26 := labels:getDefinition("B26");
declare variable $labels:B26_SHORT := labels:getPrefLabel("B26");
declare variable $labels:B27 := labels:getDefinition("B27");
declare variable $labels:B27_SHORT := labels:getPrefLabel("B27");
declare variable $labels:B28 := labels:getDefinition("B28");
declare variable $labels:B28_SHORT := labels:getPrefLabel("B28");
declare variable $labels:B29 := labels:getDefinition("B29");
declare variable $labels:B29_SHORT := labels:getPrefLabel("B29");
declare variable $labels:B30 := labels:getDefinition("B30");
declare variable $labels:B30_SHORT := labels:getPrefLabel("B30");
declare variable $labels:B31 := labels:getDefinition("B31");
declare variable $labels:B31_SHORT := labels:getPrefLabel("B31");
declare variable $labels:B32 := labels:getDefinition("B32");
declare variable $labels:B32_SHORT := labels:getPrefLabel("B32");
declare variable $labels:B33 := labels:getDefinition("B33");
declare variable $labels:B33_SHORT := labels:getPrefLabel("B33");
declare variable $labels:B34 := labels:getDefinition("B34");
declare variable $labels:B34_SHORT := labels:getPrefLabel("B34");
declare variable $labels:B35 := labels:getDefinition("B35");
declare variable $labels:B35_SHORT := labels:getPrefLabel("B35");
declare variable $labels:B36 := labels:getDefinition("B36");
declare variable $labels:B36_SHORT := labels:getPrefLabel("B36");
declare variable $labels:B37 := labels:getDefinition("B37");
declare variable $labels:B37_SHORT := labels:getPrefLabel("B37");
declare variable $labels:B38 := labels:getDefinition("B38");
declare variable $labels:B38_SHORT := labels:getPrefLabel("B38");
declare variable $labels:B39a := labels:getDefinition("B39a");
declare variable $labels:B39a_SHORT := labels:getPrefLabel("B39a");
declare variable $labels:B39b := labels:getDefinition("B39b");
declare variable $labels:B39b_SHORT := labels:getPrefLabel("B39b");
declare variable $labels:B39c := labels:getDefinition("B39c");
declare variable $labels:B39c_SHORT := labels:getPrefLabel("B39c");
declare variable $labels:B40 := labels:getDefinition("B40");
declare variable $labels:B40_SHORT := labels:getPrefLabel("B40");
declare variable $labels:B41 := labels:getDefinition("B41");
declare variable $labels:B41_SHORT := labels:getPrefLabel("B41");
declare variable $labels:B42 := labels:getDefinition("B42");
declare variable $labels:B42_SHORT := labels:getPrefLabel("B42");
declare variable $labels:B43 := labels:getDefinition("B43");
declare variable $labels:B43_SHORT := labels:getPrefLabel("B43");
declare variable $labels:B44 := labels:getDefinition("B44");
declare variable $labels:B44_SHORT := labels:getPrefLabel("B44");
declare variable $labels:B45 := labels:getDefinition("B45");
declare variable $labels:B45_SHORT := labels:getPrefLabel("B45");
declare variable $labels:B46 := labels:getDefinition("B46");
declare variable $labels:B46_SHORT := labels:getPrefLabel("B46");
declare variable $labels:B47 := labels:getDefinition("B47");
declare variable $labels:B47_SHORT := labels:getPrefLabel("B47");
declare variable $labels:C0 := labels:getDefinition("C0");
declare variable $labels:C0_SHORT := labels:getPrefLabel("C0");
declare variable $labels:C01 := labels:getDefinition("C01");
declare variable $labels:C01_SHORT := labels:getPrefLabel("C01");
declare variable $labels:C02 := labels:getDefinition("C02");
declare variable $labels:C02_SHORT := labels:getPrefLabel("C02");
declare variable $labels:C03 := labels:getDefinition("C03");
declare variable $labels:C03_SHORT := labels:getPrefLabel("C03");
declare variable $labels:C04 := labels:getDefinition("C04");
declare variable $labels:C04_SHORT := labels:getPrefLabel("C04");
declare variable $labels:C05 := labels:getDefinition("C05");
declare variable $labels:C05_SHORT := labels:getPrefLabel("C05");
declare variable $labels:C06 := labels:getDefinition("C06");
declare variable $labels:C06_SHORT := labels:getPrefLabel("C06");
declare variable $labels:C07 := labels:getDefinition("C07");
declare variable $labels:C07_SHORT := labels:getPrefLabel("C07");
declare variable $labels:C08 := labels:getDefinition("C08");
declare variable $labels:C08_SHORT := labels:getPrefLabel("C08");
declare variable $labels:C09 := labels:getDefinition("C09");
declare variable $labels:C09_SHORT := labels:getPrefLabel("C09");
declare variable $labels:C10 := labels:getDefinition("C10");
declare variable $labels:C10_SHORT := labels:getPrefLabel("C10");
declare variable $labels:C11 := labels:getDefinition("C11");
declare variable $labels:C11_SHORT := labels:getPrefLabel("C11");
declare variable $labels:C12 := labels:getDefinition("C12");
declare variable $labels:C12_SHORT := labels:getPrefLabel("C12");
declare variable $labels:C13 := labels:getDefinition("C13");
declare variable $labels:C13_SHORT := labels:getPrefLabel("C13");
declare variable $labels:C14 := labels:getDefinition("C14");
declare variable $labels:C14_SHORT := labels:getPrefLabel("C14");
declare variable $labels:C15 := labels:getDefinition("C15");
declare variable $labels:C15_SHORT := labels:getPrefLabel("C15");
declare variable $labels:C16 := labels:getDefinition("C16");
declare variable $labels:C16_SHORT := labels:getPrefLabel("C16");
declare variable $labels:C17 := labels:getDefinition("C17");
declare variable $labels:C17_SHORT := labels:getPrefLabel("C17");
declare variable $labels:C18 := labels:getDefinition("C18");
declare variable $labels:C18_SHORT := labels:getPrefLabel("C18");
declare variable $labels:C19 := labels:getDefinition("C19");
declare variable $labels:C19_SHORT := labels:getPrefLabel("C19");
declare variable $labels:C20 := labels:getDefinition("C20");
declare variable $labels:C20_SHORT := labels:getPrefLabel("C20");
declare variable $labels:C21 := labels:getDefinition("C21");
declare variable $labels:C21_SHORT := labels:getPrefLabel("C21");
declare variable $labels:C22 := labels:getDefinition("C22");
declare variable $labels:C22_SHORT := labels:getPrefLabel("C22");
declare variable $labels:C23 := labels:getDefinition("C23");
declare variable $labels:C23_SHORT := labels:getPrefLabel("C23");
declare variable $labels:C23a := labels:getDefinition("C23a");
declare variable $labels:C23a_SHORT := labels:getPrefLabel("C23a");
declare variable $labels:C23b := labels:getDefinition("C23b");
declare variable $labels:C23b_SHORT := labels:getPrefLabel("C23b");
declare variable $labels:C24 := labels:getDefinition("C24");
declare variable $labels:C24_SHORT := labels:getPrefLabel("C24");
declare variable $labels:C25 := labels:getDefinition("C25");
declare variable $labels:C25_SHORT := labels:getPrefLabel("C25");
declare variable $labels:C26 := labels:getDefinition("C26");
declare variable $labels:C26_SHORT := labels:getPrefLabel("C26");
declare variable $labels:C27 := labels:getDefinition("C27");
declare variable $labels:C27_SHORT := labels:getPrefLabel("C27");
declare variable $labels:C28 := labels:getDefinition("C28");
declare variable $labels:C28_SHORT := labels:getPrefLabel("C28");
declare variable $labels:C29 := labels:getDefinition("C29");
declare variable $labels:C29_SHORT := labels:getPrefLabel("C29");
declare variable $labels:C31 := labels:getDefinition("C31");
declare variable $labels:C31_SHORT := labels:getPrefLabel("C31");
declare variable $labels:C32 := labels:getDefinition("C32");
declare variable $labels:C32_SHORT := labels:getPrefLabel("C32");
declare variable $labels:C33 := labels:getDefinition("C33");
declare variable $labels:C33_SHORT := labels:getPrefLabel("C33");
declare variable $labels:C35 := labels:getDefinition("C35");
declare variable $labels:C35_SHORT := labels:getPrefLabel("C35");
declare variable $labels:C37 := labels:getDefinition("C37");
declare variable $labels:C37_SHORT := labels:getPrefLabel("C37");
declare variable $labels:C38 := labels:getDefinition("C38");
declare variable $labels:C38_SHORT := labels:getPrefLabel("C38");
declare variable $labels:C40 := labels:getDefinition("C40");
declare variable $labels:C40_SHORT := labels:getPrefLabel("C40");
declare variable $labels:C41 := labels:getDefinition("C41");
declare variable $labels:C41_SHORT := labels:getPrefLabel("C41");
declare variable $labels:C42 := labels:getDefinition("C42");
declare variable $labels:C42_SHORT := labels:getPrefLabel("C42");
declare variable $labels:D0 := labels:getDefinition("D0");
declare variable $labels:D0_SHORT := labels:getPrefLabel("D0");
declare variable $labels:D01 := labels:getDefinition("D01");
declare variable $labels:D01_SHORT := labels:getPrefLabel("D01");
declare variable $labels:D02 := labels:getDefinition("D02");
declare variable $labels:D02_SHORT := labels:getPrefLabel("D02");
declare variable $labels:D03 := labels:getDefinition("D03");
declare variable $labels:D03_SHORT := labels:getPrefLabel("D03");
declare variable $labels:D04 := labels:getDefinition("D04");
declare variable $labels:D04_SHORT := labels:getPrefLabel("D04");
declare variable $labels:D05 := labels:getDefinition("D05");
declare variable $labels:D05_SHORT := labels:getPrefLabel("D05");
declare variable $labels:D06 := labels:getDefinition("D06");
declare variable $labels:D06_SHORT := labels:getPrefLabel("D06");
declare variable $labels:D07 := labels:getDefinition("D07");
declare variable $labels:D07_SHORT := labels:getPrefLabel("D07");
declare variable $labels:D07.1 := labels:getDefinition("D07.1");
declare variable $labels:D07.1_SHORT := labels:getPrefLabel("D07.1");
declare variable $labels:D08 := labels:getDefinition("D08");
declare variable $labels:D08_SHORT := labels:getPrefLabel("D08");
declare variable $labels:D09 := labels:getDefinition("D09");
declare variable $labels:D09_SHORT := labels:getPrefLabel("D09");
declare variable $labels:D10 := labels:getDefinition("D10");
declare variable $labels:D10_SHORT := labels:getPrefLabel("D10");
declare variable $labels:D11 := labels:getDefinition("D11");
declare variable $labels:D11_SHORT := labels:getPrefLabel("D11");
declare variable $labels:D12 := labels:getDefinition("D12");
declare variable $labels:D12_SHORT := labels:getPrefLabel("D12");
declare variable $labels:D14 := labels:getDefinition("D14");
declare variable $labels:D14_SHORT := labels:getPrefLabel("D14");
declare variable $labels:D15 := labels:getDefinition("D15");
declare variable $labels:D15_SHORT := labels:getPrefLabel("D15");
declare variable $labels:D16 := labels:getDefinition("D16");
declare variable $labels:D16_SHORT := labels:getPrefLabel("D16");
declare variable $labels:D16.1 := labels:getDefinition("D16.1");
declare variable $labels:D16.1_SHORT := labels:getPrefLabel("D16.1");
declare variable $labels:D17 := labels:getDefinition("D17");
declare variable $labels:D17_SHORT := labels:getPrefLabel("D17");
declare variable $labels:D18 := labels:getDefinition("D18");
declare variable $labels:D18_SHORT := labels:getPrefLabel("D18");
declare variable $labels:D19 := labels:getDefinition("D19");
declare variable $labels:D19_SHORT := labels:getPrefLabel("D19");
declare variable $labels:D20 := labels:getDefinition("D20");
declare variable $labels:D20_SHORT := labels:getPrefLabel("D20");
declare variable $labels:D21 := labels:getDefinition("D21");
declare variable $labels:D21_SHORT := labels:getPrefLabel("D21");
declare variable $labels:D23 := labels:getDefinition("D23");
declare variable $labels:D23_SHORT := labels:getPrefLabel("D23");
declare variable $labels:D24 := labels:getDefinition("D24");
declare variable $labels:D24_SHORT := labels:getPrefLabel("D24");
declare variable $labels:D26 := labels:getDefinition("D26");
declare variable $labels:D26_SHORT := labels:getPrefLabel("D26");
declare variable $labels:D27 := labels:getDefinition("D27");
declare variable $labels:D27_SHORT := labels:getPrefLabel("D27");
declare variable $labels:D28 := labels:getDefinition("D28");
declare variable $labels:D28_SHORT := labels:getPrefLabel("D28");
declare variable $labels:D29 := labels:getDefinition("D29");
declare variable $labels:D29_SHORT := labels:getPrefLabel("D29");
declare variable $labels:D30 := labels:getDefinition("D30");
declare variable $labels:D30_SHORT := labels:getPrefLabel("D30");
declare variable $labels:D31 := labels:getDefinition("D31");
declare variable $labels:D31_SHORT := labels:getPrefLabel("D31");
declare variable $labels:D32 := labels:getDefinition("D32");
declare variable $labels:D32_SHORT := labels:getPrefLabel("D32");
declare variable $labels:D32.1 := labels:getDefinition("D32.1");
declare variable $labels:D32.1_SHORT := labels:getPrefLabel("D32.1");
declare variable $labels:D33 := labels:getDefinition("D33");
declare variable $labels:D33_SHORT := labels:getPrefLabel("D33");
declare variable $labels:D34 := labels:getDefinition("D34");
declare variable $labels:D34_SHORT := labels:getPrefLabel("D34");
declare variable $labels:D35 := labels:getDefinition("D35");
declare variable $labels:D35_SHORT := labels:getPrefLabel("D35");
declare variable $labels:D36 := labels:getDefinition("D36");
declare variable $labels:D36_SHORT := labels:getPrefLabel("D36");
declare variable $labels:D37 := labels:getDefinition("D37");
declare variable $labels:D37_SHORT := labels:getPrefLabel("D37");
declare variable $labels:D40 := labels:getDefinition("D40");
declare variable $labels:D40_SHORT := labels:getPrefLabel("D40");
declare variable $labels:D41 := labels:getDefinition("D41");
declare variable $labels:D41_SHORT := labels:getPrefLabel("D41");
declare variable $labels:D42 := labels:getDefinition("D42");
declare variable $labels:D42_SHORT := labels:getPrefLabel("D42");
declare variable $labels:D43 := labels:getDefinition("D43");
declare variable $labels:D43_SHORT := labels:getPrefLabel("D43");
declare variable $labels:D44 := labels:getDefinition("D44");
declare variable $labels:D44_SHORT := labels:getPrefLabel("D44");
declare variable $labels:D44b := labels:getDefinition("D44b");
declare variable $labels:D44b_SHORT := labels:getPrefLabel("D44b");
declare variable $labels:D45 := labels:getDefinition("D45");
declare variable $labels:D45_SHORT := labels:getPrefLabel("D45");
declare variable $labels:D46 := labels:getDefinition("D46");
declare variable $labels:D46_SHORT := labels:getPrefLabel("D46");
declare variable $labels:D48 := labels:getDefinition("D48");
declare variable $labels:D48_SHORT := labels:getPrefLabel("D48");
declare variable $labels:D50 := labels:getDefinition("D50");
declare variable $labels:D50_SHORT := labels:getPrefLabel("D50");
declare variable $labels:D51 := labels:getDefinition("D51");
declare variable $labels:D51_SHORT := labels:getPrefLabel("D51");
declare variable $labels:D52 := labels:getDefinition("D52");
declare variable $labels:D52_SHORT := labels:getPrefLabel("D52");
declare variable $labels:D53 := labels:getDefinition("D53");
declare variable $labels:D53_SHORT := labels:getPrefLabel("D53");
declare variable $labels:D54 := labels:getDefinition("D54");
declare variable $labels:D54_SHORT := labels:getPrefLabel("D54");
declare variable $labels:D55 := labels:getDefinition("D55");
declare variable $labels:D55_SHORT := labels:getPrefLabel("D55");
declare variable $labels:D55.1 := labels:getDefinition("D55.1");
declare variable $labels:D55.1_SHORT := labels:getPrefLabel("D55.1");
declare variable $labels:D56 := labels:getDefinition("D56");
declare variable $labels:D56_SHORT := labels:getPrefLabel("D56");
declare variable $labels:D57 := labels:getDefinition("D57");
declare variable $labels:D57_SHORT := labels:getPrefLabel("D57");
declare variable $labels:D58 := labels:getDefinition("D58");
declare variable $labels:D58_SHORT := labels:getPrefLabel("D58");
declare variable $labels:D59 := labels:getDefinition("D59");
declare variable $labels:D59_SHORT := labels:getPrefLabel("D59");
declare variable $labels:D60a := labels:getDefinition("D60a");
declare variable $labels:D60a_SHORT := labels:getPrefLabel("D60a");
declare variable $labels:D60b := labels:getDefinition("D60b");
declare variable $labels:D60b_SHORT := labels:getPrefLabel("D60b");
declare variable $labels:D61 := labels:getDefinition("D61");
declare variable $labels:D61_SHORT := labels:getPrefLabel("D61");
declare variable $labels:D62 := labels:getDefinition("D62");
declare variable $labels:D62_SHORT := labels:getPrefLabel("D62");
declare variable $labels:D63 := labels:getDefinition("D63");
declare variable $labels:D63_SHORT := labels:getPrefLabel("D63");
declare variable $labels:D65 := labels:getDefinition("D65");
declare variable $labels:D65_SHORT := labels:getPrefLabel("D65");
declare variable $labels:D67a := labels:getDefinition("D67a");
declare variable $labels:D67a_SHORT := labels:getPrefLabel("D67a");
declare variable $labels:D67b := labels:getDefinition("D67b");
declare variable $labels:D67b_SHORT := labels:getPrefLabel("D67b");
declare variable $labels:D68 := labels:getDefinition("D68");
declare variable $labels:D68_SHORT := labels:getPrefLabel("D68");
declare variable $labels:D69 := labels:getDefinition("D69");
declare variable $labels:D69_SHORT := labels:getPrefLabel("D69");
declare variable $labels:D71 := labels:getDefinition("D71");
declare variable $labels:D71_SHORT := labels:getPrefLabel("D71");
declare variable $labels:D72 := labels:getDefinition("D72");
declare variable $labels:D72_SHORT := labels:getPrefLabel("D72");
declare variable $labels:D72.1 := labels:getDefinition("D72.1");
declare variable $labels:D72.1_SHORT := labels:getPrefLabel("D72.1");
declare variable $labels:D73 := labels:getDefinition("D73");
declare variable $labels:D73_SHORT := labels:getPrefLabel("D73");
declare variable $labels:D74 := labels:getDefinition("D74");
declare variable $labels:D74_SHORT := labels:getPrefLabel("D74");
declare variable $labels:D75 := labels:getDefinition("D75");
declare variable $labels:D75_SHORT := labels:getPrefLabel("D75");
declare variable $labels:D76 := labels:getDefinition("D76");
declare variable $labels:D76_SHORT := labels:getPrefLabel("D76");
declare variable $labels:D77 := labels:getDefinition("D77");
declare variable $labels:D77_SHORT := labels:getPrefLabel("D77");
declare variable $labels:D78 := labels:getDefinition("D78");
declare variable $labels:D78_SHORT := labels:getPrefLabel("D78");
declare variable $labels:D91 := labels:getDefinition("D91");
declare variable $labels:D91_SHORT := labels:getPrefLabel("D91");
declare variable $labels:D92 := labels:getDefinition("D92");
declare variable $labels:D92_SHORT := labels:getPrefLabel("D92");
declare variable $labels:D93 := labels:getDefinition("D93");
declare variable $labels:D93_SHORT := labels:getPrefLabel("D93");
declare variable $labels:D94 := labels:getDefinition("D94");
declare variable $labels:D94_SHORT := labels:getPrefLabel("D94");
declare variable $labels:E0 := labels:getDefinition("E0");
declare variable $labels:E0_SHORT := labels:getPrefLabel("E0");
declare variable $labels:E01a := labels:getDefinition("E01a");
declare variable $labels:E01a_SHORT := labels:getPrefLabel("E01a");
declare variable $labels:E01b := labels:getDefinition("E01b");
declare variable $labels:E01b_SHORT := labels:getPrefLabel("E01b");
declare variable $labels:E02 := labels:getDefinition("E02");
declare variable $labels:E02_SHORT := labels:getPrefLabel("E02");
declare variable $labels:E03 := labels:getDefinition("E03");
declare variable $labels:E03_SHORT := labels:getPrefLabel("E03");
declare variable $labels:E04 := labels:getDefinition("E04");
declare variable $labels:E04_SHORT := labels:getPrefLabel("E04");
declare variable $labels:E05 := labels:getDefinition("E05");
declare variable $labels:E05_SHORT := labels:getPrefLabel("E05");
declare variable $labels:E06 := labels:getDefinition("E06");
declare variable $labels:E06_SHORT := labels:getPrefLabel("E06");
declare variable $labels:E07 := labels:getDefinition("E07");
declare variable $labels:E07_SHORT := labels:getPrefLabel("E07");
declare variable $labels:E08 := labels:getDefinition("E08");
declare variable $labels:E08_SHORT := labels:getPrefLabel("E08");
declare variable $labels:E09 := labels:getDefinition("E09");
declare variable $labels:E09_SHORT := labels:getPrefLabel("E09");
declare variable $labels:E10 := labels:getDefinition("E10");
declare variable $labels:E10_SHORT := labels:getPrefLabel("E10");
declare variable $labels:E11 := labels:getDefinition("E11");
declare variable $labels:E11_SHORT := labels:getPrefLabel("E11");
declare variable $labels:E12 := labels:getDefinition("E12");
declare variable $labels:E12_SHORT := labels:getPrefLabel("E12");
declare variable $labels:E15 := labels:getDefinition("E15");
declare variable $labels:E15_SHORT := labels:getPrefLabel("E15");
declare variable $labels:E16 := labels:getDefinition("E16");
declare variable $labels:E16_SHORT := labels:getPrefLabel("E16");
declare variable $labels:E17 := labels:getDefinition("E17");
declare variable $labels:E17_SHORT := labels:getPrefLabel("E17");
declare variable $labels:E18 := labels:getDefinition("E18");
declare variable $labels:E18_SHORT := labels:getPrefLabel("E18");
declare variable $labels:E19 := labels:getDefinition("E19");
declare variable $labels:E19_SHORT := labels:getPrefLabel("E19");
declare variable $labels:E19b := labels:getDefinition("E19b");
declare variable $labels:E19b_SHORT := labels:getPrefLabel("E19b");
declare variable $labels:E20 := labels:getDefinition("E20");
declare variable $labels:E20_SHORT := labels:getPrefLabel("E20");
declare variable $labels:E21 := labels:getDefinition("E21");
declare variable $labels:E21_SHORT := labels:getPrefLabel("E21");
declare variable $labels:E22 := labels:getDefinition("E22");
declare variable $labels:E22_SHORT := labels:getPrefLabel("E22");
declare variable $labels:E23 := labels:getDefinition("E23");
declare variable $labels:E23_SHORT := labels:getPrefLabel("E23");
declare variable $labels:E24 := labels:getDefinition("E24");
declare variable $labels:E24_SHORT := labels:getPrefLabel("E24");
declare variable $labels:E25 := labels:getDefinition("E25");
declare variable $labels:E25_SHORT := labels:getPrefLabel("E25");
declare variable $labels:E26 := labels:getDefinition("E26");
declare variable $labels:E26_SHORT := labels:getPrefLabel("E26");
declare variable $labels:E27 := labels:getDefinition("E27");
declare variable $labels:E27_SHORT := labels:getPrefLabel("E27");
declare variable $labels:E28 := labels:getDefinition("E28");
declare variable $labels:E28_SHORT := labels:getPrefLabel("E28");
declare variable $labels:E29 := labels:getDefinition("E29");
declare variable $labels:E29_SHORT := labels:getPrefLabel("E29");
declare variable $labels:E30 := labels:getDefinition("E30");
declare variable $labels:E30_SHORT := labels:getPrefLabel("E30");
declare variable $labels:E31 := labels:getDefinition("E31");
declare variable $labels:E31_SHORT := labels:getPrefLabel("E31");
declare variable $labels:E32 := labels:getDefinition("E32");
declare variable $labels:E32_SHORT := labels:getPrefLabel("E32");
declare variable $labels:Eb0 := labels:getDefinition("Eb0");
declare variable $labels:Eb0_SHORT := labels:getPrefLabel("Eb0");
declare variable $labels:Eb01 := labels:getDefinition("Eb01");
declare variable $labels:Eb01_SHORT := labels:getPrefLabel("Eb01");
declare variable $labels:Eb02 := labels:getDefinition("Eb02");
declare variable $labels:Eb02_SHORT := labels:getPrefLabel("Eb02");
declare variable $labels:Eb03 := labels:getDefinition("Eb03");
declare variable $labels:Eb03_SHORT := labels:getPrefLabel("Eb03");
declare variable $labels:Eb04 := labels:getDefinition("Eb04");
declare variable $labels:Eb04_SHORT := labels:getPrefLabel("Eb04");
declare variable $labels:Eb05 := labels:getDefinition("Eb05");
declare variable $labels:Eb05_SHORT := labels:getPrefLabel("Eb05");
declare variable $labels:Eb06 := labels:getDefinition("Eb06");
declare variable $labels:Eb06_SHORT := labels:getPrefLabel("Eb06");
declare variable $labels:Eb07 := labels:getDefinition("Eb07");
declare variable $labels:Eb07_SHORT := labels:getPrefLabel("Eb07");
declare variable $labels:Eb08 := labels:getDefinition("Eb08");
declare variable $labels:Eb08_SHORT := labels:getPrefLabel("Eb08");
declare variable $labels:Eb09 := labels:getDefinition("Eb09");
declare variable $labels:Eb09_SHORT := labels:getPrefLabel("Eb09");
declare variable $labels:Eb10 := labels:getDefinition("Eb10");
declare variable $labels:Eb10_SHORT := labels:getPrefLabel("Eb10");
declare variable $labels:Eb11 := labels:getDefinition("Eb11");
declare variable $labels:Eb11_SHORT := labels:getPrefLabel("Eb11");
declare variable $labels:Eb12 := labels:getDefinition("Eb12");
declare variable $labels:Eb12_SHORT := labels:getPrefLabel("Eb12");
declare variable $labels:Eb13 := labels:getDefinition("Eb13");
declare variable $labels:Eb13_SHORT := labels:getPrefLabel("Eb13");
declare variable $labels:Eb14 := labels:getDefinition("Eb14");
declare variable $labels:Eb14_SHORT := labels:getPrefLabel("Eb14");
declare variable $labels:Eb14b := labels:getDefinition("Eb14b");
declare variable $labels:Eb14b_SHORT := labels:getPrefLabel("Eb14b");
declare variable $labels:Eb15 := labels:getDefinition("Eb15");
declare variable $labels:Eb15_SHORT := labels:getPrefLabel("Eb15");
declare variable $labels:Eb16 := labels:getDefinition("Eb16");
declare variable $labels:Eb16_SHORT := labels:getPrefLabel("Eb16");
declare variable $labels:Eb17 := labels:getDefinition("Eb17");
declare variable $labels:Eb17_SHORT := labels:getPrefLabel("Eb17");
declare variable $labels:Eb18 := labels:getDefinition("Eb18");
declare variable $labels:Eb18_SHORT := labels:getPrefLabel("Eb18");
declare variable $labels:Eb19 := labels:getDefinition("Eb19");
declare variable $labels:Eb19_SHORT := labels:getPrefLabel("Eb19");
declare variable $labels:Eb19b := labels:getDefinition("Eb19b");
declare variable $labels:Eb19b_SHORT := labels:getPrefLabel("Eb19b");
declare variable $labels:Eb20 := labels:getDefinition("Eb20");
declare variable $labels:Eb20_SHORT := labels:getPrefLabel("Eb20");
declare variable $labels:Eb21 := labels:getDefinition("Eb21");
declare variable $labels:Eb21_SHORT := labels:getPrefLabel("Eb21");
declare variable $labels:Eb22 := labels:getDefinition("Eb22");
declare variable $labels:Eb22_SHORT := labels:getPrefLabel("Eb22");
declare variable $labels:Eb23 := labels:getDefinition("Eb23");
declare variable $labels:Eb23_SHORT := labels:getPrefLabel("Eb23");
declare variable $labels:Eb24 := labels:getDefinition("Eb24");
declare variable $labels:Eb24_SHORT := labels:getPrefLabel("Eb24");
declare variable $labels:Eb25 := labels:getDefinition("Eb25");
declare variable $labels:Eb25_SHORT := labels:getPrefLabel("Eb25");
declare variable $labels:Eb26 := labels:getDefinition("Eb26");
declare variable $labels:Eb26_SHORT := labels:getPrefLabel("Eb26");
declare variable $labels:Eb27 := labels:getDefinition("Eb27");
declare variable $labels:Eb27_SHORT := labels:getPrefLabel("Eb27");
declare variable $labels:Eb28 := labels:getDefinition("Eb28");
declare variable $labels:Eb28_SHORT := labels:getPrefLabel("Eb28");
declare variable $labels:Eb29 := labels:getDefinition("Eb29");
declare variable $labels:Eb29_SHORT := labels:getPrefLabel("Eb29");
declare variable $labels:Eb30 := labels:getDefinition("Eb30");
declare variable $labels:Eb30_SHORT := labels:getPrefLabel("Eb30");
declare variable $labels:Eb31 := labels:getDefinition("Eb31");
declare variable $labels:Eb31_SHORT := labels:getPrefLabel("Eb31");
declare variable $labels:Eb32 := labels:getDefinition("Eb32");
declare variable $labels:Eb32_SHORT := labels:getPrefLabel("Eb32");
declare variable $labels:Eb35 := labels:getDefinition("Eb35");
declare variable $labels:Eb35_SHORT := labels:getPrefLabel("Eb35");
declare variable $labels:Eb36 := labels:getDefinition("Eb36");
declare variable $labels:Eb36_SHORT := labels:getPrefLabel("Eb36");
declare variable $labels:Eb37 := labels:getDefinition("Eb37");
declare variable $labels:Eb37_SHORT := labels:getPrefLabel("Eb37");
declare variable $labels:Eb38 := labels:getDefinition("Eb38");
declare variable $labels:Eb38_SHORT := labels:getPrefLabel("Eb38");
declare variable $labels:Eb39 := labels:getDefinition("Eb39");
declare variable $labels:Eb39_SHORT := labels:getPrefLabel("Eb39");
declare variable $labels:Eb40 := labels:getDefinition("Eb40");
declare variable $labels:Eb40_SHORT := labels:getPrefLabel("Eb40");
declare variable $labels:Eb41 := labels:getDefinition("Eb41");
declare variable $labels:Eb41_SHORT := labels:getPrefLabel("Eb41");
declare variable $labels:Eb42 := labels:getDefinition("Eb42");
declare variable $labels:Eb42_SHORT := labels:getPrefLabel("Eb42");
declare variable $labels:G0 := labels:getDefinition("G0");
declare variable $labels:G0_SHORT := labels:getPrefLabel("G0");
declare variable $labels:G01 := labels:getDefinition("G01");
declare variable $labels:G01_SHORT := labels:getPrefLabel("G01");
declare variable $labels:G02 := labels:getDefinition("G02");
declare variable $labels:G02_SHORT := labels:getPrefLabel("G02");
declare variable $labels:G03 := labels:getDefinition("G03");
declare variable $labels:G03_SHORT := labels:getPrefLabel("G03");
declare variable $labels:G04 := labels:getDefinition("G04");
declare variable $labels:G04_SHORT := labels:getPrefLabel("G04");
declare variable $labels:G05 := labels:getDefinition("G05");
declare variable $labels:G05_SHORT := labels:getPrefLabel("G05");
declare variable $labels:G06 := labels:getDefinition("G06");
declare variable $labels:G06_SHORT := labels:getPrefLabel("G06");
declare variable $labels:G07 := labels:getDefinition("G07");
declare variable $labels:G07_SHORT := labels:getPrefLabel("G07");
declare variable $labels:G08 := labels:getDefinition("G08");
declare variable $labels:G08_SHORT := labels:getPrefLabel("G08");
declare variable $labels:G09 := labels:getDefinition("G09");
declare variable $labels:G09_SHORT := labels:getPrefLabel("G09");
declare variable $labels:G09.1 := labels:getDefinition("G09.1");
declare variable $labels:G09.1_SHORT := labels:getPrefLabel("G09.1");
declare variable $labels:G10 := labels:getDefinition("G10");
declare variable $labels:G10_SHORT := labels:getPrefLabel("G10");
declare variable $labels:G11 := labels:getDefinition("G11");
declare variable $labels:G11_SHORT := labels:getPrefLabel("G11");
declare variable $labels:G12 := labels:getDefinition("G12");
declare variable $labels:G12_SHORT := labels:getPrefLabel("G12");
declare variable $labels:G13 := labels:getDefinition("G13");
declare variable $labels:G13_SHORT := labels:getPrefLabel("G13");
declare variable $labels:G13b := labels:getDefinition("G13b");
declare variable $labels:G13b_SHORT := labels:getPrefLabel("G13b");
declare variable $labels:G13c := labels:getDefinition("G13c");
declare variable $labels:G13c_SHORT := labels:getPrefLabel("G13c");
declare variable $labels:G14 := labels:getDefinition("G14");
declare variable $labels:G14_SHORT := labels:getPrefLabel("G14");
declare variable $labels:G14b := labels:getDefinition("G14b");
declare variable $labels:G14b_SHORT := labels:getPrefLabel("G14b");
declare variable $labels:G15 := labels:getDefinition("G15");
declare variable $labels:G15_SHORT := labels:getPrefLabel("G15");
declare variable $labels:G17 := labels:getDefinition("G17");
declare variable $labels:G17_SHORT := labels:getPrefLabel("G17");
declare variable $labels:G18 := labels:getDefinition("G18");
declare variable $labels:G18_SHORT := labels:getPrefLabel("G18");
declare variable $labels:G19 := labels:getDefinition("G19");
declare variable $labels:G19_SHORT := labels:getPrefLabel("G19");
declare variable $labels:G20 := labels:getDefinition("G20");
declare variable $labels:G20_SHORT := labels:getPrefLabel("G20");
declare variable $labels:G21 := labels:getDefinition("G21");
declare variable $labels:G21_SHORT := labels:getPrefLabel("G21");
declare variable $labels:G22 := labels:getDefinition("G22");
declare variable $labels:G22_SHORT := labels:getPrefLabel("G22");
declare variable $labels:G23 := labels:getDefinition("G23");
declare variable $labels:G23_SHORT := labels:getPrefLabel("G23");
declare variable $labels:G24 := labels:getDefinition("G24");
declare variable $labels:G24_SHORT := labels:getPrefLabel("G24");
declare variable $labels:G25 := labels:getDefinition("G25");
declare variable $labels:G25_SHORT := labels:getPrefLabel("G25");
declare variable $labels:G26 := labels:getDefinition("G26");
declare variable $labels:G26_SHORT := labels:getPrefLabel("G26");
declare variable $labels:G27 := labels:getDefinition("G27");
declare variable $labels:G27_SHORT := labels:getPrefLabel("G27");
declare variable $labels:G28 := labels:getDefinition("G28");
declare variable $labels:G28_SHORT := labels:getPrefLabel("G28");
declare variable $labels:G29 := labels:getDefinition("G29");
declare variable $labels:G29_SHORT := labels:getPrefLabel("G29");
declare variable $labels:G30 := labels:getDefinition("G30");
declare variable $labels:G30_SHORT := labels:getPrefLabel("G30");
declare variable $labels:G31 := labels:getDefinition("G31");
declare variable $labels:G31_SHORT := labels:getPrefLabel("G31");
declare variable $labels:G32 := labels:getDefinition("G32");
declare variable $labels:G32_SHORT := labels:getPrefLabel("G32");
declare variable $labels:G33 := labels:getDefinition("G33");
declare variable $labels:G33_SHORT := labels:getPrefLabel("G33");
declare variable $labels:G38 := labels:getDefinition("G38");
declare variable $labels:G38_SHORT := labels:getPrefLabel("G38");
declare variable $labels:G39 := labels:getDefinition("G39");
declare variable $labels:G39_SHORT := labels:getPrefLabel("G39");
declare variable $labels:G40 := labels:getDefinition("G40");
declare variable $labels:G40_SHORT := labels:getPrefLabel("G40");
declare variable $labels:G41 := labels:getDefinition("G41");
declare variable $labels:G41_SHORT := labels:getPrefLabel("G41");
declare variable $labels:G42 := labels:getDefinition("G42");
declare variable $labels:G42_SHORT := labels:getPrefLabel("G42");
declare variable $labels:G44 := labels:getDefinition("G44");
declare variable $labels:G44_SHORT := labels:getPrefLabel("G44");
declare variable $labels:G45 := labels:getDefinition("G45");
declare variable $labels:G45_SHORT := labels:getPrefLabel("G45");
declare variable $labels:G46 := labels:getDefinition("G46");
declare variable $labels:G46_SHORT := labels:getPrefLabel("G46");
declare variable $labels:G47 := labels:getDefinition("G47");
declare variable $labels:G47_SHORT := labels:getPrefLabel("G47");
declare variable $labels:G52 := labels:getDefinition("G52");
declare variable $labels:G52_SHORT := labels:getPrefLabel("52");
declare variable $labels:G53 := labels:getDefinition("G53");
declare variable $labels:G53_SHORT := labels:getPrefLabel("53");
declare variable $labels:G54 := labels:getDefinition("G54");
declare variable $labels:G54_SHORT := labels:getPrefLabel("G54");
declare variable $labels:G55 := labels:getDefinition("G55");
declare variable $labels:G55_SHORT := labels:getPrefLabel("G55");
declare variable $labels:G56 := labels:getDefinition("G56");
declare variable $labels:G56_SHORT := labels:getPrefLabel("G56");
declare variable $labels:G58 := labels:getDefinition("G58");
declare variable $labels:G58_SHORT := labels:getPrefLabel("G58");
declare variable $labels:G59 := labels:getDefinition("G59");
declare variable $labels:G59_SHORT := labels:getPrefLabel("G59");
declare variable $labels:G60 := labels:getDefinition("G60");
declare variable $labels:G60_SHORT := labels:getPrefLabel("G60");
declare variable $labels:G61 := labels:getDefinition("G61");
declare variable $labels:G61_SHORT := labels:getPrefLabel("G61");
declare variable $labels:G62 := labels:getDefinition("G62");
declare variable $labels:G62_SHORT := labels:getPrefLabel("G62");
declare variable $labels:G63 := labels:getDefinition("G63");
declare variable $labels:G63_SHORT := labels:getPrefLabel("G63");
declare variable $labels:G64 := labels:getDefinition("G64");
declare variable $labels:G64_SHORT := labels:getPrefLabel("G64");
declare variable $labels:G65 := labels:getDefinition("G65");
declare variable $labels:G65_SHORT := labels:getPrefLabel("G65");
declare variable $labels:G66 := labels:getDefinition("G66");
declare variable $labels:G66_SHORT := labels:getPrefLabel("G66");
declare variable $labels:G67 := labels:getDefinition("G67");
declare variable $labels:G67_SHORT := labels:getPrefLabel("G67");
declare variable $labels:G70 := labels:getDefinition("G70");
declare variable $labels:G70_SHORT := labels:getPrefLabel("G70");
declare variable $labels:G71 := labels:getDefinition("G71");
declare variable $labels:G71_SHORT := labels:getPrefLabel("G71");
declare variable $labels:G72 := labels:getDefinition("G72");
declare variable $labels:G72_SHORT := labels:getPrefLabel("G72");
declare variable $labels:G73 := labels:getDefinition("G73");
declare variable $labels:G73_SHORT := labels:getPrefLabel("G73");
declare variable $labels:G74 := labels:getDefinition("G714");
declare variable $labels:G74_SHORT := labels:getPrefLabel("G74");
declare variable $labels:G75 := labels:getDefinition("G75");
declare variable $labels:G75_SHORT := labels:getPrefLabel("G75");
declare variable $labels:G76 := labels:getDefinition("G76");
declare variable $labels:G76_SHORT := labels:getPrefLabel("G76");
declare variable $labels:G78 := labels:getDefinition("G78");
declare variable $labels:G78_SHORT := labels:getPrefLabel("G78");
declare variable $labels:G79 := labels:getDefinition("G79");
declare variable $labels:G79_SHORT := labels:getPrefLabel("G79");
declare variable $labels:G80 := labels:getDefinition("G80");
declare variable $labels:G80_SHORT := labels:getPrefLabel("G80");
declare variable $labels:G81 := labels:getDefinition("G81");
declare variable $labels:G81_SHORT := labels:getPrefLabel("G81");
declare variable $labels:G85 := labels:getDefinition("G85");
declare variable $labels:G85_SHORT := labels:getPrefLabel("G85");
declare variable $labels:G86 := labels:getDefinition("G86");
declare variable $labels:G86_SHORT := labels:getPrefLabel("G86");
declare variable $labels:H0 := labels:getDefinition("H0");
declare variable $labels:H0_SHORT := labels:getPrefLabel("H0");
declare variable $labels:H01 := labels:getDefinition("H01");
declare variable $labels:H01_SHORT := labels:getPrefLabel("H01");
declare variable $labels:H02 := labels:getDefinition("H02");
declare variable $labels:H02_SHORT := labels:getPrefLabel("H02");
declare variable $labels:H03 := labels:getDefinition("H03");
declare variable $labels:H03_SHORT := labels:getPrefLabel("H03");
declare variable $labels:H04 := labels:getDefinition("H04");
declare variable $labels:H04_SHORT := labels:getPrefLabel("H04");
declare variable $labels:H05 := labels:getDefinition("H05");
declare variable $labels:H05_SHORT := labels:getPrefLabel("H05");
declare variable $labels:H06 := labels:getDefinition("H06");
declare variable $labels:H06_SHORT := labels:getPrefLabel("H06");
declare variable $labels:H07 := labels:getDefinition("H07");
declare variable $labels:H07_SHORT := labels:getPrefLabel("H07");
declare variable $labels:H08 := labels:getDefinition("H08");
declare variable $labels:H08_SHORT := labels:getPrefLabel("H08");
declare variable $labels:H09 := labels:getDefinition("H09");
declare variable $labels:H09_SHORT := labels:getPrefLabel("H09");
declare variable $labels:H10 := labels:getDefinition("H10");
declare variable $labels:H10_SHORT := labels:getPrefLabel("H10");
declare variable $labels:H11 := labels:getDefinition("H11");
declare variable $labels:H11_SHORT := labels:getPrefLabel("H11");
declare variable $labels:H12 := labels:getDefinition("H12");
declare variable $labels:H12_SHORT := labels:getPrefLabel("H12");
declare variable $labels:H13 := labels:getDefinition("H13");
declare variable $labels:H13_SHORT := labels:getPrefLabel("H13");
declare variable $labels:H14 := labels:getDefinition("H14");
declare variable $labels:H14_SHORT := labels:getPrefLabel("H14");
declare variable $labels:H15 := labels:getDefinition("H15");
declare variable $labels:H15_SHORT := labels:getPrefLabel("H15");
declare variable $labels:H16 := labels:getDefinition("H16");
declare variable $labels:H16_SHORT := labels:getPrefLabel("H16");
declare variable $labels:H17 := labels:getDefinition("H17");
declare variable $labels:H17_SHORT := labels:getPrefLabel("H17");
declare variable $labels:H18 := labels:getDefinition("H18");
declare variable $labels:H18_SHORT := labels:getPrefLabel("H18");
declare variable $labels:H19 := labels:getDefinition("H19");
declare variable $labels:H19_SHORT := labels:getPrefLabel("H19");
declare variable $labels:H20 := labels:getDefinition("H20");
declare variable $labels:H20_SHORT := labels:getPrefLabel("H20");
declare variable $labels:H21 := labels:getDefinition("H21");
declare variable $labels:H21_SHORT := labels:getPrefLabel("H21");
declare variable $labels:H22 := labels:getDefinition("H22");
declare variable $labels:H22_SHORT := labels:getPrefLabel("H22");
declare variable $labels:H23 := labels:getDefinition("H23");
declare variable $labels:H23_SHORT := labels:getPrefLabel("H23");
declare variable $labels:H24 := labels:getDefinition("H24");
declare variable $labels:H24_SHORT := labels:getPrefLabel("H24");
declare variable $labels:H25 := labels:getDefinition("H25");
declare variable $labels:H25_SHORT := labels:getPrefLabel("H25");
declare variable $labels:H26 := labels:getDefinition("H26");
declare variable $labels:H26_SHORT := labels:getPrefLabel("H26");
declare variable $labels:H27 := labels:getDefinition("H27");
declare variable $labels:H27_SHORT := labels:getPrefLabel("H27");
declare variable $labels:H28 := labels:getDefinition("H28");
declare variable $labels:H28_SHORT := labels:getPrefLabel("H28");
declare variable $labels:H29 := labels:getDefinition("H29");
declare variable $labels:H29_SHORT := labels:getPrefLabel("H29");
declare variable $labels:H30 := labels:getDefinition("H30");
declare variable $labels:H30_SHORT := labels:getPrefLabel("H30");
declare variable $labels:H31 := labels:getDefinition("H31");
declare variable $labels:H31_SHORT := labels:getPrefLabel("H31");
declare variable $labels:H32 := labels:getDefinition("H32");
declare variable $labels:H32_SHORT := labels:getPrefLabel("H32");
declare variable $labels:H33 := labels:getDefinition("H33");
declare variable $labels:H33_SHORT := labels:getPrefLabel("H33");
declare variable $labels:H34 := labels:getDefinition("H34");
declare variable $labels:H34_SHORT := labels:getPrefLabel("H34");
declare variable $labels:H35 := labels:getDefinition("H35");
declare variable $labels:H35_SHORT := labels:getPrefLabel("H35");
declare variable $labels:I0 := labels:getDefinition("I0");
declare variable $labels:I0_SHORT := labels:getPrefLabel("I0");
declare variable $labels:I01 := labels:getDefinition("I01");
declare variable $labels:I01_SHORT := labels:getPrefLabel("I01");
declare variable $labels:I02 := labels:getDefinition("I02");
declare variable $labels:I02_SHORT := labels:getPrefLabel("I02");
declare variable $labels:I03 := labels:getDefinition("I03");
declare variable $labels:I03_SHORT := labels:getPrefLabel("I03");
declare variable $labels:I04 := labels:getDefinition("I04");
declare variable $labels:I04_SHORT := labels:getPrefLabel("I04");
declare variable $labels:I05 := labels:getDefinition("I05");
declare variable $labels:I05_SHORT := labels:getPrefLabel("I05");
declare variable $labels:I06 := labels:getDefinition("I06");
declare variable $labels:I06_SHORT := labels:getPrefLabel("I06");
declare variable $labels:I07 := labels:getDefinition("I07");
declare variable $labels:I07_SHORT := labels:getPrefLabel("I07");
declare variable $labels:I08 := labels:getDefinition("I08");
declare variable $labels:I08_SHORT := labels:getPrefLabel("I08");
declare variable $labels:I09 := labels:getDefinition("I09");
declare variable $labels:I09_SHORT := labels:getPrefLabel("I09");
declare variable $labels:I10 := labels:getDefinition("I10");
declare variable $labels:I10_SHORT := labels:getPrefLabel("I10");
declare variable $labels:I11 := labels:getDefinition("I11");
declare variable $labels:I11_SHORT := labels:getPrefLabel("I11");
declare variable $labels:I11b := labels:getDefinition("I11b");
declare variable $labels:I11b_SHORT := labels:getPrefLabel("I11b");
declare variable $labels:I12 := labels:getDefinition("I12");
declare variable $labels:I12_SHORT := labels:getPrefLabel("I12");
declare variable $labels:I13 := labels:getDefinition("I13");
declare variable $labels:I13_SHORT := labels:getPrefLabel("I13");
declare variable $labels:I14 := labels:getDefinition("I14");
declare variable $labels:I14_SHORT := labels:getPrefLabel("I14");
declare variable $labels:I15 := labels:getDefinition("I15");
declare variable $labels:I15_SHORT := labels:getPrefLabel("I15");
declare variable $labels:I16 := labels:getDefinition("I16");
declare variable $labels:I16_SHORT := labels:getPrefLabel("I16");
declare variable $labels:I17 := labels:getDefinition("I17");
declare variable $labels:I17_SHORT := labels:getPrefLabel("I17");
declare variable $labels:I18 := labels:getDefinition("I18");
declare variable $labels:I18_SHORT := labels:getPrefLabel("I18");
declare variable $labels:I19 := labels:getDefinition("I19");
declare variable $labels:I19_SHORT := labels:getPrefLabel("I19");
declare variable $labels:I20 := labels:getDefinition("I20");
declare variable $labels:I20_SHORT := labels:getPrefLabel("I20");
declare variable $labels:I21 := labels:getDefinition("I21");
declare variable $labels:I21_SHORT := labels:getPrefLabel("I21");
declare variable $labels:I22 := labels:getDefinition("I22");
declare variable $labels:I22_SHORT := labels:getPrefLabel("I22");
declare variable $labels:I23 := labels:getDefinition("I23");
declare variable $labels:I23_SHORT := labels:getPrefLabel("I23");
declare variable $labels:I24 := labels:getDefinition("I24");
declare variable $labels:I24_SHORT := labels:getPrefLabel("I24");
declare variable $labels:I25 := labels:getDefinition("I25");
declare variable $labels:I25_SHORT := labels:getPrefLabel("I25");
declare variable $labels:I26 := labels:getDefinition("I26");
declare variable $labels:I26_SHORT := labels:getPrefLabel("I26");
declare variable $labels:I27 := labels:getDefinition("I27");
declare variable $labels:I27_SHORT := labels:getPrefLabel("I27");
declare variable $labels:I28 := labels:getDefinition("I28");
declare variable $labels:I28_SHORT := labels:getPrefLabel("I28");
declare variable $labels:I29 := labels:getDefinition("I29");
declare variable $labels:I29_SHORT := labels:getPrefLabel("I29");
declare variable $labels:I30 := labels:getDefinition("I30");
declare variable $labels:I30_SHORT := labels:getPrefLabel("I30");
declare variable $labels:I31 := labels:getDefinition("I31");
declare variable $labels:I31_SHORT := labels:getPrefLabel("I31");
declare variable $labels:I32 := labels:getDefinition("I32");
declare variable $labels:I32_SHORT := labels:getPrefLabel("I32");
declare variable $labels:I33 := labels:getDefinition("I33");
declare variable $labels:I33_SHORT := labels:getPrefLabel("I33");
declare variable $labels:I34 := labels:getDefinition("I34");
declare variable $labels:I34_SHORT := labels:getPrefLabel("I34");
declare variable $labels:I35 := labels:getDefinition("I35");
declare variable $labels:I35_SHORT := labels:getPrefLabel("I35");
declare variable $labels:I36 := labels:getDefinition("I36");
declare variable $labels:I36_SHORT := labels:getPrefLabel("I36");
declare variable $labels:I37 := labels:getDefinition("I37");
declare variable $labels:I37_SHORT := labels:getPrefLabel("I37");
declare variable $labels:I38 := labels:getDefinition("I38");
declare variable $labels:I38_SHORT := labels:getPrefLabel("I38");
declare variable $labels:I39 := labels:getDefinition("I39");
declare variable $labels:I39_SHORT := labels:getPrefLabel("I39");
declare variable $labels:I40 := labels:getDefinition("I40");
declare variable $labels:I40_SHORT := labels:getPrefLabel("I40");
declare variable $labels:I41 := labels:getDefinition("I41");
declare variable $labels:I41_SHORT := labels:getPrefLabel("I41");
declare variable $labels:I42 := labels:getDefinition("I42");
declare variable $labels:I42_SHORT := labels:getPrefLabel("I42");
declare variable $labels:I43 := labels:getDefinition("I43");
declare variable $labels:I43_SHORT := labels:getPrefLabel("I43");
declare variable $labels:I44 := labels:getDefinition("I44");
declare variable $labels:I44_SHORT := labels:getPrefLabel("I44");
declare variable $labels:I45 := labels:getDefinition("I45");
declare variable $labels:I45_SHORT := labels:getPrefLabel("I45");
declare variable $labels:J0 := labels:getDefinition("J0");
declare variable $labels:J0_SHORT := labels:getPrefLabel("J0");
declare variable $labels:J1 := labels:getDefinition("J1");
declare variable $labels:J1_SHORT := labels:getPrefLabel("J1");
declare variable $labels:J2 := labels:getDefinition("J2");
declare variable $labels:J2_SHORT := labels:getPrefLabel("J2");
declare variable $labels:J3 := labels:getDefinition("J3");
declare variable $labels:J3_SHORT := labels:getPrefLabel("J3");
declare variable $labels:J4 := labels:getDefinition("J4");
declare variable $labels:J4_SHORT := labels:getPrefLabel("J4");
declare variable $labels:J5 := labels:getDefinition("J5");
declare variable $labels:J5_SHORT := labels:getPrefLabel("J5");
declare variable $labels:J6 := labels:getDefinition("J6");
declare variable $labels:J6_SHORT := labels:getPrefLabel("J6");
declare variable $labels:J7 := labels:getDefinition("J7");
declare variable $labels:J7_SHORT := labels:getPrefLabel("J7");
declare variable $labels:J8 := labels:getDefinition("J8");
declare variable $labels:J8_SHORT := labels:getPrefLabel("J8");
declare variable $labels:J9 := labels:getDefinition("J9");
declare variable $labels:J9_SHORT := labels:getPrefLabel("J9");
declare variable $labels:J10 := labels:getDefinition("J10");
declare variable $labels:J10_SHORT := labels:getPrefLabel("J10");
declare variable $labels:J11 := labels:getDefinition("J11");
declare variable $labels:J11_SHORT := labels:getPrefLabel("J11");
declare variable $labels:J12 := labels:getDefinition("J12");
declare variable $labels:J12_SHORT := labels:getPrefLabel("J12");
declare variable $labels:J13 := labels:getDefinition("J13");
declare variable $labels:J13_SHORT := labels:getPrefLabel("J13");
declare variable $labels:J14 := labels:getDefinition("J14");
declare variable $labels:J14_SHORT := labels:getPrefLabel("J14");
declare variable $labels:J15 := labels:getDefinition("J15");
declare variable $labels:J15_SHORT := labels:getPrefLabel("J15");
declare variable $labels:J16 := labels:getDefinition("J16");
declare variable $labels:J16_SHORT := labels:getPrefLabel("J16");
declare variable $labels:J17 := labels:getDefinition("J17");
declare variable $labels:J17_SHORT := labels:getPrefLabel("J17");
declare variable $labels:J18 := labels:getDefinition("J18");
declare variable $labels:J18_SHORT := labels:getPrefLabel("J18");
declare variable $labels:J19 := labels:getDefinition("J19");
declare variable $labels:J19_SHORT := labels:getPrefLabel("J19");
declare variable $labels:J20 := labels:getDefinition("J20");
declare variable $labels:J20_SHORT := labels:getPrefLabel("J20");
declare variable $labels:J21 := labels:getDefinition("J21");
declare variable $labels:J21_SHORT := labels:getPrefLabel("J21");
declare variable $labels:J22 := labels:getDefinition("J22");
declare variable $labels:J22_SHORT := labels:getPrefLabel("J22");
declare variable $labels:J23 := labels:getDefinition("J23");
declare variable $labels:J23_SHORT := labels:getPrefLabel("J23");
declare variable $labels:J24 := labels:getDefinition("J24");
declare variable $labels:J24_SHORT := labels:getPrefLabel("J24");
declare variable $labels:J25 := labels:getDefinition("J25");
declare variable $labels:J25_SHORT := labels:getPrefLabel("J25");
declare variable $labels:J26 := labels:getDefinition("J26");
declare variable $labels:J26_SHORT := labels:getPrefLabel("J26");
declare variable $labels:J27 := labels:getDefinition("J27");
declare variable $labels:J27_SHORT := labels:getPrefLabel("J27");
declare variable $labels:J28 := labels:getDefinition("J28");
declare variable $labels:J28_SHORT := labels:getPrefLabel("J28");
declare variable $labels:J29 := labels:getDefinition("J29");
declare variable $labels:J29_SHORT := labels:getPrefLabel("J29");
declare variable $labels:J30 := labels:getDefinition("J30");
declare variable $labels:J30_SHORT := labels:getPrefLabel("J30");
declare variable $labels:J31 := labels:getDefinition("J31");
declare variable $labels:J31_SHORT := labels:getPrefLabel("J31");
declare variable $labels:J32 := labels:getDefinition("J32");
declare variable $labels:J32_SHORT := labels:getPrefLabel("J32");
declare variable $labels:K0 := labels:getDefinition("K0");
declare variable $labels:K0_SHORT := labels:getPrefLabel("K0");
declare variable $labels:K01 := labels:getDefinition("K01");
declare variable $labels:K01_SHORT := labels:getPrefLabel("K01");
declare variable $labels:K02 := labels:getDefinition("K02");
declare variable $labels:K02_SHORT := labels:getPrefLabel("K02");
declare variable $labels:K03 := labels:getDefinition("K03");
declare variable $labels:K03_SHORT := labels:getPrefLabel("K03");
declare variable $labels:K04 := labels:getDefinition("K04");
declare variable $labels:K04_SHORT := labels:getPrefLabel("K04");
declare variable $labels:K05 := labels:getDefinition("K05");
declare variable $labels:K05_SHORT := labels:getPrefLabel("K05");
declare variable $labels:K06 := labels:getDefinition("K06");
declare variable $labels:K06_SHORT := labels:getPrefLabel("K06");
declare variable $labels:K07 := labels:getDefinition("K07");
declare variable $labels:K07_SHORT := labels:getPrefLabel("K07");
declare variable $labels:K08 := labels:getDefinition("K08");
declare variable $labels:K08_SHORT := labels:getPrefLabel("K08");
declare variable $labels:K09 := labels:getDefinition("K09");
declare variable $labels:K09_SHORT := labels:getPrefLabel("K09");
declare variable $labels:K10 := labels:getDefinition("K10");
declare variable $labels:K10_SHORT := labels:getPrefLabel("K10");
declare variable $labels:K11 := labels:getDefinition("K11");
declare variable $labels:K11_SHORT := labels:getPrefLabel("K11");
declare variable $labels:K12 := labels:getDefinition("K12");
declare variable $labels:K12_SHORT := labels:getPrefLabel("K12");
declare variable $labels:K13 := labels:getDefinition("K13");
declare variable $labels:K13_SHORT := labels:getPrefLabel("K13");
declare variable $labels:K14 := labels:getDefinition("K14");
declare variable $labels:K14_SHORT := labels:getPrefLabel("K14");
declare variable $labels:K15 := labels:getDefinition("K15");
declare variable $labels:K15_SHORT := labels:getPrefLabel("K15");
declare variable $labels:K16 := labels:getDefinition("K16");
declare variable $labels:K16_SHORT := labels:getPrefLabel("K16");
declare variable $labels:K17 := labels:getDefinition("K17");
declare variable $labels:K17_SHORT := labels:getPrefLabel("K17");
declare variable $labels:K18 := labels:getDefinition("K18");
declare variable $labels:K18_SHORT := labels:getPrefLabel("K18");
declare variable $labels:K19 := labels:getDefinition("K19");
declare variable $labels:K19_SHORT := labels:getPrefLabel("K19");
declare variable $labels:K20 := labels:getDefinition("K20");
declare variable $labels:K20_SHORT := labels:getPrefLabel("K20");
declare variable $labels:K21 := labels:getDefinition("K21");
declare variable $labels:K21_SHORT := labels:getPrefLabel("K21");
declare variable $labels:K22 := labels:getDefinition("K22");
declare variable $labels:K22_SHORT := labels:getPrefLabel("K22");
declare variable $labels:K23 := labels:getDefinition("K23");
declare variable $labels:K23_SHORT := labels:getPrefLabel("K23");
declare variable $labels:K24 := labels:getDefinition("K24");
declare variable $labels:K24_SHORT := labels:getPrefLabel("K24");
declare variable $labels:K25 := labels:getDefinition("K25");
declare variable $labels:K25_SHORT := labels:getPrefLabel("K25");
declare variable $labels:K26 := labels:getDefinition("K26");
declare variable $labels:K26_SHORT := labels:getPrefLabel("K26");
declare variable $labels:K27 := labels:getDefinition("K27");
declare variable $labels:K27_SHORT := labels:getPrefLabel("K27");
declare variable $labels:K28 := labels:getDefinition("K28");
declare variable $labels:K28_SHORT := labels:getPrefLabel("K28");
declare variable $labels:K29 := labels:getDefinition("K29");
declare variable $labels:K29_SHORT := labels:getPrefLabel("K29");
declare variable $labels:K30 := labels:getDefinition("K30");
declare variable $labels:K30_SHORT := labels:getPrefLabel("K30");
declare variable $labels:K31 := labels:getDefinition("K31");
declare variable $labels:K31_SHORT := labels:getPrefLabel("K31");
declare variable $labels:K32 := labels:getDefinition("K32");
declare variable $labels:K32_SHORT := labels:getPrefLabel("K32");
declare variable $labels:K33 := labels:getDefinition("K33");
declare variable $labels:K33_SHORT := labels:getPrefLabel("K33");
declare variable $labels:K34 := labels:getDefinition("K34");
declare variable $labels:K34_SHORT := labels:getPrefLabel("K34");
declare variable $labels:K35 := labels:getDefinition("K35");
declare variable $labels:K35_SHORT := labels:getPrefLabel("K35");
declare variable $labels:K36 := labels:getDefinition("K36");
declare variable $labels:K36_SHORT := labels:getPrefLabel("K36");
declare variable $labels:K37 := labels:getDefinition("K37");
declare variable $labels:K37_SHORT := labels:getPrefLabel("K37");
declare variable $labels:K38 := labels:getDefinition("K38");
declare variable $labels:K38_SHORT := labels:getPrefLabel("K38");
declare variable $labels:K39 := labels:getDefinition("K39");
declare variable $labels:K39_SHORT := labels:getPrefLabel("K39");
declare variable $labels:K40 := labels:getDefinition("K40");
declare variable $labels:K40_SHORT := labels:getPrefLabel("K40");
declare variable $labels:M0 := labels:getDefinition("M0");
declare variable $labels:M0_SHORT := labels:getPrefLabel("M0");
declare variable $labels:M01 := labels:getDefinition("M01");
declare variable $labels:M01_SHORT := labels:getPrefLabel("M01");
declare variable $labels:M02 := labels:getDefinition("M02");
declare variable $labels:M02_SHORT := labels:getPrefLabel("M02");
declare variable $labels:M03 := labels:getDefinition("M03");
declare variable $labels:M03_SHORT := labels:getPrefLabel("M03");
declare variable $labels:M04 := labels:getDefinition("M04");
declare variable $labels:M04_SHORT := labels:getPrefLabel("M04");
declare variable $labels:M05 := labels:getDefinition("M05");
declare variable $labels:M05_SHORT := labels:getPrefLabel("M05");
declare variable $labels:M06 := labels:getDefinition("M06");
declare variable $labels:M06_SHORT := labels:getPrefLabel("M06");
declare variable $labels:M07 := labels:getDefinition("M07");
declare variable $labels:M07_SHORT := labels:getPrefLabel("M07");
declare variable $labels:M07.1 := labels:getDefinition("M07.1");
declare variable $labels:M07.1_SHORT := labels:getPrefLabel("M07.1");
declare variable $labels:M08 := labels:getDefinition("M08");
declare variable $labels:M08_SHORT := labels:getPrefLabel("M08");
declare variable $labels:M12 := labels:getDefinition("M12");
declare variable $labels:M12_SHORT := labels:getPrefLabel("M12");
declare variable $labels:M15 := labels:getDefinition("M15");
declare variable $labels:M15_SHORT := labels:getPrefLabel("M15");
declare variable $labels:M18 := labels:getDefinition("M18");
declare variable $labels:M18_SHORT := labels:getPrefLabel("M18");
declare variable $labels:M19 := labels:getDefinition("M19");
declare variable $labels:M19_SHORT := labels:getPrefLabel("M19");
declare variable $labels:M20 := labels:getDefinition("M20");
declare variable $labels:M20_SHORT := labels:getPrefLabel("M20");
declare variable $labels:M23 := labels:getDefinition("M23");
declare variable $labels:M23_SHORT := labels:getPrefLabel("M23");
declare variable $labels:M24 := labels:getDefinition("M24");
declare variable $labels:M24_SHORT := labels:getPrefLabel("M24");
declare variable $labels:M25 := labels:getDefinition("M25");
declare variable $labels:M25_SHORT := labels:getPrefLabel("M25");
declare variable $labels:M26 := labels:getDefinition("M26");
declare variable $labels:M26_SHORT := labels:getPrefLabel("M26");
declare variable $labels:M27 := labels:getDefinition("M27");
declare variable $labels:M27_SHORT := labels:getPrefLabel("M27");
declare variable $labels:M28 := labels:getDefinition("M28");
declare variable $labels:M28_SHORT := labels:getPrefLabel("M28");
declare variable $labels:M28.1 := labels:getDefinition("M28.1");
declare variable $labels:M28.1_SHORT := labels:getPrefLabel("M28.1");
declare variable $labels:M29 := labels:getDefinition("M29");
declare variable $labels:M29_SHORT := labels:getPrefLabel("M29");
declare variable $labels:M30 := labels:getDefinition("M30");
declare variable $labels:M30_SHORT := labels:getPrefLabel("M30");
declare variable $labels:M34 := labels:getDefinition("M34");
declare variable $labels:M34_SHORT := labels:getPrefLabel("M34");
declare variable $labels:M35 := labels:getDefinition("M35");
declare variable $labels:M35_SHORT := labels:getPrefLabel("M35");
declare variable $labels:M39 := labels:getDefinition("M39");
declare variable $labels:M39_SHORT := labels:getPrefLabel("M39");
declare variable $labels:M40 := labels:getDefinition("M40");
declare variable $labels:M40_SHORT := labels:getPrefLabel("M40");
declare variable $labels:M41 := labels:getDefinition("M41");
declare variable $labels:M41_SHORT := labels:getPrefLabel("M41");
declare variable $labels:M41.1 := labels:getDefinition("M41.1");
declare variable $labels:M41.1_SHORT := labels:getPrefLabel("M41.1");
declare variable $labels:M43 := labels:getDefinition("M43");
declare variable $labels:M43_SHORT := labels:getPrefLabel("M43");
declare variable $labels:M45 := labels:getDefinition("M45");
declare variable $labels:M45_SHORT := labels:getPrefLabel("M45");
declare variable $labels:M46 := labels:getDefinition("M46");
declare variable $labels:M46_SHORT := labels:getPrefLabel("M46");
declare variable $labels:C06.1 := "Check that namespace is registered in vocabulary";
declare variable $labels:C06.1_SHORT := "Check that namespace is registered in vocabulary";
declare variable $labels:LABELS_FILE_NAME := "aqd-labels-xq.xml";
declare variable $labels:PLACEHOLDER := "LABEL MISSING";
declare variable $schemax:INVALIDSTATUS := "invalid";
declare variable $schemax:SCHEMA := "http://dd.eionet.europa.eu/schemas/id2011850eu-1.0/AirQualityReporting.xsd";
declare variable $sparqlx:CR_SPARQL_URL := "http://cr.eionet.europa.eu/sparql";
declare variable $vocabulary:ADJUSTMENTSOURCE_VOCABULARY as xs:string := "http://dd.eionet.europa.eu/vocabulary/aq/adjustmentsourcetype/";
declare variable $vocabulary:ADJUSTMENTTYPE_VOCABULARY as xs:string := "http://dd.eionet.europa.eu/vocabulary/aq/adjustmenttype/";
declare variable $vocabulary:ADMINISTRATIVE_LEVEL_VOCABULARY := "http://dd.eionet.europa.eu/vocabulary/aq/administrativelevel/";
declare variable $vocabulary:AGGREGATION_PROCESS as xs:string := $vocabulary:BASE || "aggregationprocess/";
declare variable $vocabulary:ANALYTICALTECHNIQUE_VOCABULARY :=  "http://dd.eionet.europa.eu/vocabulary/aq/analyticaltechnique/";
declare variable $vocabulary:AQ_MANAGEMENET_ZONE := "http://inspire.ec.europa.eu/codeList/ZoneTypeCode/airQualityManagementZone";
declare variable $vocabulary:AQ_MANAGEMENET_ZONE_LC := "http://inspire.ec.europa.eu/codelist/ZoneTypeCode/airQualityManagementZone";
declare variable $vocabulary:AREA_CLASSIFICATION_VOCABULARY := "http://dd.eionet.europa.eu/vocabulary/aq/areaclassification/";
declare variable $vocabulary:ASSESSMENTTYPE_VOCABULARY as xs:string := "http://dd.eionet.europa.eu/vocabulary/aq/assessmenttype/";
declare variable $vocabulary:BASE := "http://dd.eionet.europa.eu/vocabulary/aq/";
declare variable $vocabulary:CURRENCIES as xs:string := "http://dd.eionet.europa.eu/vocabulary/common/currencies/";
declare variable $vocabulary:DISPERSION_LOCAL_VOCABULARY := "http://dd.eionet.europa.eu/vocabulary/aq/dispersionlocal/";
declare variable $vocabulary:DISPERSION_REGIONAL_VOCABULARY := "http://dd.eionet.europa.eu/vocabulary/aq/dispersionregional/";
declare variable $vocabulary:ENVIRONMENTALOBJECTIVE := "http://dd.eionet.europa.eu/vocabulary/aq/environmentalobjective/";
declare variable $vocabulary:EQUIVALENCEDEMONSTRATED_VOCABULARY := "http://dd.eionet.europa.eu/vocabulary/aq/equivalencedemonstrated/";
declare variable $vocabulary:LEGISLATION_LEVEL := "http://inspire.ec.europa.eu/codeList/LegislationLevelValue/";
declare variable $vocabulary:LEGISLATION_LEVEL_LC := "http://inspire.ec.europa.eu/codelist/LegislationLevelValue/";
declare variable $vocabulary:MEASURECLASSIFICATION_VOCABULARY := "http://dd.eionet.europa.eu/vocabulary/aq/measureclassification/";
declare variable $vocabulary:MEASUREMENTEQUIPMENT_VOCABULARY :="http://dd.eionet.europa.eu/vocabulary/aq/measurementequipment/";
declare variable $vocabulary:MEASUREMENTMETHOD_VOCABULARY := "http://dd.eionet.europa.eu/vocabulary/aq/measurementmethod/";
declare variable $vocabulary:MEASUREMENTTYPE_VOCABULARY := "http://dd.eionet.europa.eu/vocabulary/aq/measurementtype/";
declare variable $vocabulary:MEASURETYPE_VOCABULARY := "http://dd.eionet.europa.eu/vocabulary/aq/measuretype//";
declare variable $vocabulary:MEASUREIMPLEMENTATIONSTATUS_VOCABULARY := "http://dd.eionet.europa.eu/vocabulary/aq/measureimplementationstatus/";
declare variable $vocabulary:MEDIA_VALUE_VOCABULARY := "http://dd.eionet.europa.eu/vocabulary/inspire/MediaValue/";
declare variable $vocabulary:MEDIA_VALUE_VOCABULARY_BASE_URI := "http://inspire.ec.europa.eu/codelist/MediaValue/";
declare variable $vocabulary:MEDIA_VALUE_VOCABULARY_BASE_URI_UC := "http://inspire.ec.europa.eu/codeList/MediaValue/";
declare variable $vocabulary:METEO_PARAMS_VOCABULARY := ("http://vocab.nerc.ac.uk/collection/P07/current/","http://vocab.nerc.ac.uk/collection/I01/current/","http://dd.eionet.europa.eu/vocabulary/aq/meteoparameter/");
declare variable $vocabulary:METEO_PARAMS_VOCABULARY_I01 := "http://vocab.nerc.ac.uk/collection/I01/current/";
declare variable $vocabulary:METEO_PARAMS_VOCABULARY_M := "http://vocab.nerc.ac.uk/collection/P07/current/";
declare variable $vocabulary:METEO_PARAMS_VOCABULARY_aq := "http://dd.eionet.europa.eu/vocabulary/aq/meteoparameter/";
declare variable $vocabulary:MODEL_PARAMETER as xs:string := "http://dd.eionet.europa.eu/vocabulary/aq/modelparameter/";
declare variable $vocabulary:NAMESPACE := "http://dd.eionet.europa.eu/vocabulary/aq/namespace/";
declare variable $vocabulary:NETWORK_TYPE_VOCABULARY := "http://dd.eionet.europa.eu/vocabulary/aq/networktype/";
declare variable $vocabulary:OBJECTIVETYPE_VOCABULARY as xs:string := "http://dd.eionet.europa.eu/vocabulary/aq/objectivetype/";
declare variable $vocabulary:OBLIGATIONS := "http://rod.eionet.europa.eu/obligations/";
declare variable $vocabulary:OBSERVATIONS_PRIMARY as xs:string := "http://dd.eionet.europa.eu/vocabulary/aq/primaryObservation/";
declare variable $vocabulary:OBSERVATIONS_RANGE as xs:string := "http://dd.eionet.europa.eu/vocabulary/aq/primaryObservationRange/";
declare variable $vocabulary:OBSERVATIONS_VALIDITY as xs:string := "http://dd.eionet.europa.eu/vocabulary/aq/observationvalidity/";
declare variable $vocabulary:OBSERVATIONS_VERIFICATION as xs:string := "http://dd.eionet.europa.eu/vocabulary/aq/observationverification/";
declare variable $vocabulary:ORGANISATIONAL_LEVEL_VOCABULARY := "http://dd.eionet.europa.eu/vocabulary/aq/organisationallevel/";
declare variable $vocabulary:POLLUTANT_VOCABULARY := "http://dd.eionet.europa.eu/vocabulary/aq/pollutant/";
declare variable $vocabulary:PROCESSPARAMETER_RESULTENCODING as xs:string := $vocabulary:PROCESS_PARAMETER || "resultencoding";
declare variable $vocabulary:PROCESSPARAMETER_RESULTFORMAT as xs:string := $vocabulary:PROCESS_PARAMETER || "resultformat";
declare variable $vocabulary:PROCESS_PARAMETER as xs:string := "http://dd.eionet.europa.eu/vocabulary/aq/processparameter/";
declare variable $vocabulary:PROTECTIONTARGET_VOCABULARY as xs:string := "http://dd.eionet.europa.eu/vocabulary/aq/protectiontarget/";
declare variable $vocabulary:QAQC_VOCABULARY as xs:string := "http://dd.eionet.europa.eu/vocabulary/aq/cdrqaqc/";
declare variable $vocabulary:REPMETRIC_VOCABULARY as xs:string := "http://dd.eionet.europa.eu/vocabulary/aq/reportingmetric/";
declare variable $vocabulary:RESULT_ENCODING as xs:string := $vocabulary:BASE || "resultencoding/";
declare variable $vocabulary:RESULT_FORMAT as xs:string := $vocabulary:BASE || "resultformat/";
declare variable $vocabulary:ROD_PREFIX as xs:string := "http://rod.eionet.europa.eu/obligations/";
declare variable $vocabulary:SAMPLINGEQUIPMENT_VOCABULARY := "http://dd.eionet.europa.eu/vocabulary/aq/samplingequipment/";
declare variable $vocabulary:SPACIALSCALE_VOCABULARY := "http://dd.eionet.europa.eu/vocabulary/aq/spatialscale/";
declare variable $vocabulary:SOURCESECTORS_VOCABULARY := "http://dd.eionet.europa.eu/vocabulary/aq/sourcesectors/";
declare variable $vocabulary:TIMESCALE_VOCABULARY := "http://dd.eionet.europa.eu/vocabulary/aq/timescale/";
declare variable $vocabulary:TIMEZONE_VOCABULARY := "http://dd.eionet.europa.eu/vocabulary/aq/timezone/";
declare variable $vocabulary:UOM_CONCENTRATION_VOCABULARY := "http://dd.eionet.europa.eu/vocabulary/uom/concentration/";
declare variable $vocabulary:UOM_STATISTICS := "http://dd.eionet.europa.eu/vocabulary/uom/statistics/";
declare variable $vocabulary:UOM_TIME := "http://dd.eionet.europa.eu/vocabulary/uom/time/";
declare variable $vocabulary:UOM_EMISSION_VOCABULARY := "http://dd.eionet.europa.eu/vocabulary/uom/emission/";
declare variable $vocabulary:ZONETYPE_VOCABULARY as xs:string := "http://dd.eionet.europa.eu/vocabulary/aq/zonetype/";






(: Lower case equals string :)
declare function common:equalsLC($value as xs:string, $target as xs:string) {
    lower-case($value) = lower-case($target)
};

(:~
 : Get the cleaned URL without authorisation info
 : @param $url URL of the source XML file
 : @return String
 :)
declare function common:getCleanUrl($url) as xs:string {
    if (contains($url, $common:SOURCE_URL_PARAM)) then
        fn:substring-after($url, $common:SOURCE_URL_PARAM)
    else
        $url
};

(: XMLCONV QA sends the file URL to XQuery engine as source_file paramter value in URL which is able to retreive restricted content from CDR.
   This method replaces the source file url value in source_url parameter with another URL. source_file url must be the last parameter :)
declare function common:replaceSourceUrl($url as xs:string, $url2 as xs:string) as xs:string {
    if (contains($url, $common:SOURCE_URL_PARAM)) then
        fn:concat(fn:substring-before($url, $common:SOURCE_URL_PARAM), $common:SOURCE_URL_PARAM, $url2)
    else
        $url2
};

declare function common:getEnvelopeXML($url as xs:string) as xs:string{
    let $col := fn:tokenize($url,'/')
    let $col := fn:remove($col, fn:count($col))
    let $ret := fn:string-join($col,'/')
    let $ret := fn:concat($ret,'/xml')
    return
        if(fn:doc-available($ret)) then
            $ret
        else
            ""
};

declare function common:getCdrUrl($countryCode as xs:string) as xs:string {
    let $countryCode :=
        if ($countryCode = "uk") then
            "gb"
        else if ($countryCode = "el") then
            "gr"
        else
            $countryCode
    let $eu :=
        if ($countryCode='gi') then
            'eea'
        else
            'eu'
    return "cdr.eionet.europa.eu/" || lower-case($countryCode) || "/" || $eu || "/aqd/"
};

(: returns year from aqd:AQD_ReportingHeader/aqd:reportingPeriod/gml:TimePeriod
gml:beginPosition
or
gml:timePosition
:)
declare function common:getReportingYear($xml as document-node()) as xs:string {
    let $year1 := year-from-dateTime($xml//aqd:AQD_ReportingHeader/aqd:reportingPeriod/gml:TimePeriod/gml:beginPosition)
    let $year2 := string($xml//aqd:AQD_ReportingHeader/aqd:reportingPeriod/gml:TimeInstant/gml:timePosition)
    return
        if (exists($year1) and $year1 castable as xs:integer) then xs:string($year1)
        else if (string-length($year2) > 0 and $year2 castable as xs:integer) then $year2
        else ""
};

declare function common:containsAny($seq1 as xs:string*, $seq2 as xs:string*) as xs:boolean {
    not(empty(
            for $str in $seq2
            where not(empty(index-of($seq1, $str)))
            return
                true()
    ))
};

declare function common:getSublist($seq1 as xs:string*, $seq2 as xs:string*)
as xs:string* {

    distinct-values(
            for $str in $seq2
            where not(empty(index-of($seq1, $str)))
            return
                $str
    )
};

declare function common:checkLink($text as xs:string*) as element(span)*{
    for $c at $pos in $text
    return
        <span>{
            if (starts-with($c, "http://")) then
                <a href="{$c}">{$c}</a>
            else
                $c
            }{
            if ($pos < count($text)) then
                ", "
            else
                ""
        }</span>
};

declare function common:is-a-number( $value as xs:anyAtomicType? ) as xs:boolean {
    string(number($value)) != 'NaN'
};

declare function common:includesURL($x as xs:string) {
    contains($x, "http://") or contains($x, "https://")
};

declare function common:isInvalidYear($value as xs:string?) {
    let $year := if (empty($value)) then ()
    else
        if ($value castable as xs:integer) then xs:integer($value) else ()

    return
        if ((empty($year) and empty($value)) or (not(empty($year)) and $year > 1800 and $year < 9999)) then fn:false() else fn:true()

};
declare function common:if-empty($first as item()?, $second as item()?) as item()* {
    if (not(data($first) = '')) then
        data($first)
    else
        data($second)
};

(: This is to be used only for dates with <= 1 year difference :)
declare function common:isDateDifferenceOverYear($startDate as xs:date, $endDate as xs:date) as xs:boolean {
    let $year1 := year-from-date($startDate)
    let $year2 := year-from-date($endDate)
    let $difference :=
        if (functx:is-leap-year($year1) and $startDate < xs:date(concat($year1,"-02-29"))
                or functx:is-leap-year($year2) and $endDate > xs:date(concat($year2,"-02-29"))) then
            366
        else
            365
    return
        if (($endDate - $startDate) div xs:dayTimeDuration("P1D") > $difference) then
            true()
        else
            false()
};

declare function common:containsAnyNumber($values as xs:string*) as xs:boolean {
    let $result :=
        for $i in $values
        where $i castable as xs:double
        return 1
    return $result = 1
};

(: This is to be used only for dateTimes with <= 1 year difference :)
declare function common:isDateTimeDifferenceOneYear($startDateTime as xs:dateTime, $endDateTime as xs:dateTime) as xs:boolean {
    let $year1 := year-from-dateTime($startDateTime)
    let $year2 := year-from-dateTime($endDateTime)
    (: TODO check again corner cases :)
    let $difference :=
        if (functx:is-leap-year($year1) and $startDateTime < xs:dateTime(concat($year1,"-02-29T24:00:00Z"))
                or functx:is-leap-year($year2) and $endDateTime > xs:dateTime(concat($year2,"-02-29T00:00:00Z"))) then
            8784
        else
            8760
    return
        if (($endDateTime - $startDateTime) div xs:dayTimeDuration("PT1H") = $difference) then
            true()
        else
            false()
};

declare function common:isDateTimeIncluded($reportingYear as xs:string, $beginPosition as xs:dateTime?, $endPosition as xs:dateTime?) {
    let $reportingYearDateTimeStart := xs:dateTime($reportingYear || "-01-01T00:00:00Z")
    let $reportingYearDateTimeEnd := xs:dateTime($reportingYear || "-01-01T00:00:00Z")
    return
        if (empty($endPosition)) then
            if ($reportingYearDateTimeStart >= $beginPosition) then
                true()
            else
                false()
        else if ($endPosition >= $reportingYearDateTimeEnd) then
            if ($reportingYearDateTimeStart >= $beginPosition) then
                true()
            else false()
        else
            false()
};

(: Returns error report for ?0 check :)
declare function common:checkDeliveryReport (
    $errorClass as xs:string,
    $statusMessage as xs:string
) as element(tr) {
    <tr class="{$errorClass}">
        <td title="Status">{$statusMessage}</td>
    </tr>
};

(: Returns structure with error if node is empty :)
(: TODO: test if node doesn't exist :)
declare function common:needsValidString(
    $parent as node(),
    $nodeName as xs:string
) as element(tr)* {
    let $el := $parent/*[name() = $nodeName]
    return try {
        if (string-length(normalize-space($el/text())) = 0)
        then
            <tr>
                <td title="{$nodeName}">{$nodeName} needs a valid input</td>
            </tr>
        else
            ()
    }  catch * {
        html:createErrorRow($err:code, $err:description)
    }
};

(: Check if the given node links to a term that is defined in the vocabulary :)
declare function common:isInVocabulary(
  $uri as xs:string?,
  $vocabularyName as xs:string
) as xs:boolean {
    let $validUris := dd:getValidConcepts($vocabularyName || "rdf")
    return $uri and $uri = $validUris
};

declare function common:isInVocabularyReport(
  $main as node()+,
  $vocabularyName as xs:string
) as element(tr)* {
    try {
        for $el in $main
            let $uri := $el/@xlink:href
            return
            if (not(common:isInVocabulary($uri, $vocabularyName)))
            then
                <tr>
                    <td title="{node-name($el)}"> not conform to vocabulary</td>
                </tr>
            else
                ()
    } catch * {
        html:createErrorRow($err:code, $err:description)
    }
};

        (: (xs:string, xs:anyAtomicType)* :)

declare function common:conditionalReportRow (
    $ok as xs:boolean,
    $vals as array(item()*)
) as element(tr)* {
    if (not($ok))
    then
        let $tr :=
            <tr>
            {
                for $i in 1 to array:size($vals)
                let $row := array:get($vals, $i)
                return
                    if ($row instance of array(*))
                    then
                        <td title="{$row(1)}">
                            {data($row(2))}
                        </td>
                    else
                        <td title="{$row[1]}">
                            {data($row[2])}
                        </td>
            }
            </tr>
        (:let $x := trace($tr, 'x:'):)
        return $tr
    else
        ()
};



(: returns if a specific node exists in a parent :)
declare function common:isNodeInParent(
    $parent as node(),
    $nodeName as xs:string
) as xs:boolean {
    exists($parent/*[name() = $nodeName])
};

(: prints error if a specific node does not exist in a parent :)
declare function common:isNodeNotInParentReport(
    $parent as node(),
    $nodeName as xs:string
) as element(tr)* {
    try {
        if (not(common:isNodeInParent($parent, $nodeName)))
        then
            <tr>
                <td title="{$nodeName}"> needs valid input</td>
            </tr>
        else
            ()
    } catch * {
        html:createErrorRow($err:code, $err:description)
    }
};

(: if node has value, then that value should be an integer :)
declare function common:maybeNodeValueIsInteger($el) as xs:boolean {
    (: TODO: is possible to use or :)
    let $v := data($el)
    return
        if (exists($v))
        then
            common:is-a-number($v)
        else
            true()
};

(: prints error if a specific node has value and is not an integer :)
declare function common:maybeNodeValueIsIntegerReport(
    $parent as node()?,
    $nodeName as xs:string
) as element(tr)* {
    let $el := $parent/*[name() = $nodeName]
    return try {
        if (not(common:maybeNodeValueIsInteger($el)))
        then
            <tr>
                <td title="{$nodeName}"> needs valid input</td>
            </tr>
        else
            ()
    } catch * {
        html:createErrorRow($err:code, $err:description)
    }
};

(: If node exists, validate it :)
declare function common:validatePossibleNodeValue(
    $el,
    $validator as function(item()) as xs:boolean
) {
    let $v := data($el)
    return
        if (exists($v))
        then
            $validator($v)
        else
            true()
};

(: Prints an error if validation for a possible existing node fails :)
declare function common:validatePossibleNodeValueReport(
    $parent as node()?,
    $nodeName as xs:string,
    $validator as function(item()) as xs:boolean
) {
    let $el := $parent/*[name() = $nodeName]
    return try {
        if (not(common:validatePossibleNodeValue($el, $validator)))
        then
            <tr>
                <td title="{$nodeName}"> needs valid input</td>
            </tr>
        else
            ()
    } catch * {
        html:createErrorRow($err:code, $err:description)
    }
};


(: Given a node, if it exists, print error based on provided value :)
declare function common:validateMaybeNodeWithValueReport(
    $parent as node()?,
    $nodeName as xs:string,
    $val as xs:boolean
) as element(tr)* {
    let $el := $parent/*[name() = $nodeName]
    return try {
        if (exists($el))
        then
            if (not($val))
            then
                <tr>
                    <td title="{$nodeName}"> needs valid input</td>
                </tr>
            else
                ()
        else
            ()
    } catch * {
        html:createErrorRow($err:code, $err:description)
    }
};

(: Check if a given string is a full ISO date type:)
declare function common:isDateFullISO(
    $date as xs:string?
) as xs:boolean {
    if ($date castable as xs:dateTime)
    then
        true()
    else
        false()
    (:try {
        let $asd := xs:dateTime($date)
        return true()
    } catch *{
        false()
    }:)

};
(: Create report :)
declare function common:isDateFullISOReport(
    $el as node()*
) as element(tr)*
{
    let $date := data($el)
    return
    try {
        if (not(common:isDateFullISO($date)))
        then
            <tr>
                <td title="{node-name($el)}">{$date} not in full ISO format</td>
            </tr>
        else
            ()
    } catch * {
        html:createErrorRow($err:code, $err:description)
    }
};

declare function common:has-one-node(
    $seq as item()*,
    $item as item()?
) as xs:boolean {
    let $norm-seq :=
        for $x in $seq
        return $x => normalize-space() => lower-case()
    return count(index-of($norm-seq, lower-case(normalize-space($item)))) = 1
};


(: Check if end date is after begin date and if both are in full ISO format:)
declare function common:isEndDateAfterBeginDate(
    $begin as node()?,
    $end as node()?
) as xs:boolean
{
    if(common:isDateFullISO($begin) and common:isDateFullISO($end) and $end > $begin)
    then
        true()
    else
        false()
};

(:
pseudocode, for brainstorming

validators =[
    isDate(x),
    isDate(y),
    isXBiggerThenY(x, y)
]

validate([
    isDate(x),
    isDate(y),
    ])


    (isDate(x) and isDate(y) and isXBiggerThanY(x, y)) or (hasNodeAttribute())

isXBiggerThanY(x:orice, y:orice)
:)

(:
 : Module Name: Implementing Decision 2011/850/EU: AQ info exchange & reporting (Library module)
 :
 : Version:     $Id$
 : Created:     20 June 2013
 : Copyright:   European Environment Agency
 :
 : XQuery script implements dataflow B tier-1 checks as documented in http://taskman.eionet.europa.eu/documents/3 .
 :
 : @author Enriko Käsper
 : @author George Sofianos
 : small modification added by Jaume Targa (ETC/ACM) to align with QA document
 :)







declare variable $dataflowB:ISO2_CODES as xs:string* := ("AL","AT","BA","BE","BG","CH","CY","CZ","DE","DK","DZ","EE","EG","ES","FI",
    "FR","GB","GR","HR","HU","IE","IL","IS","IT","JO","LB","LI","LT","LU","LV","MA","ME","MK","MT","NL","NO","PL","PS","PT",
     "RO","RS","SE","SI","SK","TN","TR","XK","UK");


(: Rule implementations :)
declare function dataflowB:checkReport($source_url as xs:string, $countryCode as xs:string) as element(table) {

let $envelopeUrl := common:getEnvelopeXML($source_url)
let $docRoot := doc($source_url)
let $cdrUrl := common:getCdrUrl($countryCode)
let $bdir := if (contains($source_url, "b_preliminary")) then "b_preliminary/" else "b/"
let $reportingYear := common:getReportingYear($docRoot)
let $latestEnvelopeB := query:getLatestEnvelope($cdrUrl || $bdir, $reportingYear)
let $nameSpaces := distinct-values($docRoot//base:namespace)
let $zonesNamespaces := distinct-values($docRoot//aqd:AQD_Zone/am:inspireId/base:Identifier/base:namespace)

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

(: B0 :)
let $B0table :=
    try {
        if ($reportingYear = "") then
            <tr class="{$errors:ERROR}">
                <td title="Status">Reporting Year is missing.</td>
            </tr>
        else if (query:deliveryExists($dataflowB:OBLIGATIONS, $countryCode, "b/", $reportingYear)) then
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
let $isNewDelivery := errors:getMaxError($B0table) = $errors:INFO

(: Generic variables :)
let $knownZones :=
    if ($isNewDelivery) then
        distinct-values(data(sparqlx:run(query:getZone(query:getLatestEnvelope($cdrUrl || $bdir, string(number($reportingYear) - 1))))//sparql:binding[@name = 'inspireLabel']/sparql:literal))
    else
        distinct-values(data(sparqlx:run(query:getZone($latestEnvelopeB))//sparql:binding[@name = 'inspireLabel']/sparql:literal))

(: B01 :)
let $countZones := count($docRoot//aqd:AQD_Zone)

(: B02 :)
let $B02table :=
    try {
        for $zone in $docRoot//aqd:AQD_Zone
            let $id := $zone/am:inspireId/base:Identifier/base:namespace || "/" || $zone/am:inspireId/base:Identifier/base:localId
        where ($id = "/" or not($knownZones = $id))
        return
            <tr>
                <td title="base:localId">{$zone/am:inspireId/base:Identifier/base:localId/string()}</td>
                <td title="zoneName">{data($zone/am:name/gn:GeographicalName/gn:spelling/gn:SpellingOfName/gn:text)}</td>
                <td title="zoneCode">{data($zone/aqd:zoneCode)}</td>
                <td title="aqd:predecessor">{if (empty($zone/aqd:predecessor)) then "not specified" else data($zone/aqd:predecessor/@xlink:href)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
let $B02errorLevel :=
    if (count($B02table) = $countZones) then
        $errors:B02
    else
        $errors:INFO

(: B03 :)
let $B03table :=
    try {
        for $zone in $docRoot//aqd:AQD_Zone
            let $id := $zone/am:inspireId/base:Identifier/base:namespace || "/" || $zone/am:inspireId/base:Identifier/base:localId
        where ($knownZones = $id)
        return
            <tr>
                <td title="base:localId">{$zone/am:inspireId/base:Identifier/base:localId/string()}</td>
                <td title="zoneName">{data($zone/am:name/gn:GeographicalName/gn:spelling/gn:SpellingOfName/gn:text)}</td>
                <td title="zoneCode">{data($zone/aqd:zoneCode)}</td>
                <td title="aqd:predecessor">{if (empty($zone/aqd:predecessor)) then "not specified" else data($zone/aqd:predecessor/@xlink:href)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: B04 :)
let $B04table :=
    try {
        for $rec in $docRoot//aqd:AQD_Zone
        return
            <tr>
                <td title="gml:id">{data($rec/@gml:id)}</td>
                <td title="namespace/localId">{concat(data($rec/am:inspireId/base:Identifier/base:namespace), '/', data($rec/am:inspireId/base:Identifier/base:localId))}</td>
                <td title="zoneName">{data($rec/am:name/gn:GeographicalName/gn:spelling/gn:SpellingOfName/gn:text)}</td>
                <td title="zoneCode">{data($rec/aqd:zoneCode)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: B06a :)
let $countZonesWithAmGeometry :=
    try {
        count($docRoot//aqd:AQD_Zone/am:geometry)
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: B06b :)
let $countZonesWithLAU :=
    try {
        count($docRoot//aqd:AQD_Zone[not(empty(aqd:LAU)) or not(empty(aqd:shapefileLink))])
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: B07 - Compile & feedback a list of aqd:aqdZoneType, aqd:pollutantCode, aqd:protectionTarget combinations in the delivery :)
let $B07table :=
    try {
        let $allB7Combinations :=
            for $pollutant in $docRoot//aqd:Pollutant
            return concat(data($pollutant/../../aqd:aqdZoneType/@xlink:href), "#", data($pollutant/aqd:pollutantCode/@xlink:href), "#", data($pollutant/aqd:protectionTarget/@xlink:href))

        let $allB7Combinations := fn:distinct-values($allB7Combinations)
        for $rec in $allB7Combinations
        let $zoneType := substring-before($rec, "#")
        let $tmpStr := substring-after($rec, concat($zoneType, "#"))
        let $pollutant := substring-before($tmpStr, "#")
        let $protTarget := substring-after($tmpStr, "#")
        return
            <tr>
                <td title="aqd:aqdZoneType">{common:checkLink($zoneType)}</td>
                <td title="aqd:pollutantCode">{common:checkLink($pollutant)}</td>
                <td title="aqd:protectionTarget">{common:checkLink($protTarget)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: B08 :)
let $B08table :=
    try {
        let $B08tmp :=
            for $x in $docRoot//aqd:AQD_Zone
                let $beginPosition := geox:parseDateTime($x/am:designationPeriod//gml:beginPosition)
                let $endPosition := geox:parseDateTime($x/am:designationPeriod//gml:endPosition)
                for $pollutantNode in $x/aqd:pollutants/aqd:Pollutant
                let $pollutant := string($pollutantNode/aqd:pollutantCode/@xlink:href)
                let $zone := string($pollutantNode/../../am:inspireId/base:Identifier/base:localId)
                let $protectionTarget := string($pollutantNode/aqd:protectionTarget/@xlink:href)
                let $key := string-join(($zone, $pollutant, $protectionTarget), "#")
            where common:isDateTimeIncluded($reportingYear, $beginPosition, $endPosition)
            group by $pollutant, $protectionTarget
            return
                <result>
                    <pollutantName>{dd:getNameFromPollutantCode($pollutant)}</pollutantName>
                    <pollutantCode>{tokenize($pollutant, "/")[last()]}</pollutantCode>
                    <protectionTarget>{$protectionTarget}</protectionTarget>
                    <count>{count(distinct-values($key))}</count>
                </result>
        let $combinations :=
            <combinations>
                <combination pollutant="1" protectionTarget="H"/><combination pollutant="1" protectionTarget="V"/>
                <combination pollutant="7" protectionTarget="H"/><combination pollutant="7" protectionTarget="V"/>
                <combination pollutant="8" protectionTarget="H"/>
                <combination pollutant="9" protectionTarget="V"/>
                <combination pollutant="5" protectionTarget="H"/>
                <combination pollutant="6001" protectionTarget="H"/>
                <combination pollutant="10" protectionTarget="H"/>
                <combination pollutant="20" protectionTarget="H"/>
                <combination pollutant="5012" protectionTarget="H"/>
                <combination pollutant="5018" protectionTarget="H"/>
                <combination pollutant="5014" protectionTarget="H"/>
                <combination pollutant="5015" protectionTarget="H"/>
                <combination pollutant="5029" protectionTarget="H"/>
            </combinations>

        for $x in $combinations/combination
            let $pollutant := $x/@pollutant
            let $protectionTarget := $vocabulary:PROTECTIONTARGET_VOCABULARY || $x/@protectionTarget
            let $elem := $B08tmp[pollutantCode = $pollutant and protectionTarget = $protectionTarget]
            let $count := string($elem/count)
            let $vsName := dd:getNameFromPollutantCode($pollutant)
            let $vsCode := string($vocabulary:POLLUTANT_VOCABULARY || $pollutant)
            let $errorClass :=
                if ($countryCode = "gi" and (($x/@pollutant = "1" and $x/@protectionTarget = "V") or ($x/@pollutant = "9" and $x/@protectionTarget = "V"))) then
                    $errors:INFO
                else if ($count = "" or $count = "NaN" or $count = "0") then
                    $errors:B08
                else
                    $errors:INFO
            order by $vsName
            return
                <tr class="{$errorClass}">
                    <td title="Pollutant Name">{$vsName}</td>
                    <td title="Pollutant Code">{$vsCode}</td>
                    <td title="Protection Target">{$protectionTarget}</td>
                    <td title="Count">{$count}</td>
                </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: B09 :)
(:TODO: ADD TRY CATCH :)
let $all1 := $docRoot//aqd:AQD_Zone/lower-case(@gml:id)
let $part1 := distinct-values(
    for $id in $docRoot//aqd:AQD_Zone/@gml:id
    where string-length($id) > 0 and count(index-of($all1, lower-case($id))) > 1
    return
        $id
    )
let $part1 :=
    for $x in $part1
    return
        <tr>
            <td title="Duplicate records">@gml:id [{$x}]</td>
        </tr>

let $all2 :=
    for $id in $docRoot//aqd:AQD_Zone/am:inspireId
    return lower-case("[" || $id/base:Identifier/base:localId || ", " || $id/base:Identifier/base:namespace || ", " || $id/base:Identifier/base:versionId || "]")
let $part2 := distinct-values(
    for $id in $docRoot//aqd:AQD_Zone/am:inspireId
    let $key := "[" || $id/base:Identifier/base:localId || ", " || $id/base:Identifier/base:namespace || ", " || $id/base:Identifier/base:versionId || "]"
    where string-length($id/base:Identifier/base:localId) > 0 and count(index-of($all2, lower-case($key))) > 1
    return
        $key
    )
let $part2 :=
    for $x in $part2
    return
        <tr>
            <td title="Duplicate records">am:inspireId {$x}</td>
        </tr>

let $all3 :=
    for $id in $docRoot//aqd:AQD_Zone/aqd:inspireId
    return lower-case("[" || $id/base:Identifier/base:localId || ", " || $id/base:Identifier/base:namespace || ", " || $id/base:Identifier/base:versionId || "]")
let $part3 := distinct-values(
    for $id in $docRoot//aqd:AQD_Zone/aqd:inspireId
    let $key := "[" || $id/base:Identifier/base:localId || ", " || $id/base:Identifier/base:namespace || ", " || $id/base:Identifier/base:versionId || "]"
    where  string-length(normalize-space($id/base:Identifier/base:localId)) > 0 and count(index-of($all3, lower-case($key))) > 1
    return
        $key
    )
let $part3 :=
    for $x in $part3
    return
        <tr>
            <td title="Duplicate records">aqd:inspireId {$x}</td>
        </tr>

let $countGmlIdDuplicates := count($part1)
let $countamInspireIdDuplicates := count($part2)
let $countaqdInspireIdDuplicates := count($part3)
let $B09invalid := ($part1, $part2, $part3)

(: B10 :)
let $B10table :=
    try {
        for $id in $zonesNamespaces
        let $localId := $docRoot//aqd:AQD_Zone/am:inspireId/base:Identifier[base:namespace = $id]/base:localId
        return
            <tr>
                <td title="base:namespace">{$id}</td>
                <td title="base:localId">{count($localId)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: B10.1 :)
let $B10.1invalid :=
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

(: B13 :)
let $B13invalid :=
    try {
        let $langSkippedMsg := "The test was skipped - ISO 639-3 and ISO 639-5 language codes are not available in Content Registry."
        let $langCodes := distinct-values(data(sparqlx:run(query:getLangCodesSparql())//sparql:binding[@name='code']/sparql:literal))

        for $x in $docRoot//aqd:AQD_Zone/am:name/gn:GeographicalName/gn:language
        where not($x = $langCodes)
        return
            <tr>
                <td title="aqd:AQD_Zone">{data($x/../../../am:inspireId/base:Identifier/base:localId)}</td>
                <td title="gn:language">{data($x)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: B18 :)
let $B18invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Zone[string(am:name/gn:GeographicalName/gn:spelling/gn:SpellingOfName/gn:text) = ""]
        return
            <tr>
                <td title="aqd:AQD_Zone">{string($x/am:inspireId/base:Identifier/base:localId)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: B20 :)
let $B20invalid :=
    try {
        let $validSrsNames := ("urn:ogc:def:crs:EPSG::3035", "urn:ogc:def:crs:EPSG::4326", "urn:ogc:def:crs:EPSG::4258")
        let $invalidPolygonName := distinct-values($docRoot//aqd:AQD_Zone[count(am:geometry/gml:Polygon) > 0 and not(am:geometry/gml:Polygon/@srsName = $validSrsNames)]/am:inspireId/base:Identifier/base:localId)
        let $invalidPointName := distinct-values($docRoot//aqd:AQD_Zone[count(am:geometry/gml:Point) > 0 and not(am:geometry/gml:Point/@srsName = $validSrsNames)]/am:inspireId/base:Identifier/base:localId)
        let $invalidMultiPointName := distinct-values($docRoot//aqd:AQD_Zone[count(am:geometry/gml:MultiPoint) > 0 and not(am:geometry/gml:MultiPoint/@srsName = $validSrsNames)]/am:inspireId/base:Identifier/base:localId)
        let $invalidMultiSurfaceName := distinct-values($docRoot//aqd:AQD_Zone[count(am:geometry/gml:MultiSurface) > 0 and not(am:geometry/gml:MultiSurface/@srsName = $validSrsNames)]/am:inspireId/base:Identifier/base:localId)
        let $invalidGridName := distinct-values($docRoot//aqd:AQD_Zone[count(am:geometry/gml:Grid) > 0 and not(am:geometry/gml:Grid/@srsName = $validSrsNames)]/am:inspireId/base:Identifier/base:localId)
        let $invalidRectifiedGridName := distinct-values($docRoot//aqd:AQD_Zone[count(am:geometry/gml:RectifiedGrid) > 0 and not(am:geometry/gml:RectifiedGrid/@srsName = $validSrsNames)]/am:inspireId/base:Identifier/base:localId)
        for $x in distinct-values(($invalidPolygonName, $invalidMultiPointName, $invalidPointName, $invalidMultiSurfaceName, $invalidGridName, $invalidRectifiedGridName))
        return
            <tr>
                <td title="aqd:AQD_Zone">{string($x)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: B21 :)
let $B21invalid  :=
    try {
        let $count := count($docRoot//aqd:AQD_Zone/am:geometry//gml:posList[@srsDimension != "2"])
        let $metadata := html:createMetadataTR($count)
        let $result :=
        for $x in $docRoot//aqd:AQD_Zone/am:geometry//gml:posList[@srsDimension != "2"]
        return
            <tr>
                <td title="aqd:AQD_Zone">{string($x/ancestor::aqd:AQD_Zone/am:inspireId/base:Identifier/base:localId)}</td>
                <td title="Polygon">{string($x/ancestor::gml:Polygon/@gml:id)}</td>
                <td title="srsDimension">{string($x/@srsDimension)}</td>
            </tr>
        return ($metadata, $result)
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: B22 - generalized by Hermann :)
let $B22invalid :=
    try {
        for $posList in $docRoot//gml:posList
        let $posListCount := count(fn:tokenize(normalize-space($posList), "\s+")) mod 2
        where (not(empty($posList)) and $posListCount > 0)
        return
            <tr>
                <td title="Polygon">{string($posList/../../../@gml:id)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: B23 - generalized by Hermann
 : In Europe, lat values tend to be bigger than lon values. We use this observation as a poor farmer's son test to check that in a coordinate value pair,
 : the lat value comes first, as defined in the GML schema
:)
let $B23invalid :=
    try {
        for $latLong in $docRoot//gml:posList
        let $latlongToken := fn:tokenize(normalize-space($latLong), "\s+")
        let $lat := number($latlongToken[1])
        let $long := number($latlongToken[2])
        let $srsName := string($latLong/../../../@srsName)
        where (not($countryCode = "fr") and not(geox:compareLatLong($srsName, $lat, $long)))
        return
            <tr>
                <td title="Polygon">{string($latLong/../../../@gml:id)}</td>
                <td title="srsName">{$srsName}</td>
                <td title="First vertex">{string($lat) || string($long)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
let $B23message :=
    if ($countryCode = "fr") then
        "Temporary turned off"
    else
        "All values are valid"

(: B24 - ./am:zoneType value shall resolve to http://inspire.ec.europa.eu/codeList/ZoneTypeCode/airQualityManagementZone :)
 let $B24invalid  :=
     try {
         for $x in $docRoot//aqd:AQD_Zone/am:zoneType
         where not($x/@xlink:href = $vocabulary:AQ_MANAGEMENET_ZONE) and not($x/@xlink:href = $vocabulary:AQ_MANAGEMENET_ZONE_LC)
         return
             <tr>
                <td title="aqd:AQD_Zone">{string($x/../am:inspireId/base:Identifier/base:localId)}</td>
                <td title="zoneType">{string($x/@xlink:href)}</td>
             </tr>
     } catch * {
         <tr class="{$errors:FAILED}">
             <td title="Error code">{$err:code}</td>
             <td title="Error description">{$err:description}</td>
         </tr>
     }

(: B25 :)
(: ./am:designationPeriod/gml:TimePeriod/gml:beginPosition shall be less than ./am:designationPeri/gml:TimePeriod/gml:endPosition. :)
 let $B25invalid  :=
     try {
         for $timePeriod in $docRoot//aqd:AQD_Zone/am:designationPeriod/gml:TimePeriod
         (: XQ does not support 24h that is supported by xsml schema validation :)
         (: TODO: comment by sofiageo - the above statement is not true, fix this if necessary :)
         let $beginDate := substring(normalize-space($timePeriod/gml:beginPosition), 1, 10)
         let $endDate := substring(normalize-space($timePeriod/gml:endPosition), 1, 10)
         let $beginPosition := if ($beginDate castable as xs:date) then xs:date($beginDate) else ()
         let $endPosition := if ($endDate castable as xs:date) then xs:date($endDate) else ()
         where (not(empty($beginPosition)) and not(empty($endPosition)) and $beginPosition > $endPosition)
         return
         (:  concat($timePeriod/../../@gml:id, ": gml:beginPosition=", $beginPosition, ": gml:endPosition=", $endPosition) :)
            <tr>
                <td title="aqd:AQD_Zone">{string($timePeriod/../../am:inspireId/base:Identifier/base:localId)}</td>
                <td title="gml:beginPosition">{$beginPosition}</td>
                <td title="gml:endPosition">{$endPosition}</td>
            </tr>
     } catch * {
         <tr class="{$errors:FAILED}">
             <td title="Error code">{$err:code}</td>
             <td title="Error description">{$err:description}</td>
         </tr>
     }

(: B28 - ./am:beginLifespanVersion shall be a valid historical date for the start of the version of the zone in extended ISO format.
If an am:endLifespanVersion exists its value shall be greater than the am:beginLifespanVersion :)
let $B28invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Zone
        let $beginDate := substring(normalize-space($x/am:beginLifespanVersion), 1, 10)
        let $endDate := substring(normalize-space($x/am:endLifespanVersion), 1, 10)
        let $beginPeriod := if ($beginDate castable as xs:date) then xs:date($beginDate) else ()
        let $endPeriod := if ($endDate castable as xs:date) then xs:date($endDate) else ()
        where ((not(empty($beginPeriod)) and not(empty($endPeriod)) and $beginPeriod > $endPeriod) or empty($beginPeriod))
        return
            <tr>
                <td title="aqd:AQD_Zone">{string($x/am:inspireId/base:Identifier/base:localId)}</td>
                <td title="am:beginLifespanVersion">{data($x/am:beginLifespanVersion)}</td>
                <td title="am:endLifespanVersion">{data($x/am:endLifespanVersion)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: B30 :)
let $B30invalid :=
    try {
        for $x in $docRoot//am:environmentalDomain
        where not(starts-with($x/@xlink:href, $vocabulary:MEDIA_VALUE_VOCABULARY_BASE_URI) or starts-with($x/@xlink:href, $vocabulary:MEDIA_VALUE_VOCABULARY_BASE_URI_UC))
        return
            <tr>
                <td title="aqd:AQD_Zone">{string($x/../am:inspireId/base:Identifier/base:localId)}</td>
                <td title="am:environmentalDomain">{data($x/@xlink:href)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: B31 :)
let $B31invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Zone/am:legalBasis/base2:LegislationCitation[normalize-space(base2:name) != "2011/850/EC"]
        let $base2 := if (string-length($x/base2:name) > 20) then concat(substring($x/base2:name, 1, 20), "...") else $x/base2:name
        return
            <tr>
                <td title="aqd:AQD_Zone">{string($x/../../am:inspireId/base:Identifier/base:localId)}</td>
                <td title="base2:name">{string($base2)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
(: B32 :)
let $B32invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Zone/am:legalBasis/base2:LegislationCitation[normalize-space(base2:date) != "2011-12-12"]
        let $base2 := if (string-length($x/base2:date) > 20) then concat(substring($x/base2:date, 1, 20), "...") else $x/base2:date
        return
            <tr>
                <td title="aqd:AQD_Zone">{string($x/../../am:inspireId/base:Identifier/base:localId)}</td>
                <td title="base2:date">{string($base2)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: B33 :)
let $B33invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Zone/am:legalBasis/base2:LegislationCitation[normalize-space(base2:link) != "http://rod.eionet.europa.eu/instruments/650"]
        let $base2 := if (string-length($x/base2:link) > 40) then concat(substring($x/base2:link, 1, 40), "...") else $x/base2:link
        return
            <tr>
                <td title="aqd:AQD_Zone">{string($x/../../am:inspireId/base:Identifier/base:localId)}</td>
                <td title="base2:link">{string($base2)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
(: B34 :)
let $B34invalid :=
    try {
        for $x in $docRoot//base2:level
        where not(starts-with($x/@xlink:href, $vocabulary:LEGISLATION_LEVEL) or starts-with($x/@xlink:href, $vocabulary:LEGISLATION_LEVEL_LC))
        return
            <tr>
                <td title="aqd:AQD_Zone">{string($x/../../../am:inspireId/base:Identifier/base:localId)}</td>
                <td title="base2:level">{string($x/@xlink:href)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: B35 :)
let $amNamespaceAndaqdZoneCodeIds := $docRoot//aqd:AQD_Zone/concat(am:inspireId/base:Identifier/lower-case(normalize-space(base:namespace)), '##', lower-case(normalize-space(aqd:zoneCode)))
let $dublicateAmNamespaceAndaqdZoneCodeIds := distinct-values(
        for $identifier in $docRoot//aqd:AQD_Zone
        where string-length(normalize-space($identifier/am:inspireId/base:Identifier/base:namespace)) > 0 and count(index-of($amNamespaceAndaqdZoneCodeIds,
                concat($identifier/am:inspireId/base:Identifier/lower-case(normalize-space(base:namespace)), '##', $identifier/lower-case(normalize-space(aqd:zoneCode))))) > 1
        return
            concat(normalize-space($identifier/am:inspireId/base:Identifier/base:namespace), ':', normalize-space($identifier/aqd:zoneCode))
)
let $countB35duplicates :=
    try {
        let $countAmNamespaceAndaqdZoneCodeDuplicates := count($dublicateAmNamespaceAndaqdZoneCodeIds)
        return $countAmNamespaceAndaqdZoneCodeDuplicates
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: B36 :)
let $B36invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Zone[not(count(aqd:residentPopulation)>0 and aqd:residentPopulation castable as xs:integer and number(aqd:residentPopulation) >= 0)]
        let $residentPopulation := if (string-length($x/aqd:residentPopulation) = 0) then "missing" else $x/aqd:residentPopulation
        return
            <tr>
                <td title="aqd:AQD_Zone">{string($x/am:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:residentPopulation">{string($residentPopulation)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: B37 - ./aqd:residentPopulationYear/gml:TimeInstant/gml:timePosition shall cite the year in which the resident population was estimated in yyyy format :)
let $B37invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Zone
        where (common:isInvalidYear(data($x/aqd:residentPopulationYear/gml:TimeInstant/gml:timePosition)))
        return
            <tr>
                <td title="aqd:AQD_Zone">{string($x/am:inspireId/base:Identifier/base:localId)}</td>
                <td title="gml:timePosition">{data($x/aqd:residentPopulationYear/gml:TimeInstant/gml:timePosition)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: B38 :)
let $B38invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Zone[not(count(aqd:area)>0 and number(aqd:area) and number(aqd:area) > 0)]
        let $area := if (string-length($x/aqd:area) = 0) then "missing" else $x/aqd:area
        return
            <tr>
                <td title="aqd:AQD_Zone">{string($x/am:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:area">{data($area)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: B39a - Find invalid combinations :)
let $pollutantCombinations :=
    <combinations>
        <combination>
            <code>1</code>
            <target>H</target>
        </combination>
        <combination>
            <code>1</code>
            <target>V</target>
        </combination>
        <combination>
            <code>7</code>
            <target>H</target>
        </combination>
        <combination>
            <code>7</code>
            <target>V</target>
        </combination>
        <combination>
            <code>8</code>
            <target>H</target>
        </combination>
        <combination>
            <code>9</code>
            <target>V</target>
        </combination>
        <combination>
            <code>5</code>
            <target>H</target>
        </combination>
        <combination>
            <code>6001</code>
            <target>H</target>
        </combination>
        <combination>
            <code>10</code>
            <target>H</target>
        </combination>
        <combination>
            <code>20</code>
            <target>H</target>
        </combination>
        <combination>
            <code>5012</code>
            <target>H</target>
        </combination>
        <combination>
            <code>5018</code>
            <target>H</target>
        </combination>
        <combination>
            <code>5014</code>
            <target>H</target>
        </combination>
        <combination>
            <code>5015</code>
            <target>H</target>
        </combination>
        <combination>
            <code>5029</code>
            <target>H</target>
        </combination>
    </combinations>
let $pollutantCodeVocabulary := "http://dd.eionet.europa.eu/vocabulary/aq/pollutant/"
let $pollutantTargetVocabulary := "http://dd.eionet.europa.eu/vocabulary/aq/protectiontarget/"
let $B39aItemsList :=
    <table>
        <caption>Allowed Pollutant / Target combinations: </caption>
        <thead>
            <tr>
                <th>Pollutant</th>
                <th>Protection target</th>
            </tr>
        </thead>
        <tbody>{
            for $i in $pollutantCombinations//combination
            return
                <tr>
                    <td>{concat($pollutantCodeVocabulary, $i/code)}</td>
                    <td>{concat($pollutantTargetVocabulary, $i/target)}</td>
                </tr>
        }</tbody>
    </table>

(: B39a :)
let $B39ainvalid :=
    for $x in $docRoot//aqd:AQD_Zone/aqd:pollutants/aqd:Pollutant
        let $code := string($x/aqd:pollutantCode/@xlink:href)
        let $target := string($x/aqd:protectionTarget/@xlink:href)
    where not($pollutantCombinations//combination[concat($pollutantCodeVocabulary, code) = $code and concat($pollutantTargetVocabulary, target) = $target])
    return
        <tr>
            <td title="base:localId">{string($x/../../am:inspireId/base:Identifier/base:localId)}</td>
            <td title="Pollutant">{string($code)}</td>
            <td title="Protection target">{string($target)}</td>
        </tr>
(: B39b - Count combination occurrences  :)
let $B39binvalid :=
    try {
        let $pollutantOccurrences := <results> {
            for $x in $pollutantCombinations//combination
            let $code := concat($pollutantCodeVocabulary, $x/code)
            let $target := concat($pollutantTargetVocabulary, $x/target)
            let $count := count($docRoot//aqd:AQD_Zone/aqd:pollutants/aqd:Pollutant[aqd:pollutantCode/@xlink:href = $code and aqd:protectionTarget/@xlink:href = $target])
            let $warning :=
                if ($count = 0) then
                    if ($countryCode = "gi") then
                        if ((($code = "http://dd.eionet.europa.eu/vocabulary/aq/pollutant/1") and ($target = "http://dd.eionet.europa.eu/vocabulary/aq/protectiontarget/V")) or
                        (($code = "http://dd.eionet.europa.eu/vocabulary/aq/pollutant/9") and ($target = "http://dd.eionet.europa.eu/vocabulary/aq/protectiontarget/V"))) then
                            0 else 1
                    else 1
                else 0
            return
                <result>
                    <code>{$code}</code>
                    <target>{$target}</target>
                    <warning>{$warning}</warning>
                </result>
        }</results>
        for $x in $pollutantOccurrences//result[warning = 1]
        return
            <tr>
                <td title="Pollutant">{data($x/code)}</td>
                <td title="Protection target">{data($x/target)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: B39c - Combination cannot be repeated in individual zone :)
let $B39cinvalid :=
    try {
        for $x in $docRoot//aqd:AQD_Zone
        let $codes :=
            for $y in $pollutantCombinations//combination
            let $code := concat($pollutantCodeVocabulary, $y/code)
            let $target := concat($pollutantTargetVocabulary, $y/target)
            let $count := count($x/aqd:pollutants/aqd:Pollutant[aqd:pollutantCode/@xlink:href = $code and aqd:protectionTarget/@xlink:href = $target])
            where $count > 1
            return $code
        let $codes := distinct-values($codes)
        where not(empty($codes))
        return
            <tr>
                <td title="base:localId">{data($x/am:inspireId/base:Identifier/base:localId)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: B40 - /aqd:timeExtensionExemption attribute must resolve to one of concept within http://dd.eionet.europa.eu/vocabulary/aq/timeextensiontypes/ :)
let $B40invalid :=
    try {
        let $year := xs:integer(common:getReportingYear($docRoot))
        let $valid :=
            if ($year >= 2015) then
                "http://dd.eionet.europa.eu/vocabulary/aq/timeextensiontypes/none"
            else
                dd:getValidConcepts("http://dd.eionet.europa.eu/vocabulary/aq/timeextensiontypes/rdf")
            for $x in $docRoot//aqd:AQD_Zone/aqd:timeExtensionExemption/@xlink:href
            where (not($x = $valid))
            return
                <tr>
                    <td title="aqd:AQD_Zone">{string($x/../../am:inspireId/base:Identifier/base:localId)}</td>
                    <td title="aqd:timeExtensionExemption">{string($x)}</td>
                </tr>

    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: B41 :)
let $B41invalid :=
    try {
        let $zoneIds :=
            for $x in $docRoot//aqd:AQD_Zone/aqd:pollutants
            where ($x/aqd:Pollutant/aqd:pollutantCode/@xlink:href = "http://dd.eionet.europa.eu/vocabulary/aq/pollutant/8" and $x/aqd:Pollutant/aqd:protectionTarget/@xlink:href = "http://dd.eionet.europa.eu/vocabulary/aq/protectiontarget/H")
                    and ($x/../aqd:timeExtensionExemption/fn:normalize-space(@xlink:href) = "http://dd.eionet.europa.eu/vocabulary/aq/timeextensiontypes/NO2-1h"
                            or $x/../aqd:timeExtensionExemption/fn:normalize-space(@xlink:href) = "http://dd.eionet.europa.eu/vocabulary/aq/timeextensiontypes/NO2-annual")
            return
                string($x/../am:inspireId/base:Identifier/base:localId)

        for $y in $docRoot//aqd:AQD_Zone[aqd:timeExtensionExemption/fn:normalize-space(@xlink:href) = "http://dd.eionet.europa.eu/vocabulary/aq/timeextensiontypes/NO2-1h"
                or aqd:timeExtensionExemption/fn:normalize-space(@xlink:href) = "http://dd.eionet.europa.eu/vocabulary/aq/timeextensiontypes/NO2-annual"]
        where empty(index-of($zoneIds, string($y/am:inspireId/base:Identifier/base:localId)))
        return
            <tr>
                <td title="base:localId">{data($y/am:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:pollutantCode">{common:checkLink("http://dd.eionet.europa.eu/vocabulary/aq/pollutant/8")}</td>
                <td title="aqd:protectionTarget">{common:checkLink("http://dd.eionet.europa.eu/vocabulary/aq/protectiontarget/H")}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: B42 :)
let $B42invalid :=
    try {
        let $zoneIds :=
            for $x in $docRoot//aqd:AQD_Zone/aqd:pollutants
            where ($x/aqd:Pollutant/aqd:pollutantCode/@xlink:href = "http://dd.eionet.europa.eu/vocabulary/aq/pollutant/5" and $x/aqd:Pollutant/aqd:protectionTarget/@xlink:href = "http://dd.eionet.europa.eu/vocabulary/aq/protectiontarget/H")
                    and ($x/../aqd:timeExtensionExemption/fn:normalize-space(@xlink:href) = "http://dd.eionet.europa.eu/vocabulary/aq/timeextensiontypes/PM10-24h"
                            or $x/../aqd:timeExtensionExemption/fn:normalize-space(@xlink:href) = "http://dd.eionet.europa.eu/vocabulary/aq/timeextensiontypes/PM10-annual")
            return string($x/../am:inspireId/base:Identifier/base:localId)


        for $y in $docRoot//aqd:AQD_Zone[aqd:timeExtensionExemption/fn:normalize-space(@xlink:href) = "http://dd.eionet.europa.eu/vocabulary/aq/timeextensiontypes/PM10-24h"
                or aqd:timeExtensionExemption/fn:normalize-space(@xlink:href) = "http://dd.eionet.europa.eu/vocabulary/aq/timeextensiontypes/PM10-annual"]
        where (not($zoneIds = string($y/am:inspireId/base:Identifier/base:localId)))
        return
            <tr>
                <td title="base:localId">{data($y/am:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:pollutantCode">{common:checkLink("http://dd.eionet.europa.eu/vocabulary/aq/pollutant/5")}</td>
                <td title="aqd:protectionTarget">{common:checkLink("http://dd.eionet.europa.eu/vocabulary/aq/protectiontarget/H")}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }


(: B43 :)
let $B43invalid :=
    try {
        let $zoneIds :=
            for $x in $docRoot//aqd:AQD_Zone/aqd:pollutants
            where (($x/aqd:Pollutant/aqd:pollutantCode/@xlink:href = "http://dd.eionet.europa.eu/vocabulary/aq/pollutant/20" and $x/aqd:Pollutant/aqd:protectionTarget/@xlink:href = "http://dd.eionet.europa.eu/vocabulary/aq/protectiontarget/H")
                    and ($x/../aqd:timeExtensionExemption/fn:normalize-space(@xlink:href) = "http://dd.eionet.europa.eu/vocabulary/aq/timeextensiontypes/C6H6-annual"))
            return string($x/../am:inspireId/base:Identifier/base:localId)

        for $y in $docRoot//aqd:AQD_Zone[aqd:timeExtensionExemption/fn:normalize-space(@xlink:href) = "http://dd.eionet.europa.eu/vocabulary/aq/timeextensiontypes/C6H6-annual"]
        where (not($zoneIds = string($y/am:inspireId/base:Identifier/base:localId)))
        return
            <tr>
                <td title="base:localid">{data($y/am:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:pollutantCode">{common:checkLink("http://dd.eionet.europa.eu/vocabulary/aq/pollutant/20")}</td>
                <td title="aqd:protectionTarget">{common:checkLink("http://dd.eionet.europa.eu/vocabulary/aq/protectiontarget/H")}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: B45 :)
let $B45invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Zone[count(am:geometry/@xlink:href) > 0]
        return
            <tr>
                <td title="base:localId">{string($x/am:inspireId/base:Identifier/base:localId)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: B46 - Where ./aqd:shapefileLink has been used the xlink should return a link to a valid and existing file located in the same cdr envelope as this XML :)
let $B46invalid :=
    try {
        let $aqdShapeFileLink := $docRoot//aqd:AQD_Zone[not(normalize-space(aqd:shapefileLink) = '')]/aqd:shapefileLink

        for $link in $aqdShapeFileLink
        let $correctLink := common:getEnvelopeXML($source_url)
        return
            if (count(doc($correctLink)/envelope/file[replace(@link, "https://", "http://") = replace($link, "https://", "http://")]) = 0) then
                <tr>
                    <td title="aqd:AQD_Zone">{data($link/../am:inspireId/base:Identifier/base:localId)}</td>
                    <td title="aqd:shapefileLink">{data($link)}</td>
                </tr>
            else
                ()
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: B47 :)
let $B47invalid :=
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
    }

return
    <table class="maintable hover">
        {html:build2("NS", $labels:NAMESPACES, $labels:NAMESPACES_SHORT, $NSinvalid, "All values are valid", "record", $errors:NS)}
        {html:build3("B0", $labels:B0, $labels:B0_SHORT, $B0table, string($B0table/td), errors:getMaxError($B0table))}
        {html:buildCountRow0("B01", $labels:B01, $labels:B01_SHORT, $countZones, "", "record", $errors:B01)}
        {html:buildSimple("B02", $labels:B02, $labels:B02_SHORT, $B02table, "", "record", $B02errorLevel)}
        {html:build0("B03", $labels:B03, $labels:B03_SHORT, $B03table, "record")}
        {html:build0("B04", $labels:B04, $labels:B04_SHORT, $B04table, "record")}
        {html:buildResultsSimpleRow("B06a", $labels:B06a, $labels:B06a_SHORT, $countZonesWithAmGeometry, $errors:B06a)}
        {html:buildResultsSimpleRow("B06b", $labels:B06b, $labels:B06b_SHORT, $countZonesWithLAU, $errors:B06b)}
        {html:build0("B07", $labels:B07, $labels:B07_SHORT, $B07table, "record")}
        {html:build2("B08", $labels:B08, $labels:B08_SHORT, $B08table, "", "record", errors:getMaxError($B08table))}
        {html:build2("B09", $labels:B09, $labels:B09_SHORT, $B09invalid, "All values are valid", "record", $errors:B09)}
        {html:buildUnique("B10", $labels:B10, $labels:B10_SHORT, $B10table, "record", $errors:B10)}
        {html:build2("B10.1", $labels:B10.1, $labels:B10.1_SHORT, $B10.1invalid, "All values are valid", " invalid namespaces", $errors:B10.1)}
        {html:build2("B13", $labels:B13, $labels:B13_SHORT, $B13invalid, "All values are valid", " invalid value", $errors:B13)}
        {html:build2("B18", $labels:B18, $labels:B18_SHORT, $B18invalid, "All text are valid"," invalid attribute", $errors:B18)}
        {html:build2("B20", $labels:B20, $labels:B20_SHORT, $B20invalid, "All srsName attributes are valid"," invalid attribute", $errors:B20)}
        {html:build2("B21", $labels:B21, $labels:B21_SHORT, $B21invalid, "All srsDimension attributes resolve to ""2""", " invalid attribute", $errors:B21)}
        {html:build2("B22", $labels:B22, $labels:B22_SHORT, $B22invalid, "All values are valid", " invalid attribute", $errors:B22)}
        {html:build2("B23", $labels:B23, $labels:B23_SHORT, $B23invalid, $B23message, " invalid attribute", $errors:B23)}
        {html:build2("B24", $labels:B24, $labels:B24_SHORT, $B24invalid, "All zoneType attributes are valid", " invalid attribute", $errors:B24)}
        {html:build2("B25", $labels:B25, $labels:B25_SHORT, $B25invalid, "All positions are valid", " invalid position", $errors:B25)}
        {html:build2("B28", $labels:B28, $labels:B28_SHORT, $B28invalid, "All LifespanVersion values are valid", " invalid value", $errors:B28)}
        {html:build2("B30", $labels:B30, $labels:B30_SHORT, $B30invalid, "All values are valid", " invalid value", $errors:B30)}
        {html:build2("B31", $labels:B31, $labels:B31_SHORT, $B31invalid, "All values are valid", " invalid value", $errors:B31)}
        {html:build2("B32", $labels:B32, $labels:B32_SHORT, $B32invalid, "All values are valid", " invalid value", $errors:B32)}
        {html:build2("B33", $labels:B33, $labels:B33_SHORT, $B33invalid, "All values are valid", " invalid value", $errors:B33)}
        {html:build2("B34", $labels:B34, $labels:B34_SHORT, $B34invalid, "All values are valid", " invalid value", $errors:B34)}
        {html:buildCountRow("B35", $labels:B35, $labels:B35_SHORT, $countB35duplicates, (), (), ())}
        {html:buildConcatRow($dublicateAmNamespaceAndaqdZoneCodeIds, "Duplicate base:namespace:aqd:zoneCode - ")}
        {html:build2("B36", $labels:B36, $labels:B36_SHORT, $B36invalid, "All values are valid", " invalid value", $errors:B36)}
        {html:build2("B37", $labels:B37, $labels:B37_SHORT, $B37invalid, "All values are valid", " invalid value", $errors:B37)}
        {html:build2("B38", $labels:B38, $labels:B38_SHORT, $B38invalid, "All values are valid", " invalid value", $errors:B38)}
        {html:build2("B39a", $labels:B39a, <span>{$labels:B39a_SHORT} - {html:buildInfoTable("B39a", $B39aItemsList)}</span>, $B39ainvalid, "All values are valid", " invalid value", $errors:B39a)}
        {html:build2("B39b", $labels:B39b, $labels:B39b_SHORT, $B39binvalid, "All values are valid", " missing value", $errors:B39b)}
        {html:build2("B39c", $labels:B39c, $labels:B39c_SHORT, $B39cinvalid, "All values are valid", " invalid value", $errors:B39c)}
        {html:build2("B40", $labels:B40, $labels:B40_SHORT, $B40invalid, "All values are valid", "record", $errors:B40)}
        {html:build2("B41", $labels:B41, $labels:B41_SHORT, $B41invalid, "All values are valid", " invalid value", $errors:B41)}
        {html:build2("B42", $labels:B42, $labels:B42_SHORT, $B42invalid, "All values are valid", " crucial invalid value", $errors:B42)}
        {html:build2("B43", $labels:B43, $labels:B43_SHORT, $B43invalid, "All values are valid", " crucial invalid value", $errors:B43)}
        {html:build2("B45", $labels:B45, $labels:B45_SHORT, $B45invalid, "All values are valid", " invalid value", $errors:B45)}
        {html:build2("B46", $labels:B46, $labels:B46_SHORT, $B46invalid, "All values are valid", " invalid value", $errors:B46)}
        {html:build2("B47", $labels:B47, $labels:B47_SHORT, $B47invalid, "All values are valid", "invalid value", $errors:B47)}
    </table>
};
declare function dataflowB:proceed($source_url as xs:string, $countryCode as xs:string) as element(div) {

let $countZones := count(doc($source_url)//aqd:AQD_Zone)
let $result := if ($countZones > 0) then dataflowB:checkReport($source_url, $countryCode) else ()
let $meta := map:merge((
    map:entry("count", $countZones),
    map:entry("header", "Check air quality zones"),
    map:entry("dataflow", "Dataflow B"),
    map:entry("zeroCount", <p>No aqd:AQD_Zone elements found in this XML.</p>),
    map:entry("report", <p>This check evaluated the delivery by executing tier-1 tests on air quality zones data in Dataflow B as specified in <a href="http://www.eionet.europa.eu/aqportal/qaqc/">e-reporting QA/QC rules documentation</a>.</p>)
))
return
    html:buildResultDiv($meta, $result)
};
(:
 : Module Name: Implementing Decision 2011/850/EU: AQ info exchange & reporting (Library module)
 :
 : Version:     $Id$
 : Created:     13 September 2013
 : Copyright:   European Environment Agency
 :
 : XQuery script implements dataflow C tier-1 checks as documented in http://taskman.eionet.europa.eu/documents/3 .
 :
 : @author Enriko Käsper
 : @author George Sofianos
 : small modification added by Jaume Targa (ETC/ACM) to align with QA document & polish some checks
 :)





declare variable $dataflowC:ISO2_CODES as xs:string* := ("AL","AT","BA","BE","BG","CH","CY","CZ","DE","DK","DZ","EE","EG","ES","FI",
    "FR","GB","GR","HR","HU","IE","IL","IS","IT","JO","LB","LI","LT","LU","LV","MA","ME","MK","MT","NL","NO","PL","PS","PT",
     "RO","RS","SE","SI","SK","TN","TR","XK","UK");



declare variable $dataflowC:UNIQUE_POLLUTANT_IDS_9 as xs:string* := ("1","7","8","9","5","6001","10","20","5012","5014","5015","5018","5029","1045",
"1046","1047","1771","1772","1629","1659","1657","1668","1631","2012","2014","2015","2018","7013","4013","4813","653","5013","5610","5617","5759",
"5626","5655","5763","7029","611","618","760","627","656","7419","20","428","430","432","503","505","394","447","6005","6006","6007","24","486",
"316","6008","6009","451","443","316","441","475","449","21","431","464","482","6011","6012","32","25");

declare variable $dataflowC:VALID_POLLUTANT_IDS_19 as xs:string* := ("1045","1046","1047","1771","1772","1629","1659","1657","1668","1631","2012","2014","2015","2018","7013","4013","4813","653","5013","5610","5617",
"5759","5626","5655","5763","7029","611","618","760","627","656","7419","428","430","432","503","505","394","447","6005","6006","6007","24","486","316","6008","6009","451","443","441","475","449","21","431","464",
"482","6011","6012","32","25");

declare variable $dataflowC:VALID_POLLUTANT_IDS_27 as xs:string* := ('1045','1046','1047','1771','1772','1629','1659','1657','1668','1631','2012','2014','2015','2018','7013','4013','4813','653','5013','5610','5617',
'5759','5626','5655','5763','7029','611','618','760','627','656','7419','20','428','430','432','503','505','394','447','6005','6006','6007','24','486','316','6008','6009',
'451','443','316','441','475','449','21','431','464','482','6011','6012','32','25','6001');





(: Rule implementations :)
declare function dataflowC:checkReport($source_url as xs:string, $countryCode as xs:string) as element(table) {

(: SETUP COMMON VARIABLES :)
let $envelopeUrl := common:getEnvelopeXML($source_url)
let $docRoot := doc($source_url)
let $cdrUrl := common:getCdrUrl($countryCode)
let $bdir := if (contains($source_url, "c_preliminary")) then "b_preliminary/" else "b/"
let $cdir := if (contains($source_url, "c_preliminary")) then "c_preliminary/" else "c/"
let $zonesUrl := concat($cdrUrl, $bdir)
let $reportingYear := common:getReportingYear($docRoot)
let $latestEnvelopeB := query:getLatestEnvelope($zonesUrl, $reportingYear)
let $namespaces := distinct-values($docRoot//base:namespace)

let $zoneIds := if ((fn:string-length($countryCode) = 2) and exists($latestEnvelopeB)) then distinct-values(data(sparqlx:run(query:getZone($latestEnvelopeB))//sparql:binding[@name = 'inspireLabel']/sparql:literal)) else ()
let $countZoneIds1 := count($zoneIds)
let $countZoneIds2 := count(distinct-values($docRoot//aqd:AQD_AssessmentRegime/aqd:zone/@xlink:href))


let $latestEnvelopeB := query:getLatestEnvelope($cdrUrl || $bdir)
let $latestEnvelopeC := query:getLatestEnvelope($cdrUrl || $cdir, $reportingYear)
let $latestEnvelopeD := query:getLatestEnvelope($cdrUrl || "d/")
let $latestEnvelopeD1b := query:getLatestEnvelope($cdrUrl || "d1b/", $reportingYear)
let $knownRegimes := distinct-values(data(sparqlx:run(query:getAssessmentRegime($latestEnvelopeC))/sparql:binding[@name = 'inspireLabel']/sparql:literal))
let $allRegimes := query:getAllRegimeIds($namespaces)
let $countRegimes := count($docRoot//aqd:AQD_AssessmentRegime)

let $latestModels :=
    try {
        distinct-values(data(sparqlx:run(query:getModel($latestEnvelopeD1b))//sparql:binding[@name = 'inspireLabel']/sparql:literal))
    } catch * {
        ()
    }
let $modelsEnvelope := if (empty($latestModels)) then $latestEnvelopeD else $latestEnvelopeD1b

let $latestModels :=
    try {
        if (empty($latestModels)) then distinct-values(data(sparqlx:run(query:getModel($latestEnvelopeD))//sparql:binding[@name = 'inspireLabel']/sparql:literal)) else $latestModels
    } catch * {
        ()
    }
let $latestSamplingPoints := data(sparqlx:run(query:getSamplingPoint($latestEnvelopeD))/sparql:binding[@name = 'inspireLabel']/sparql:literal)

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

(: C0 :)
let $C0table :=
    try {
        if ($reportingYear = "") then
            <tr class="{$errors:ERROR}">
                <td title="Status">Reporting Year is missing.</td>
            </tr>
        else if (query:deliveryExists($dataflowC:OBLIGATIONS, $countryCode, $cdir, $reportingYear)) then
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
let $isNewDelivery := errors:getMaxError($C0table) = $errors:INFO

(: C01 :)
let $C01table :=
    try {
        for $rec in $docRoot//aqd:AQD_AssessmentRegime
        return
            <tr>
                <td title="gml:id">{data($rec/@gml:id)}</td>
                <td title="base:localId">{data($rec/aqd:inspireId/base:Identifier/base:localId)}</td>
                <td title="base:namespace">{data($rec/aqd:inspireId/base:Identifier/base:namespace)}</td>
                <td title="aqd:zone">{common:checkLink(data($rec/aqd:zone/@xlink:href))}</td>
                <td title="aqd:pollutant">{common:checkLink(data($rec/aqd:pollutant/@xlink:href))}</td>
                <td title="aqd:protectionTarget">{common:checkLink(data($rec/aqd:assessmentThreshold/aqd:AssessmentThreshold/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:protectionTarget/@xlink:href))}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: C02 :)
let $C02table :=
    try {
        for $x in $docRoot//aqd:AQD_AssessmentRegime
        let $id := $x/aqd:inspireId/base:Identifier/base:namespace || "/" || $x/aqd:inspireId/base:Identifier/base:localId
        where (not($knownRegimes = $id))
        return
            <tr>
                <td title="gml:id">{data($x/@gml:id)}</td>
                <td title="base:localId">{data($x/aqd:inspireId/base:Identifier/base:localId)}</td>
                <td title="base:namespace">{data($x/aqd:inspireId/base:Identifier/base:namespace)}</td>
                <td title="aqd:zone">{common:checkLink(data($x/aqd:zone/@xlink:href))}</td>
                <td title="aqd:pollutant">{common:checkLink(data($x/aqd:pollutant/@xlink:href))}</td>
                <td title="aqd:protectionTarget">{common:checkLink(data($x/aqd:assessmentThreshold/aqd:AssessmentThreshold/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:protectionTarget/@xlink:href))}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
let $C02errorLevel :=
    if ($isNewDelivery and count(
        for $x in $docRoot//aqd:AQD_AssessmentRegime
        let $id := $x/aqd:inspireId/base:Identifier/base:namespace || "/" || $x/aqd:inspireId/base:Identifier/base:localId
        where ($allRegimes = $id)
        return 1) > 0) then
            $errors:C02
    else
        $errors:INFO

(: C03 :)
let $C03table :=
    try {
        for $x in $docRoot//aqd:AQD_AssessmentRegime
        let $id := $x/aqd:inspireId/base:Identifier/base:namespace || "/" || $x/aqd:inspireId/base:Identifier/base:localId
        where ($knownRegimes = $id)
        return
            <tr>
                <td title="gml:id">{data($x/@gml:id)}</td>
                <td title="base:localId">{data($x/aqd:inspireId/base:Identifier/base:localId)}</td>
                <td title="base:versionId">{data($x/aqd:inspireId/base:Identifier/base:versionId)}</td>
                <td title="base:namespace">{data($x/aqd:inspireId/base:Identifier/base:namespace)}</td>
                <td title="aqd:zone">{common:checkLink(data($x/aqd:zone/@xlink:href))}</td>
                <td title="aqd:pollutant">{common:checkLink(data($x/aqd:pollutant/@xlink:href))}</td>
                <td title="aqd:protectionTarget">{common:checkLink(data($x/aqd:assessmentThreshold/aqd:AssessmentThreshold/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:protectionTarget/@xlink:href))}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
let $C03errorLevel :=
    if (not($isNewDelivery) and count($C03table) = 0) then
        $errors:C03
    else
        $errors:INFO

(: C04 - duplicate @gml:ids :)
let $C04invalid :=
    try {
        let $gmlIds := $docRoot//aqd:AQD_AssessmentRegime/lower-case(normalize-space(@gml:id))
        for $id in $docRoot//aqd:AQD_AssessmentRegime/@gml:id
        where count(index-of($gmlIds, lower-case(normalize-space($id)))) > 1
        return
            <tr>
                <td title="@gml:id">{$id}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }


(: C05 - duplicate ./aqd:inspireId/base:Identifier/base:localId :)
let $C05invalid :=
    try {
        let $localIds := $docRoot//aqd:AQD_AssessmentRegime/aqd:inspireId/base:Identifier/lower-case(normalize-space(base:localId))
        for $id in $docRoot//aqd:inspireId/base:Identifier/base:localId
        where count(index-of($localIds, lower-case(normalize-space($id)))) > 1
        return
            <tr>
                <td title="base:localId">{$id}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: C06 - :)
let $C06table :=
    try {
        let $allBaseNamespace := distinct-values($docRoot//aqd:AQD_AssessmentRegime/aqd:inspireId/base:Identifier/base:namespace)
        for $id in $allBaseNamespace
        let $localId := $docRoot//aqd:AQD_AssessmentRegime/aqd:inspireId/base:Identifier[base:namespace = $id]/base:localId
        return
            <tr>
                <td title="base:namespace">{$id}</td>
                <td title="base:localId">{count($localId)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
        
(: C06.1 :)
let $C06.1invalid :=
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

(: C07 :)
let $C07invalid :=
    try {
        for $aqdAQD_AssessmentRegim in $docRoot//aqd:AQD_AssessmentRegime
        where $aqdAQD_AssessmentRegim[count(aqd:assessmentThreshold/aqd:AssessmentThreshold/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:objectiveType/@xlink:href) = 0]
        return
            <tr>
                <td title="base:localId">{string($aqdAQD_AssessmentRegim/aqd:inspireId/base:Identifier/base:localId)}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: C08 - if a regime is missing for a pollutant in the list, warning should be thrown :)
let $C08invalid :=
    try {
        let $mandatory := ("1","7","8","9","5","6001","10","20","5012","5014","5015","5018","5029")
        let $pollutants :=
            if ($countryCode = "gi") then remove($mandatory, index-of($mandatory, "9"))
            else $mandatory
        for $code in $pollutants
        let $pollutantLink := $vocabulary:POLLUTANT_VOCABULARY || $code
        where count($docRoot//aqd:AQD_AssessmentRegime/aqd:pollutant[@xlink:href = $pollutantLink]) < 1
        return
            <tr>
                <td title="Pollutant"><a href="{$pollutantLink}">{$code}</a></td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: C09 - Provides a count of unique pollutants and lists them :)
let $C09table :=
    try {
        let $pollutants :=
            for $x in $docRoot//aqd:AQD_AssessmentRegime[aqd:assessmentThreshold/aqd:AssessmentThreshold/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:objectiveType/@xlink:href = "http://dd.eionet.europa.eu/vocabulary/aq/objectivetype/MO"]
            return $x/aqd:pollutant/@xlink:href/string()
        for $i in distinct-values($pollutants)
        return
            <tr>
                <td title="pollutant">{$i}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: C10 :)
let $C10invalid :=
    try {
        let $exceptions := ($vocabulary:OBJECTIVETYPE_VOCABULARY || "MO")
        let $all :=
            for $x in doc($vocabulary:ENVIRONMENTALOBJECTIVE || "rdf")//skos:Concept[adms:status/@rdf:resource = $dd:VALIDRESOURCE]
            return $x/prop:relatedPollutant/@rdf:resource || "#" || $x/prop:hasObjectiveType/@rdf:resource || "#" || $x/prop:hasReportingMetric/@rdf:resource || "#" || $x/prop:hasProtectionTarget/@rdf:resource

        for $x in $docRoot//aqd:AQD_AssessmentRegime
        let $pollutant := $x/aqd:pollutant/@xlink:href
        let $objectiveType := $x/aqd:assessmentThreshold/aqd:AssessmentThreshold/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:objectiveType/@xlink:href
        let $reportingMetric := $x/aqd:assessmentThreshold/aqd:AssessmentThreshold/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:reportingMetric/@xlink:href
        let $protectionTarget := $x/aqd:assessmentThreshold/aqd:AssessmentThreshold/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:protectionTarget/@xlink:href
        let $combination := $pollutant || "#" || $objectiveType || "#" || $reportingMetric || "#" || $protectionTarget
        where not($objectiveType = $exceptions) and not($combination = $all)
        return
            <tr>
                <td title="aqd:AQD_AssessmentRegime">{data($x/aqd:inspireId/base:Identifier/base:localId)}</td>
                <td title="Pollutant">{data($pollutant)}</td>
                <td title="ObjectiveType">{data($objectiveType)}</td>
                <td title="ReportingMetric">{data($reportingMetric)}</td>
                <td title="ProtectionTarget">{data($protectionTarget)}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: C20 :)
let $C20invalid :=
    try {
        let $rdf := doc($vocabulary:ENVIRONMENTALOBJECTIVE || "rdf")
        let $rdf := distinct-values(
            for $x in $rdf//skos:Concept[string-length(prop:exceedanceThreshold) > 0]
            where not($x/prop:hasObjectiveType/@rdf:resource = ($vocabulary:OBJECTIVETYPE_VOCABULARY || "MO", $vocabulary:OBJECTIVETYPE_VOCABULARY || "LVMOT", $vocabulary:OBJECTIVETYPE_VOCABULARY || "LVmaxMOT"))
                and not($countryCode = "gi" and ($x/prop:hasObjectiveType/@rdf:resource = ($vocabulary:OBJECTIVETYPE_VOCABULARY || "ECO") or $x/prop:hasProtectionTarget/@rdf:resource = ($vocabulary:PROTECTIONTARGET_VOCABULARY || "V")))
            return $x/prop:relatedPollutant/@rdf:resource || "#" || $x/prop:hasObjectiveType/@rdf:resource || "#" || $x/prop:hasReportingMetric/@rdf:resource || "#" || $x/prop:hasProtectionTarget/@rdf:resource
        )
        let $exception := $vocabulary:POLLUTANT_VOCABULARY || "6001" || "#" || $vocabulary:OBJECTIVETYPE_VOCABULARY || "TV" || "#" || $vocabulary:REPMETRIC_VOCABULARY || "aMean" || "#" || $vocabulary:PROTECTIONTARGET_VOCABULARY || "H"
        let $rdf :=
            if (number($reportingYear) >= 2015 and index-of($rdf, $exception) > 0) then
                remove($rdf, index-of($rdf, $exception))
            else
                $rdf

        for $i in $rdf
            let $tokens := tokenize($i, "#")
        where count($docRoot//aqd:AQD_AssessmentRegime/aqd:assessmentThreshold/aqd:AssessmentThreshold/
                aqd:environmentalObjective/aqd:EnvironmentalObjective[concat(../../../../aqd:pollutant/@xlink:href, "#", aqd:objectiveType/@xlink:href, "#", aqd:reportingMetric/@xlink:href, "#", aqd:protectionTarget/@xlink:href) = $i]) = 0
        return
            <tr>
                <td title="pollutant">{$tokens[1]}</td>
                <td title="objectiveType">{$tokens[2]}</td>
                <td title="reportingMetric">{$tokens[3]}</td>
                <td title="hasProtectionTarget">{$tokens[4]}</td>
            </tr>

    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: C21 :)
let $C21invalid :=
    try {
        let $exceptions := ($vocabulary:OBJECTIVETYPE_VOCABULARY || "MO")
        let $environmentalObjectiveCombinations := doc($vocabulary:ENVIRONMENTALOBJECTIVE || "rdf")
        for $x in $docRoot//aqd:AQD_AssessmentRegime/aqd:assessmentThreshold/aqd:AssessmentThreshold/aqd:environmentalObjective/aqd:EnvironmentalObjective
        let $pollutant := string($x/../../../../aqd:pollutant/@xlink:href)
        let $objectiveType := string($x/aqd:objectiveType/@xlink:href)
        let $reportingMetric := string($x/aqd:reportingMetric/@xlink:href)
        let $protectionTarget := string($x/aqd:protectionTarget/@xlink:href)
        let $exceedance := string($x/../../aqd:exceedanceAttainment/@xlink:href)
        where not($objectiveType = $exceptions) and (not($environmentalObjectiveCombinations//skos:Concept[prop:relatedPollutant/@rdf:resource = $pollutant and prop:hasProtectionTarget/@rdf:resource = $protectionTarget
                and prop:hasObjectiveType/@rdf:resource = $objectiveType and prop:hasReportingMetric/@rdf:resource = $reportingMetric
                and prop:assessmentThreshold/@rdf:resource = $exceedance]))
        return
            <tr>
                <td title="aqd:AQD_AssessmentRegime">{string($x/../../../../aqd:inspireId/base:Identifier/base:localId)}</td>
                <td title="Pollutant">{data($pollutant)}</td>
                <td title="ObjectiveType">{data($objectiveType)}</td>
                <td title="ReportingMetric">{data($reportingMetric)}</td>
                <td title="ProtectionTarget">{data($protectionTarget)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: C23a :)
let $C23ainvalid :=
    try {
        (let $valid := for $i in ("fixed", "model", "indicative", "objective", "fixedrandom") return $vocabulary:ASSESSMENTTYPE_VOCABULARY || $i
        for $x in $docRoot//aqd:AQD_AssessmentRegime[count(aqd:assessmentMethods/aqd:AssessmentMethods/aqd:assessmentType/@xlink:href) > 0]/aqd:assessmentMethods/aqd:AssessmentMethods/aqd:assessmentType
        where not($x/@xlink:href = $valid)
        return
            <tr>
                <td title="base:localId">{string($x/../../../aqd:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:assessmentType">{data($x/@xlink:href)}</td>
            </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: C23B - Warning :)
let $C23binvalid :=
    try {
        for $x in $docRoot//aqd:AQD_AssessmentRegime/aqd:assessmentMethods/aqd:AssessmentMethods
            let $type := $x/aqd:assessmentType/@xlink:href
            let $desc := $x/aqd:assessmentTypeDescription
        where empty($desc) or data($desc = "")
        return
            <tr>
                <td title="base:localId">{string($x/../../aqd:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:assessmentType">{data($type)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

let $C24errorClass := if (contains($source_url, "c_preliminary")) then $errors:WARNING else $errors:C24
let $C24invalid :=
    try {
        for $x in $docRoot//aqd:AQD_AssessmentRegime/aqd:assessmentMethods/aqd:AssessmentMethods/aqd:modelAssessmentMetadata
        where not($x/@xlink:href = $latestModels)
        return
            <tr>
                <td title="aqd:AQD_AssessmentRegime">{string($x/../../../aqd:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:modelAssessmentMetadata">{data($x/@xlink:href)}</td>
            </tr>

    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

let $C25invalid :=
    for $x in $docRoot//aqd:AQD_AssessmentRegime/aqd:assessmentMethods/aqd:AssessmentMethods/aqd:samplingPointAssessmentMetadata
    where not($x/@xlink:href = $latestSamplingPoints)
    return
        <tr>
            <td title="aqd:AQD_AssessmentRegime">{string($x/../../../aqd:inspireId/base:Identifier/base:localId)}</td>
            <td title="aqd:samplingPointAssessmentMetadata">{data($x/@xlink:href)}</td>
        </tr>

(: C26 - :)
let $C26table :=
    try {
        let $startDate := substring(data($docRoot//aqd:reportingPeriod/gml:TimePeriod/gml:beginPosition),1,10)
        let $endDate := substring(data($docRoot//aqd:reportingPeriod/gml:TimePeriod/gml:endPosition),1,10)

        let $modelMethods := if (fn:string-length($countryCode) = 2) then distinct-values(data(sparqlx:run(query:getModelEndPosition($modelsEnvelope, $startDate, $endDate))//sparql:binding[@name='inspireLabel']/sparql:literal)) else ()
        let $sampingPointMethods := if (fn:string-length($countryCode) = 2) then distinct-values(data(sparqlx:run(query:getSamplingPointEndPosition($latestEnvelopeD,$startDate,$endDate))//sparql:binding[@name='inspireLabel']/sparql:literal)) else ()

        for $method in $docRoot//aqd:AQD_AssessmentRegime/aqd:assessmentMethods/aqd:AssessmentMethods
        let $modelMetaCount := count($method/aqd:modelAssessmentMetadata)
        let $samplingPointMetaCount := count($method/aqd:samplingPointAssessmentMetadata)

        let $invalidModel :=
            for $meta1 in $method/aqd:modelAssessmentMetadata
            where (empty(index-of($modelMethods, data($meta1/@xlink:href))))
            return
                <tr>
                    <td title="AQD_AssessmentRegime">{data($meta1/../../../aqd:inspireId/base:Identifier/base:localId)}</td>
                    <td title="aqd:modelAssessmentMetadata">{data($meta1/@xlink:href)}</td>
                    <td title="aqd:samplingPointAssessmentMetadata"></td>
                </tr>

        let $invalidSampingPoint :=
            for $meta2 in $method/aqd:samplingPointAssessmentMetadata
            where (empty(index-of($sampingPointMethods, data($meta2/@xlink:href))))
            return
                <tr>
                    <td title="AQD_AssessmentRegime">{data($meta2/../../../aqd:inspireId/base:Identifier/base:localId)}</td>
                    <td title="aqd:modelAssessmentMetadata"></td>
                    <td title="aqd:samplingPointAssessmentMetadata">{data($meta2/@xlink:href)}</td>
                </tr>

        return
            if ($modelMetaCount = 0 and $samplingPointMetaCount = 0) then
                <tr>
                    <td title="AQD_AssessmentRegime">{data($method/../../aqd:inspireId/base:Identifier/base:localId)}</td>
                    <td title="aqd:modelAssessmentMetadata">None specified</td>
                    <td title="aqd:samplingPointAssessmentMetadata">None specified</td>
                </tr>
            else
                (($invalidModel), ($invalidSampingPoint))
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: C27 - return all zones listed in the doc :)
let $C27table :=
    try {
        (: return zones not listed in B :)
        let $invalidEqual :=
            for $regime in $docRoot//aqd:AQD_AssessmentRegime
            let $zoneId := string($regime/aqd:zone/@xlink:href)
            where ($zoneId != "" and not($zoneIds = $zoneId))
            return
                <tr>
                    <td title="AQD_AssessmentRegime">{data($regime/aqd:inspireId/base:Identifier/base:localId)}</td>
                    <td title="aqd:zoneId">{$zoneId}</td>
                    <td title="AQD_Zone">Not existing</td>
                </tr>
        let $invalidEqual2 :=
            for $zoneId in $zoneIds
            where ($zoneId != "" and count($docRoot//aqd:AQD_AssessmentRegime/aqd:zone[@xlink:href = $zoneId]) = 0)
            return
                <tr>
                    <td title="AQD_AssessmentRegime">Not existing</td>
                    <td title="aqd:zoneId"></td>
                    <td title="AQD_Zone">{$zoneId}</td>
                </tr>

        return (($invalidEqual), ($invalidEqual2))
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: C29 - :)
let $C29invalid :=
    try {
        let $validZones :=
            for $zoneId in $zoneIds
            return
                if ($zoneId != "" and count($docRoot//aqd:AQD_AssessmentRegime/aqd:zone[@xlink:href = $zoneId]) > 0) then
                    $zoneId
                else
                    ()
        let $combinations := sparqlx:run(query:getPollutantCodeAndProtectionTarge($cdrUrl, $bdir))
        let $validRows :=
            for $rec in $combinations
            return
                concat(data($rec//sparql:binding[@name = 'inspireLabel']/sparql:literal), "#", data($rec//sparql:binding[@name = 'pollutantCode']/sparql:uri), "#", data($rec//sparql:binding[@name = 'protectionTarget']/sparql:uri))
        let $validRows := distinct-values($validRows)

        let $exceptionPollutantIds := ("6001")

            for $x in $docRoot//aqd:AQD_AssessmentRegime[aqd:zone/@xlink:href = $validZones]
            let $pollutantCode := fn:substring-after(data($x//aqd:pollutant/@xlink:href), "pollutant/")
            let $key :=
                if (not(empty(index-of($exceptionPollutantIds, $pollutantCode))) and data($x//aqd:zone/@nilReason) = "inapplicable") then
                    "EXC"
                else
                    concat(data($x//aqd:zone/@xlink:href), '#', data($x//aqd:pollutant/@xlink:href), '#', data($x//aqd:protectionTarget/@xlink:href))
            where empty(index-of($validRows, $key)) and not(empty(index-of($dataflowC:MANDATORY_POLLUTANT_IDS_8, $pollutantCode))) and ($key != "EXC")
            return
                <tr>
                    <td title="AQD_AssessmentRegime">{data($x/aqd:inspireId/base:Identifier/base:localId)}</td>
                    <td title="aqd:zone">{data($x//aqd:zone/@xlink:href)}</td>
                    <td title="aqd:pollutant">{data($x//aqd:pollutant/@xlink:href)}</td>
                    <td title="aqd:protectionTarget">{data($x//aqd:protectionTarget/@xlink:href)}</td>
                </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: C28 If ./aqd:zone xlink:href shall be current, then ./AQD_zone/aqd:operationActivityPeriod/gml:endPosition shall be equal to “9999-12-31 23:59:59Z” or nulled (blank)  :)
let $C28invalid :=
    try {
        for $zone in $docRoot//aqd:zone[@xlink:href = '.']/aqd:AQD_Zone
        let $endPosition := normalize-space($zone/aqd:operationActivityPeriod/gml:endPosition)
        where upper-case($endPosition) != '9999-12-31 23:59:59Z' and $endPosition != ''
        return
            <tr>
                <td title="aqd:AQD_AssessmentRegime/aqd:inspireId/base:Identifier/base:localId">{data($zone/../../aqd:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:AQD_Zone/am:inspireId/base:Identifier/base:localId">{data($zone/am:inspireId/base:Identifier/base:localId)}</td>
                {html:getErrorTD(data($endPosition), "gml:endPosition", fn:true())}
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: C31 :)
let $C31table :=
    try {
        let $C31ResultB :=
            for $i in sparqlx:run(query:getC31($latestEnvelopeB, $reportingYear))
            return
                <result>
                    <pollutantName>{string($i/sparql:binding[@name = "Pollutant"]/sparql:literal)}</pollutantName>
                    <protectionTarget>{string($i/sparql:binding[@name = "ProtectionTarget"]/sparql:uri)}</protectionTarget>
                    <count>{
                        let $x := string($i/sparql:binding[@name = "countOnB"]/sparql:literal)
                        return if ($x castable as xs:integer) then xs:integer($x) else 0
                    }</count>
                </result>

        let $C31tmp :=
            for $x in $docRoot//aqd:AQD_AssessmentRegime/aqd:assessmentThreshold/aqd:AssessmentThreshold/aqd:environmentalObjective/
                    aqd:EnvironmentalObjective/aqd:protectionTarget[not(../string(aqd:objectiveType/@xlink:href) = ("http://dd.eionet.europa.eu/vocabulary/aq/objectivetype/MO",
                    "http://dd.eionet.europa.eu/vocabulary/aq/objectivetype/ECO", "http://dd.eionet.europa.eu/vocabulary/aq/objectivetype/ALT", "http://dd.eionet.europa.eu/vocabulary/aq/objectivetype/INT"))]
            let $pollutant := string($x/../../../../../aqd:pollutant/@xlink:href)
            let $zone := string($x/../../../../../aqd:zone/@xlink:href)
            let $protectionTarget := string($x/@xlink:href)
            let $key := string-join(($zone, $pollutant, $protectionTarget), "#")
            group by $pollutant, $protectionTarget
            return
                <result>
                    <pollutantName>{dd:getNameFromPollutantCode($pollutant)}</pollutantName>
                    <pollutantCode>{tokenize($pollutant, "/")[last()]}</pollutantCode>
                    <protectionTarget>{$protectionTarget}</protectionTarget>
                    <count>{count(distinct-values($key))}</count>
                </result>
        let $C31ResultC := filter:filterByName($C31tmp, "pollutantCode", (
            "1", "7", "8", "9", "5", "6001", "10", "20", "5012", "5018", "5014", "5015", "5029"
        ))
        for $x in $C31ResultC
            let $vsName := string($x/pollutantName)
            let $vsCode := string($x/pollutantCode)
            let $protectionTarget := string($x/protectionTarget)
            let $countC := number($x/count)
            let $countB := number($C31ResultB[pollutantName = $vsName and protectionTarget = $protectionTarget]/count)
            let $errorClass :=
                if ((string($countC), string($countB)) = "NaN") then $errors:C31
                else if ($countC > $countB) then $errors:C31
                else if ($countB > $countC) then $errors:WARNING
                else $errors:INFO
        order by $vsName
        return
            <tr class="{$errorClass}">
                <td title="Pollutant Name">{$vsName}</td>
                <td title="Pollutant Code">{$vsCode}</td>
                <td title="Protection Target">{$protectionTarget}</td>
                <td title="Count C">{string($countC)}</td>
                <td title="Count B">{string($countB)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: C32 - :)
let $C32table :=
    try {
        let $query1 :=
        "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
         PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
         PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>

         SELECT ?zone ?inspireId ?inspireLabel ?assessmentType
         WHERE {
            ?zone a aqd:AQD_SamplingPoint ;
            aqd:inspireId ?inspireId .
            ?inspireId rdfs:label ?inspireLabel .
            ?zone aqd:assessmentType ?assessmentType
            FILTER (CONTAINS(str(?zone), '" || $latestEnvelopeD || "'))
         }"
        let $aqdSamplingPointAssessMEntTypes :=
            for $i in sparqlx:run($query1)
            let $ii := concat($i/sparql:binding[@name = 'inspireLabel']/sparql:literal, "#", $i/sparql:binding[@name = 'assessmentType']/sparql:uri)
            return $ii

        let $query2 :=
        "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
         PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
         PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>

         SELECT ?zone ?inspireId ?inspireLabel ?assessmentType
         WHERE {
            ?zone a aqd:AQD_Model ;
            aqd:inspireId ?inspireId .
            ?inspireId rdfs:label ?inspireLabel .
            ?zone aqd:assessmentType ?assessmentType
            FILTER (CONTAINS(str(?zone), '" || $modelsEnvelope || "'))
         }"

        let $aqdModelAssessMentTypes :=
            for $i in sparqlx:run($query2)
            let $ii := concat($i/sparql:binding[@name = 'inspireLabel']/sparql:literal, "#", $i/sparql:binding[@name = 'assessmentType']/sparql:uri)
            return $ii

        let $allAssessmentTypes := ($aqdSamplingPointAssessMEntTypes, $aqdModelAssessMentTypes)
        for $sMetadata in $docRoot//aqd:AQD_AssessmentRegime/aqd:assessmentMethods/aqd:AssessmentMethods/aqd:samplingPointAssessmentMetadata
        let $id := string($sMetadata/@xlink:href)
        let $docType := string($sMetadata/../aqd:assessmentType/@xlink:href)

        let $typeInDoc := lower-case(substring-after($docType, $vocabulary:ASSESSMENTTYPE_VOCABULARY))
        let $combination := $id || "#" || $docType
        let $combinationFixed := $id || "#" || $vocabulary:ASSESSMENTTYPE_VOCABULARY || "fixed"
        let $combinationFixedRandom := $id || "#" || $vocabulary:ASSESSMENTTYPE_VOCABULARY || "fixedrandom"
        let $combinationIndicative := $id || "#" || $vocabulary:ASSESSMENTTYPE_VOCABULARY || "indicative"
        let $combinationModel := $id || "#" || $vocabulary:ASSESSMENTTYPE_VOCABULARY || "model"
        let $combinationObjective := $id || "#" || $vocabulary:ASSESSMENTTYPE_VOCABULARY || "objective"

        let $condition :=
            if ($typeInDoc = ("fixed")) then
                $combination = ($combinationFixed, $combinationFixedRandom)
            else if ($typeInDoc = ("fixedrandom")) then
                $combination = ($combinationFixedRandom)
            else if ($typeInDoc = "indicative") then
                $combination = ($combinationIndicative, $combinationFixed, $combinationFixedRandom)
            else if ($typeInDoc = "objective") then
                $combination = ($combinationObjective, $combinationFixed, $combinationFixedRandom, $combinationIndicative, $combinationModel)
            else
                false()
        where (not($condition))
        return
            <tr>
                <td title="AQD_AssessmentRegime">{string($sMetadata/../../../aqd:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:samplingPointAssessmentMetadata">{$id}</td>
                <td title="aqd:assessmentType">{substring-after($docType, $vocabulary:ASSESSMENTTYPE_VOCABULARY)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
        

(: C33 If The lifecycle information of ./aqd:assessmentMethods/aqd:AssessmentMethods/aqd:*AssessmentMetadata xlink:href shall be current,
    then /AQD_SamplingPoint/aqd:operationActivityPeriod/gml:endPosition or /AQD_ModelType/aqd:operationActivityPeriod/gml:endPosition shall be equal to “9999-12-31 23:59:59Z” or nulled (blank):)
let $C33invalid :=
    try {
        for $assessmentMetadata in $docRoot//aqd:assessmentMethods/aqd:AssessmentMethods/*[ends-with(local-name(), 'AssessmentMetadata') and @xlink:href = '.']

        let $endPosition :=
            if ($assessmentMetadata/local-name() = 'modelAssessmentMetadata') then
                normalize-space($assessmentMetadata/aqd:AQD_Model/aqd:operationActivityPeriod/gml:endPosition)
            else if ($assessmentMetadata/local-name() = 'samplingPointAssessmentMetadata') then
                normalize-space($assessmentMetadata/aqd:AQD_SamplingPoint/aqd:operationActivityPeriod/gml:endPosition)
            else
                ""
        where upper-case($endPosition) != '9999-12-31 23:59:59Z' and $endPosition != ''
        return
            <tr>
                <td title="aqd:AQD_AssessmentRegime/aqd:inspireId/base:Identifier/base:localId">{data($assessmentMetadata/../../../aqd:inspireId/base:Identifier/base:localId)}</td>{
                if ($assessmentMetadata/local-name() = 'modelAssessmentMetadata') then
                    (<td title="aqd:AQD_Model/ @gml:id">{data($assessmentMetadata/aqd:AQD_Model/@gml:id)}</td>,
                    html:getErrorTD(data($endPosition), "gml:endPosition", fn:true())
                    , <td title="aqd:AQD_SamplingPoint/ @gml:id"/>, <td title="gml:endPosition"/>)
                else if ($assessmentMetadata/local-name() = 'samplingPointAssessmentMetadata') then
                    (<td title="aqd:AQD_Model/ @gml:id"/>, <td title="gml:endPosition"/>,
                    <td title="aqd:AQD_SamplingPoint/ @gml:id">{data($assessmentMetadata/aqd:AQD_SamplingPoint/@gml:id)}</td>,
                    html:getErrorTD(data($endPosition), "gml:endPosition", fn:true())
                    )
                else
                    ()
            }
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }


(: C35 /aqd:AQD_SamplingPoint/aqd:usedAQD or /aqd:AQD_ModelType/aqd:used shall EQUAL “true” for all ./aqd:assessmentMethods/aqd:AssessmentMethods/aqd:*AssessmentMetadata xlink:href citations :)
let $C35invalid :=
    try {
        for $assessmentMetadata in $docRoot//aqd:assessmentMethods/aqd:AssessmentMethods/*[ends-with(local-name(), 'AssessmentMetadata') and @xlink:href = '.']

        let $used :=
            if ($assessmentMetadata/local-name() = 'modelAssessmentMetadata') then
                normalize-space($assessmentMetadata/aqd:AQD_Model/aqd:used)
            else if ($assessmentMetadata/local-name() = 'samplingPointAssessmentMetadata') then
                normalize-space($assessmentMetadata/aqd:AQD_SamplingPoint/aqd:usedAQD)
            else
                ""

        where $used != 'true'
        return
            <tr>
                <td title="aqd:AQD_AssessmentRegime">{data($assessmentMetadata/../../../aqd:inspireId/base:Identifier/base:localId)}</td>{
                if ($assessmentMetadata/local-name() = 'modelAssessmentMetadata') then
                    (<td title="aqd:AQD_Model/ @gml:id">{data($assessmentMetadata/aqd:AQD_Model/@gml:id)}</td>,
                    html:getErrorTD(data($used), "aqd:used", fn:true())
                    , <td title="aqd:AQD_SamplingPoint/ @gml:id"/>, <td title="aqd:usedAQD"/>)
                else if ($assessmentMetadata/local-name() = 'samplingPointAssessmentMetadata') then
                    (<td title="aqd:AQD_Model/ @gml:id"/>, <td title="aqd:used"/>,
                    <td title="aqd:AQD_SamplingPoint/ @gml:id">{data($assessmentMetadata/aqd:AQD_SamplingPoint/@gml:id)}</td>,
                    html:getErrorTD(data($used), "aqd:usedAQD", fn:true())
                    )
                else
                    ()
            }
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: C37 - :)
let $C37invalid :=
    try {
        let $reportingMetric := $docRoot//aqd:AQD_AssessmentRegime[aqd:assessmentThreshold/aqd:AssessmentThreshold/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:reportingMetric/normalize-space(@xlink:href) = "http://dd.eionet.europa.eu/vocabulary/aq/reportingmetric/AEI"]/@gml:id
        return
            if (count($reportingMetric) > 1) then
                for $i in $reportingMetric
                return
                    <tr><td title="@gml:id">{string($i)}</td></tr>
            else
                ()
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: C38 :)
let $C38invalid :=
    try {
        let $query :=
            "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
             PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
             PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>

             SELECT ?zone ?inspireId ?inspireLabel ?relevantEmissions ?stationClassification
             WHERE {
                    ?zone a aqd:AQD_SamplingPoint ;
                    aqd:inspireId ?inspireId .
                    ?inspireId rdfs:label ?inspireLabel .
                    ?zone aqd:relevantEmissions ?relevantEmissions .
                    ?relevantEmissions aqd:stationClassification ?stationClassification
             FILTER (CONTAINS(str(?zone), '" || $latestEnvelopeD || "') and str(?stationClassification)='http://dd.eionet.europa.eu/vocabulary/aq/stationclassification/background')
             }"
        let $valid := distinct-values(data(sparqlx:run($query)/sparql:binding[@name = 'inspireLabel']/sparql:literal))

        for $x in $docRoot//aqd:AQD_AssessmentRegime/aqd:assessmentThreshold/aqd:AssessmentThreshold/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:reportingMetric[@xlink:href = $vocabulary:REPMETRIC_VOCABULARY || "AEI"]
        for $xlink in $x/../../../../../aqd:assessmentMethods/aqd:AssessmentMethods/aqd:samplingPointAssessmentMetadata/@xlink:href
        where not($xlink = $valid)
        return
            <tr>
                <td title="aqd:AQD_AssessmentRegime">{data($x/../../../../../aqd:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:AQD_SamplingPoint">{$xlink}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: C40 :)
let $C40invalid :=
    try {
        for $aqdPollutantC40 in $docRoot//aqd:AQD_AssessmentRegime
        let $pollutantXlinkC40 := fn:substring-after(data($aqdPollutantC40/aqd:pollutant/@xlink:href), "pollutant/")
        where not(empty(index-of($dataflowC:VALID_POLLUTANT_IDS_40, $pollutantXlinkC40))) and not((count($aqdPollutantC40/aqd:assessmentMethods/aqd:AssessmentMethods/aqd:samplingPointAssessmentMetadata) >= 1
                or count($aqdPollutantC40/aqd:assessmentMethods/aqd:AssessmentMethods/aqd:modelAssessmentMetadata) >= 1))
        return
            <tr>
                <td title="@gml:id">{string($aqdPollutantC40/@gml:id)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: C41 gml:timePosition MUST be provided and must be equal or greater than (aqd:reportingPeriod – 5 years) included in the ReportingHeader :)
let $C41invalid :=
    try {
        let $C41minYear := if ($reportingYear castable as xs:integer) then xs:integer($reportingYear) - 5 else ()
        for $x in $docRoot//aqd:AQD_AssessmentRegime/aqd:assessmentThreshold/aqd:AssessmentThreshold/aqd:classificationDate/gml:TimeInstant
        let $timePosition := string($x/gml:timePosition)
        let $timePosition :=
            if ($timePosition castable as xs:integer) then
                xs:integer($timePosition)
            else if ($timePosition castable as xs:date) then
                year-from-date(xs:date($x/gml:timePosition))
            else
                ()
        where empty($timePosition) or ($timePosition < $C41minYear)
        return
            <tr>
                <td title="aqd:AQD_AssessmentRegime">{string($x/../../../../aqd:inspireId/base:Identifier/base:localId)}</td>
                <td title="gml:timePosition">{$timePosition}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: C42 - :)
let $C42invalid :=
    try {
        for $x in $docRoot//aqd:AQD_AssessmentRegime/aqd:assessmentThreshold/aqd:AssessmentThreshold/aqd:classificationReport
        where (string($x) = "") or (not(common:includesURL($x)))
        return
            <tr>
                <td title="base:localId">{$x/../../../aqd:inspireId/base:Identifier/base:localId}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

return
    <table class="maintable hover">
        {html:build2("NS", $labels:NAMESPACES, $labels:NAMESPACES_SHORT, $NSinvalid, "All values are valid", "record", $errors:NS)}
        {html:build3("C0", $labels:C0, $labels:C0_SHORT, $C0table, string($C0table/td), errors:getMaxError($C0table))}
        {html:build1("C01", $labels:C01, $labels:C01_SHORT, $C01table, "", string(count($C01table)), "", "", $errors:C01)}
        {html:buildSimple("C02", $labels:C02, $labels:C02_SHORT, $C02table, "", "record", $C02errorLevel)}
        {html:buildSimple("C03", $labels:C03, $labels:C03_SHORT, $C03table, "", "record", $C03errorLevel)}
        {html:build2("C04", $labels:C04, $labels:C04_SHORT, $C04invalid, "No duplicates found", " duplicate", $errors:C04)}
        {html:build2("C05", $labels:C05, $labels:C05_SHORT, $C05invalid, "No duplicates found", " duplicate", $errors:C05)}
        {html:build2("C06", $labels:C06, $labels:C06_SHORT, $C06table, string(count($C06table)), "", $errors:C06)}
        {html:build2("C06.1", $labels:C06.1, $labels:C06.1_SHORT, $C06.1invalid, "All values are valid", " invalid namespaces", $errors:C06.1)}
        {html:build2("C07", $labels:C07, $labels:C07_SHORT, $C07invalid, "All values are valid", " invalid value", $errors:C07)}
        {html:build2("C08", $labels:C08, $labels:C08_SHORT, $C08invalid, "All values are valid", " missing pollutant", $errors:C08)}
        {html:build0("C09", $labels:C09, $labels:C09_SHORT, $C09table, "pollutant")}
        {html:build2("C10", $labels:C10, $labels:C10_SHORT, $C10invalid, "All values are valid", " invalid value", $errors:C10)}
        {html:build2("C20", $labels:C20, $labels:C20_SHORT, $C20invalid, "All combinations have been found", "record", $errors:C20)}
        {html:build2("C21", $labels:C21, $labels:C21_SHORT, $C21invalid, "All values are valid", " invalid value", $errors:C21)}
        {html:build2("C23a", $labels:C23a, $labels:C23a_SHORT, $C23ainvalid, "All values are valid", " invalid value", $errors:C23a)}
        {html:build2("C23b", $labels:C23b, $labels:C23b_SHORT, $C23binvalid, "All values are valid", " invalid value", $errors:C23b)}
        {html:build2("C24", $labels:C24, $labels:C24_SHORT, $C24invalid, "All values are valid", "", $C24errorClass)}
        {html:build2("C25", $labels:C25, $labels:C25_SHORT, $C25invalid, "All values are valid", "", $errors:C25)}
        {html:build2("C26", $labels:C26, $labels:C26_SHORT, $C26table, "All values are valid", " invalid value", $errors:C26)}
        {html:build2("C27", labels:interpolate($labels:C27, ($countZoneIds2, $countZoneIds1)), $labels:C27_SHORT, $C27table, "", " not unique zone", $errors:C27)}
        {html:build2("C28", $labels:C28, $labels:C28_SHORT, $C28invalid, "All values are valid", " invalid value", $errors:C28)}
        {html:build2("C29", $labels:C29, $labels:C29_SHORT,  $C29invalid, "All values are valid", " invalid value", $errors:C29)}
        {html:build2("C31", $labels:C31, $labels:C31_SHORT, $C31table, "", "record", errors:getMaxError($C31table))}
        {html:build2("C32", $labels:C32, $labels:C32_SHORT, $C32table, "All values are valid", " invalid value", $errors:C32)}
        {html:build2("C33", $labels:C33, $labels:C33_SHORT, $C33invalid, "All values are valid", " invalid value", $errors:C33)}
        {html:build2("C35", $labels:C35, $labels:C35_SHORT, $C35invalid, "All values are valid", " invalid value", $errors:C35)}
        {html:build2("C37", $labels:C37, $labels:C37_SHORT, $C37invalid, "All values are valid", " invalid value", $errors:C37)}
        {html:build2("C38", $labels:C38, $labels:C38_SHORT, $C38invalid, "All values are valid", " invalid value", $errors:C38)}
        {html:build2("C40", $labels:C40, $labels:C40_SHORT, $C40invalid, "All values are valid", " invalid value", $errors:C40)}
        {html:build2("C41", $labels:C41, $labels:C41_SHORT, $C41invalid, "All values are valid", " invalid value", $errors:C41)}
        {html:build2("C42", $labels:C42, $labels:C42_SHORT, $C42invalid, "All values are valid", " invalid value", $errors:C42)}
    </table>
};

declare function dataflowC:proceed($source_url as xs:string, $countryCode as xs:string) {

let $countZones := count(doc($source_url)//aqd:AQD_AssessmentRegime)
let $result := if ($countZones > 0) then dataflowC:checkReport($source_url, $countryCode) else ()

let $meta := map:merge((
    map:entry("count", $countZones),
    map:entry("header", "Check air quality assessment regimes"),
    map:entry("dataflow", "Dataflow C"),
    map:entry("zeroCount", <p>No aqd:AQD_AssessmentRegime elements found in this XML.</p>),
    map:entry("report", <p>This check evaluated the delivery by executing tier-1 tests on air quality assessment regimes data in Dataflow C as specified in <a href="http://www.eionet.europa.eu/aqportal/qaqc/">e-reporting QA/QC rules documentation</a>.</p>)
))
return
    html:buildResultDiv($meta, $result)
};
(:
 : Module Name: Implementing Decision 2011/850/EU: AQ info exchange & reporting (Library module)
 :
 : Version:     $Id$
 : Created:     13 September 2013
 : Copyright:   European Environment Agency
 :
 : XQuery script implements dataflow C tier-1 checks as documented in http://taskman.eionet.europa.eu/documents/3 .
 :
 : @author Rait Väli and Enriko Käsper
 : @author George Sofianos
 : small modification added by Jaume Targa (ETC/ACM) to align with QA document
 :)





declare variable $dataflowD:ISO2_CODES as xs:string* := ("AL", "AD", "AT","BA","BE","BG","CH","CY","CZ","DE","DK","DZ","EE","EG","ES","FI",
    "FR","GB","GR","HR","HU","IE","IL","IS","IT","JO","LB","LI","LT","LU","LV","MA","ME","MK","MT","NL","NO","PL","PS","PT",
     "RO","RS","SE","SI","SK","TN","TR","XK","UK");

declare variable $dataflowD:FEATURE_TYPES := ("aqd:AQD_Network", "aqd:AQD_Station", "aqd:AQD_SamplingPointProcess", "aqd:AQD_Sample",
"aqd:AQD_RepresentativeArea", "aqd:AQD_SamplingPoint");


(: Rule implementations :)
declare function dataflowD:checkReport($source_url as xs:string, $countryCode as xs:string) as element(table) {

let $docRoot := doc($source_url)
let $cdrUrl := common:getCdrUrl($countryCode)
let $reportingYear := common:getReportingYear($docRoot)

(: COMMON variables used in many QCs :)
let $countFeatureTypesMap :=
    map:merge((
    for $featureType in $dataflowD:FEATURE_TYPES
    return
        map:entry($featureType, count($docRoot//descendant::*[name()=$featureType]))
    ))
let $DCombinations :=
    for $featureType in $dataflowD:FEATURE_TYPES
    return
        doc($source_url)//descendant::*[name()=$featureType]
let $namespaces := distinct-values($docRoot//base:namespace)
let $knownFeatures := distinct-values(data(sparqlx:run(query:getAllFeatureIds($dataflowD:FEATURE_TYPES, $namespaces))//sparql:binding[@name='inspireLabel']/sparql:literal))
let $SPOnamespaces := distinct-values($docRoot//aqd:AQD_SamplingPoint//base:Identifier/base:namespace)
let $SPPnamespaces := distinct-values($docRoot//aqd:AQD_SamplingPointProcess/ompr:inspireId/base:Identifier/base:namespace)
let $networkNamespaces := distinct-values($docRoot//aqd:AQD_Network/ef:inspireId/base:Identifier/base:namespace)
let $sampleNamespaces := distinct-values($docRoot//aqd:AQD_Sample/aqd:inspireId/base:Identifier/base:namespace)
let $stationNamespaces := distinct-values($docRoot//aqd:AQD_Station/ef:inspireId/base:Identifier/base:namespace)

let $latestEnvelopeB := query:getLatestEnvelope($cdrUrl || "b/")

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

(: D0 :)
let $D0table :=
    try {
        if ($reportingYear = "") then
            <tr class="{$errors:ERROR}">
                <td title="Status">Reporting Year is missing.</td>
            </tr>
        else if (query:deliveryExists($dataflowD:OBLIGATIONS, $countryCode, "d/", $reportingYear)) then
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
let $isNewDelivery := errors:getMaxError($D0table) = $errors:INFO


let $D1sum := string(sum(
    for $featureType in $dataflowD:FEATURE_TYPES
    return
        count($docRoot//descendant::*[name()=$featureType])))
(: D01 :)
let $D01table :=
    try {
        for $featureType at $pos in $dataflowD:FEATURE_TYPES
        order by $featureType descending
        where map:get($countFeatureTypesMap, $featureType) > 0
        return
            <tr>
                <td title="Feature type">{$featureType}</td>
                <td title="Total number">{map:get($countFeatureTypesMap, $featureType)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: D02 - :)
let $D02table :=
    try {
        let $all := map:merge((
            for $featureType at $pos in $dataflowD:FEATURE_TYPES
                let $count := count(
                for $x in $docRoot//descendant::*[name()=$featureType]
                    let $inspireId := $x//base:Identifier/base:namespace/string() || "/" || $x//base:Identifier/base:localId/string()
                where ($inspireId = "/" or not($knownFeatures = $inspireId))
                return
                    <tr>
                        <td title="base:localId">{$x//base:Identifier/base:localId/string()}</td>
                    </tr>)
            return map:entry($dataflowD:FEATURE_TYPES[$pos], $count)
        ))
        return
            map:for-each($all, function($name, $count) {
                if ($count > 0) then
                    <tr>
                        <td title="Feature type">{$name}</td>
                        <td title="Total number">{$count}</td>
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
let $D02errorLevel :=
    try {
        let $map1 := map:merge((
            for $x in $D02table
            return
                map:entry($x/td[1]/string(), $x/td[2]/number())
        ))
        return
            if ($errors:ERROR =
                    map:for-each($map1, function($name, $count) {
                        if ($count = map:get($countFeatureTypesMap, $name)) then
                            $errors:ERROR
                        else
                            $errors:INFO
                    })) then
                $errors:D02
            else
                $errors:INFO
    } catch * {
        $errors:FAILED
    }

(: D03 - :)
let $D03table :=
    try {
        let $featureTypes := remove($dataflowD:FEATURE_TYPES, index-of($dataflowD:FEATURE_TYPES, "aqd:AQD_RepresentativeArea"))
        let $all := map:merge((
            for $featureType at $pos in $featureTypes
            let $count := count(
                    for $x in $docRoot//descendant::*[name()=$featureType]
                    let $inspireId := $x//base:Identifier/base:namespace/string() || "/" || $x//base:Identifier/base:localId/string()
                    where ($knownFeatures = $inspireId)
                    return
                        <tr>
                            <td title="base:localId">{$x//base:Identifier/base:localId/string()}</td>
                        </tr>)
            return map:entry($featureTypes[$pos], $count)
        ))
        return
            map:for-each($all, function($name, $count) {
                    <tr isvalid="{not($count=0)}">
                        <td title="Feature type">{$name}</td>
                        <td title="Total number">{$count}</td>
                    </tr>
            })
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
let $D03errorLevel :=
    try {
        if (data($D03table/@isvalid) = "false") then
            $errors:D03
        else
            $errors:INFO
    } catch * {
        $errors:FAILED
    }
let $D3count :=
    try {
        string(sum($D03table/td[2]))
    } catch * {
        "NaN"
    }


(: D04 :)
let $D04table :=
    try {
        let $allD4Combinations :=
            for $aqdModel in $DCombinations
            return concat(data($aqdModel/@gml:id), "#", $aqdModel/ef:inspireId/base:Identifier/base:localId, "#", $aqdModel/ompr:inspireId/base:Identifier/base:localId, "#", $aqdModel/ef:name, "#", $aqdModel/ompr:name)
        let $allD4Combinations := fn:distinct-values($allD4Combinations)
        for $rec in $allD4Combinations
        let $modelType := substring-before($rec, "#")
        let $tmpStr := substring-after($rec, concat($modelType, "#"))
        let $inspireId := substring-before($tmpStr, "#")
        let $tmpInspireId := substring-after($tmpStr, concat($inspireId, "#"))
        let $aqdInspireId := substring-before($tmpInspireId, "#")
        let $tmpEfName := substring-after($tmpInspireId, concat($aqdInspireId, "#"))
        let $efName := substring-before($tmpEfName, "#")
        let $omprName := substring-after($tmpEfName, concat($efName, "#"))
        return
            <tr>
                <td title="gml:id">{common:checkLink($modelType)}</td>
                <td title="ef:inspireId/localId">{common:checkLink($inspireId)}</td>
                <td title="ompr:inspireId/localId">{common:checkLink($aqdInspireId)}</td>
                <td title="ef:name">{common:checkLink($efName)}</td>
                <td title="ompr:name">{common:checkLink($omprName)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: D05 :)
(: TODO: FIX TRY CATCH :)
let $all1 := $DCombinations/lower-case(normalize-space(@gml:id))
let $part1 := distinct-values(
        for $id in $DCombinations/@gml:id
        where string-length(normalize-space($id)) > 0 and count(index-of($all1, lower-case(normalize-space($id)))) > 1
        return
            $id
)
let $part1 :=
    for $i in $part1
    return
        <tr>
            <td title="Duplicate records">@gml:id {$i}</td>
        </tr>

let $all2 := for $id in $DCombinations/ef:inspireId
return lower-case("[" || $id/base:Identifier/base:localId || ", " || $id/base:Identifier/base:namespace || ", " || $id/base:Identifier/base:versionId || "]")
let $part2 := distinct-values(
        for $id in $DCombinations/ef:inspireId
        let $key := "[" || $id/base:Identifier/base:localId || ", " || $id/base:Identifier/base:namespace || ", " || $id/base:Identifier/base:versionId || "]"
        where string-length(normalize-space($id/base:Identifier/base:localId)) > 0 and count(index-of($all2, lower-case($key))) > 1
        return
            $key
)
let $part2 :=
    for $i in $part2
    return
        <tr>
            <td title="Duplicate records">ef:inspireId {string($i)}</td>
        </tr>


let $all3 := for $id in $DCombinations/aqd:inspireId
return lower-case("[" || $id/base:Identifier/base:localId || ", " || $id/base:Identifier/base:namespace || ", " || $id/base:Identifier/base:versionId || "]")

let $part3 := distinct-values(
        for $id in $DCombinations/aqd:inspireId
        let $key :=
            concat("[", normalize-space($id/base:Identifier/base:localId), ", ", normalize-space($id/base:Identifier/base:namespace),
                    ", ", normalize-space($id/base:Identifier/base:versionId), "]")
        where string-length(normalize-space($id/base:Identifier/base:localId)) > 0 and count(index-of($all3, lower-case($key))) > 1
        return
            $key
)
let $part3 :=
    for $i in $part3
    return
        <tr>
            <td title="Duplicate records">aqd:inspireId {string($i)}</td>
        </tr>

let $countGmlIdDuplicates := count($part1)
let $countefInspireIdDuplicates := count($part2)
let $countaqdInspireIdDuplicates := count($part3)
let $D05invalid := $part1 + $part2 + $part3


(: D06 Done by Rait ./ef:inspireId/base:Identifier/base:localId shall be an unique code for AQD_network and unique within the namespace.:)
(: TODO FIX TRY CATCH :)
    let $amInspireIds := $docRoot//aqd:AQD_Network/ef:inspireId/base:Identifier/concat(lower-case(normalize-space(base:namespace)), '##',
            lower-case(normalize-space(base:localId)))
    let $duplicateEUStationCode := distinct-values(
            for $identifier in $docRoot//aqd:AQD_Network/ef:inspireId/base:Identifier
            where string-length(normalize-space($identifier/base:localId)) > 0 and count(index-of($amInspireIds,
                    concat(lower-case(normalize-space($identifier/base:namespace)), '##', lower-case(normalize-space($identifier/base:localId))))) > 1
            return
                concat(normalize-space($identifier/base:namespace), ':', normalize-space($identifier/base:localId))
    )
    let $countAmInspireIdDuplicates := count($duplicateEUStationCode)
    let $D06invalid := $countAmInspireIdDuplicates

(: D07 :)
let $D07table :=
    try {
        for $id in $networkNamespaces
        let $localId := $docRoot//aqd:AQD_Network/ef:inspireId/base:Identifier[base:namespace = $id]/base:localId
        return
            <tr>
                <td title="feature">aqd:AQD_Network</td>
                <td title="base:namespace">{$id}</td>
                <td title="base:localId">{count($localId)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: D07.1 :)
let $D07.1invalid :=
    try {
        let $vocDoc := doc($vocabulary:NAMESPACE || "rdf")
        let $prefLabel := $vocDoc//skos:Concept[adms:status/@rdf:resource = $dd:VALIDRESOURCE and @rdf:about = concat($vocabulary:NAMESPACE, $countryCode)]/skos:prefLabel[1]
        let $altLabel := $vocDoc//skos:Concept[adms:status/@rdf:resource = $dd:VALIDRESOURCE and @rdf:about = concat($vocabulary:NAMESPACE, $countryCode)]/skos:altLabel[1]
        for $x in distinct-values($docRoot//aqd:AQD_Network/ef:inspireId/base:Identifier/base:namespace)
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

(: D08 :)
let $D08invalid :=
    try {
        let $valid := ($vocabulary:MEDIA_VALUE_VOCABULARY_BASE_URI || "air", $vocabulary:MEDIA_VALUE_VOCABULARY_BASE_URI_UC || "air")
        for $x in $docRoot//aqd:AQD_Network/ef:mediaMonitored
        where not($x/@xlink:href = $valid)
        return
            <tr>
                <td title="aqd:AQD_Network">{data($x/../ef:inspireId/base:Identifier/base:localId)}</td>
                <td title="ef:mediaMonitored">{data($x/@xlink:href)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: D09 :)
let $D09invalid :=
    try {
        let $valid := dd:getValidConcepts($vocabulary:ORGANISATIONAL_LEVEL_VOCABULARY || "rdf")
        for $x in $docRoot//aqd:AQD_Network/ef:organisationLevel
        where not($x/@xlink:href = $valid)
        return
            <tr>
                <td title="aqd:AQD_Network">{data($x/../ef:inspireId/base:Identifier/base:localId)}</td>
                <td title="ef:organisationLevel">{data($x/@xlink:href)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: D10 :)
let $D10invalid :=
    try {
        let $valid := dd:getValidConcepts($vocabulary:NETWORK_TYPE_VOCABULARY || "rdf")
        for $x in $docRoot//aqd:AQD_Network/aqd:networkType
        where not($x/@xlink:href = $valid)
        return
            <tr>
                <td title="aqd:AQD_Network">{data($x/../ef:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:networkType">{data($x/@xlink:href)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: D11 :)
let $D11invalid :=
    try {
        let $D11tmp := distinct-values(
                $docRoot//aqd:AQD_Network/aqd:operationActivityPeriod/gml:TimePeriod[((gml:beginPosition >= gml:endPosition)
                        and (gml:endPosition != ""))]/../../ef:inspireId/base:Identifier/base:localId)
        for $x in $D11tmp
        return
            <tr>
                <td title="base:localId">{$x}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: D12 aqd:AQD_Network/ef:name shall return a string :)
let $D12invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Network[string(ef:name) = ""]
        return
            <tr>
                <td title="base:localId">{string($x/ef:inspireId/base:Identifier/base:localId)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: D14 - ./aqd:aggregationTimeZone attribute shall resolve to a valid code in http://dd.eionet.europa.eu/vocabulary/aq/timezone/ :)
let $D14invalid :=
    try {
        let $validTimezones := dd:getValidConcepts("http://dd.eionet.europa.eu/vocabulary/aq/timezone/rdf")
        for $x in $docRoot//aqd:AQD_Network
        let $timezone := $x/aqd:aggregationTimeZone/@xlink:href
        where not($timezone = $validTimezones)
        return
            <tr>
                <td title="Feature type">{$x/name()}</td>
                <td title="gml:id">{data($x/@gml:id)}</td>
                <td title="ef:name">{data($x/ef:name)}</td>
                <td title="aqd:aggregationTimeZone" style="color:red">{string($timezone)}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }
(: D15 Done by Rait :)
let $D15invalid :=
    try {
        let $amInspireIds := $docRoot//aqd:AQD_Station/ef:inspireId/base:Identifier/concat(lower-case(normalize-space(base:namespace)), '##',
                lower-case(normalize-space(base:localId)))

        let $D15tmp := distinct-values(
                for $identifier in $docRoot//aqd:AQD_Station/ef:inspireId/base:Identifier
                where string-length(normalize-space($identifier/base:localId)) > 0 and count(index-of($amInspireIds,
                        concat(lower-case(normalize-space($identifier/base:namespace)), '##', lower-case(normalize-space($identifier/base:localId))))) > 1
                return
                    concat(normalize-space($identifier/base:namespace), ':', normalize-space($identifier/base:localId))
        )
        let $D15tmp :=
            for $i in $D15tmp
            return
                <tr>
                    <td title="id">{string($i)}</td>
                </tr>
        let $countAmInspireIdDuplicates := count($duplicateEUStationCode)
        return $countAmInspireIdDuplicates
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D16 :)
let $D16table :=
    try {
        for $id in $networkNamespaces
        let $localId := $docRoot//aqd:AQD_Station/ef:inspireId/base:Identifier[base:namespace = $id]/base:localId
        return
            <tr>
                <td title="feature">Station(s)</td>
                <td title="base:namespace">{$id}</td>
                <td title="base:localId">{count($localId)}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D16.1 :)
let $D16.1invalid :=
    try {
        let $vocDoc := doc($vocabulary:NAMESPACE || "rdf")
        let $prefLabel := $vocDoc//skos:Concept[adms:status/@rdf:resource = $dd:VALIDRESOURCE and @rdf:about = concat($vocabulary:NAMESPACE, $countryCode)]/skos:prefLabel[1]
        let $altLabel := $vocDoc//skos:Concept[adms:status/@rdf:resource = $dd:VALIDRESOURCE and @rdf:about = concat($vocabulary:NAMESPACE, $countryCode)]/skos:altLabel[1]
        for $x in distinct-values($docRoot//aqd:AQD_Station/ef:inspireId/base:Identifier/base:namespace)
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

(: D17 aqd:AQD_Station/ef:name shall return a string :)
let $D17invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Station[string(ef:name) = ""]
        return
            <tr>
                <td title="base:localId">{string($x/ef:inspireId/base:Identifier/base:localId)}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D18 Cross-check with AQD_Network (aqd:AQD_Station/ef:belongsTo shall resolve to a traversable local of global URI to ../AQD_Network) :)
let $D18invalid :=
    try {
        let $aqdNetworkLocal :=
            for $z in $docRoot//aqd:AQD_Network
            let $id := concat(data($z/ef:inspireId/base:Identifier/base:namespace), '/',
                    data($z/ef:inspireId/base:Identifier/base:localId))
            return $id

        for $x in $docRoot//aqd:AQD_Station[not(ef:belongsTo/@xlink:href = $aqdNetworkLocal)]
        return
            <tr>
                <td title="aqd:AQD_Station">{string($x/ef:inspireId/base:Identifier/base:localId)}</td>
                <td title="ef:belongsTo">{string($x/ef:belongsTo/@xlink:href)}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }
(: D19 :)
let $D19invalid :=
    try {
        let $valid := ($vocabulary:MEDIA_VALUE_VOCABULARY_BASE_URI || "air", $vocabulary:MEDIA_VALUE_VOCABULARY_BASE_URI_UC || "air")
        for $x in $docRoot//aqd:AQD_Station/ef:mediaMonitored
        where not($x/@xlink:href = $valid)
        return
            <tr>
                <td title="aqd:AQD_Station">{data($x/../ef:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:networkType">{data($x/@xlink:href)}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D20 ./ef:geometry/gml:Points the srsName attribute shall be a recognisable URN :)
let $D20invalid :=
    try {
        let $D20validURN := ("urn:ogc:def:crs:EPSG::3035", "urn:ogc:def:crs:EPSG::4258", "urn:ogc:def:crs:EPSG::4326")
        for $x in distinct-values($docRoot//aqd:AQD_Station[count(ef:geometry/gml:Point) > 0 and not(ef:geometry/gml:Point/@srsName = $D20validURN)]/ef:inspireId/base:Identifier/base:localId)
        return
            <tr>
                <td title="base:localId">{$x}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }


(: D21 - The Dimension attribute shall resolve to "2." :)
let $invalidPosD21 :=
    try {
        let $D21tmp := distinct-values($docRoot//aqd:AQD_Station/ef:geometry/gml:Point/gml:pos[@srsDimension != "2"]/
        concat(../../../ef:inspireId/base:Identifier/base:localId, ": srsDimension=", @srsDimension))
        let $invalidPos_srsDim :=
            for $i in $D21tmp
            return
                <tr>
                    <td title="dimension">{string($i)}</td>
                </tr>


        let $aqdStationPos :=
            for $allPos in $docRoot//aqd:AQD_Station
            where not(empty($allPos/ef:geometry/gml:Point/gml:pos))
            return concat($allPos/ef:inspireId/base:Identifier/base:namespace, "/", $allPos/ef:inspireId/base:Identifier/base:localId, "|",
                    fn:substring-before(data($allPos/ef:geometry/gml:Point/gml:pos), " "), "#", fn:substring-after(data($allPos/ef:geometry/gml:Point/gml:pos), " "))


        let $invalidPos_order :=
            for $gmlPos in $docRoot//aqd:AQD_SamplingPoint

            let $samplingPos := data($gmlPos/ef:geometry/gml:Point/gml:pos)
            let $samplingLat := if (not(empty($samplingPos))) then fn:substring-before($samplingPos, " ") else ""
            let $samplingLong := if (not(empty($samplingPos))) then fn:substring-after($samplingPos, " ") else ""


            let $samplingLat := if ($samplingLat castable as xs:decimal) then xs:decimal($samplingLat) else 0.00
            let $samplingLong := if ($samplingLong castable as xs:decimal) then xs:decimal($samplingLong) else 0.00

            return
                if ($samplingLat < $samplingLong and $countryCode != 'fr') then
                    <tr>
                        <td title="lat/long">{concat($gmlPos/ef:inspireId/base:Identifier/base:localId, " : lat=", string($samplingLat), " :long=", string($samplingLong))}</td>
                    </tr>
                else
                    ()
        return (($invalidPos_srsDim), ($invalidPos_order))
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D23 Done by Rait :)
let $D23invalid :=
    try {
        let $allEfOperationActivityPeriod :=
            for $allOperationActivityPeriod in $docRoot//aqd:AQD_Station/ef:operationalActivityPeriod
            where ($allOperationActivityPeriod/ef:OperationalActivityPeriod/ef:activityTime/gml:TimePeriod/gml:endPosition[normalize-space(@indeterminatePosition) != "unknown"]
                    or fn:string-length($allOperationActivityPeriod/ef:OperationalActivityPeriod/ef:activityTime/gml:TimePeriod/gml:endPosition) > 0)
            return $allOperationActivityPeriod

        for $operationActivityPeriod in $allEfOperationActivityPeriod
        where ($operationActivityPeriod/ef:OperationalActivityPeriod/ef:activityTime/gml:TimePeriod/gml:endPosition < $operationActivityPeriod/ef:OperationalActivityPeriod/ef:activityTime/gml:TimePeriod/gml:beginPosition) and ($operationActivityPeriod/ef:OperationalActivityPeriod/ef:activityTime/gml:TimePeriod/gml:endPosition != "")
        return
            <tr>
                <td title="aqd:AQD_Station">{data($operationActivityPeriod/../@gml:id)}</td>
                <td title="gml:TimePeriod">{data($operationActivityPeriod/ef:OperationalActivityPeriod/ef:activityTime/gml:TimePeriod/@gml:id)}</td>
                <td title="gml:beginPosition">{$operationActivityPeriod/ef:OperationalActivityPeriod/ef:activityTime/gml:TimePeriod/gml:beginPosition}</td>
                <td title="gml:endPosition">{$operationActivityPeriod/ef:OperationalActivityPeriod/ef:activityTime/gml:TimePeriod/gml:endPosition}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D24 - List the total number of aqd:AQD_Station which are operational :)
let $D24table :=
    try {
        for $operationActivityPeriod in $docRoot//aqd:AQD_Station/ef:operationalActivityPeriod
        where $operationActivityPeriod/ef:OperationalActivityPeriod/ef:activityTime/gml:TimePeriod/gml:endPosition[normalize-space(@indeterminatePosition) = "unknown"]
                or fn:string-length($operationActivityPeriod/ef:OperationalActivityPeriod/ef:activityTime/gml:TimePeriod/gml:endPosition) = 0
        return
            <tr>
                <td title="aqd:AQD_Station">{data($operationActivityPeriod/../@gml:id)}</td>
                <td title="gml:TimePeriod">{data($operationActivityPeriod/ef:OperationalActivityPeriod/ef:activityTime/gml:TimePeriod/@gml:id)}</td>
                <td title="gml:beginPosition">{$operationActivityPeriod/ef:OperationalActivityPeriod/ef:activityTime/gml:TimePeriod/gml:beginPosition}</td>
                <td title="gml:endPosition">{$operationActivityPeriod/ef:OperationalActivityPeriod/ef:activityTime/gml:TimePeriod/gml:endPosition}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D26 Done by Rait:)
let $D26invalid :=
    try {
        let $localEUStationCode := $docRoot//aqd:AQD_Station/upper-case(normalize-space(aqd:EUStationCode))
        for $EUStationCode in $docRoot//aqd:AQD_Station/aqd:EUStationCode
        where
            count(index-of($localEUStationCode, upper-case(normalize-space($EUStationCode)))) > 1 or
                    (
                        count(index-of($dataflowD:ISO2_CODES, substring(upper-case(normalize-space($EUStationCode)), 1, 2))) = 0
                    )
        return
            <tr>
                <td title="aqd:AQD_Station">{data($EUStationCode/../@gml:id)}</td>
                <td title="aqd:EUStationCode">{data($EUStationCode)}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D27 :)
let $D27invalid :=
    try {
        ()
        (:dataflowD:checkVocabulariesConceptEquipmentValues($source_url, "aqd:AQD_Station", "aqd:meteoParams", $vocabulary:METEO_PARAMS_VOCABULARY, "collection"):)
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D28 :)
let $D28invalid :=
    try {
        let $valid := dd:getValidConcepts($vocabulary:AREA_CLASSIFICATION_VOCABULARY || "rdf")
        for $x in $docRoot//aqd:AQD_Station/aqd:areaClassification
        where not($x/@xlink:href = $valid)
        return
            <tr>
                <td title="aqd:AQD_Station">{data($x/../ef:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:areaClassification">{data($x/@xlink:href)}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D29 :)
let $D29invalid :=
    try {
        let $valid := dd:getValidConcepts($vocabulary:DISPERSION_LOCAL_VOCABULARY || "rdf")
        for $x in $docRoot//aqd:AQD_Station/aqd:dispersionSituation/aqd:DispersionSituation/aqd:dispersionLocal
        where not($x/@xlink:href = $valid)
        return
            <tr>
                <td title="aqd:AQD_Station">{data($x/../../../ef:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:dispersionLocal">{data($x/@xlink:href)}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D30 :)
let $D30invalid :=
    try {
        let $valid := dd:getValidConcepts($vocabulary:DISPERSION_REGIONAL_VOCABULARY || "rdf")
        for $x in $docRoot//aqd:AQD_Station/aqd:dispersionSituation/aqd:DispersionSituation/aqd:dispersionRegional
        where not($x/@xlink:href = $valid)
        return
            <tr>
                <td title="aqd:AQD_Station">{data($x/../../../ef:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:dispersionRegional">{data($x/@xlink:href)}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D31 Done by Rait:)
let $D31invalid :=
    try {
        let $localSamplingPointIds := $docRoot//aqd:AQD_SamplingPoint/ef:inspireId/base:Identifier/base:localId
        for $idCode in $docRoot//aqd:AQD_SamplingPoint/ef:inspireId/base:Identifier/base:localId
        where
            count(index-of($localSamplingPointIds, normalize-space($idCode))) > 1
        return
            <tr>
                <td title="aqd:AQD_SamplingPoint">{data($idCode/../../../@gml:id)}</td>
                <td title="base:localId">{data($idCode)}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D32 :)
let $D32table :=
    try {
        for $id in $networkNamespaces
        let $localId := $docRoot//aqd:AQD_SamplingPoint//base:Identifier[base:namespace = $id]/base:localId
        return
            <tr>
                <td title="feature">SamplingPoint(s)</td>
                <td title="base:namespace">{$id}</td>
                <td title="base:localId">{count($localId)}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D32.1 :)
let $D32.1invalid :=
    try {
        let $vocDoc := doc($vocabulary:NAMESPACE || "rdf")
        let $prefLabel := $vocDoc//skos:Concept[adms:status/@rdf:resource = $dd:VALIDRESOURCE and @rdf:about = concat($vocabulary:NAMESPACE, $countryCode)]/skos:prefLabel[1]
        let $altLabel := $vocDoc//skos:Concept[adms:status/@rdf:resource = $dd:VALIDRESOURCE and @rdf:about = concat($vocabulary:NAMESPACE, $countryCode)]/skos:altLabel[1]
        for $x in distinct-values($docRoot//aqd:AQD_SamplingPoint/ef:inspireId/base:Identifier/base:namespace)
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

(: D33 :)
let $D33invalid :=
    try {
        let $valid := ($vocabulary:MEDIA_VALUE_VOCABULARY_BASE_URI || "air", $vocabulary:MEDIA_VALUE_VOCABULARY_BASE_URI_UC || "air")
        for $x in $docRoot//aqd:AQD_SamplingPoint/ef:mediaMonitored
        where not($x/@xlink:href = $valid)
        return
            <tr>
                <td title="aqd:AQD_SamplingPoint">{data($x/../ef:inspireId/base:Identifier/base:localId)}</td>
                <td title="ef:mediaMonitored">{data($x/@xlink:href)}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D34 :)
let $D34invalid :=
    try {
        let $D34validURN := ("urn:ogc:def:crs:EPSG::3035", "urn:ogc:def:crs:EPSG::4258", "urn:ogc:def:crs:EPSG::4326")
        for $x in distinct-values($docRoot//aqd:AQD_SamplingPoint[count(ef:geometry/gml:Point) > 0 and not(ef:geometry/gml:Point/@srsName = $D34validURN)]/ef:inspireId/base:Identifier/string(base:localId))
        return
            <tr>
                <td title="base:localId">{$x}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D35 :)
let $D35invalid :=
    try {
        for $x in $docRoot//aqd:AQD_SamplingPoint
        let $invalidOrder :=
            for $i in $x/ef:geometry/gml:Point/gml:pos
            let $latlongToken := tokenize($i, "\s+")
            let $lat := number($latlongToken[1])
            let $long := number($latlongToken[2])
            where ($long > $lat)
            return 1
        where (not($countryCode = "fr") and ($x/ef:geometry/gml:Point/gml:pos/@srsDimension != "2" or $invalidOrder = 1))
        return
            <tr>
                <td title="base:localId">{string($x/ef:inspireId/base:Identifier/base:localId)}</td>
                <td title="@srsDimension">{string($x/ef:geometry/gml:Point/gml:pos/@srsDimension)}</td>
                <td title="Pos">{string($x/ef:geometry/gml:Point/gml:pos)}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }
let $D35message :=
    if ($countryCode = "fr") then
        "Temporary turned off"
    else
        "All srsDimension attributes resolve to '2'"

(: D36 :)
let $D36invalid :=
    try {
        let $approximity := 0.0003

        (: StationID|long#lat :)
        let $aqdStationPos :=
            for $allPos in $docRoot//aqd:AQD_Station
            where not(empty($allPos/ef:geometry/gml:Point/gml:pos))
            return concat($allPos/ef:inspireId/base:Identifier/base:namespace, "/", $allPos/ef:inspireId/base:Identifier/base:localId, "|",
                    fn:substring-before(data($allPos/ef:geometry/gml:Point/gml:pos), " "), "#", fn:substring-after(data($allPos/ef:geometry/gml:Point/gml:pos), " "))


        for $gmlPos in $docRoot//aqd:AQD_SamplingPoint[ef:geometry/gml:Point/gml:pos]
        let $efBroader := $gmlPos/ef:broader/@xlink:href
        let $samplingStationId := data($efBroader)
        let $stationPos :=
            for $station in $aqdStationPos
            let $stationId := fn:substring-before($station, "|")
            return if ($stationId = $samplingStationId) then $station else ()

        let $stationLong := if (not(empty($stationPos))) then fn:substring-before(fn:substring-after($stationPos[1], "|"), "#") else ""
        let $stationLat := if (not(empty($stationPos))) then fn:substring-after(fn:substring-after($stationPos[1], "|"), "#") else ""

        let $samplingPos := data($gmlPos/ef:geometry/gml:Point/gml:pos)
        let $samplingLong := if (not(empty($samplingPos))) then fn:substring-before($samplingPos, " ") else ""
        let $samplingLat := if (not(empty($samplingPos))) then fn:substring-after($samplingPos, " ") else ""


        let $stationLong := if ($stationLong castable as xs:decimal) then xs:decimal($stationLong) else 0.00
        let $stationLat := if ($stationLat castable as xs:decimal) then xs:decimal($stationLat) else 0.00

        let $samplingLong := if ($samplingLong castable as xs:decimal) then xs:decimal($samplingLong) else 0.00
        let $samplingLat := if ($samplingLat castable as xs:decimal) then xs:decimal($samplingLat) else 0.00

        return
            if (abs($samplingLong - $stationLong) > $approximity or abs($samplingLat - $stationLat) > $approximity) then
                <tr>
                    <td title="@gml:id">{string($gmlPos/@gml:id)}</td>
                </tr>
            else
                ()
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D37 - check for invalid data or if beginPosition > endPosition :)
let $D37invalid :=
    try {
        let $invalidPosition :=
            for $timePeriod in $docRoot//aqd:AQD_SamplingPoint/ef:observingCapability/ef:ObservingCapability/ef:observingTime/gml:TimePeriod
            (: XQ does not support 24h that is supported by xml schema validation :)
            (: TODO: comment by sofiageo - the above statement is not true, fix this if necessary :)
            let $beginDate := substring(normalize-space($timePeriod/gml:beginPosition), 1, 10)
            let $endDate := substring(normalize-space($timePeriod/gml:endPosition), 1, 10)
            let $beginPosition :=
                if ($beginDate castable as xs:date) then
                    xs:date($beginDate)
                else
                    "error"
            let $endPosition :=
                if ($endDate castable as xs:date) then
                    xs:date($endDate)
                else if ($endDate = "") then
                    "empty"
                else
                    "error"

            return
                if ((string($beginPosition) = "error" or string($endPosition) = "error") or
                        ($beginPosition instance of xs:date and $endPosition instance of xs:date and $beginPosition > $endPosition)) then
                    <tr>
                        <td title="aqd:AQD_SamplingPoint">{data($timePeriod/../../../../ef:inspireId/base:Identifier/base:localId)}</td>
                        <td title="gml:TimePeriod">{data($timePeriod/@gml:id)}</td>
                        <td title="gml:beginPosition">{$timePeriod/gml:beginPosition}</td>
                        <td title="gml:endPosition">{$timePeriod/gml:endPosition}</td>
                    </tr>

                else
                    ()


        (: sort by begin and find if end is greater than next end :)
        let $overlappingPeriods :=
            for $rec in $docRoot//aqd:AQD_SamplingPoint
            let $observingCapabilities :=
                for $cp in $rec/ef:observingCapability/ef:ObservingCapability/ef:observingTime/gml:TimePeriod
                order by $cp/gml:beginPosition
                return $cp

            for $period at $pos in $observingCapabilities

            let $ok := if ($pos < count($observingCapabilities))
            then
                if ($period/gml:endPosition castable as xs:dateTime and $observingCapabilities[$pos + 1]/gml:beginPosition castable as xs:dateTime) then
                    if (xs:dateTime($period/gml:endPosition) > xs:dateTime($observingCapabilities[$pos + 1]/gml:beginPosition)) then fn:false() else fn:true()
                else
                    fn:true()
            else
                fn:true()

            return if ($ok) then () else

                <tr>
                    <td title="aqd:AQD_SamplingPoint">{data($period/../../../../ef:inspireId/base:Identifier/base:localId)}</td>
                    <td title="gml:TimePeriod">{data($period/@gml:id)}</td>
                    <td title="gml:beginPosition">{$period/gml:beginPosition}</td>
                    <td title="gml:endPosition">{$period/gml:endPosition}</td>
                </tr>


        return (($invalidPosition), ($overlappingPeriods))
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D40 :)
let $D40invalid :=
    try {
        for $x in $docRoot//aqd:AQD_SamplingPoint
        where (not($x/ef:observingCapability/ef:ObservingCapability/ef:observedProperty/@xlink:href = $dd:VALIDPOLLUTANTS)) or
                (count(distinct-values(data($x/ef:observingCapability/ef:ObservingCapability/ef:observedProperty/@xlink:href))) > 1)
        return
            <tr>
                <td title="base:localId">{$x/ef:inspireId/base:Identifier/string(base:localId)}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D41 Updated by Jaume Targa following working logic of D44 :)
let $D41invalid :=
    try {
        let $aqdSampleLocal :=
            for $z in $docRoot//aqd:AQD_Sample
            let $id := concat(data($z/aqd:inspireId/base:Identifier/base:namespace), '/',
                    data($z/aqd:inspireId/base:Identifier/base:localId))
            return $id

        for $x in $docRoot//aqd:AQD_SamplingPoint/ef:observingCapability/ef:ObservingCapability/ef:featureOfInterest
        where empty(index-of($aqdSampleLocal, fn:normalize-space($x/@xlink:href)))
        return
            <tr>
                <td title="aqd:AQD_SamplingPoint">{data($x/../@gml:id)}</td>
                <td title="ef:featureOfInterest">{data(fn:normalize-space($x/@xlink:href))}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D42 :)
let $D42invalid :=
    try {
        let $aqdProcessLocal :=
            for $allProcessLocal in $docRoot//aqd:AQD_SamplingPointProcess
            let $id := concat(data($allProcessLocal/ompr:inspireId/base:Identifier/base:namespace),
                    '/', data($allProcessLocal/ompr:inspireId/base:Identifier/base:localId))
            return $id

        for $x in $docRoot//aqd:AQD_SamplingPoint/ef:observingCapability/ef:ObservingCapability/ef:procedure
        where empty(index-of($aqdProcessLocal, fn:normalize-space($x/@xlink:href)))
        return
            <tr>
                <td title="aqd:AQD_SamplingPoint">{data($x/../../../@gml:id)}</td>
                <td title="ef:procedure">{data(fn:normalize-space($x/@xlink:href))}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D43 Updated by Jaume Targa following working logic of D44 :)
let $D43invalid :=
    try {
        let $aqdStationLocal :=
            for $z in $docRoot//aqd:AQD_Station
            let $id := concat(data($z/ef:inspireId/base:Identifier/base:namespace), '/',
                    data($z/ef:inspireId/base:Identifier/base:localId))
            return $id

        for $x in $docRoot//aqd:AQD_SamplingPoint/ef:broader
        where empty(index-of($aqdStationLocal, fn:normalize-space($x/@xlink:href)))
        return
            <tr>
                <td title="aqd:AQD_SamplingPoint">{data($x/../@gml:id)}</td>
                <td title="ef:broader">{data(fn:normalize-space($x/@xlink:href))}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D44 :)
let $D44invalid :=
    try {
        let $aqdNetworkLocal :=
            for $z in $docRoot//aqd:AQD_Network
            let $id := concat(data($z/ef:inspireId/base:Identifier/base:namespace), '/',
                    data($z/ef:inspireId/base:Identifier/base:localId))
            return $id
        
        for $x in $docRoot//aqd:AQD_SamplingPoint/ef:belongsTo
        where empty(index-of($aqdNetworkLocal, fn:normalize-space($x/@xlink:href)))
        return
            <tr>
                <td title="aqd:AQD_SamplingPoint">{data($x/../@gml:id)}</td>
                <td title="ef:belongsTo">{data(fn:normalize-space($x/@xlink:href))}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D45 - Find all period with out end period :)
let $D45invalid :=
    try {
        let $allNotNullEndOperationActivityPeriods :=
            for $allOperationActivityPeriod in $docRoot//aqd:AQD_SamplingPoint/ef:operationalActivityPeriod/ef:OperationalActivityPeriod/ef:activityTime/gml:TimePeriod
            where ($allOperationActivityPeriod/gml:endPosition[normalize-space(@indeterminatePosition) != "unknown"]
                    or fn:string-length($allOperationActivityPeriod/gml:endPosition) > 0)

            return $allOperationActivityPeriod

        for $operationActivitPeriod in $allNotNullEndOperationActivityPeriods
        where ((xs:dateTime($operationActivitPeriod/gml:endPosition) < xs:dateTime($operationActivitPeriod/gml:beginPosition)))
        return
            <tr>
                <td title="aqd:AQD_Station">{data($operationActivitPeriod/../../../../@gml:id)}</td>
                <td title="gml:TimePeriod">{data($operationActivitPeriod/@gml:id)}</td>
                <td title="gml:beginPosition">{$operationActivitPeriod/gml:beginPosition}</td>
                <td title="gml:endPosition">{$operationActivitPeriod/gml:endPosition}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D46 :)
let $D46invalid :=
    try {
        for $operationActivityPeriod in $docRoot//aqd:AQD_SamplingPoint/ef:operationalActivityPeriod
        where $operationActivityPeriod/ef:OperationalActivityPeriod/ef:activityTime/gml:TimePeriod/gml:endPosition[normalize-space(@indeterminatePosition) = "unknown"]
                or fn:string-length($operationActivityPeriod/ef:OperationalActivityPeriod/ef:activityTime/gml:TimePeriod/gml:endPosition) = 0
        return
            <tr>
                <td title="aqd:AQD_SamplingPoint">{data($operationActivityPeriod/../@gml:id)}</td>
                <td title="gml:TimePeriod">{data($operationActivityPeriod/ef:OperationalActivityPeriod/ef:activityTime/gml:TimePeriod/@gml:id)}</td>
                <td title="gml:beginPosition">{$operationActivityPeriod/ef:OperationalActivityPeriod/ef:activityTime/gml:TimePeriod/gml:beginPosition}</td>
                <td title="gml:endPosition">{$operationActivityPeriod/ef:OperationalActivityPeriod/ef:activityTime/gml:TimePeriod/gml:endPosition}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }
(: D48 :)
let $D48invalid :=
    try {
        let $valid := dd:getValidConcepts($vocabulary:ASSESSMENTTYPE_VOCABULARY || "rdf")
        for $x in $docRoot//aqd:assessmentType
        where not($x/@xlink:href = $valid)
        return
            <tr>
                <td title="{$x/../name()}">{data($x/..//base:Identifier/base:localId)}</td>
                <td title="aqd:assessmentType">{data($x/@xlink:href)}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
(: D50 :)
let $D50invalid :=
    try {
        let $rdf := doc("http://dd.eionet.europa.eu/vocabulary/aq/stationclassification/rdf")
        let $all := data($rdf//skos:Concept[adms:status/@rdf:resource="http://dd.eionet.europa.eu/vocabulary/datadictionary/status/valid"]/@rdf:about)

        for $x in $docRoot//aqd:AQD_SamplingPoint[not(aqd:relevantEmissions/aqd:RelevantEmissions/aqd:stationClassification/@xlink:href = $all)]
        return
            <tr>
                <td title="aqd:AQD_SamplingPoint">{data($x/ef:inspireId/base:Identifier/base:localId)}</td>
                <td title="xlink:href">{data($x/aqd:relevantEmissions/aqd:RelevantEmissions/aqd:stationClassification/@xlink:href)}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D51 :)
let $D51invalid :=
    try {
        let $exceptions := ($vocabulary:OBJECTIVETYPE_VOCABULARY || "MO")
        let $environmentalObjectiveCombinations := doc("http://dd.eionet.europa.eu/vocabulary/aq/environmentalobjective/rdf")
        for $x in $docRoot//aqd:AQD_SamplingPoint/aqd:environmentalObjective/aqd:EnvironmentalObjective
            for $z in $x/../../ef:observingCapability/ef:ObservingCapability/ef:observedProperty/@xlink:href
            let $pollutant := data($z)
            let $objectiveType := data($x/aqd:objectiveType/@xlink:href)
            let $reportingMetric := data($x/aqd:reportingMetric/@xlink:href)
            let $protectionTarget := data($x/aqd:protectionTarget/@xlink:href)
        where not($objectiveType = $exceptions) and not($environmentalObjectiveCombinations//skos:Concept[prop:relatedPollutant/@rdf:resource = $pollutant and prop:hasProtectionTarget/@rdf:resource = $protectionTarget
                and prop:hasObjectiveType/@rdf:resource = $objectiveType and prop:hasReportingMetric/@rdf:resource = $reportingMetric])
        return
            <tr>
                <td title="aqd:AQD_SamplingPoint">{data($x/../../ef:inspireId/base:Identifier/base:localId)}</td>
                <td title="ef:observedProperty">{$pollutant}</td>
                <td title="aqd:objectiveType">{$objectiveType}</td>
                <td title="aqd:reportingMetric">{$reportingMetric}</td>
                <td title="aqd:protectionTarget">{$protectionTarget}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: D53 :)
let $D53invalid :=
    try {
        let $zones := distinct-values(data(sparqlx:run(query:getZone($latestEnvelopeB))/sparql:binding[@name = 'inspireLabel']/sparql:literal))
        for $x in $docRoot//aqd:AQD_SamplingPoint/aqd:zone[not(@nilReason = 'inapplicable')]
        where not($x/@xlink:href = $zones)
        return
            <tr>
                <td title="aqd:AQD_SamplingPoint">{data($x/../ef:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:zone">{data($x/@xlink:href)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D54 - aqd:AQD_SamplingPointProcess/ompr:inspireId/base:Identifier/base:localId not unique codes :)
let $D54invalid :=
    try {
        let $localSamplingPointProcessIds := $docRoot//aqd:AQD_SamplingPointProcess/ompr:inspireId/base:Identifier
        for $idSamplingPointProcessCode in $docRoot//aqd:AQD_SamplingPointProcess/ompr:inspireId/base:Identifier
        where
            count(index-of($localSamplingPointProcessIds/base:localId, normalize-space($idSamplingPointProcessCode/base:localId))) > 1 and
                    count(index-of($localSamplingPointProcessIds/base:namespace, normalize-space($idSamplingPointProcessCode/base:namespace))) > 1
        return
            <tr>
                <td title="base:localId">{data($idSamplingPointProcessCode/base:localId)}</td>
                <td title="base:namespace">{data($idSamplingPointProcessCode/base:namespace)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D55 :)
let $D55table :=
    try {
        for $id in $SPPnamespaces
        let $localId := $docRoot//aqd:AQD_SamplingPointProcess/ompr:inspireId/base:Identifier[base:namespace = $id]/base:localId
        return
            <tr>
                <td title="feature">SamplingPointProcess(es)</td>
                <td title="base:namespace">{$id}</td>
                <td title="unique localId">{count($localId)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }
(: D55.1 :)
let $D55.1invalid :=
    try {
        let $vocDoc := doc($vocabulary:NAMESPACE || "rdf")
        let $prefLabel := $vocDoc//skos:Concept[adms:status/@rdf:resource = $dd:VALIDRESOURCE and @rdf:about = concat($vocabulary:NAMESPACE, $countryCode)]/skos:prefLabel[1]
        let $altLabel := $vocDoc//skos:Concept[adms:status/@rdf:resource = $dd:VALIDRESOURCE and @rdf:about = concat($vocabulary:NAMESPACE, $countryCode)]/skos:altLabel[1]
        for $x in distinct-values($docRoot//aqd:AQD_SamplingPointProcess/ef:inspireId/base:Identifier/base:namespace)
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

(: D56 :)
let $D56invalid :=
    try {
        let $valid := dd:getValidConcepts($vocabulary:MEASUREMENTTYPE_VOCABULARY || "rdf")
        for $x in $docRoot//aqd:AQD_SamplingPointProcess/aqd:measurementType
        where not($x/@xlink:href = $valid)
        return
            <tr>
                <td title="aqd:AQD_SamplingPointProcess">{data($x/../ef:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:measurementType">{data($x/@xlink:href)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D57 :)
let $D57table :=
    try {
        let $valid := dd:getValidConcepts($vocabulary:MEASUREMENTMETHOD_VOCABULARY || "rdf")
        for $process in doc($source_url)//aqd:AQD_SamplingPointProcess
        let $measurementType := data($process/aqd:measurementType/@xlink:href)
        let $measurementMethod := data($process/aqd:measurementMethod/aqd:MeasurementMethod/aqd:measurementMethod/@xlink:href)
        let $samplingMethod := data($process/aqd:samplingMethod/aqd:SamplingMethod/aqd:samplingMethod/@xlink:href)
        let $analyticalTechnique := data($process/aqd:analyticalTechnique/aqd:AnalyticalTechnique/aqd:analyticalTechnique/@xlink:href)
        where ($measurementType = 'http://dd.eionet.europa.eu/vocabulary/aq/measurementtype/automatic' or
                $measurementType = 'http://dd.eionet.europa.eu/vocabulary/aq/measurementtype/remote')
                and (
                    string-length($samplingMethod) > 0 or string-length($analyticalTechnique) > 0 or not($measurementMethod = $valid)
                )

        return
            <tr>
                <td title="aqd:AQD_SamplingPointProcess">{data($process/ompr:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:measurementType">{$measurementType}</td>
                <td title="aqd:measurementMethod">{$measurementMethod}</td>
                <td title="aqd:samplingMethod">{$samplingMethod}</td>
                <td title="aqd:analyticalTechnique">{$analyticalTechnique}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D58 Done by Rait :)
let $D58table :=
    try {
        let $allConceptUrl58 :=
        for $conceptUrl in doc($source_url)//aqd:AQD_SamplingPointProcess/aqd:measurementType/@xlink:href
        where $conceptUrl = 'http://dd.eionet.europa.eu/vocabulary/aq/measurementtype/active' or
                $conceptUrl = 'http://dd.eionet.europa.eu/vocabulary/aq/measurementtype/passive'
        return $conceptUrl
        for $checkElements in $allConceptUrl58
            let $style1 := if(count($checkElements/../../aqd:samplingMethod) = 0 ) then "color:red;" else ""
            let $style2 := if(count($checkElements/../../aqd:analyticalTechnique) = 0) then "color:red;" else ""
            let $style3 := if(count($checkElements/../../aqd:measurementMethod) >= 1) then "color:red;" else ""
        where (count($checkElements/../../aqd:samplingMethod) = 0 or count($checkElements/../../aqd:analyticalTechnique) = 0)
                 or count($checkElements/../../aqd:measurementMethod) >= 1
        return
            <tr>
                <td title="gml:id">{data($checkElements/../../@gml:id)}</td>
                <td style="{$style1}" title="aqd:samplingMethod">{if(count($checkElements/../../aqd:samplingMethod) = 0 ) then "Error, shall  be provided." else "Valid."}</td>
                <td style="{$style2}" title="aqd:analyticalTechnique">{if(count($checkElements/../../aqd:analyticalTechnique) = 0) then "Error, shall  be provided." else "Valid."}</td>
                <td style="{$style3}" title="aqd:measurementMethod">{if(count($checkElements/../../aqd:measurementMethod) >= 1) then "Error, shall not be provided." else "Valid."}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D59 Done by Rait:)
(: TODO FIND OUT WHAT IS CORRECT PATH:)
let $D59invalid :=
    try {
        let $valid := dd:getValidConcepts($vocabulary:ANALYTICALTECHNIQUE_VOCABULARY || "rdf")
        for $x in $docRoot//aqd:SamplingPointProcess/aqd:analyticalTechnique/aqd:AnalyticalTechnique/aqd:analyticalTechnique
        where not($x/@xlink:href = $valid)
        return
            <tr>
                <td title="aqd:AQD_SamplingPointProcess">{data($x/../ef:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:measurementType">{data($x/@xlink:href)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D60a  :)
let $D60ainvalid :=
    try {
        let $valid := dd:getValidConcepts($vocabulary:MEASUREMENTTYPE_VOCABULARY || "rdf")
        for $x in $docRoot//aqd:AQD_SamplingPointProcess/aqd:measurementType
        where not($x/@xlink:href = $valid)
        return
            <tr>
                <td title="aqd:AQD_SamplingPointProcess">{data($x/../ompr:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:measurementEquipment">{data($x/@xlink:href)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D60b :)
let $D60binvalid :=
    try {
        let $valid := dd:getValidConcepts($vocabulary:SAMPLINGEQUIPMENT_VOCABULARY || "rdf")
        for $x in $docRoot//aqd:AQD_SamplingPointProcess/aqd:samplingEquipment/aqd:SamplingEquipment/aqd:equipment
        where not($x/@xlink:href = $valid)
        return
            <tr>
                <td title="aqd:AQD_SamplingPointProcess">{data($x/../../../ompr:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:samplingEquipment">{data($x/@xlink:href)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D61 :)
let $D61invalid :=
    try {
        for $x in $docRoot//aqd:AQD_SamplingPointProcess
        let $analyticalTechnique := $x/aqd:analyticalTechnique/aqd:AnalyticalTechnique/aqd:otherAnalyticalTechnique
        let $otherMeasurementMethod := $x/aqd:measurementMethod/aqd:MeasurementMethod/aqd:otherMeasurementMethod
        let $measurementEquipment := $x/aqd:measurementEquipment/aqd:MeasurementEquipment/aqd:otherEquipment
        let $otherSamplingMethod := $x/aqd:samplingMethod/aqd:SamplingMethod/aqd:otherSamplingMethod
        let $samplingEquipment := $x/aqd:SamplingEquipment/aqd:SamplingEquipment/aqd:otherEquipment
        where not(empty(($analyticalTechnique, $otherMeasurementMethod, $measurementEquipment, $otherSamplingMethod, $samplingEquipment)))
        return
            <tr>
                <td title="aqd:AQD_SamplingPointProcess">{data($x/ompr:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:otherAnalyticalTechnique">{data($analyticalTechnique)}</td>
                <td title="aqd:otherMeasurementMethod">{data($otherMeasurementMethod)}</td>
                <td title="aqd:MeasurementEquipment">{data($measurementEquipment)}</td>
                <td title="aqd:otherSamplingMethod">{data($otherSamplingMethod)}</td>
                <td title="aqd:SamplingEquipment">{data($samplingEquipment)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D62 :)
let $D62invalid :=
    try {
        let $valid := dd:getValidConcepts($vocabulary:PROCESS_PARAMETER || "rdf")
        for $x in $docRoot//ompr:name
        where not($x/@xlink:href = $valid)
        return
            <tr>
                <td title="aqd:AQD_SamplingPointProcess">{data($x/../../../ompr:inspireId/base:Identifier/base:localId)}</td>
                <td title="ompr:name">{data($x/@xlink:href)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: D63 :)
let $D63invalid :=
    try {
        let $valid := dd:getValidConcepts($vocabulary:UOM_CONCENTRATION_VOCABULARY || "rdf")
        for $x in $docRoot//aqd:detectionLimit
        let $uom := string($x/@uom)
        where not ($uom = $valid)
        return
            <tr>
                <td title="aqd:AQD_SamplingPointProcess">{string($x/../../../ompr:inspireId/base:Identifier/base:localId)}</td>
                <td title="@uom">$uom</td>
            </tr>

    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: D65 :)
let $D65invalid :=
    try {
        let $valid := dd:getValidConcepts($vocabulary:UOM_TIME || "rdf")
        for $x in $docRoot//aqd:unit
        where not($x/@xlink:href = $valid)
        return
            <tr>
                <td title="{$x/../../../name()}">{data($x/../../..//base:Identifier/base:localId)}</td>
                <td title="aqd:unit">{data($x/@xlink:href)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: D67a :)
let $D67ainvalid :=
    try {
        let $rdf := doc("http://dd.eionet.europa.eu/vocabulary/aq/equivalencedemonstrated/rdf")
        let $all := data($rdf//skos:Concept[adms:status/@rdf:resource = "http://dd.eionet.europa.eu/vocabulary/datadictionary/status/valid"]/@rdf:about)
        let $wrongSPP :=
            for $x in $docRoot//aqd:AQD_SamplingPointProcess[not(string(aqd:equivalenceDemonstration/aqd:EquivalenceDemonstration/aqd:equivalenceDemonstrated/@xlink:href) = $all)]
            return string($x/ompr:inspireId/base:Identifier/base:namespace) || '/' || string($x/ompr:inspireId/base:Identifier/base:localId)

        for $x in $docRoot//aqd:AQD_SamplingPoint[aqd:usedAQD = "true"]
        let $xlink := data($x/ef:observingCapability/ef:ObservingCapability/ef:procedure/@xlink:href)
        where ($xlink = $wrongSPP)
        return
            <tr>
                <td title="gml:id">{data($x/@gml:id)}</td>
                <td title="base:localId">{data($x/ef:inspireId/base:Identifier/base:localId)}</td>
                <td title="base:namespace">{data($x/ef:inspireId/base:Identifier/base:namespace)}</td>
                <td title="ef:procedure">{$xlink}</td>
                <td title="ef:ObservingCapability">{data($x/ef:observingCapability/ef:ObservingCapability/@gml:id)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D67b - ./aqd:equivalenceDemonstration/aqd:EquivalenceDemonstration/aqd:equivalenceDemonstrated should resolve to
 : http://dd.eionet.europa.eu/vocabulary/aq/equivalencedemonstrated/ for all SamplingPointProcess :)
let $D67binvalid :=
    try {
        let $rdf := doc("http://dd.eionet.europa.eu/vocabulary/aq/equivalencedemonstrated/rdf")
        let $all := data($rdf//skos:Concept[adms:status/@rdf:resource = "http://dd.eionet.europa.eu/vocabulary/datadictionary/status/valid"]/@rdf:about)
        let $wrongSPP :=
            for $x in $docRoot//aqd:AQD_SamplingPointProcess[not(string(aqd:equivalenceDemonstration/aqd:EquivalenceDemonstration/aqd:equivalenceDemonstrated/@xlink:href) = $all)]
            return string($x/ompr:inspireId/base:Identifier/base:namespace) || '/' || string($x/ompr:inspireId/base:Identifier/base:localId)

        for $x in $docRoot//aqd:AQD_SamplingPoint
        let $xlink := data($x/ef:observingCapability/ef:ObservingCapability/ef:procedure/@xlink:href)
        where ($xlink = $wrongSPP)
        return
                <tr>
                    <td title="gml:id">{data($x/@gml:id)}</td>
                    <td title="base:localId">{data($x/ef:inspireId/base:Identifier/base:localId)}</td>
                    <td title="base:namespace">{data($x/ef:inspireId/base:Identifier/base:namespace)}</td>
                    <td title="ef:procedure">{$xlink}</td>
                    <td title="ef:ObservingCapability">{data($x/ef:observingCapability/ef:ObservingCapability/@gml:id)}</td>
                </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D68 Jaume Targa :)
let $D68invalid :=
    try {
        let $allProcNotMatchingCondition68 :=
            for $proc in $docRoot//aqd:AQD_SamplingPointProcess
            let $demonstrated := data($proc/aqd:equivalenceDemonstration/aqd:EquivalenceDemonstration/aqd:equivalenceDemonstrated/@xlink:href)
            let $demonstrationReport := data($proc/aqd:equivalenceDemonstration/aqd:EquivalenceDemonstration/aqd:demonstrationReport)
            where ($demonstrated = 'http://dd.eionet.europa.eu/vocabulary/aq/equivalencedemonstrated/yes' and fn:string-length($demonstrationReport) = 0)
            return concat(data($proc/ompr:inspireId/base:Identifier/base:namespace), '/', data($proc/ompr:inspireId/base:Identifier/base:localId))

        for $invalidTrueUsedAQD68 in $docRoot//aqd:AQD_SamplingPoint
        let $procIds68 := data($invalidTrueUsedAQD68/ef:observingCapability/ef:ObservingCapability/ef:procedure/@xlink:href)
        let $aqdUsed68 := $invalidTrueUsedAQD68/aqd:usedAQD = true()

        for $procId68 in $procIds68
        return
            if ($aqdUsed68 and not(empty(index-of($allProcNotMatchingCondition68, $procId68)))) then
                <tr>
                    <td title="gml:id">{data($invalidTrueUsedAQD68/@gml:id)}</td>
                    <td title="base:localId">{data($invalidTrueUsedAQD68/ef:inspireId/base:Identifier/base:localId)}</td>
                    <td title="base:namespace">{data($invalidTrueUsedAQD68/ef:inspireId/base:Identifier/base:namespace)}</td>
                    <td title="ef:procedure">{$procId68}</td>
                    <td title="ef:ObservingCapability">{data($invalidTrueUsedAQD68/ef:observingCapability/ef:ObservingCapability/@gml:id)}</td>
                </tr>
            else
                ()
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D69 :)
let $D69invalid :=
    try {
        let $all :=
            for $proc in $docRoot//aqd:AQD_SamplingPointProcess
            let $documentation := data($proc/aqd:dataQuality/aqd:DataQuality/aqd:documentation)
            let $qaReport := data($proc/aqd:dataQuality/aqd:DataQuality/aqd:qaReport)
            where (string-length($documentation) = 0) and (string-length($qaReport) = 0)
            return concat(data($proc/ompr:inspireId/base:Identifier/base:namespace), '/' , data($proc/ompr:inspireId/base:Identifier/base:localId))

        for $x in $docRoot//aqd:AQD_SamplingPoint[aqd:usedAQD = "true"]/ef:observingCapability[ef:ObservingCapability/ef:procedure/@xlink:href = $all]
        return
        <tr>
            <td title="base:localId">{data($x/../ef:inspireId/base:Identifier/base:localId)}</td>
            <td title="base:namespace">{data($x/../ef:inspireId/base:Identifier/base:namespace)}</td>
            <td title="ef:procedure">{string($x/ef:ObservingCapability/ef:procedure/@xlink:href)}</td>
            <td title="ef:ObservingCapability">{data($x/ef:ObservingCapability/@gml:id)}</td>
        </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: D71 - ./aqd:inspireId/base:Identifier/base:localId shall be unique for AQD_Sample and unique within the namespace :)
let $D71invalid :=
    try {
        let $localSampleIds := data($docRoot//aqd:AQD_Sample/aqd:inspireId/base:Identifier/base:localId)
        let $D71namespaces := data($docRoot//base:namespace/../base:localId)
        for $x in $docRoot//aqd:AQD_Sample/aqd:inspireId/base:Identifier
            let $id := string($x/base:localId)
        where count(index-of($localSampleIds, $id)) > 1 or count(index-of($D71namespaces, $id)) > 1
        return
            <tr>
                <td title="base:localId">{data($x/base:localId)}</td>
                <td title="base:namespace">{data($x/base:namespace)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: D72 - :)
let $D72table :=
    try {
        for $id in $sampleNamespaces
        let $localId := $docRoot//aqd:AQD_Sample/aqd:inspireId/base:Identifier[base:namespace = $id]/base:localId
        return
            <tr>
                <td title="base:namespace">{$id}</td>
                <td title="base:localId">{count($localId)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
(: D72.1 :)
let $D72.1invalid :=
    try {
        let $vocDoc := doc($vocabulary:NAMESPACE || "rdf")
        let $prefLabel := $vocDoc//skos:Concept[adms:status/@rdf:resource = $dd:VALIDRESOURCE and @rdf:about = concat($vocabulary:NAMESPACE, $countryCode)]/skos:prefLabel[1]
        let $altLabel := $vocDoc//skos:Concept[adms:status/@rdf:resource = $dd:VALIDRESOURCE and @rdf:about = concat($vocabulary:NAMESPACE, $countryCode)]/skos:altLabel[1]
        for $x in distinct-values($docRoot//aqd:AQD_Sample/ef:inspireId/base:Identifier/base:namespace)
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

(: D73 :)
let $allGmlPoint := $docRoot//aqd:AQD_Sample/sams:shape/gml:Point
let $D73validURN := ("urn:ogc:def:crs:EPSG::3035", "urn:ogc:def:crs:EPSG::4258", "urn:ogc:def:crs:EPSG::4326")
let $D73invalid :=
    try {
        for $point in $docRoot//aqd:AQD_Sample/sams:shape/gml:Point[not(@srsName = $D73validURN)]
        return
            <tr>
                <td title="aqd:AQD_Sample">{data($point/../../aqd:inspireId/base:Identifier/base:localId)}</td>
                <td title="gml:Point">{data($point/@gml:id)}</td>
                <td title="gml:Point/@srsName">{data($point/@srsName)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
let $isInvalidInvalidD73 := if (count($allGmlPoint) > 0) then fn:true() else fn:false()
let $errLevelD73 := if (count($allGmlPoint) > 0) then $errors:ERROR else $errors:WARNING
let $errMsg73 := if (count($allGmlPoint) > 0) then " errors found" else " gml:Point elements found"

(: D74 :)
let $D74invalid :=
    try {
        let $all := distinct-values(
            for $x in $docRoot//aqd:AQD_Sample/sams:shape/gml:Point[@srsDimension != "2"]
            return $x/../../aqd:inspireId/base:Identifier/base:localId/string() || "#" || $x/@gml:id || "#" || $x/@srsDimension
        )
        for $i in $all
        return
            <tr>
                <td title="aqd:AQD_Sample">{tokenize($i, "#")[1]}</td>
                <td title="gml:Point">{tokenize($i, "#")[2]}</td>
                <td title="srsDimension">{tokenize($i, "#")[3]}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: D75 :)
let $D75invalid :=
    try {
        let $approximity := 0.0003

        (: SampleID|long#lat :)
        let $aqdSampleMap := map:merge((
            for $allPos in $docRoot//aqd:AQD_Sample[not(sams:shape/gml:Point/gml:pos = "")]
            let $id := concat($allPos/aqd:inspireId/base:Identifier/base:namespace, "/", $allPos/aqd:inspireId/base:Identifier/base:localId)
            let $pos := $allPos/sams:shape/gml:Point/string(gml:pos)
            return map:entry($id, $pos)
        ))
        for $x in $docRoot//aqd:AQD_SamplingPoint[not(ef:geometry/gml:Point/gml:pos = "")]/ef:observingCapability
        let $samplingPos := $x/../ef:geometry/gml:Point/string(gml:pos)
        let $xlink := ($x/ef:ObservingCapability/ef:featureOfInterest/@xlink:href)
        (: checks Sample map for value :)
        let $samplePos := map:get($aqdSampleMap, $xlink)
        let $sampleLong := geox:getX($samplePos)
        let $sampleLat := geox:getY($samplePos)
        let $samplingLong := geox:getX($samplingPos)
        let $samplingLat := geox:getY($samplingPos)

        let $sampleLong := if ($sampleLong castable as xs:decimal) then xs:decimal($sampleLong) else 0.00
        let $sampleLat := if ($sampleLat castable as xs:decimal) then xs:decimal($sampleLat) else 0.00

        let $samplingLong := if ($samplingLong castable as xs:decimal) then xs:decimal($samplingLong) else 0.00
        let $samplingLat := if ($samplingLat castable as xs:decimal) then xs:decimal($samplingLat) else 0.00

        where (abs($samplingLong - $sampleLong) > $approximity or abs($samplingLat - $sampleLat) > $approximity)
        return
            <tr>
                <td title="aqd:AQD_Sample">{string($xlink)}</td>
                <td title="aqd:AQD_SamplingPoint">{string($x/../ef:inspireId/base:Identifier/string(base:localId))}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: D76 :)
let $D76invalid :=
    try {
        let $sampleDistanceMap :=
            map:merge((
                for $x in $docRoot//aqd:AQD_Sample[not(string(aqd:buildingDistance) = "")]
                let $id := concat($x/aqd:inspireId/base:Identifier/base:namespace, "/", $x/aqd:inspireId/base:Identifier/base:localId)
                let $distance := string($x/aqd:buildingDistance)
                return map:entry($id, $distance)
            ))
        for $x in $docRoot//aqd:AQD_SamplingPoint[aqd:relevantEmissions/aqd:RelevantEmissions/aqd:stationClassification/@xlink:href = "http://dd.eionet.europa.eu/vocabulary/aq/stationclassification/traffic"]/ef:observingCapability
            let $xlink := string($x/ef:ObservingCapability/ef:featureOfInterest/@xlink:href)
            let $distance := map:get($sampleDistanceMap, $xlink)
        return
            if ($distance castable as xs:double) then
                ()
            else
                <tr>
                    <td title="AQD_Sample">{tokenize($xlink, "/")[last()]}</td>
                    <td title="AQD_SamplingPoint">{string($x/../ef:inspireId/base:Identifier/base:localId)}</td>
                </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: D77 :)
let $D77invalid :=
    try {
        let $sampleDistanceMap :=
            map:merge((
                for $x in $docRoot//aqd:AQD_Sample[not(string(aqd:kerbDistance) = "")]
                    let $id := concat($x/aqd:inspireId/base:Identifier/base:namespace, "/", $x/aqd:inspireId/base:Identifier/base:localId)
                    let $distance := string($x/aqd:kerbDistance)
                return map:entry($id, $distance)
            ))
        for $x in $docRoot//aqd:AQD_SamplingPoint[aqd:relevantEmissions/aqd:RelevantEmissions/aqd:stationClassification/@xlink:href = "http://dd.eionet.europa.eu/vocabulary/aq/stationclassification/traffic"]/ef:observingCapability
            let $xlink := string($x/ef:ObservingCapability/ef:featureOfInterest/@xlink:href)
            let $distance := map:get($sampleDistanceMap, $xlink)
        return
            if ($distance castable as xs:double) then
                ()
            else
                <tr>
                    <td title="aqd:AQD_Sample">{string($xlink)}</td>
                    <td title="aqd:AQD_SamplingPoint">{string($x/../ef:inspireId/base:Identifier/base:localId)}</td>
                </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }


(: D78 :)
let $D78invalid :=
    try {
        for $inletHeigh in $docRoot//aqd:AQD_Sample/aqd:inletHeight
        return
            if (($inletHeigh/@uom != "http://dd.eionet.europa.eu/vocabulary/uom/length/m") or (common:is-a-number(data($inletHeigh)) = false())) then
                <tr>
                    <td title="@gml:id">{string($inletHeigh/../@gml:id)}</td>
                </tr>
            else
                ()
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: D91 - Each aqd:AQD_Sample reported within the XML shall be xlinked (at least once) via aqd:AQD_SamplingPoint/ef:observingCapability/ef:ObservingCapability/ef:featureOfInterest/@xlink:href :)
let $D91invalid :=
    try {
        let $x := data($docRoot//aqd:AQD_SamplingPoint/ef:observingCapability/ef:ObservingCapability/ef:featureOfInterest/@xlink:href)
        for $i in $docRoot//aqd:AQD_Sample/aqd:inspireId/base:Identifier
            let $xlink := $i/base:namespace || "/" || $i/base:localId
        where not($xlink = $x)
        return
            <tr>
                <td title="AQD_Sample">{string($i/base:localId)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
(: D92 - Each aqd:AQD_SamplingPointProcess reported within the XML shall be xlinked (at least once) via /aqd:AQD_SamplingPoint/ef:observingCapability/ef:ObservingCapability/ef:procedure/@xlink:href :)
let $D92invalid :=
    try {
        let $x := data($docRoot//aqd:AQD_SamplingPoint/ef:observingCapability/ef:ObservingCapability/ef:procedure/@xlink:href)
        for $i in $docRoot//aqd:AQD_SamplingPointProcess/ompr:inspireId/base:Identifier
            let $xlink := $i/base:namespace || "/" || $i/base:localId
        where not($xlink = $x)
        return
            <tr>
                <td title="AQD_SamplingPointProcess">{string($i/base:localId)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
(: D93 - Each aqd:AQD_Station reported within the XML shall be xlinked (at least once) via aqd:AQD_SamplingPoint/ef:broader/@xlink:href :)
let $D93invalid :=
    try {
        let $x := data($docRoot//aqd:AQD_SamplingPoint/ef:broader/@xlink:href)
        for $i in $docRoot//aqd:AQD_Station/ef:inspireId/base:Identifier
            let $xlink := $i/base:namespace || "/" || $i/base:localId
        where not($xlink = $x)
        return
            <tr>
                <td title="AQD_Station">{string($i/base:localId)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
(: D94 - Each aqd:AQD_Netwok reported within the XML shall be xlinked (at least once) via /aqd:AQD_SamplingPoint/ef:belongsTo/@xlink:href or aqd:AQD_Station/ef:belongsTo/@xlink:href :)
let $D94invalid :=
    try {
        let $x := (data($docRoot//aqd:AQD_SamplingPoint/ef:belongsTo/@xlink:href), data($docRoot//aqd:AQD_Station/ef:belongsTo/@xlink:href))
        for $i in $docRoot//aqd:AQD_Network/ef:inspireId/base:Identifier
            let $xlink := $i/base:namespace || "/" || $i/base:localId
        where not($xlink = $x)
        return
            <tr>
                <td title="AQD_Network">{string($i/base:localId)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

return
    <table class="maintable hover">
        {html:build2("NS", $labels:NAMESPACES, $labels:NAMESPACES_SHORT, $NSinvalid, "All values are valid", "record", $errors:NS)}
        {html:build3("D0", $labels:D0, $labels:D0_SHORT, $D0table, string($D0table/td), errors:getMaxError($D0table))}
        {html:build1("D01", $labels:D01, $labels:D01_SHORT, $D01table, "", $D1sum, "", "",$errors:D01)}
        {html:buildSimple("D02", $labels:D02, $labels:D02_SHORT, $D02table, "", "feature type", $D02errorLevel)}
        {html:buildSimple("D03", $labels:D03, $labels:D03_SHORT, $D03table, $D3count, "feature type", $D03errorLevel)}
        {html:build1("D04", $labels:D04, $labels:D04_SHORT, $D04table, string(count($D04table)), "", "", "", $errors:D04)}
        {html:build2("D05", $labels:D05, $labels:D05_SHORT, $D05invalid, "All values are valid", "record", $errors:D05)}
        {html:buildInfoTR("Specific checks on AQD_Network feature(s) within this XML")}
        {html:buildCountRow("D06", $labels:D06, $labels:D06_SHORT, $D06invalid, (), (), ())}
        {html:buildUnique("D07", $labels:D07, $labels:D07_SHORT, $D07table, "namespace", $errors:D07)}
        {html:build2("D07.1", $labels:D07.1, $labels:D07.1_SHORT, $D07.1invalid, "All values are valid", " invalid namespaces", $errors:D07.1)}
        {html:build2("D08", $labels:D08, $labels:D08_SHORT, $D08invalid, "", "", $errors:D08)}
        {html:build2("D09", $labels:D09, $labels:D09_SHORT, $D09invalid, "", "", $errors:D09)}
        {html:build2("D10", $labels:D10, $labels:D10_SHORT, $D10invalid, "", "", $errors:D10)}
        {html:build2("D11", $labels:D11, $labels:D11_SHORT, $D11invalid, "All attributes are valid", " invalid attribute ", $errors:D11)}
        {html:build2("D12", $labels:D12, $labels:D12_SHORT, $D12invalid, "All attributes are valid", " invalid attribute ", $errors:D12)}
        {html:build2("D14", $labels:D14, $labels:D14_SHORT, $D14invalid, "", "", $errors:D14)}
        {html:buildInfoTR("Specific checks on AQD_Station feature(s) within this XML")}
        {html:buildCountRow("D15", $labels:D15, $labels:D15_SHORT, $D15invalid, "All Ids are unique", (), ())}
        {html:buildUnique("D16", $labels:D16, $labels:D16_SHORT, $D16table, "namespace", $errors:D16)}
        {html:build2("D16.1", $labels:D16.1, $labels:D16.1_SHORT, $D16.1invalid, "All values are valid", " invalid namespaces", $errors:D16.1)}
        {html:build2("D17", $labels:D17, $labels:D17_SHORT, $D17invalid, "All values are valid", "", $errors:D17)}
        {html:build2("D18", $labels:D18, $labels:D18_SHORT, $D18invalid, "All values are valid", "", $errors:D18)}
        {html:build2("D19", $labels:D19, $labels:D19_SHORT, $D19invalid, "All values are valid", "record", $errors:D19)}
        {html:build2("D20", $labels:D20, $labels:D20_SHORT, $D20invalid, "All smsName attributes are valid"," invalid attribute", $errors:D20)}
        {html:build2("D21", $labels:D21, $labels:D21_SHORT, $invalidPosD21, "All srsDimension attributes resolve to ""2""", " invalid attribute", $errors:D21)}
        {html:build2("D23", $labels:D23, $labels:D23_SHORT, $D23invalid, "All values are valid", "", $errors:D23)}
        {html:build1("D24", $labels:D24, $labels:D24_SHORT, $D24table, "", string(count($D24table)) || "records found", "record", "", $errors:D24)}
        {html:build2("D26", $labels:D26, $labels:D26_SHORT, $D26invalid, "All station codes are valid", " invalid station codes", $errors:D26)}
        {html:deprecated("D27", $labels:D27, $labels:D27_SHORT, $D27invalid, "aqd:meteoParams", "", "", "", $errors:D27)}
        {html:build2("D28", $labels:D28, $labels:D28_SHORT, $D28invalid, "All values are valid", "", $errors:D28)}
        {html:build2("D29", $labels:D29, $labels:D29_SHORT, $D29invalid, "All values are valid", "", $errors:D29)}
        {html:build2("D30", $labels:D30, $labels:D30_SHORT, $D30invalid, "All values are valid", "", $errors:D30)}
        {html:build2("D31", $labels:D31, $labels:D31_SHORT, $D31invalid, "All values are valid", "", $errors:D31)}
        {html:buildUnique("D32", $labels:D32, $labels:D32_SHORT, $D32table, "namespace", $errors:D32)}
        {html:build2("D32.1", $labels:D32.1, $labels:D32.1_SHORT, $D32.1invalid, "All values are valid", " invalid namespaces", $errors:D32.1)}
        {html:build2("D33", $labels:D33, $labels:D33_SHORT, $D33invalid, "All values are valid", "", $errors:D33)}
        {html:build2("D34", $labels:D34, $labels:D34_SHORT, $D34invalid, "All values are valid", "", $errors:D34)}
        {html:build2("D35", $labels:D35, $labels:D35_SHORT, $D35invalid, $D35message, " invalid elements", $errors:D35)}
        {html:build2("D36", $labels:D36, $labels:D36_SHORT, $D36invalid, "All attributes are valid", " invalid attribute", $errors:D36)}
        {html:build2("D37", $labels:D37, $labels:D37_SHORT, $D37invalid, "All values are valid", "", $errors:D37)}
        {html:build2("D40", $labels:D40, $labels:D40_SHORT, $D40invalid, "All values are valid", "invalid pollutant", $errors:D40)}
        {html:buildInfoTR("Internal XML cross-checks between AQD_SamplingPoint and AQD_Sample;AQD_SamplingPointProcess;AQD_Station;AQD_Network")}
        {html:buildInfoTR("Please note that the qa might give you warning if different features have been submitted in separate XMLs")}
        {html:build2("D41", $labels:D41, $labels:D41_SHORT, $D41invalid, "All attributes are valid", " invalid attribute", $errors:D41)}
        {html:build2("D42", $labels:D42, $labels:D42_SHORT, $D42invalid, "All attributes are valid", " invalid attribute", $errors:D42)}
        {html:build2("D43", $labels:D43, $labels:D43_SHORT, $D43invalid, "All attributes are valid", " invalid attribute", $errors:D43)}
        {html:build2("D44", $labels:D44, $labels:D44_SHORT, $D44invalid, "All attributes are valid", " invalid attribute", $errors:D44)}
        {html:build2("D45", $labels:D45, $labels:D45_SHORT, $D45invalid, "All values are valid", "", $errors:D45)}
        {html:build2("D46", $labels:D46, $labels:D46_SHORT, $D46invalid, "All values are valid", "", $errors:D46)}
        {html:build2("D48", $labels:D48, $labels:D48_SHORT, $D48invalid, "All values are valid", "record", $errors:D48)}
        {html:build2("D50", $labels:D50, $labels:D50_SHORT, $D50invalid, "All values are valid", "", $errors:D50)}
        {html:build2("D51", $labels:D51, $labels:D51_SHORT, $D51invalid, "All values are valid", " invalid attribute", $errors:D51)}
        {html:build2("D53", $labels:D53, $labels:D53_SHORT, $D53invalid, "All values are valid", " invalid attribute", $errors:D53)}
        {html:build2("D54", $labels:D54, $labels:D54_SHORT, $D54invalid, "All values are valid", " invalid attribute", $errors:D54)}
        {html:buildInfoTR("Specific checks on AQD_SamplingPointProcess feature(s) within this XML")}
        {html:buildUnique("D55", $labels:D55, $labels:D55_SHORT, $D55table, "namespace", $errors:D55)}
        {html:build2("D55.1", $labels:D55.1, $labels:D55.1_SHORT, $D55.1invalid, "All values are valid", " invalid namespaces", $errors:D55.1)}
        {html:build2("D56", $labels:D56, $labels:D56_SHORT, $D56invalid, "All values are valid", "",$errors:D56)}
        {html:build2("D57", $labels:D57, $labels:D57_SHORT, $D57table, "All values are valid", "", $errors:D57)}
        {html:build2("D58", $labels:D58, $labels:D58_SHORT, $D58table, "All values are valid", " invalid attribute", $errors:D58)}
        {html:build2("D59", $labels:D59, $labels:D59_SHORT, $D59invalid, "All values are valid", "", $errors:D59)}
        {html:build2("D60a", $labels:D60a, $labels:D60a_SHORT, $D60ainvalid, "All values are valid", "", $errors:D60a)}
        {html:build2("D60b", $labels:D60b, $labels:D60b_SHORT, $D60binvalid, "All values are valid", "", $errors:D60b)}
        {html:build2("D61", $labels:D61, $labels:D61_SHORT, $D61invalid, "All values are valid", "record", $errors:D61)}
        {html:build2("D62", $labels:D62, $labels:D62_SHORT, $D62invalid, "All values are valid", "invalid record", $errors:D62)}
        {html:build2("D63", $labels:D63, $labels:D63_SHORT, $D63invalid, "All values are valid", "invalid record", $errors:D63)}
        {html:buildInfoTR("Checks on SamplingPointProcess(es) where the xlinked SamplingPoint has aqd:AQD_SamplingPoint/aqd:usedAQD equals TRUE (D67 to D70):")}
        {html:build2("D65", $labels:D65, $labels:D65_SHORT, $D65invalid, "All values are valid", "record", $errors:D65)}
        {html:build2("D67a", $labels:D67a, $labels:D67a_SHORT, $D67ainvalid, "All values are valid", "", $errors:D67a)}
        {html:build2("D67b", $labels:D67b, $labels:D67b_SHORT, $D67binvalid, "All values are valid", "", $errors:D67b)}
        {html:build2("D68", $labels:D68, $labels:D68_SHORT, $D68invalid, "All values are valid", "record", $errors:D68)}
        {html:build2("D69", $labels:D69, $labels:D69_SHORT, $D69invalid, "All values are valid", "record", $errors:D69)}
        {html:buildInfoTR("Specific checks on AQD_Sample feature(s) within this XML")}
        {html:build2("D71", $labels:D71, $labels:D71_SHORT, $D71invalid, "All values are valid", "", $errors:D71)}
        {html:buildUnique("D72", $labels:D72, $labels:D72_SHORT, $D72table, "namespace", $errors:D72)}
        {html:build2("D72.1", $labels:D72.1, $labels:D72.1_SHORT, $D72.1invalid, "All values are valid", " invalid namespaces", $errors:D72.1)}
        {html:build2("D73", $labels:D73, $labels:D73_SHORT, $D73invalid, concat(string(count($D73invalid)), $errMsg73), "", $errLevelD73)}
        {html:build2("D74", $labels:D74, $labels:D74_SHORT, $D74invalid, "All srsDimension attributes are valid"," invalid attribute", $errors:D74)}
        {html:build2("D75", $labels:D75, $labels:D75_SHORT, $D75invalid, "All attributes are valid", " invalid attribute", $errors:D75)}
        {html:build2("D76", $labels:D76, $labels:D76_SHORT, $D76invalid, "All attributes are valid", " invalid attribute", $errors:D76)}
        {html:build2("D77", $labels:D77, $labels:D77_SHORT, $D77invalid, "All attributes are valid", " invalid attribute", $errors:D77)}
        {html:build2("D78", $labels:D78, $labels:D78_SHORT, $D78invalid, "All values are valid"," invalid attribute", $errors:D78)}
        {html:build2("D91", $labels:D91, $labels:D91_SHORT, $D91invalid, "All values are valid"," invalid attribute", $errors:D91)}
        {html:build2("D92", $labels:D92, $labels:D92_SHORT, $D92invalid, "All values are valid"," invalid attribute", $errors:D92)}
        {html:build2("D93", $labels:D93, $labels:D93_SHORT, $D93invalid, "All values are valid"," invalid attribute", $errors:D93)}
        {html:build2("D94", $labels:D94, $labels:D94_SHORT, $D94invalid, "All values are valid"," invalid attribute", $errors:D94)}
    </table>
};

(:
 : ======================================================================
 : Main function
 : ======================================================================
 :)
declare function dataflowD:proceed($source_url as xs:string, $countryCode as xs:string) {

let $countFeatures := count(doc($source_url)//descendant::*[$dataflowD:FEATURE_TYPES = name()])
let $result := if ($countFeatures > 0) then dataflowD:checkReport($source_url, $countryCode) else ()
let $meta := map:merge((
    map:entry("count", $countFeatures),
    map:entry("header", "Check environmental monitoring feature types"),
    map:entry("dataflow", "Dataflow D"),
    map:entry("zeroCount", <p>No environmental monitoring feature type elements ({string-join($dataflowD:FEATURE_TYPES, ", ")}) found in this XML.</p>),
    map:entry("report", <p>This feedback report provides a summary overview of feature types reported and some consistency checks defined in Dataflow D as specified in <a href="http://www.eionet.europa.eu/aqportal/qaqc/">e-reporting QA/QC rules documentation</a>.</p>)
))
return
    html:buildResultDiv($meta, $result)
};

(:~
: User: George Sofianos
: Date: 6/28/2016
: Time: 6:10 PM
:)





declare function dataflowEa:checkReport($source_url as xs:string, $countryCode as xs:string) as element(table) {

let $envelopeUrl := common:getEnvelopeXML($source_url)
let $docRoot := doc($source_url)
let $reportingYear := common:getReportingYear($docRoot)
let $cdrUrl := common:getCdrUrl($countryCode)
let $latestEnvelopeD := query:getLatestEnvelope($cdrUrl || "d/")

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

(: E0 :)
let $E0table :=
    try {
        if ($reportingYear = "") then
            <tr class="{$errors:ERROR}">
                <td title="Status">Reporting Year is missing.</td>
            </tr>
        else if (query:deliveryExists($dataflowEa:OBLIGATIONS, $countryCode, "e1a/", $reportingYear)) then
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
let $isNewDelivery := errors:getMaxError($E0table) = $errors:INFO

(: E01a :)
let $E01atable :=
    try {
        for $x in $docRoot//om:OM_Observation
            let $namedValue := $x/om:parameter/om:NamedValue[om:name/@xlink:href = "http://dd.eionet.europa.eu/vocabulary/aq/processparameter/SamplingPoint"]
            let $samplingPoint := tokenize(common:if-empty($namedValue/om:value, $namedValue/om:value/@xlink:href), "/")[last()]
            let $observedProperty := $x/om:observedProperty/@xlink:href/string()
        return
            <tr>
                <td title="gml:id">{data($x/@gml:id)}</td>
                <td title="aqd:AQD_SamplingPoint">{$samplingPoint}</td>
                <td title="Pollutant">{$observedProperty}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: E01b - /om:OM_Observation gml:id attribute shall be unique code for the group of observations enclosed by /OM_Observation within the delivery. :)
let $E01binvalid :=
    try {
        (let $all := data($docRoot//om:OM_Observation/@gml:id)
        for $x in $docRoot//om:OM_Observation/@gml:id
        where count(index-of($all, $x)) > 1
        return
            <tr>
                <td title="om:OM_Observation">{string($x)}</td>
            </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(:E02 - /om:phenomenonTime/gml:TimePeriod/gml:beginPosition shall be LESS THAN ./om:phenomenonTime/gml:TimePeriod/gml:endPosition. -:)
let $E02invalid :=
    try {
        (let $all := $docRoot//om:phenomenonTime/gml:TimePeriod
        for $x in $all
            let $begin := xs:dateTime($x/gml:beginPosition)
            let $end := xs:dateTime($x/gml:endPosition)
        where ($end <= $begin)
        return
            <tr>
                <td title="@gml:id">{string($x/../../@gml:id)}</td>
                <td title="gml:beginPosition">{string($x/gml:beginPosition)}</td>
                <td title="gml:endPosition">{string($x/gml:endPosition)}</td>
            </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
    }
    catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(:E03 - ./om:resultTime/gml:TimeInstant/gml:timePosition shall be GREATER THAN ./om:phenomenonTime/gml:TimePeriod/gml:endPosition :)
let $E03invalid :=
    try {
        (let $all := $docRoot//om:OM_Observation
        for $x in $all
            let $timePosition := xs:dateTime($x/om:resultTime/gml:TimeInstant/gml:timePosition)
            let $endPosition := xs:dateTime($x/om:phenomenonTime/gml:TimePeriod/gml:endPosition)
        where ($timePosition < $endPosition)
        return
            <tr>
                <td title="@gml:id">{string($x/@gml:id)}</td>
            </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
    }
    catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
(: E04 - ./om:procedure xlink:href attribute shall resolve to a traversable link process configuration in Data flow D: /aqd:AQD_SamplingPointProcess/ompr:inspireld/base:Identifier/base:localId:)
let $E04invalid :=
    try {
        (let $result := sparqlx:run(query:getSamplingPointProcess($cdrUrl))
        let $all := $result/sparql:binding[@name = "inspireLabel"]/sparql:literal/string()
        let $procedures := $docRoot//om:procedure/@xlink:href/string()
        for $x in $procedures[not(. = $all)]
        return
            <tr>
                <td title="base:localId">{$x}</td>
            </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
(: E05 - A valid delivery MUST provide an om:parameter with om:name/@xlink:href to http://dd.eionet.europa.eu/vocabulary/aq/processparameter/SamplingPoint :)
let $E05invalid :=
    try {
        (for $x in $docRoot//om:OM_Observation
        where not($x/om:parameter/om:NamedValue/om:name/@xlink:href = $vocabulary:PROCESS_PARAMETER || "SamplingPoint")
        return
        <tr>
            <td title="@gml:id">{string($x/@gml:id)}</td>
        </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: E06 :)
let $E06invalid :=
    try {
        (let $result := sparqlx:run(query:getSamplingPointFromFiles($latestEnvelopeD))
        let $all := $result/sparql:binding[@name = "inspireLabel"]/sparql:literal/string()
        for $x in $docRoot//om:OM_Observation/om:parameter/om:NamedValue[om:name/@xlink:href = "http://dd.eionet.europa.eu/vocabulary/aq/processparameter/SamplingPoint"]
            let $name := $x/om:name/@xlink:href/string()
            let $value := common:if-empty($x/om:value, $x/om:value/@xlink:href)
        where ($value = "" or not($value = $all))
        return
            <tr>
                <td title="om:OM_Observation">{string($x/../../@gml:id)}</td>
                <td title="om:value">{$value}</td>
            </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: E07 :)
let $E07invalid :=
    try {
        (for $x in $docRoot//om:OM_Observation
        where not($x/om:parameter/om:NamedValue/om:name/@xlink:href = $vocabulary:PROCESS_PARAMETER || "AssessmentType")
        return
            <tr>
                <td title="@gml:id">{string($x/@gml:id)}</td>
            </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
    }
    catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: E08 :)
let $E08invalid :=
    try {
        (let $valid := dd:getValidConcepts($vocabulary:ASSESSMENTTYPE_VOCABULARY || "rdf")
        for $x in $docRoot//om:OM_Observation/om:parameter/om:NamedValue[om:name/@xlink:href = "http://dd.eionet.europa.eu/vocabulary/aq/processparameter/AssessmentType"]
        let $value := common:if-empty($x/om:value, $x/om:value/@xlink:href)
        where not($value = $valid)
        return
            <tr>
                <td title="om:OM_Observation">{string($x/../../@gml:id)}</td>
                <td title="om:value">{$value}</td>
            </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
    }
    catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: E09 :)
(: TODO Check ticket for implementation :)
let $E09invalid :=
    try {
        (let $valid := dd:getValidConcepts($vocabulary:PROCESS_PARAMETER || "rdf")
        for $x in $docRoot//om:OM_Observation/om:parameter/om:NamedValue/om:name
        where not($x/@xlink:href = $valid)
        return
            <tr>
                <td title="@gml:id">{string($x/../../../@gml:id)}</td>
                <td title="om:name">{data($x/@xlink:href)}</td>
            </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: E10 - /om:observedProperty xlink:href attribute shall resolve to a traversable link to http://dd.eionet.europa.eu/vocabulary/aq/pollutant/ :)
let $E10invalid :=
    try {
        (let $all := dd:getValidConcepts("http://dd.eionet.europa.eu/vocabulary/aq/pollutant/rdf")
        for $x in $docRoot//om:OM_Observation/om:observedProperty
        let $namedValue := $x/../om:parameter/om:NamedValue[om:name/@xlink:href ="http://dd.eionet.europa.eu/vocabulary/aq/processparameter/SamplingPoint"]
        let $value := common:if-empty($namedValue/om:value, $namedValue/om:value/@xlink:href)
        where not($x/@xlink:href = $all)
        return
            <tr>
                <td title="om:OM_Observation">{string($x/../@gml:id)}</td>
                <td title="om:value">{$value}</td>
                <td title="om:observedProperty">{string($x/@xlink:href)}</td>
            </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
(: E11 - The pollutant xlinked via /om:observedProperty must match the pollutant code declared via /aqd:AQD_SamplingPoint/ef:observingCapability/ef:ObservingCapability/ef:observedProperty :)
let $E11invalid :=
    try {
        (let $result := sparqlx:run(query:getSamplingPointMetadataFromFiles($latestEnvelopeD))
        let $resultConcat := for $x in $result
        return $x/sparql:binding[@name="featureOfInterest"]/sparql:uri/string() || $x/sparql:binding[@name="observedProperty"]/sparql:uri/string()
        for $x in $docRoot//om:OM_Observation
            let $observedProperty := $x/om:observedProperty/@xlink:href/string()
            let $featureOfInterest := $x/om:featureOfInterest/@xlink:href/string()
            let $featureOfInterest :=
                if (not($featureOfInterest = "") and not(starts-with($featureOfInterest, "http://"))) then
                    "http://reference.eionet.europa.eu/aq/" || $featureOfInterest
                else
                    $featureOfInterest
            let $concat := $featureOfInterest || $observedProperty
            let $namedValue := $x/om:parameter/om:NamedValue[om:name/@xlink:href = "http://dd.eionet.europa.eu/vocabulary/aq/processparameter/SamplingPoint"]
            let $value := common:if-empty($namedValue/om:value, $namedValue/om:value/@xlink:href)
        where not($concat = $resultConcat)
        return
            <tr>
                <td title="@gml:id">{$x/@gml:id/string()}</td>
                <td title="om:value">{$value}</td>
                <td title="om:observedProperty">{$observedProperty}</td>
            </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: E12 :)
let $E12invalid :=
    try {
        (let $samples := data(sparqlx:run(query:getSample($latestEnvelopeD))/sparql:binding[@name = "localId"]/sparql:literal)
        for $x in $docRoot//om:OM_Observation
            let $featureOfInterest := $x/om:featureOfInterest/@xlink:href/tokenize(string(), "/")[last()]
        where ($featureOfInterest = "") or not($featureOfInterest = $samples)
        return
            <tr>
                <td title="@gml:id">{$x/@gml:id/string()}</td>
                <td title="om:featureOfInterest">{$featureOfInterest}</td>
                <td title="om:observedProperty">{string($x/om:observedProperty/@xlink:href)}</td>
            </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: E15 :)
let $E15invalid :=
    try {
        (for $x in $docRoot//om:OM_Observation/om:result//swe:elementType/swe:DataRecord/swe:field[@name = "StartTime"
                and not(swe:Time[@definition = "http://www.opengis.net/def/property/OGC/0/SamplingTime"]/swe:uom/@xlink:href = "http://www.opengis.net/def/uom/ISO-8601/0/Gregorian")]
        return
            <tr>
                <td title="@gml:id">{string($x/../../../../../@gml:id)}</td>
                <td title="swe:uom">{string($x/swe:Time[@definition = "http://www.opengis.net/def/property/OGC/0/SamplingTime"]/swe:uom/@xlink:href)}</td>
            </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: E16 :)
let $E16invalid :=
    try {
        (for $x in $docRoot//om:OM_Observation/om:result//swe:elementType/swe:DataRecord/swe:field[@name = "EndTime"
                and not(swe:Time[@definition = "http://www.opengis.net/def/property/OGC/0/SamplingTime"]/swe:uom/@xlink:href = "http://www.opengis.net/def/uom/ISO-8601/0/Gregorian")]
        return
            <tr>
                <td title="@gml:id">{string($x/../../../../../@gml:id)}</td>
                <td title="swe:uom">{string($x/swe:Time[@definition = "http://www.opengis.net/def/property/OGC/0/SamplingTime"]/swe:uom/@xlink:href)}</td>
            </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
(: E17 :)
let $E17invalid :=
    try {
        (for $x in $docRoot//om:OM_Observation/om:result//swe:elementType/swe:DataRecord/swe:field[@name="Validity"
                and not(swe:Category/@definition = "http://dd.eionet.europa.eu/vocabulary/aq/observationvalidity")]
        return
            <tr>
                <td title="@gml:id">{string($x/../../../../../@gml:id)}</td>
                <td title="swe:Category">{string($x/swe:Category/@definition)}</td>
            </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
(: E18 :)
let $E18invalid :=
    try {
        (for $x in $docRoot//om:OM_Observation/om:result//swe:elementType/swe:DataRecord/swe:field[@name = "Verification"
                and not(swe:Category/@definition = "http://dd.eionet.europa.eu/vocabulary/aq/observationverification")]
        return
            <tr>
                <td title="@gml:id">{string($x/../../../../../@gml:id)}</td>
                <td title="swe:Category">{string($x/swe:Category/@definition)}</td>
            </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
(: E19 :)
let $E19invalid :=
    try {
        (let $obs := dd:getValidConceptsLC("http://dd.eionet.europa.eu/vocabulary/aq/primaryObservation/rdf")
        let $cons := dd:getValidConceptsLC("http://dd.eionet.europa.eu/vocabulary/uom/concentration/rdf")
        for $x in $docRoot//om:OM_Observation/om:result//swe:elementType/swe:DataRecord/swe:field[@name = "Value"
                and (not(swe:Quantity/lower-case(@definition) = $obs) or not(swe:Quantity/swe:uom/lower-case(@xlink:href) = $cons))]
        return
            <tr>
                <td title="@gml:id">{string($x/../../../../../@gml:id)}</td>
                <td title="swe:Quantity">{string($x/swe:Quantity/@definition)}</td>
                <td title="swe:uom">{string($x/swe:Quantity/swe:uom/@xlink:href)}</td>
            </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
(: E19b :)
let $E19binvalid :=
    try {
        (for $x in $docRoot//om:OM_Observation
        let $pollutant := string($x/om:observedProperty/@xlink:href)
        let $value := string($x//swe:field[@name = 'Value']/swe:Quantity/swe:uom/@xlink:href)
        let $recommended := dd:getRecommendedUnit($pollutant)
        where not($value = $recommended)
        return
            <tr>
                <td title="om:OM_Observation">{data($x/@gml:id)}</td>
                <td title="Pollutant">{$pollutant}</td>
                <td title="Recommended Unit">{$recommended}</td>
                <td title="swe:uom">{$value}</td>
            </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: E20 :)
let $E20invalid :=
    try {
        (let $all := $docRoot//om:result//swe:elementType/swe:DataRecord/swe:field[@name="DataCapture"]
        for $x in $all
        let $def := $x/swe:Quantity/@definition/string()
        let $uom := $x/swe:Quantity/swe:uom/@xlink:href/string()
        where (not($def = "http://dd.eionet.europa.eu/vocabulary/aq/primaryObservation/dc") or not($uom = "http://dd.eionet.europa.eu/vocabulary/uom/statistics/percentage"))
        return
            <tr>
                <td title="@gml:id">{string($x/../../../../../@gml:id)}</td>
                <td title="@definition">{$def}</td>
                <td title="@uom">{$uom}</td>
            </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
    }
    catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: E21 - /om:result/swe:DataArray/swe:encoding/swe:TextEncoding shall resolve to decimalSeparator="." tokenSeparator="," blockSeparator="@@" :)
let $E21invalid :=
    try {
        (for $x in $docRoot//om:result//swe:encoding/swe:TextEncoding[not(@decimalSeparator=".") or not(@tokenSeparator=",") or not(@blockSeparator="@@")]
        return
            <tr>
                <td title="@gml:id">{string($x/../../../../@gml:id)}</td>
                <td title="@decimalSeparator">{string($x/@decimalSeparator)}</td>
                <td title="@tokenSeparator">{string($x/@tokenSeparator)}</td>
                <td title="@blockSeparator">{string($x/@blockSeparator)}</td>
            </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
    }
    catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

let $E22invalid :=
    try {
        (let $validVerifications := dd:getValidNotations($vocabulary:OBSERVATIONS_VERIFICATION || "rdf")
        let $validValidity:= dd:getValidNotations($vocabulary:OBSERVATIONS_VALIDITY || "rdf")
        let $exceptionDataCapture := ("-99", "-999")

        for $x at $xpos in $docRoot//om:OM_Observation/om:result
        let $blockSeparator := string($x//swe:encoding/swe:TextEncoding/@blockSeparator)
        let $decimalSeparator := string($x//swe:encoding/swe:TextEncoding/@decimalSeparator)
        let $tokenSeparator := string($x//swe:encoding/swe:TextEncoding/@tokenSeparator)
        let $fields := data($x//swe:elementType/swe:DataRecord/swe:field/@name)

        for $i at $ipos in tokenize(replace($x//swe:values, $blockSeparator || "$", ""), $blockSeparator)
        for $z at $zpos in tokenize($i, $tokenSeparator)
        let $invalid :=
            if ($fields[$zpos] = ("StartTime", "EndTime")) then if ($z castable as xs:dateTime) then false() else true()
            else if ($fields[$zpos] = "Verification") then if ($z = $validVerifications) then false() else true()
            else if ($fields[$zpos] = "Validity") then if ($z = $validValidity) then false() else true()
            else if ($fields[$zpos] = "Value") then if ($z = "" or $z castable as xs:double) then false() else true()
            else if ($fields[$zpos] = "DataCapture") then if ($z = $exceptionDataCapture or ($z castable as xs:decimal and number($z) >= 0 and number($z) <= 100)) then false() else true()
            else true()
        where $invalid = true()
        return
            <tr>
                <td title="OM_Observation">{string($x/../@gml:id)}</td>
                <td title="Data record position">{$ipos}</td>
                <td title="Expected type">{$fields[$zpos]}</td>
                <td title="Actual value">{$z}</td>
            </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

let $E23invalid :=
    try {
        (for $x at $xpos in $docRoot//om:OM_Observation/om:result
        let $blockSeparator := string($x//swe:encoding/swe:TextEncoding/@blockSeparator)
        let $decimalSeparator := string($x//swe:encoding/swe:TextEncoding/@decimalSeparator)
        let $tokenSeparator := string($x//swe:encoding/swe:TextEncoding/@tokenSeparator)

        let $actual := count(tokenize(replace($x//swe:values, $blockSeparator || "$", ""), $blockSeparator))
        let $expected := number($x//swe:elementCount/swe:Count/swe:value)
        where not($actual = $expected)
        return
            <tr>
                <td title="OM_Observation">{string($x/../@gml:id)}</td>
                <td title="Expected count">{$expected}</td>
                <td title="Actual count">{$actual}</td>
            </tr>)[position() = 1 to $errors:HIGHER_LIMIT]
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }


let $E24invalid :=
    try {
        (for $x at $xpos in $docRoot//om:OM_Observation/om:result[//swe:field[@name = "Value"]/swe:Quantity/contains(@definition, $vocabulary:OBSERVATIONS_PRIMARY) = true()]

        let $blockSeparator := string($x//swe:encoding/swe:TextEncoding/@blockSeparator)
        let $decimalSeparator := string($x//swe:encoding/swe:TextEncoding/@decimalSeparator)
        let $tokenSeparator := string($x//swe:encoding/swe:TextEncoding/@tokenSeparator)
        let $definition := $x//swe:field[@name = "Value"]/swe:Quantity/@definition/string()
        let $fields := data($x//swe:elementType/swe:DataRecord/swe:field/@name)

        let $startPos := index-of($fields, "StartTime")
        let $endPos := index-of($fields, "EndTime")

        for $i at $ipos in tokenize(replace($x//swe:values, $blockSeparator || "$", ""), $blockSeparator)
        let $startTime := tokenize($i, $tokenSeparator)[$startPos]
        let $endTime := tokenize($i, $tokenSeparator)[$endPos]
        let $result :=
            if (not($startTime castable as xs:dateTime) or not($endTime castable as xs:dateTime)) then
                true()
            else
                let $startDateTime := xs:dateTime($startTime)
                let $endDateTime := xs:dateTime($endTime)
                return
                    if ($definition = $vocabulary:OBSERVATIONS_PRIMARY || "hour") then
                        if (($endDateTime - $startDateTime) div xs:dayTimeDuration("PT1H") = 1) then
                            false()
                        else
                            true()
                    else if ($definition = $vocabulary:OBSERVATIONS_PRIMARY || "day") then
                        if (($endDateTime - $startDateTime) div xs:dayTimeDuration("P1D") = 1) then
                            false()
                        else
                            true()
                    else if ($definition = $vocabulary:OBSERVATIONS_PRIMARY || "year") then
                        if (common:isDateTimeDifferenceOneYear($startDateTime, $endDateTime)) then
                            false()
                        else
                            true()
                    else if ($definition = $vocabulary:OBSERVATIONS_PRIMARY || "var") then
                        if (($endDateTime - $startDateTime) div xs:dayTimeDuration("PT1H") > 0) then
                            false()
                        else
                            true()
                    else
                        false()
        where $result = true()
        return
            <tr>
                <td title="@gml:id">{string($x/../@gml:id)}</td>
                <td title="@definition">{$definition}</td>
                <td title="StartTime">{$startTime}</td>
                <td title="EndTime">{$endTime}</td>
            </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
    }
    catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

let $E25invalid :=
    try {
        (for $x at $xpos in $docRoot//om:OM_Observation/om:result
        let $blockSeparator := string($x//swe:encoding/swe:TextEncoding/@blockSeparator)
        let $decimalSeparator := string($x//swe:encoding/swe:TextEncoding/@decimalSeparator)
        let $tokenSeparator := string($x//swe:encoding/swe:TextEncoding/@tokenSeparator)
        let $fields := data($x//swe:elementType/swe:DataRecord/swe:field/@name)
        let $startPos := index-of($fields, "StartTime")
        let $endPos := index-of($fields, "EndTime")
        let $expectedStart := $x/../om:phenomenonTime/gml:TimePeriod/gml:beginPosition/text()
        let $expectedEnd := $x/../om:phenomenonTime/gml:TimePeriod/gml:endPosition/text()
        return
            try {
                for $i at $ipos in tokenize(replace($x//swe:values, $blockSeparator || "$", ""), $blockSeparator)
                let $startTime := tokenize($i, $tokenSeparator)[$startPos]
                let $endTime := tokenize($i, $tokenSeparator)[$endPos]
                where not(xs:dateTime($expectedStart) <= xs:dateTime($startTime)) or not(xs:dateTime($expectedEnd) >= xs:dateTime($endTime))
                return
                    <tr>
                        <td title="@gml:id">{string($x/../@gml:id)}</td>
                        <td title="Data record position">{$ipos}</td>
                        <td title="gml:beginPosition">{$expectedStart}</td>
                        <td title="StartTime">{$startTime}</td>
                        <td title="gml:endPosition">{$expectedEnd}</td>
                        <td title="EndTime">{$endTime}</td>
                    </tr>
            } catch * {
                <tr class="{$errors:FAILED}">
                    <td title="Error code">{$err:code}</td>
                    <td title="Error description">{$err:description}</td>
                </tr>
            })[position() = 1 to $errors:HIGHER_LIMIT]
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: E26 :)
let $E26invalid :=
    try {
        (let $result := sparqlx:run(query:getSamplingPointMetadataFromFiles($latestEnvelopeD))
        let $resultsConcat :=
            for $x in $result
            return $x/sparql:binding[@name="localId"]/sparql:literal/string() || $x/sparql:binding[@name="procedure"]/sparql:uri/string() ||
            $x/sparql:binding[@name="featureOfInterest"]/sparql:uri/string() || $x/sparql:binding[@name="observedProperty"]/sparql:uri/string()

        for $x in $docRoot//om:OM_Observation
            let $namedValue := $x/om:parameter/om:NamedValue[om:name/@xlink:href = "http://dd.eionet.europa.eu/vocabulary/aq/processparameter/SamplingPoint"]
            let $samplingPoint := tokenize(common:if-empty($namedValue/om:value, $namedValue/om:value/@xlink:href), "/")[last()]
            let $procedure := $x/om:procedure/@xlink:href/string()
            let $procedure :=
                if (not($procedure = "") and not(starts-with($procedure, "http://"))) then
                    "http://reference.eionet.europa.eu/aq/" || $procedure
                else
                    $procedure
            let $featureOfInterest := $x/om:featureOfInterest/@xlink:href/string()
            let $featureOfInterest :=
                if (not($featureOfInterest = "") and not(starts-with($featureOfInterest, "http://"))) then
                    "http://reference.eionet.europa.eu/aq/" || $featureOfInterest
                else
                    $featureOfInterest
            let $observedProperty := $x/om:observedProperty/@xlink:href/string()
            let $concat := $samplingPoint || $procedure || $featureOfInterest || $observedProperty
        where not($concat = $resultsConcat)
        return
            <tr>
                <td title="om:OM_Observation">{string($x/@gml:id)}</td>
                <td title="aqd:AQD_SamplingPoint">{string($samplingPoint)}</td>
                <td title="aqd:AQD_SamplingPointProcess">{$procedure}</td>
                <td title="aqd:AQD_Sample">{$featureOfInterest}</td>
                <td title="Pollutant">{$observedProperty}</td>
            </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
    }
    catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: E27 :)
let $E27invalid :=
    try {
        (for $x at $xpos in $docRoot//om:OM_Observation/om:result
        let $blockSeparator := string($x//swe:encoding/swe:TextEncoding/@blockSeparator)
        let $decimalSeparator := string($x//swe:encoding/swe:TextEncoding/@decimalSeparator)
        let $tokenSeparator := string($x//swe:encoding/swe:TextEncoding/@tokenSeparator)
        let $validCount := count($x//swe:elementType/swe:DataRecord/swe:field)

        for $i at $ipos in tokenize(replace($x//swe:values, $blockSeparator || "$", ""), $blockSeparator)
        let $count := count(tokenize($i, $tokenSeparator))
        where not($count = $validCount)
        return
            <tr>
                <td title="OM_Observation">{string($x/../@gml:id)}</td>
                <td title="Data record position">{$ipos}</td>
                <td title="Expected fields">{$validCount}</td>
                <td title="Actual fields">{$count}</td>
            </tr>)[position() = 1 to $errors:HIGHER_LIMIT]
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

let $E28invalid :=
    try {
        (for $x at $xpos in $docRoot//om:OM_Observation/om:result
        let $blockSeparator := string($x//swe:encoding/swe:TextEncoding/@blockSeparator)
        where ends-with($x//swe:values, $blockSeparator)
        return
            <tr>
                <td title="OM_Observation">{string($x/../@gml:id)}</td>
            </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

let $E29invalid :=
    try {
        (for $x at $xpos in $docRoot//om:OM_Observation/om:result
        let $blockSeparator := string($x//swe:encoding/swe:TextEncoding/@blockSeparator)
        let $decimalSeparator := string($x//swe:encoding/swe:TextEncoding/@decimalSeparator)
        let $tokenSeparator := string($x//swe:encoding/swe:TextEncoding/@tokenSeparator)
        let $fields := data($x//swe:elementType/swe:DataRecord/swe:field/@name)

        for $i at $ipos in tokenize(replace($x//swe:values, $blockSeparator || "$", ""), $blockSeparator)
        for $z at $zpos in tokenize($i, $tokenSeparator)
        where matches($z, "\s+")
        return
            <tr>
                <td title="OM_Observation">{string($x/../@gml:id)}</td>
                <td title="Data record position">{$ipos}</td>
                <td title="Expected type">{$fields[$zpos]}</td>
                <td title="Actual value">{$z}</td>
            </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

let $E30invalid :=
    try {
        (let $valid := dd:getValid($vocabulary:OBSERVATIONS_RANGE)

        for $x at $xpos in $docRoot//om:OM_Observation/om:result
        let $blockSeparator := string($x//swe:encoding/swe:TextEncoding/@blockSeparator)
        let $decimalSeparator := string($x//swe:encoding/swe:TextEncoding/@decimalSeparator)
        let $tokenSeparator := string($x//swe:encoding/swe:TextEncoding/@tokenSeparator)
        let $fields := data($x//swe:elementType/swe:DataRecord/swe:field/@name)

        let $definition := $x//swe:field[@name = "Value"]/swe:Quantity/@definition/string()
        let $uom := $x//swe:field[@name = "Value"]/swe:Quantity/swe:uom/@xlink:href/string()
        let $pollutant := $x/../om:observedProperty/@xlink:href/string()
        let $minValue := $valid[prop:recommendedUnit/@rdf:resource = $uom and prop:relatedPollutant/@rdf:resource = $pollutant and prop:primaryObservationTime/@rdf:resource = $definition]/prop:minimumValue/string()
        let $maxValue := $valid[prop:recommendedUnit/@rdf:resource = $uom and prop:relatedPollutant/@rdf:resource = $pollutant and prop:primaryObservationTime/@rdf:resource = $definition]/prop:maximumValue/string()
        where ($minValue castable as xs:double and $maxValue castable as xs:double)

        for $i at $ipos in tokenize(replace($x//swe:values, $blockSeparator || "$", ""), $blockSeparator)
        let $tokens := tokenize($i, $tokenSeparator)
        let $validity := $tokens[index-of($fields, "Validity")]
        let $value := $tokens[index-of($fields, "Value")]
        where (($validity castable as xs:integer) and xs:integer($validity) >= 1) and (not($value castable as xs:double) or (xs:double($value) < xs:double($minValue)) or (xs:double($value) > xs:double($maxValue)))
        return
            <tr>
                <td title="OM_Observation">{string($x/../@gml:id)}</td>
                <td title="Data record position">{$ipos}</td>
                <td title="Pollutant">{tokenize($pollutant, "/")[last()]}</td>
                <td title="Concentration">{tokenize($uom, "/")[last()]}</td>
                <td title="Primary Observation">{tokenize($definition, "/")[last()]}</td>
                <td title="Minimum value">{$minValue}</td>
                <td title="Maximum value">{$maxValue}</td>
                <td title="Actual value">{$value}</td>
            </tr>)[position() = 1 to $errors:MAX_LIMIT]
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

let $E31invalid :=
    try {
        (for $x at $xpos in $docRoot//om:OM_Observation/om:result

        let $blockSeparator := string($x//swe:encoding/swe:TextEncoding/@blockSeparator)
        let $decimalSeparator := string($x//swe:encoding/swe:TextEncoding/@decimalSeparator)
        let $tokenSeparator := string($x//swe:encoding/swe:TextEncoding/@tokenSeparator)
        let $fields := data($x//swe:elementType/swe:DataRecord/swe:field/@name)

        let $startPos := index-of($fields, "StartTime")
        let $endPos := index-of($fields, "EndTime")

        let $startTimes := for $i in tokenize(replace($x//swe:values, $blockSeparator || "$", ""), $blockSeparator)
        return tokenize($i, $tokenSeparator)[$startPos]
        let $endTimes := for $i in tokenize(replace($x//swe:values, $blockSeparator || "$", ""), $blockSeparator)
        return tokenize($i, $tokenSeparator)[$endPos]
        return try {
            for $startTime at $ipos in $startTimes
            let $prevStartTime := $startTimes[$ipos - 1]
            let $endTime := $endTimes[$ipos]
            let $prevEndTime := $endTimes[$ipos - 1]
            where not($ipos = 1) and (xs:dateTime($startTime) < xs:dateTime($prevEndTime))
            return
                <tr>
                    <td title="@gml:id">{string($x/../@gml:id)}</td>
                    <td title="Data record position">{$ipos}</td>
                    <td title="StartTime">{$startTime}</td>
                    <td title="Previous endTime">{$prevEndTime}</td>
                </tr>
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        })[position() = 1 to $errors:MEDIUM_LIMIT]
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

let $E32invalid :=
    try {
        (for $x at $xpos in $docRoot//om:OM_Observation/om:result
        let $blockSeparator := string($x//swe:encoding/swe:TextEncoding/@blockSeparator)
        let $decimalSeparator := string($x//swe:encoding/swe:TextEncoding/@decimalSeparator)
        let $tokenSeparator := string($x//swe:encoding/swe:TextEncoding/@tokenSeparator)
        let $fields := data($x//swe:elementType/swe:DataRecord/swe:field/@name)
        let $verificationPos := index-of($fields, "Verification")

        let $values :=
            for $i at $ipos in tokenize(replace($x//swe:values, $blockSeparator || "$", ""), $blockSeparator)
            let $verification := tokenize($i, $tokenSeparator)[$verificationPos]
            where not($verification = "1")
            return
                $verification
        for $z in distinct-values($values)
        return
            <tr>
                <td title="OM_Observation">{string($x/../@gml:id)}</td>
                <td title="Verification">{$z}</td>
                <td title="Occurrences">{count(index-of($values, $z))}</td>
            </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]

    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

return
    <table class="maintable hover">
        {html:build2("NS", $labels:NAMESPACES, $labels:NAMESPACES_SHORT, $NSinvalid, "All values are valid", "record", $errors:NS)}
        {html:build3("E0", $labels:E0, $labels:E0_SHORT, $E0table, data($E0table/td), errors:getMaxError($E0table))}
        {html:build1("E01a", $labels:E01a, $labels:E01a_SHORT, $E01atable, "", string(count($E01atable)), "record", "", $errors:E01a)}
        {html:build2("E01b", $labels:E01b, $labels:E01b_SHORT, $E01binvalid, "All records are valid", "record", $errors:E01b)}
        {html:build2("E02", $labels:E02, $labels:E02_SHORT, $E02invalid, "All records are valid", "record", $errors:E02)}
        {html:build2("E03", $labels:E03, $labels:E03_SHORT, $E03invalid, "All records are valid", "record", $errors:E03)}
        {html:build2("E04", $labels:E04, $labels:E04_SHORT, $E04invalid, "All records are valid", "record", $errors:E04)}
        {html:build2("E05", $labels:E05, $labels:E05_SHORT, $E05invalid, "All records are valid", "record", $errors:E05)}
        {html:build2("E06", $labels:E06, $labels:E06_SHORT, $E06invalid, "All records are valid", "record", $errors:E06)}
        {html:build2("E07", $labels:E07, $labels:E07_SHORT, $E07invalid, "All records are valid", "record", $errors:E07)}
        {html:build2("E08", $labels:E08, $labels:E08_SHORT, $E08invalid, "All records are valid", "record", $errors:E08)}
        {html:build2("E09", $labels:E09, $labels:E09_SHORT, $E09invalid, "All records are valid", "record", $errors:E09)}
        {html:build2("E10", $labels:E10, $labels:E10_SHORT, $E10invalid, "All records are valid", "record", $errors:E10)}
        {html:build2("E11", $labels:E11, $labels:E11_SHORT, $E11invalid, "All records are valid", "record", $errors:E11)}
        {html:build2("E12", $labels:E12, $labels:E12_SHORT, $E12invalid, "All records are valid", "record", $errors:E12)}
        {html:build2("E15", $labels:E15, $labels:E15_SHORT, $E15invalid, "All records are valid", "record", $errors:E15)}
        {html:build2("E16", $labels:E16, $labels:E16_SHORT, $E16invalid, "All records are valid", "record", $errors:E16)}
        {html:build2("E17", $labels:E17, $labels:E17_SHORT, $E17invalid, "All records are valid", "record", $errors:E17)}
        {html:build2("E18", $labels:E18, $labels:E18_SHORT, $E18invalid, "All records are valid", "record", $errors:E18)}
        {html:build2("E19", $labels:E19, $labels:E19_SHORT, $E19invalid, "All records are valid", "record", $errors:E19)}
        {html:build2("E19b", $labels:E19b, $labels:E19b_SHORT, $E19binvalid, "All records are valid", "record", $errors:E19b)}
        {html:build2("E20", $labels:E20, $labels:E20_SHORT, $E20invalid, "All records are valid", "record", $errors:E20)}
        {html:build2("E21", $labels:E21, $labels:E21_SHORT, $E21invalid, "All records are valid", "record", $errors:E21)}
        {html:build2("E22", $labels:E22, $labels:E22_SHORT, $E22invalid, "All records are valid", "record", $errors:E22)}
        {html:build2("E23", $labels:E23, $labels:E23_SHORT, $E23invalid, "All records are valid", "record", $errors:E23)}
        {html:build2("E24", $labels:E24, $labels:E24_SHORT, $E24invalid, "All records are valid", "record", $errors:E24)}
        {html:build2("E25", $labels:E25, $labels:E25_SHORT, $E25invalid, "All records are valid", "record", $errors:E25)}
        {html:build2("E26", $labels:E26, $labels:E26_SHORT, $E26invalid, "All records are valid", "record", $errors:E26)}
        {html:build2("E27", $labels:E27, $labels:E27_SHORT, $E27invalid, "All records are valid", "record", $errors:E27)}
        {html:build2("E28", $labels:E28, $labels:E28_SHORT, $E28invalid, "All records are valid", "record", $errors:E28)}
        {html:build2("E29", $labels:E29, $labels:E29_SHORT, $E29invalid, "All records are valid", "record", $errors:E29)}
        {html:build2("E30", $labels:E30, $labels:E30_SHORT, $E30invalid, "All records are valid", "record", $errors:E30)}
        {html:build2("E31", $labels:E31, $labels:E31_SHORT, $E31invalid, "All records are valid", "record", $errors:E31)}
        {html:build2("E32", $labels:E32, $labels:E32_SHORT, $E32invalid, "All records are valid", "record", $errors:E32)}
    </table>

};


declare function dataflowEa:proceed($source_url as xs:string, $countryCode as xs:string) as element(div) {
    let $count := count(doc($source_url)//om:OM_Observation)
    let $result := if ($count > 0) then dataflowEa:checkReport($source_url, $countryCode) else ()
    let $meta := map:merge((
        map:entry("count", $count),
        map:entry("header", "Check air quality observations"),
        map:entry("dataflow", "Dataflow E"),
        map:entry("zeroCount", <p>No aqd:OM_Observation elements found in this XML.</p>),
        map:entry("report", <p>This check evaluated the delivery by executing tier-1 tests on air quality observation data in Dataflow E as specified in <a href="http://www.eionet.europa.eu/aqportal/qaqc/">e-reporting QA/QC rules documentation</a>.</p>)
    ))
    return
        html:buildResultDiv($meta, $result)
};







(: Rule implementations :)
declare function dataflowEb:checkReport($source_url as xs:string, $countryCode as xs:string) as element(table) {
    let $docRoot := doc($source_url)
    let $cdrUrl := common:getCdrUrl($countryCode)
    let $reportingYear := common:getReportingYear($docRoot)
    let $latestEnvelopeD1b := query:getLatestEnvelope($cdrUrl || "d1b/")

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

    (: Eb0 - Check if delivery if this is a new delivery or updated delivery (via reporting year) :)
    let $Eb0table :=
        try {
            if ($reportingYear = "") then
                <tr class="{$errors:ERROR}">
                    <td title="Status">Reporting Year is missing.</td>
                </tr>
            else if (query:deliveryExists($dataflowEb:OBLIGATIONS, $countryCode, "e1b/", $reportingYear)) then
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
    let $isNewDelivery := errors:getMaxError($Eb0table) = $errors:INFO

    (: Eb01 - Compile & feedback upon the total number of observations included in the delivery :)
    let $Eb01table :=
        try {
            let $parameters := for $i in ("model", "objective") return $vocabulary:PROCESS_PARAMETER || $i
            for $x in $docRoot//om:OM_Observation
            let $namedValue := $x/om:parameter/om:NamedValue[om:name/@xlink:href = $parameters]
            let $model := tokenize(common:if-empty($namedValue/om:value, $namedValue/om:value/@xlink:href), "/")[last()]
            let $observedProperty := $x/om:observedProperty/@xlink:href/string()
            return
                <tr>
                    <td title="gml:id">{data($x/@gml:id)}</td>
                    <td title="aqd:AQD_Model">{$model}</td>
                    <td title="Pollutant">{$observedProperty}</td>
                </tr>
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (:Eb02 ./om:phenomenonTime/gml:TimePeriod/gml:beginPosition shall be LESS THAN ./om:phenomenonTime/gml:TimePeriod/gml:endPosition. :)
    let $Eb02invalid :=
        try {
            (let $all := $docRoot//om:phenomenonTime/gml:TimePeriod
            for $x in $all
            let $begin := xs:dateTime($x/gml:beginPosition)
            let $end := xs:dateTime($x/gml:endPosition)
            where ($end <= $begin)
            return
                <tr>
                    <td title="@gml:id">{string($x/../../@gml:id)}</td>
                    <td title="gml:beginPosition">{string($x/gml:beginPosition)}</td>
                    <td title="gml:endPosition">{string($x/gml:endPosition)}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (:Eb03 - ./om:resultTime/gml:TimeInstant/gml:timePosition shall be GREATER THAN ./om:phenomenonTime/gml:TimePeriod/gml:endPosition :)
    let $Eb03invalid :=
        try {
            (let $all := $docRoot//om:OM_Observation
            for $x in $all
            let $timePosition := xs:dateTime($x/om:resultTime/gml:TimeInstant/gml:timePosition)
            let $endPosition := xs:dateTime($x/om:phenomenonTime/gml:TimePeriod/gml:endPosition)
            where ($timePosition < $endPosition)
            return
                <tr>
                    <td title="@gml:id">{string($x/@gml:id)}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        }
        catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb04 -  All om:OM_Observation/ must provide a valid /om:procedure xlink (can not be empty) & ./om:procedure xlink:href attribute
     shall resolve to a traversable link process configuration in Data flow D1b: /aqd:AQD_ModelProcess/ompr:inspireld/base:Identifier/base:localId :)
    let $Eb04invalid :=
        try {
            (let $result := sparqlx:run(query:getModelProcess($cdrUrl))
            let $all := $result/sparql:binding[@name = "inspireLabel"]/sparql:literal/string()
            let $procedures := $docRoot//om:procedure/@xlink:href/string()
            for $x in $procedures[not(. = $all)]
            return
                <tr>
                    <td title="base:localId">{$x}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb05 A valid delivery MUST provide an om:parameter/om:NamedValue/om:name xlink:href to
    either http://dd.eionet.europa.eu/vocabulary/aq/processparameter/model or http://dd.eionet.europa.eu/vocabulary/aq/processparameter/objective :)
    let $Eb05invalid :=
        try {
            (let $parameters := for $i in ("model", "objective") return $vocabulary:PROCESS_PARAMETER || $i
            for $x in $docRoot//om:OM_Observation
            where not($x/om:parameter/om:NamedValue/om:name/@xlink:href = $parameters)
            return
                <tr>
                    <td title="@gml:id">{string($x/@gml:id)}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb06 - If ./om:parameter/om:NamedValue/om:name xlink:href  resolves to http://dd.eionet.europa.eu/vocabulary/aq/processparameter/model or .../objective
/om:parameter/om:NamedValue/om:value xlink:href attribute shall resolve to a traversable link to a unique AQD_Model (“namespace/localId” of the object) :)
    let $Eb06invalid :=
        try {
            (let $parameters := for $i in ("model", "objective") return $vocabulary:PROCESS_PARAMETER || $i
            let $result := sparqlx:run(query:getModelFromFiles($latestEnvelopeD1b))
            let $all := $result/sparql:binding[@name = "inspireLabel"]/sparql:literal/string()
            for $x in $docRoot//om:OM_Observation/om:parameter/om:NamedValue[om:name/@xlink:href = $parameters]
            let $name := $x/om:name/@xlink:href/string()
            let $value := common:if-empty($x/om:value, $x/om:value/@xlink:href)
            where ($value = "" or not($value = $all))
            return
                <tr>
                    <td title="om:OM_Observation">{string($x/../../@gml:id)}</td>
                    <td title="om:value">{$value}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb07 - A valid delivery should provide  an om:parameter with om:name xlink:href to http://dd.eionet.europa.eu/vocabulary/aq/processparameter/AssessmentType :)
    let $Eb07invalid :=
        try {
            (for $x in $docRoot//om:OM_Observation
            where not($x/om:parameter/om:NamedValue/om:name/@xlink:href = $vocabulary:PROCESS_PARAMETER || "AssessmentType")
            return
                <tr>
                    <td title="@gml:id">{string($x/@gml:id)}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        }
        catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb08 - If ./om:parameter/om:NamedValue/om:name links to http://dd.eionet.europa.eu/vocabulary/aq/processparameter/AssessmentType
     /om:parameter/om:NamedValue/om:value xlink:href attribute shall resolve to  valid code for http://dd.eionet.europa.eu/vocabulary/aq/assessmenttype/ :)
    let $Eb08invalid :=
        try {
            (let $valid := dd:getValidConcepts($vocabulary:ASSESSMENTTYPE_VOCABULARY || "rdf")
            for $x in $docRoot//om:OM_Observation/om:parameter/om:NamedValue[om:name/@xlink:href = $vocabulary:PROCESS_PARAMETER || "AssessmentType"]
            let $value := common:if-empty($x/om:value, $x/om:value/@xlink:href)
            where not($value = $valid)
            return
                <tr>
                    <td title="om:OM_Observation">{string($x/../../@gml:id)}</td>
                    <td title="om:value">{$value}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        }
        catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb09 - OM observations shall contain several om:parameters to further define the model/objective estimation results
./om:parameter/om:NamedValue/om:name xlink:href attribute shall resolve to a traversable link to http://dd.eionet.europa.eu/vocabulary/aq/processparameter/ :)
    let $Eb09invalid :=
        try {
            (let $valid := (dd:getValidConcepts($vocabulary:MODEL_PARAMETER || "rdf"), dd:getValidConcepts($vocabulary:PROCESS_PARAMETER || "rdf"))
            for $x in $docRoot//om:OM_Observation/om:parameter/om:NamedValue/om:name
            where not($x/@xlink:href = $valid)
            return
                <tr>
                    <td title="@gml:id">{string($x/../../../@gml:id)}</td>
                    <td title="om:name">{data($x/@xlink:href)}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb10 - . /om:observedProperty xlink:href attribute shall resolve to a traversable link to http://dd.eionet.europa.eu/vocabulary/aq/pollutant/ :)
    let $Eb10invalid :=
        try {
            (let $all := dd:getValidConcepts("http://dd.eionet.europa.eu/vocabulary/aq/pollutant/rdf")
            for $x in $docRoot//om:OM_Observation/om:observedProperty
            let $namedValue := $x/../om:parameter/om:NamedValue[om:name/@xlink:href = $vocabulary:PROCESS_PARAMETER || "model"]
            let $value := common:if-empty($namedValue/om:value, $namedValue/om:value/@xlink:href)
            where not($x/@xlink:href = $all)
            return
                <tr>
                    <td title="om:OM_Observation">{string($x/../@gml:id)}</td>
                    <td title="om:value">{$value}</td>
                    <td title="om:observedProperty">{string($x/@xlink:href)}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb11 - The pollutant xlinked via /om:observedProperty must match the pollutant code declared via /aqd:AQD_Model/ef:observingCapability/ef:ObservingCapability/ef:observedProperty
      (See Eb6 on linkages between the Observations & the SamplingPoint) :)
    let $Eb11invalid :=
        try {
            (let $result := sparqlx:run(query:getModelMetadataFromFiles($latestEnvelopeD1b))
            let $resultConcat := for $x in $result
            return $x/sparql:binding[@name="featureOfInterest"]/sparql:uri/string() || $x/sparql:binding[@name="observedProperty"]/sparql:uri/string()
            for $x in $docRoot//om:OM_Observation
            let $observedProperty := $x/om:observedProperty/@xlink:href/string()
            let $featureOfInterest := $x/om:featureOfInterest/@xlink:href/string()
            let $featureOfInterest :=
                if (not($featureOfInterest = "") and not(starts-with($featureOfInterest, "http://"))) then
                    "http://reference.eionet.europa.eu/aq/" || $featureOfInterest
                else
                    $featureOfInterest
            let $concat := $featureOfInterest || $observedProperty
            let $namedValue := $x/om:parameter/om:NamedValue[om:name/@xlink:href = $vocabulary:PROCESS_PARAMETER || "model"]
            let $value := common:if-empty($namedValue/om:value, $namedValue/om:value/@xlink:href)
            where not($concat = $resultConcat)
            return
                <tr>
                    <td title="@gml:id">{$x/@gml:id/string()}</td>
                    <td title="om:value">{$value}</td>
                    <td title="om:observedProperty">{$observedProperty}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb12 - All om:OM_Observation/ must provide a valid /om:featureOfInterest xlink (can not be empty)& 
     /om:featureOfInterest xlink:href attribute shall resolve to a traversable link to /aqd:AQD_modelArea/ompr:inspireld/base:Identifier/base:localId :)
    let $Eb12invalid :=
        try {
            (let $areas := data(sparqlx:run(query:getModelArea($latestEnvelopeD1b))/sparql:binding[@name = "localId"]/sparql:literal)
            for $x in $docRoot//om:OM_Observation
            let $featureOfInterest := $x/om:featureOfInterest/@xlink:href/tokenize(string(), "/")[last()]
            where ($featureOfInterest = "") or not($featureOfInterest = $areas)
            return
                <tr>
                    <td title="@gml:id">{$x/@gml:id/string()}</td>
                    <td title="om:featureOfInterest">{$featureOfInterest}</td>
                    <td title="om:observedProperty">{string($x/om:observedProperty/@xlink:href)}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb13 - A valid delivery MUST provide an om:parameter/om:NamedValue/om:name xlink:href to http://dd.eionet.europa.eu/vocabulary/aq/processparameter/resultencoding &
    om:parameter/om:NamedValue/om:value xlink:href attribute shall resolve to  valid code for http://dd.eionet.europa.eu/vocabulary/aq/resultencoding/ :)
    let $Eb13invalid :=
        try {
            (let $valid := dd:getValidConcepts($vocabulary:RESULT_ENCODING || "rdf")
            for $x in $docRoot//om:OM_Observation
            let $node := $x/om:parameter/om:NamedValue[om:name/@xlink:href = $vocabulary:PROCESSPARAMETER_RESULTENCODING]
            let $value := common:if-empty($node/om:value, $node/om:value/@xlink:href)
            where $node => empty() or not($value = $valid)
            return
                <tr>
                    <td title="gml:id">{data($x/@gml:id)}</td>
                    <td title="Result encoding">{$value}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb14 - A valid delivery MUST provide an om:parameter/om:NamedValue/om:name xlink:href to http://dd.eionet.europa.eu/vocabulary/aq/processparameter/resultformat &
    om:parameter/om:NamedValue/om:value xlink:href attribute attribute shall resolve to  valid code for http://dd.eionet.europa.eu/vocabulary/aq/resultformat/ :)
    let $Eb14invalid :=
        try {
            (let $valid := dd:getValidConcepts($vocabulary:RESULT_FORMAT || "rdf")
            for $x in $docRoot//om:OM_Observation
            let $node := $x/om:parameter/om:NamedValue[om:name/@xlink:href = $vocabulary:PROCESSPARAMETER_RESULTFORMAT]
            let $value := common:if-empty($node/om:value, $node/om:value/@xlink:href)
            where $node => empty() or not($value = $valid)
            return
                <tr>
                    <td title="gml:id">{data($x/@gml:id)}</td>
                    <td title="Result format">{$value}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: IF resultencoding = inline, resultformat can only be http://dd.eionet.europa.eu/vocabulary/aq/resultformat/swe-array
     IF resultencoding = external resultformat can only be http://dd.eionet.europa.eu/vocabulary/aq/resultformat/ascii-grid ,
       http://dd.eionet.europa.eu/vocabulary/aq/resultformat/esri-shp or http://dd.eionet.europa.eu/vocabulary/aq/resultformat/geotiff
    :)
    let $Eb14binvalid :=
        try {
            (let $ir := "http://dd.eionet.europa.eu/vocabulary/aq/resultencoding/inline"
            let $er := "http://dd.eionet.europa.eu/vocabulary/aq/resultencoding/external"
            let $validInline := ($ir || "http://dd.eionet.europa.eu/vocabulary/aq/resultformat/swe-array")
            let $validExternal := ($er || "http://dd.eionet.europa.eu/vocabulary/aq/resultformat/ascii-grid",
            $er || "http://dd.eionet.europa.eu/vocabulary/aq/resultformat/esri-shp", $er || "http://dd.eionet.europa.eu/vocabulary/aq/resultformat/geotiff")
            for $x in $docRoot//om:OM_Observation
            let $encoding := $x/om:parameter/om:NamedValue[om:name/@xlink:href = $vocabulary:PROCESSPARAMETER_RESULTENCODING]
            let $encoding := common:if-empty($encoding/om:value, $encoding/om:value/@xlink:href)
            let $format := $x/om:parameter/om:NamedValue[om:name/@xlink:href = $vocabulary:PROCESSPARAMETER_RESULTFORMAT]
            let $format := common:if-empty($format/om:value, $format/om:value/@xlink:href)
            let $combination := $encoding || $format
            let $condition :=
                if ($encoding = "http://dd.eionet.europa.eu/vocabulary/aq/resultencoding/inline") then
                    $combination = $validInline and exists($x/om:result/swe:DataArray)
                else if ($encoding = "http://dd.eionet.europa.eu/vocabulary/aq/resultencoding/external") then
                    $combination = $validExternal and exists($x/om:result/gml:File)
                else
                    false()
            where not($condition)
            return
                <tr>
                    <td title="gml:id">{data($x/@gml:id)}</td>
                    <td title="Result Encoding">{$encoding}</td>
                    <td title="Result Formatting">{$format}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb15 - IF resultformat is http://dd.eionet.europa.eu/vocabulary/aq/resultformat/swe-array (Eb14) then ./om:result/swe:DataArray/swe:elementType/swe:DataRecord/swe:field name="startTime" attribute THEN
    swe:Time definition=http://www.opengis.net/def/property/OGC/0/SamplingTime swe:uom xlink:href=http://www.opengis.net/def/uom/ISO-8601/0/Gregorian:)
    (: TODO FIX :)
    let $Eb15invalid :=
        try {
            (for $x in $docRoot//om:OM_Observation/om:result[swe:DataArray]//swe:elementType/swe:DataRecord/swe:field[@name = "StartTime"
                    and not(swe:Time[@definition = "http://www.opengis.net/def/property/OGC/0/SamplingTime"]/swe:uom/@xlink:href = "http://www.opengis.net/def/uom/ISO-8601/0/Gregorian")]
            return
                <tr>
                    <td title="@gml:id">{string($x/../../../../../@gml:id)}</td>
                    <td title="swe:uom">{string($x/swe:Time[@definition = "http://www.opengis.net/def/property/OGC/0/SamplingTime"]/swe:uom/@xlink:href)}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb16 - IF resultformat is http://dd.eionet.europa.eu/vocabulary/aq/resultformat/swe-array (Eb14) then ./om:result/swe:DataArray/swe:elementType/swe:DataRecord/swe:field name="endTime" attribute THEN
    swe:Time definition=http://www.opengis.net/def/property/OGC/0/SamplingTime swe:uom xlink:href=http://www.opengis.net/def/uom/ISO-8601/0/Gregorian :)
    let $Eb16invalid :=
        try {
            (for $x in $docRoot//om:OM_Observation/om:result[swe:DataArray]//swe:elementType/swe:DataRecord/swe:field[@name = "EndTime"
                    and not(swe:Time[@definition = "http://www.opengis.net/def/property/OGC/0/SamplingTime"]/swe:uom/@xlink:href = "http://www.opengis.net/def/uom/ISO-8601/0/Gregorian")]
            return
                <tr>
                    <td title="@gml:id">{string($x/../../../../../@gml:id)}</td>
                    <td title="swe:uom">{string($x/swe:Time[@definition = "http://www.opengis.net/def/property/OGC/0/SamplingTime"]/swe:uom/@xlink:href)}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb17 - IF resultformat is http://dd.eionet.europa.eu/vocabulary/aq/resultformat/swe-array (Eb14) then ./om:result/swe:DataArray/swe:elementType/swe:DataRecord/swe:field name="validity" attribute THEN
     swe:Category definition is defined by http://dd.eionet.europa.eu/vocabulary/aq/observationvalidity:)
    let $Eb17invalid :=
        try {
            (for $x in $docRoot//om:OM_Observation/om:result[swe:DataArray]//swe:elementType/swe:DataRecord/swe:field[@name="Validity"
                    and not(swe:Category/@definition = "http://dd.eionet.europa.eu/vocabulary/aq/observationvalidity")]
            return
                <tr>
                    <td title="@gml:id">{string($x/../../../../../@gml:id)}</td>
                    <td title="swe:Category">{string($x/swe:Category/@definition)}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }
    (: Eb18 - IF resultformat is http://dd.eionet.europa.eu/vocabulary/aq/resultformat/swe-array (Eb14) then ./om:result/swe:DataArray/swe:elementType/swe:DataRecord/swe:field name="verification" attribute THEN
     swe:Category definition is defined by http://dd.eionet.europa.eu/vocabulary/aq/observationverification :)
    let $Eb18invalid :=
        try {
            (for $x in $docRoot//om:OM_Observation/om:result[swe:DataArray]//swe:elementType/swe:DataRecord/swe:field[@name = "Verification"
                    and not(swe:Category/@definition = $vocabulary:BASE || "observationverification")]
            return
                <tr>
                    <td title="@gml:id">{string($x/../../../../../@gml:id)}</td>
                    <td title="swe:Category">{string($x/swe:Category/@definition)}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }
    (: Eb19 - IF resultformat is http://dd.eionet.europa.eu/vocabulary/aq/resultformat/swe-array (Eb14) then ./om:result/swe:DataArray/swe:elementType/swe:DataRecord/swe:field name="Value" attribute THEN swe:Quantity definition is defined by
    http://dd.eionet.europa.eu/vocabulary/aq/primaryObservation/[code] or http://dd.eionet.europa.eu/vocabulary/aq/aggregationprocess/[code] & the swe:uom resolves to an xlink to http://dd.eionet.europa.eu/vocabulary/uom/concentration/[code]:)
    let $Eb19invalid :=
        try {
            (let $defs := (dd:getValidConceptsLC($vocabulary:OBSERVATIONS_PRIMARY || "rdf"), dd:getValidConceptsLC($vocabulary:AGGREGATION_PROCESS || "rdf"))
            let $cons := dd:getValidConceptsLC($vocabulary:UOM_CONCENTRATION_VOCABULARY || "rdf")
            for $x in $docRoot//om:OM_Observation/om:result[swe:DataArray]//swe:elementType/swe:DataRecord/swe:field[@name = "Value"
                    and (not(swe:Quantity/lower-case(@definition) = $defs) or not(swe:Quantity/swe:uom/lower-case(@xlink:href) = $cons))]
            return
                <tr>
                    <td title="@gml:id">{string($x/../../../../../@gml:id)}</td>
                    <td title="swe:Quantity">{string($x/swe:Quantity/@definition)}</td>
                    <td title="swe:uom">{string($x/swe:Quantity/swe:uom/@xlink:href)}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb19b - Check if the unit of measure reporting via (swe:uom) corresponds to the recommended unit of measure in vocabulary
     http://dd.eionet.europa.eu/vocabulary/uom/concentration/[code] depending on pollutant reported via /om:observedProperty :)
    let $Eb19binvalid :=
        try {
            (for $x in $docRoot//om:OM_Observation/om:result[swe:DataArray]
            let $pollutant := string($x/../om:observedProperty/@xlink:href)
            let $value := string($x//swe:field[@name = 'Value']/swe:Quantity/swe:uom/@xlink:href)
            let $recommended := dd:getRecommendedUnit($pollutant)
            where not($value = $recommended)
            return
                <tr>
                    <td title="om:OM_Observation">{data($x/../@gml:id)}</td>
                    <td title="Pollutant">{$pollutant}</td>
                    <td title="Recommended Unit">{$recommended}</td>
                    <td title="swe:uom">{$value}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb20 - IF resultformat is http://dd.eionet.europa.eu/vocabulary/aq/resultformat/swe-array (Eb14) then a fifth element might be included. IF ./om:result/swe:DataArray/swe:elementType/swe:DataRecord/swe:field name="DataCapture" attribute THEN swe:Category definition is defined by
     http://dd.eionet.europa.eu/vocabulary/aq/primaryObservation/dc & the swe:uom resolves to an xlink to http://dd.eionet.europa.eu/vocabulary/uom/statistics/percentage :)
    let $Eb20invalid :=
        try {
            (let $all := $docRoot//om:OM_Observation/om:result[swe:DataArray]//swe:elementType/swe:DataRecord/swe:field[@name="DataCapture"]
            for $x in $all
            let $def := $x/swe:Quantity/@definition/string()
            let $uom := $x/swe:Quantity/swe:uom/@xlink:href/string()
            where (not($def = "http://dd.eionet.europa.eu/vocabulary/aq/primaryObservation/dc") or not($uom = "http://dd.eionet.europa.eu/vocabulary/uom/statistics/percentage"))
            return
                <tr>
                    <td title="@gml:id">{string($x/../../../../../@gml:id)}</td>
                    <td title="@definition">{$def}</td>
                    <td title="@uom">{$uom}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        }
        catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb21 - IF resultformat is http://dd.eionet.europa.eu/vocabulary/aq/resultformat/swe-array (Eb14) then /om:result/swe:DataArray/swe:encoding/swe:TextEncoding shall resolve to decimalSeparator="." tokenSeparator="," blockSeparator="@@" :)
    let $Eb21invalid :=
        try {
            (for $x in $docRoot//om:OM_Observation/om:result[swe:DataArray]//swe:encoding/swe:TextEncoding[not(@decimalSeparator=".") or not(@tokenSeparator=",") or not(@blockSeparator="@@")]
            return
                <tr>
                    <td title="@gml:id">{string($x/../../../../@gml:id)}</td>
                    <td title="@decimalSeparator">{string($x/@decimalSeparator)}</td>
                    <td title="@tokenSeparator">{string($x/@tokenSeparator)}</td>
                    <td title="@blockSeparator">{string($x/@blockSeparator)}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        }
        catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb22 - IF resultformat is http://dd.eionet.europa.eu/vocabulary/aq/resultformat/swe-array (Eb14) then the order of the fields within individual data blocks (swe:values) must correspond to the order described within the swe:DataRecord/swe:field(multiple). :)
    let $Eb22invalid :=
        try {
            (let $validVerifications := dd:getValidNotations($vocabulary:OBSERVATIONS_VERIFICATION || "rdf")
            let $validValidity:= dd:getValidNotations($vocabulary:OBSERVATIONS_VALIDITY || "rdf")
            let $exceptionDataCapture := ("-99", "-999")

            for $x at $xpos in $docRoot//om:OM_Observation/om:result[swe:DataArray]
            let $blockSeparator := string($x//swe:encoding/swe:TextEncoding/@blockSeparator)
            let $decimalSeparator := string($x//swe:encoding/swe:TextEncoding/@decimalSeparator)
            let $tokenSeparator := string($x//swe:encoding/swe:TextEncoding/@tokenSeparator)
            let $fields := data($x//swe:elementType/swe:DataRecord/swe:field/@name)

            for $i at $ipos in tokenize(replace($x//swe:values, $blockSeparator || "$", ""), $blockSeparator)
            for $z at $zpos in tokenize($i, $tokenSeparator)
            let $invalid :=
                if ($fields[$zpos] = ("StartTime", "EndTime")) then if ($z castable as xs:dateTime) then false() else true()
                else if ($fields[$zpos] = "Verification") then if ($z = $validVerifications) then false() else true()
                else if ($fields[$zpos] = "Validity") then if ($z = $validValidity) then false() else true()
                    else if ($fields[$zpos] = "Value") then if ($z = "" or translate($z, "<>=", "") castable as xs:double) then false() else true()
                        else if ($fields[$zpos] = "DataCapture") then if ($z = $exceptionDataCapture or ($z castable as xs:decimal and number($z) >= 0 and number($z) <= 100)) then false() else true()
                            else true()
            where $invalid = true()
            return
                <tr>
                    <td title="OM_Observation">{string($x/../@gml:id)}</td>
                    <td title="Data record position">{$ipos}</td>
                    <td title="Expected type">{$fields[$zpos]}</td>
                    <td title="Actual value">{$z}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb23 - IF resultformat is http://dd.eionet.europa.eu/vocabulary/aq/resultformat/swe-array (Eb14)
     then the count of elements under <swe:elementCount><swe:Count><swe:value> should match the count of data blocks under <swe:values>. :)
    let $Eb23invalid :=
        try {
            (for $x at $xpos in $docRoot//om:OM_Observation/om:result[swe:DataArray]
            let $blockSeparator := string($x//swe:encoding/swe:TextEncoding/@blockSeparator)
            let $decimalSeparator := string($x//swe:encoding/swe:TextEncoding/@decimalSeparator)
            let $tokenSeparator := string($x//swe:encoding/swe:TextEncoding/@tokenSeparator)

            let $actual := count(tokenize(replace($x//swe:values, $blockSeparator || "$", ""), $blockSeparator))
            let $expected := number($x//swe:elementCount/swe:Count/swe:value)
            where not($actual = $expected)
            return
                <tr>
                    <td title="OM_Observation">{string($x/../@gml:id)}</td>
                    <td title="Expected count">{$expected}</td>
                    <td title="Actual count">{$actual}</td>
                </tr>)[position() = 1 to $errors:HIGHER_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb24 - IF resultformat is http://dd.eionet.europa.eu/vocabulary/aq/resultformat/swe-array (Eb14) then difference between endTime & startTime must correspond to the definition under <swe:field name="Value"><swe:Quantity definition=> .Difference between endTime & startTime must correspond to the definition:
    http://dd.eionet.europa.eu/vocabulary/aq/primaryObservation/hour must be 1 h
    http://dd.eionet.europa.eu/vocabulary/aq/primaryObservation/day must be 24 hours
    http://dd.eionet.europa.eu/vocabulary/aq/primaryObservation/year must be 8760 hours or 8784
    http://dd.eionet.europa.eu/vocabulary/aq/primaryObservation/var can be anything :)
    let $Eb24invalid :=
        try {
            (for $x at $xpos in $docRoot//om:OM_Observation/om:result[swe:DataArray//swe:field[@name = "Value"]/swe:Quantity/contains(@definition, $vocabulary:OBSERVATIONS_PRIMARY) = true()]

            let $blockSeparator := string($x//swe:encoding/swe:TextEncoding/@blockSeparator)
            let $decimalSeparator := string($x//swe:encoding/swe:TextEncoding/@decimalSeparator)
            let $tokenSeparator := string($x//swe:encoding/swe:TextEncoding/@tokenSeparator)
            let $definition := $x//swe:field[@name = "Value"]/swe:Quantity/@definition/string()
            let $fields := data($x//swe:elementType/swe:DataRecord/swe:field/@name)

            let $startPos := index-of($fields, "StartTime")
            let $endPos := index-of($fields, "EndTime")

            for $i at $ipos in tokenize(replace($x//swe:values, $blockSeparator || "$", ""), $blockSeparator)
            let $startTime := tokenize($i, $tokenSeparator)[$startPos]
            let $endTime := tokenize($i, $tokenSeparator)[$endPos]
            let $result :=
                if (not($startTime castable as xs:dateTime) or not($endTime castable as xs:dateTime)) then
                    true()
                else
                    let $startDateTime := xs:dateTime($startTime)
                    let $endDateTime := xs:dateTime($endTime)
                    return
                        if ($definition = $vocabulary:OBSERVATIONS_PRIMARY || "hour") then
                            if (($endDateTime - $startDateTime) div xs:dayTimeDuration("PT1H") = 1) then
                                false()
                            else
                                true()
                        else if ($definition = $vocabulary:OBSERVATIONS_PRIMARY || "day") then
                            if (($endDateTime - $startDateTime) div xs:dayTimeDuration("P1D") = 1) then
                                false()
                            else
                                true()
                        else if ($definition = $vocabulary:OBSERVATIONS_PRIMARY || "year") then
                                if (common:isDateTimeDifferenceOneYear($startDateTime, $endDateTime)) then
                                    false()
                                else
                                    true()
                            else if ($definition = $vocabulary:OBSERVATIONS_PRIMARY || "var") then
                                    if (($endDateTime - $startDateTime) div xs:dayTimeDuration("PT1H") > 0) then
                                        false()
                                    else
                                        true()
                                else
                                    false()
            where $result = true()
            return
                <tr>
                    <td title="@gml:id">{string($x/../@gml:id)}</td>
                    <td title="@definition">{$definition}</td>
                    <td title="StartTime">{$startTime}</td>
                    <td title="EndTime">{$endTime}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        }
        catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }
    (: Eb25 - IF resultformat is http://dd.eionet.europa.eu/vocabulary/aq/resultformat/swe-array (Eb14)
     then the temporal envelopes of the swe:values (reported via starTime and EndTime) shall reconcile with ./om:phenomenonTime/gml:TimePeriod/gml:beginPosition :)
    let $Eb25invalid :=
        try {
            (for $x at $xpos in $docRoot//om:OM_Observation/om:result[swe:DataArray]
            let $blockSeparator := string($x//swe:encoding/swe:TextEncoding/@blockSeparator)
            let $decimalSeparator := string($x//swe:encoding/swe:TextEncoding/@decimalSeparator)
            let $tokenSeparator := string($x//swe:encoding/swe:TextEncoding/@tokenSeparator)
            let $fields := data($x//swe:elementType/swe:DataRecord/swe:field/@name)
            let $startPos := index-of($fields, "StartTime")
            let $endPos := index-of($fields, "EndTime")
            let $expectedStart := $x/../om:phenomenonTime/gml:TimePeriod/gml:beginPosition/text()
            let $expectedEnd := $x/../om:phenomenonTime/gml:TimePeriod/gml:endPosition/text()
            return
                try {
                    for $i at $ipos in tokenize(replace($x//swe:values, $blockSeparator || "$", ""), $blockSeparator)
                    let $startTime := tokenize($i, $tokenSeparator)[$startPos]
                    let $endTime := tokenize($i, $tokenSeparator)[$endPos]
                    where not(xs:dateTime($expectedStart) <= xs:dateTime($startTime)) or not(xs:dateTime($expectedEnd) >= xs:dateTime($endTime))
                    return
                        <tr>
                            <td title="@gml:id">{string($x/../@gml:id)}</td>
                            <td title="Data record position">{$ipos}</td>
                            <td title="gml:beginPosition">{$expectedStart}</td>
                            <td title="StartTime">{$startTime}</td>
                            <td title="gml:endPosition">{$expectedEnd}</td>
                            <td title="EndTime">{$endTime}</td>
                        </tr>
                } catch * {
                    <tr class="{$errors:FAILED}">
                        <td title="Error code">{$err:code}</td>
                        <td title="Error description">{$err:description}</td>
                    </tr>
                })[position() = 1 to $errors:HIGHER_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb26 :)
    let $Eb26invalid :=
        try {
            (let $result := sparqlx:run(query:getModelMetadataFromFiles($latestEnvelopeD1b))
            let $resultsConcat :=
                for $x in $result
                return $x/sparql:binding[@name="localId"]/sparql:literal/string() || $x/sparql:binding[@name="procedure"]/sparql:uri/string() ||
                $x/sparql:binding[@name="featureOfInterest"]/sparql:uri/string() || $x/sparql:binding[@name="observedProperty"]/sparql:uri/string()

            for $x in $docRoot//om:OM_Observation
            let $namedValue := $x/om:parameter/om:NamedValue[om:name/@xlink:href = ($vocabulary:PROCESS_PARAMETER || "model", $vocabulary:PROCESS_PARAMETER || "objective")]
            let $model := tokenize(common:if-empty($namedValue/om:value, $namedValue/om:value/@xlink:href), "/")[last()]
            let $procedure := $x/om:procedure/@xlink:href/string()
            let $procedure :=
                if (not($procedure = "") and not(starts-with($procedure, "http://"))) then
                    "http://reference.eionet.europa.eu/aq/" || $procedure
                else
                    $procedure
            let $featureOfInterest := $x/om:featureOfInterest/@xlink:href/string()
            let $featureOfInterest :=
                if (not($featureOfInterest = "") and not(starts-with($featureOfInterest, "http://"))) then
                    "http://reference.eionet.europa.eu/aq/" || $featureOfInterest
                else
                    $featureOfInterest
            let $observedProperty := $x/om:observedProperty/@xlink:href/string()
            let $concat := $model || $procedure || $featureOfInterest || $observedProperty
            where not($concat = $resultsConcat)
            return
                <tr>
                    <td title="om:OM_Observation">{string($x/@gml:id)}</td>
                    <td title="aqd:AQD_Model">{string($model)}</td>
                    <td title="aqd:AQD_ModelProcess">{$procedure}</td>
                    <td title="aqd:AQD_ModelArea">{$featureOfInterest}</td>
                    <td title="Pollutant">{$observedProperty}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        }
        catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb27 -  IF resultformat is http://dd.eionet.europa.eu/vocabulary/aq/resultformat/swe-array (Eb14) then check that all values (between @@) include as many fields as declared under swe:DataRecord :)
    let $Eb27invalid :=
        try {
            (for $x at $xpos in $docRoot//om:OM_Observation/om:result[swe:DataArray]
            let $blockSeparator := string($x//swe:encoding/swe:TextEncoding/@blockSeparator)
            let $decimalSeparator := string($x//swe:encoding/swe:TextEncoding/@decimalSeparator)
            let $tokenSeparator := string($x//swe:encoding/swe:TextEncoding/@tokenSeparator)
            let $validCount := count($x//swe:elementType/swe:DataRecord/swe:field)

            for $i at $ipos in tokenize(replace($x//swe:values, $blockSeparator || "$", ""), $blockSeparator)
            let $count := count(tokenize($i, $tokenSeparator))
            where not($count = $validCount)
            return
                <tr>
                    <td title="OM_Observation">{string($x/../@gml:id)}</td>
                    <td title="Data record position">{$ipos}</td>
                    <td title="Expected fields">{$validCount}</td>
                    <td title="Actual fields">{$count}</td>
                </tr>)[position() = 1 to $errors:HIGHER_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb28 - IF resultformat is http://dd.eionet.europa.eu/vocabulary/aq/resultformat/swe-array (Eb14) then the data array should not end with "@@". Please note that @@ is a block separator. :)
    let $Eb28invalid :=
        try {
            (for $x at $xpos in $docRoot//om:OM_Observation/om:result[swe:DataArray]
            let $blockSeparator := string($x//swe:encoding/swe:TextEncoding/@blockSeparator)
            where ends-with($x//swe:values, $blockSeparator)
            return
                <tr>
                    <td title="OM_Observation">{string($x/../@gml:id)}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb29 - IF resultformat is http://dd.eionet.europa.eu/vocabulary/aq/resultformat/swe-array (Eb14) then check for unexpected spaces  around all values (between comma separator) under swe:values :)
    let $Eb29invalid :=
        try {
            (for $x at $xpos in $docRoot//om:OM_Observation/om:result[swe:DataArray]
            let $blockSeparator := string($x//swe:encoding/swe:TextEncoding/@blockSeparator)
            let $decimalSeparator := string($x//swe:encoding/swe:TextEncoding/@decimalSeparator)
            let $tokenSeparator := string($x//swe:encoding/swe:TextEncoding/@tokenSeparator)
            let $fields := data($x//swe:elementType/swe:DataRecord/swe:field/@name)

            for $i at $ipos in tokenize(replace($x//swe:values, $blockSeparator || "$", ""), $blockSeparator)
            for $z at $zpos in tokenize($i, $tokenSeparator)
            where matches($z, "\s+")
            return
                <tr>
                    <td title="OM_Observation">{string($x/../@gml:id)}</td>
                    <td title="Data record position">{$ipos}</td>
                    <td title="Expected type">{$fields[$zpos]}</td>
                    <td title="Actual value">{$z}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb31 - IF resultformat is http://dd.eionet.europa.eu/vocabulary/aq/resultformat/swe-array (Eb14) then check for date overlaps
     between consecutive data blocks within swe:values :)
    let $Eb31invalid :=
        try {
            (let $valid := dd:getValid($vocabulary:OBSERVATIONS_RANGE)

            for $x at $xpos in $docRoot//om:OM_Observation/om:result[swe:DataArray]
            let $blockSeparator := string($x//swe:encoding/swe:TextEncoding/@blockSeparator)
            let $decimalSeparator := string($x//swe:encoding/swe:TextEncoding/@decimalSeparator)
            let $tokenSeparator := string($x//swe:encoding/swe:TextEncoding/@tokenSeparator)
            let $fields := data($x//swe:elementType/swe:DataRecord/swe:field/@name)

            let $definition := $x//swe:field[@name = "Value"]/swe:Quantity/@definition/string()
            let $uom := $x//swe:field[@name = "Value"]/swe:Quantity/swe:uom/@xlink:href/string()
            let $pollutant := $x/../om:observedProperty/@xlink:href/string()
            let $minValue := $valid[prop:recommendedUnit/@rdf:resource = $uom and prop:relatedPollutant/@rdf:resource = $pollutant and prop:primaryObservationTime/@rdf:resource = $definition]/prop:minimumValue/string()
            let $maxValue := $valid[prop:recommendedUnit/@rdf:resource = $uom and prop:relatedPollutant/@rdf:resource = $pollutant and prop:primaryObservationTime/@rdf:resource = $definition]/prop:maximumValue/string()
            where ($minValue castable as xs:double and $maxValue castable as xs:double)

            for $i at $ipos in tokenize(replace($x//swe:values, $blockSeparator || "$", ""), $blockSeparator)
            let $tokens := tokenize($i, $tokenSeparator)
            let $validity := $tokens[index-of($fields, "Validity")]
            let $value := $tokens[index-of($fields, "Value")]
            where (($validity castable as xs:integer) and xs:integer($validity) >= 1) and (not($value castable as xs:double) or (xs:double($value) < xs:double($minValue)) or (xs:double($value) > xs:double($maxValue)))
            return
                <tr>
                    <td title="OM_Observation">{string($x/../@gml:id)}</td>
                    <td title="Data record position">{$ipos}</td>
                    <td title="Pollutant">{tokenize($pollutant, "/")[last()]}</td>
                    <td title="Concentration">{tokenize($uom, "/")[last()]}</td>
                    <td title="Primary Observation">{tokenize($definition, "/")[last()]}</td>
                    <td title="Minimum value">{$minValue}</td>
                    <td title="Maximum value">{$maxValue}</td>
                    <td title="Actual value">{$value}</td>
                </tr>)[position() = 1 to $errors:MAX_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb32 - IF resultformat is http://dd.eionet.europa.eu/vocabulary/aq/resultformat/swe-array (Eb14) then check that all data submitted via CDR has been fully verified. The verification flag must be 1 for all data. :)
    let $Eb32invalid :=
        try {
            (for $x at $xpos in $docRoot//om:OM_Observation/om:result[swe:DataArray]

            let $blockSeparator := string($x//swe:encoding/swe:TextEncoding/@blockSeparator)
            let $decimalSeparator := string($x//swe:encoding/swe:TextEncoding/@decimalSeparator)
            let $tokenSeparator := string($x//swe:encoding/swe:TextEncoding/@tokenSeparator)
            let $fields := data($x//swe:elementType/swe:DataRecord/swe:field/@name)

            let $startPos := index-of($fields, "StartTime")
            let $endPos := index-of($fields, "EndTime")

            let $startTimes := for $i in tokenize(replace($x//swe:values, $blockSeparator || "$", ""), $blockSeparator)
            return tokenize($i, $tokenSeparator)[$startPos]
            let $endTimes := for $i in tokenize(replace($x//swe:values, $blockSeparator || "$", ""), $blockSeparator)
            return tokenize($i, $tokenSeparator)[$endPos]
            return try {
                for $startTime at $ipos in $startTimes
                let $prevStartTime := $startTimes[$ipos - 1]
                let $endTime := $endTimes[$ipos]
                let $prevEndTime := $endTimes[$ipos - 1]
                where not($ipos = 1) and (xs:dateTime($startTime) < xs:dateTime($prevEndTime))
                return
                    <tr>
                        <td title="@gml:id">{string($x/../@gml:id)}</td>
                        <td title="Data record position">{$ipos}</td>
                        <td title="StartTime">{$startTime}</td>
                        <td title="Previous endTime">{$prevEndTime}</td>
                    </tr>
            } catch * {
                <tr class="{$errors:FAILED}">
                    <td title="Error code">{$err:code}</td>
                    <td title="Error description">{$err:description}</td>
                </tr>
            })[position() = 1 to $errors:MEDIUM_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb35 - IF resultformat is ascii-grid ;  esri-shp or geotiff (Eb14) then ./om:result/gml:File/gml:rangeParameters MUST be populated :)
    let $Eb35invalid :=
        try {
            (for $x in $docRoot//om:OM_Observation/om:result[gml:File]
                let $files := $x/gml:File/gml:rangeParameters
                where $files/* => empty()
                return
                <tr>
                    <td title="@gml:id">{string($x/../@gml:id)}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb36 - IF resultformat is ascii-grid ;  esri-shp or geotiff (Eb14) then ./om:result/gml:File/gml:rangeParameters/swe:Quantity@Definition MUST match a code under
     http://dd.eionet.europa.eu/vocabulary/aq/aggregationprocess/ :)
    let $Eb36invalid :=
        try {
            (let $valid := dd:getValidConcepts($vocabulary:AGGREGATION_PROCESS || "rdf")
            for $x in $docRoot//om:OM_Observation/om:result[gml:File]
            let $definition := $x/gml:File/gml:rangeParameters/swe:Quantity/@definition/string()
            where not($definition = $valid)
            return
                <tr>
                    <td title="@gml:id">{string($x/../@gml:id)}</td>
                    <td title="Definition">{$definition}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb37 - IF resultformat is ascii-grid ;  esri-shp or geotiff (Eb14) then ./om:result/gml:File/gml:rangeParameters/swe:label should be populated :)
    let $Eb37invalid :=
        try {
            (for $x in $docRoot//om:OM_Observation/om:result[gml:File]
            let $label:= $x/gml:File/gml:rangeParameters/swe:Quantity/swe:label
            where ($label => empty())
            return
                <tr>
                    <td title="@gml:id">{string($x/../@gml:id)}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb38 - IF resultformat is ascii-grid ;  esri-shp or geotiff (Eb14) then ./om:result/gml:File/gml:rangeParameters/swe:description MUST be provided :)
    let $Eb38invalid :=
        try {
            (for $x in $docRoot//om:OM_Observation/om:result[gml:File]
            let $description:= $x/gml:File/gml:rangeParameters/swe:Quantity/swe:description
            where ($description => empty())
            return
                <tr>
                    <td title="@gml:id">{string($x/../@gml:id)}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb39 - IF resultformat is ascii-grid ;  esri-shp or geotiff (Eb14) then ./om:result/gml:File/gml:rangeParameters/swe:uom xlink
     MUST match a code under http://dd.eionet.europa.eu/vocabulary/uom/concentration/ :)
    let $Eb39invalid :=
        try {
            (let $valid := (dd:getValidConcepts($vocabulary:UOM_CONCENTRATION_VOCABULARY || "rdf"), dd:getValidConcepts($vocabulary:UOM_STATISTICS || "rdf"))
            for $x in $docRoot//om:OM_Observation/om:result[gml:File]
            let $xlink := $x/gml:File/gml:rangeParameters/swe:Quantity/swe:uom/@xlink:href
            where not($xlink = $valid)
            return
                <tr>
                    <td title="@gml:id">{string($x/../@gml:id)}</td>
                    <td title="swe:uom">{$xlink => string()}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb40 - Check if the unit of measure reporting via (/om:result/gml:File/gml:rangeParameters/swe:uom) corresponds to the recommended unit of measure in
    vocabulary http://dd.eionet.europa.eu/vocabulary/uom/concentration/[code] depending on pollutant reported via /om:observedProperty :)
    let $Eb40invalid :=
        try {
            (let $valid := dd:getValidConcepts($vocabulary:UOM_CONCENTRATION_VOCABULARY || "rdf")
            for $x in $docRoot//om:OM_Observation/om:result[gml:File]
            let $observedProperty := $x/om:observedProperty
            let $xlink := $x/gml:File/gml:rangeParameters/swe:Quantity/swe:uom/@xlink:href
            let $condition1 := not(contains($xlink, $vocabulary:UOM_STATISTICS))
            where $condition1 and not($xlink = $valid)
            return
                <tr>
                    <td title="@gml:id">{string($x/../@gml:id)}</td>
                    <td title="swe:uom">{$xlink => string()}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }
    (: Eb41 - IF resultformat is ascii-grid ;  esri-shp or geotiff (Eb14) then ./om:result/gml:File/gml:fileReference MUST be provided :)
    let $Eb41invalid :=
        try {
            (for $x in $docRoot//om:OM_Observation/om:result[gml:File]
            let $reference := $x/gml:File/gml:fileReference
            where $reference => empty()
            return
                <tr>
                    <td title="@gml:id">{string($x/../@gml:id)}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: Eb42 - ./om:result/gml:File/gml:fileReference MUST provide appropiate reference following this format:
        A valid cdr URL matching the cdr location where the XML files is located  (e.g. http://cdr.eionet.europa.eu/es/eu/aqd/e1b/.../)
        +
        File including extension (e.g. model.zip)
        +
        Variable using a # (e.g. #no2) :)
    let $Eb42invalid :=
        try {
            (let $regex := functx:escape-for-regex($cdrUrl || "e1b") || ".+\.[a-z]{3,3}#.*"
            for $x in $docRoot//om:OM_Observation/om:result[gml:File]
            let $reference := $x/gml:File/gml:fileReference
            where not(matches($reference, $regex))
            return
                <tr>
                    <td title="@gml:id">{string($x/../@gml:id)}</td>
                    <td title="gml:fileReference">{$reference => string()}</td>
                </tr>)[position() = 1 to $errors:MEDIUM_LIMIT]
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    return
        <table class="maintable hover">
            {html:build2("NS", $labels:NAMESPACES, $labels:NAMESPACES_SHORT, $NSinvalid, "All values are valid", "record", $errors:NS)}
            {html:build3("Eb0", $labels:Eb0, $labels:Eb0_SHORT, $Eb0table, data($Eb0table/td), errors:getMaxError($Eb0table))}
            {html:build1("Eb01", $labels:Eb01, $labels:Eb01_SHORT, $Eb01table, "", string(count($Eb01table)), "record", "", $errors:Eb01)}
            {html:build2("Eb02", $labels:Eb02, $labels:Eb02_SHORT, $Eb02invalid, "All records are valid", "record", $errors:Eb02)}
            {html:build2("Eb03", $labels:Eb03, $labels:Eb03_SHORT, $Eb03invalid, "All records are valid", "record", $errors:Eb03)}
            {html:build2("Eb04", $labels:Eb04, $labels:Eb04_SHORT, $Eb04invalid, "All records are valid", "record", $errors:Eb04)}
            {html:build2("Eb05", $labels:Eb05, $labels:Eb05_SHORT, $Eb05invalid, "All records are valid", "record", $errors:Eb05)}
            {html:build2("Eb06", $labels:Eb06, $labels:Eb06_SHORT, $Eb06invalid, "All records are valid", "record", $errors:Eb06)}
            {html:build2("Eb07", $labels:Eb07, $labels:Eb07_SHORT, $Eb07invalid, "All records are valid", "record", $errors:Eb07)}
            {html:build2("Eb08", $labels:Eb08, $labels:Eb08_SHORT, $Eb08invalid, "All records are valid", "record", $errors:Eb08)}
            {html:build2("Eb09", $labels:Eb09, $labels:Eb09_SHORT, $Eb09invalid, "All records are valid", "record", $errors:Eb09)}
            {html:build2("Eb10", $labels:Eb10, $labels:Eb10_SHORT, $Eb10invalid, "All records are valid", "record", $errors:Eb10)}
            {html:build2("Eb13", $labels:Eb13, $labels:Eb13_SHORT, $Eb13invalid, "All records are valid", "record", $errors:Eb13)}
            {html:build2("Eb14", $labels:Eb14, $labels:Eb14_SHORT, $Eb14invalid, "All records are valid", "record", $errors:Eb14)}
            {html:build2("Eb14b", $labels:Eb14b, $labels:Eb14b_SHORT, $Eb14binvalid, "All records are valid", "record", $errors:Eb14b)}
            {html:build2("Eb15", $labels:Eb15, $labels:Eb15_SHORT, $Eb15invalid, "All records are valid", "record", $errors:Eb15)}
            {html:build2("Eb16", $labels:Eb16, $labels:Eb16_SHORT, $Eb16invalid, "All records are valid", "record", $errors:Eb16)}
            {html:build2("Eb17", $labels:Eb17, $labels:Eb17_SHORT, $Eb17invalid, "All records are valid", "record", $errors:Eb17)}
            {html:build2("Eb18", $labels:Eb18, $labels:Eb18_SHORT, $Eb18invalid, "All records are valid", "record", $errors:Eb18)}
            {html:build2("Eb19", $labels:Eb19, $labels:Eb19_SHORT, $Eb19invalid, "All records are valid", "record", $errors:Eb19)}
            {html:build2("Eb19b", $labels:Eb19b, $labels:Eb19b_SHORT, $Eb19binvalid, "All records are valid", "record", $errors:Eb19b)}
            {html:build2("Eb20", $labels:Eb20, $labels:Eb20_SHORT, $Eb20invalid, "All records are valid", "record", $errors:Eb20)}
            {html:build2("Eb21", $labels:Eb21, $labels:Eb21_SHORT, $Eb21invalid, "All records are valid", "record", $errors:Eb21)}
            {html:build2("Eb22", $labels:Eb22, $labels:Eb22_SHORT, $Eb22invalid, "All records are valid", "record", $errors:Eb22)}
            {html:build2("Eb23", $labels:Eb23, $labels:Eb23_SHORT, $Eb23invalid, "All records are valid", "record", $errors:Eb23)}
            {html:build2("Eb24", $labels:Eb24, $labels:Eb24_SHORT, $Eb24invalid, "All records are valid", "record", $errors:Eb24)}
            {html:build2("Eb25", $labels:Eb25, $labels:Eb25_SHORT, $Eb25invalid, "All records are valid", "record", $errors:Eb25)}
            {html:build2("Eb26", $labels:Eb26, $labels:Eb26_SHORT, $Eb26invalid, "All records are valid", "record", $errors:Eb26)}
            {html:build2("Eb27", $labels:Eb27, $labels:Eb27_SHORT, $Eb27invalid, "All records are valid", "record", $errors:Eb27)}
            {html:build2("Eb28", $labels:Eb28, $labels:Eb28_SHORT, $Eb28invalid, "All records are valid", "record", $errors:Eb28)}
            {html:build2("Eb29", $labels:Eb29, $labels:Eb29_SHORT, $Eb29invalid, "All records are valid", "record", $errors:Eb29)}
            {html:build2("Eb31", $labels:Eb31, $labels:Eb31_SHORT, $Eb31invalid, "All records are valid", "record", $errors:Eb31)}
            {html:build2("Eb32", $labels:Eb32, $labels:Eb32_SHORT, $Eb32invalid, "All records are valid", "record", $errors:Eb32)}
            {html:build2("Eb35", $labels:Eb35, $labels:Eb35_SHORT, $Eb35invalid, "All records are valid", "record", $errors:Eb35)}
            {html:build2("Eb36", $labels:Eb36, $labels:Eb36_SHORT, $Eb36invalid, "All records are valid", "record", $errors:Eb36)}
            {html:build2("Eb37", $labels:Eb37, $labels:Eb37_SHORT, $Eb37invalid, "All records are valid", "record", $errors:Eb37)}
            {html:build2("Eb38", $labels:Eb38, $labels:Eb38_SHORT, $Eb38invalid, "All records are valid", "record", $errors:Eb38)}
            {html:build2("Eb39", $labels:Eb39, $labels:Eb39_SHORT, $Eb39invalid, "All records are valid", "record", $errors:Eb39)}
            {html:build2("Eb40", $labels:Eb40, $labels:Eb40_SHORT, $Eb40invalid, "All records are valid", "record", $errors:Eb40)}
            {html:build2("Eb41", $labels:Eb41, $labels:Eb41_SHORT, $Eb41invalid, "All records are valid", "record", $errors:Eb41)}
            {html:build2("Eb42", $labels:Eb42, $labels:Eb42_SHORT, $Eb42invalid, "All records are valid", "record", $errors:Eb42)}
        </table>

};


declare function dataflowEb:proceed($source_url as xs:string, $countryCode as xs:string) as element(div) {
    let $count := count(doc($source_url)//om:OM_Observation)
    let $result := if ($count > 0) then dataflowEb:checkReport($source_url, $countryCode) else ()
    let $meta := map:merge((
        map:entry("count", $count),
        map:entry("header", "Check air quality observations"),
        map:entry("dataflow", "Dataflow Eb"),
        map:entry("zeroCount", <p>No aqd:OM_Observation elements found in this XML.</p>),
        map:entry("report", <p>This check evaluated the delivery by executing tier-1 tests on air quality observation data in Dataflow E as specified in <a href="http://www.eionet.europa.eu/aqportal/qaqc/">e-reporting QA/QC rules documentation</a>.</p>)
    ))
    return
        html:buildResultDiv($meta, $result)
};
(:
 : Module Name: Implementing Decision 2011/850/EU: AQ info exchange & reporting (Library module)
 :
 : Version:     $Id$
 : Created:     13 September 2013
 : Copyright:   European Environment Agency
 :
 : XQuery script implements dataflow G tier-1 checks as documented in http://taskman.eionet.europa.eu/documents/3 .
 :
 : @author Enriko Käsper
 : small modification added by Jaume Targa (ETC/ACM) to align with QA document
 : @author George Sofianos
 :)




declare variable $dataflowG:ISO2_CODES as xs:string* := ("AL","AT","BA","BE","BG","CH","CY","CZ","DE","DK","DZ","EE","EG","ES","FI",
    "FR","GB","GR","HR","HU","IE","IL","IS","IT","JO","LB","LI","LT","LU","LV","MA","ME","MK","MT","NL","NO","PL","PS","PT",
     "RO","RS","SE","SI","SK","TN","TR","XK","UK");


(: Rule implementations :)
declare function dataflowG:checkReport($source_url as xs:string, $countryCode as xs:string) as element(table) {

let $envelopeUrl := common:getEnvelopeXML($source_url)
let $docRoot := doc($source_url)
let $cdrUrl := common:getCdrUrl($countryCode)
let $modelCdrUrl := if ($countryCode = 'gi') then common:getCdrUrl('gb') else $cdrUrl
let $reportingYear := common:getReportingYear($docRoot)

let $latestEnvelopeByYearB := query:getLatestEnvelope($cdrUrl || "b/", $reportingYear)
let $latestEnvelopeB := query:getLatestEnvelope($cdrUrl || "b/")
let $latestEnvelopeC := query:getLatestEnvelope($cdrUrl || "c/")
let $latestEnvelopeByYearC := query:getLatestEnvelope($cdrUrl || "c/", $reportingYear)
let $latestEnvelopeD := query:getLatestEnvelope($cdrUrl || "d/")
let $latestEnvelopeD1b := query:getLatestEnvelope($cdrUrl || "d1b/", $reportingYear)
let $latestEnvelopeByYearG := query:getLatestEnvelope($cdrUrl || "g/", $reportingYear)

let $latestModels :=
    try {
        let $all := distinct-values(data(sparqlx:run(query:getModel($latestEnvelopeD1b))//sparql:binding[@name = 'inspireLabel']/sparql:literal))
        return if (empty($all)) then distinct-values(data(sparqlx:run(query:getModel($latestEnvelopeD))//sparql:binding[@name = 'inspireLabel']/sparql:literal)) else $all
    } catch * {
        ()
    }

(: GLOBAL variables needed for all checks :)
let $assessmentRegimeIds := distinct-values(data(sparqlx:run(query:getAssessmentRegime($cdrUrl || "c/"))//sparql:binding[@name='inspireLabel']/sparql:literal))
let $assessmentMetadataNamespace := distinct-values(data(sparqlx:run(query:getAssessmentMethods())//sparql:binding[@name='assessmentMetadataNamespace']/sparql:literal))
let $assessmentMetadataId := distinct-values(data(sparqlx:run(query:getAssessmentMethods())//sparql:binding[@name='assessmentMetadataId']/sparql:literal))
let $assessmentMetadata := distinct-values(data(sparqlx:run(query:getAssessmentMethods())//concat(sparql:binding[@name='assessmentMetadataNamespace']/sparql:literal,"/",sparql:binding[@name='assessmentMetadataId']/sparql:literal)))
let $validAssessment :=
    for $x in $docRoot//aqd:AQD_Attainment/aqd:assessment[@xlink:href = $assessmentRegimeIds]
    return $x

let $latestSamplingPoints := data(sparqlx:run(query:getSamplingPoint($latestEnvelopeD))/sparql:binding[@name="inspireLabel"]/sparql:literal)

let $samplingPointAssessmentMetadata :=
    let $results := sparqlx:run(query:getSamplingPointAssessmentMetadata())
    return distinct-values(
            for $i in $results
            return concat($i/sparql:binding[@name='metadataNamespace']/sparql:literal,"/", $i/sparql:binding[@name='metadataId']/sparql:literal)
    )
let $namespaces := distinct-values($docRoot//base:namespace)
let $allAttainments := query:getAllAttainmentIds2($namespaces)

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

(: G0 :)
let $G0table :=
    try {
        if ($reportingYear = "") then
            <tr class="{$errors:ERROR}">
                <td title="Status">Reporting Year is missing.</td>
            </tr>
        else if (query:deliveryExists($dataflowG:OBLIGATIONS, $countryCode, "g/", $reportingYear)) then
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
let $isNewDelivery := errors:getMaxError($G0table) = $errors:INFO
let $knownAttainments :=
    if ($isNewDelivery) then
        distinct-values(data(sparqlx:run(query:getAttainment($cdrUrl || "g/"))//sparql:binding[@name='inspireLabel']/sparql:literal))
    else
        distinct-values(data(sparqlx:run(query:getAttainment($latestEnvelopeByYearG))//sparql:binding[@name='inspireLabel']/sparql:literal))

(: G01 :)
let $countAttainments := count($docRoot//aqd:AQD_Attainment)
let $tblAllAttainments :=
    try {
        for $rec in $docRoot//aqd:AQD_Attainment
        return
            <tr>
                <td title="gml:id">{data($rec/@gml:id)}</td>
                <td title="base:localId">{data($rec/aqd:inspireId/base:Identifier/base:localId)}</td>
                <td title="base:namespace">{data($rec/aqd:inspireId/base:Identifier/base:namespace)}</td>
                <td title="aqd:zone">{common:checkLink(data($rec/aqd:zone/@xlink:href))}</td>
                <td title="aqd:pollutant">{common:checkLink(data($rec/aqd:pollutant/@xlink:href))}</td>
                <td title="aqd:protectionTarget">{common:checkLink(data($rec/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:protectionTarget/@xlink:href))}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G02 :)
let $G02table :=
    try {
        for $x in $docRoot//aqd:AQD_Attainment
        let $inspireId := concat(data($x/aqd:inspireId/base:Identifier/base:namespace), "/", data($x/aqd:inspireId/base:Identifier/base:localId))
        where (not($inspireId = $knownAttainments))
        return
            <tr>
                <td title="gml:id">{data($x/@gml:id)}</td>
                <td title="aqd:inspireId">{$inspireId}</td>
                <td title="aqd:pollutant">{common:checkLink(distinct-values(data($x/aqd:pollutant/@xlink:href)))}</td>
                <td title="aqd:objectiveType">{common:checkLink(distinct-values(data($x/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:objectiveType/@xlink:href)))}</td>
                <td title="aqd:reportingMetric">{common:checkLink(distinct-values(data($x/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:reportingMetric/@xlink:href)))}</td>
                <td title="aqd:protectionTarget">{common:checkLink(distinct-values(data($x/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:protectionTarget/@xlink:href)))}</td>
                <td title="aqd:zone">{common:checkLink(distinct-values(data($x/aqd:zone/@xlink:href)))}</td>
                <td title="aqd:assessment">{common:checkLink(distinct-values(data($x/aqd:assessment/@xlink:href)))}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
let $G02errorLevel :=
    if ($isNewDelivery and count(
        for $x in $docRoot//aqd:AQD_Attainment
            let $id := $x/aqd:inspireId/base:Identifier/base:namespace || "/" || $x/aqd:inspireId/base:Identifier/base:localId
        where ($allAttainments = $id)
        return 1) > 0) then
            $errors:G02
        else
            $errors:INFO

(: G03 - :)
let $G03table :=
    try {
        for $x in $docRoot//aqd:AQD_Attainment
        let $inspireId := data($x/aqd:inspireId/base:Identifier/base:namespace) ||  "/" || data($x/aqd:inspireId/base:Identifier/base:localId)
        where ($inspireId = $knownAttainments)
        return
            <tr>
                <td title="gml:id">{data($x/@gml:id)}</td>
                <td title="aqd:inspireId">{$inspireId}</td>
                <td title="aqd:pollutant">{common:checkLink(distinct-values(data($x/aqd:pollutant/@xlink:href)))}</td>
                <td title="aqd:objectiveType">{common:checkLink(distinct-values(data($x/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:objectiveType/@xlink:href)))}</td>
                <td title="aqd:reportingMetric">{common:checkLink(distinct-values(data($x/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:reportingMetric/@xlink:href)))}</td>
                <td title="aqd:protectionTarget">{common:checkLink(distinct-values(data($x/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:protectionTarget/@xlink:href)))}</td>
                <td title="aqd:zone">{common:checkLink(distinct-values(data($x/aqd:zone/@xlink:href)))}</td>
                <td title="aqd:assessment">{common:checkLink(distinct-values(data($x/aqd:assessment/@xlink:href)))}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
let $G03errorLevel :=
    if (not($isNewDelivery) and count($G03table) = 0)  then
        $errors:G03
    else
        $errors:INFO

(: G04 - :)
let $G04table :=
    try {
        let $gmlIds := $docRoot//aqd:AQD_Attainment/lower-case(normalize-space(@gml:id))
        let $inspireIds := $docRoot//aqd:AQD_Attainment/lower-case(normalize-space(aqd:inspireId))
        for $x in $docRoot//aqd:AQD_Attainment
            let $id := $x/@gml:id
            let $inspireId := $x/aqd:inspireId
            let $aqdinspireId := concat($x/aqd:inspireId/base:Identifier/base:localId, "/", $x/aqd:inspireId/base:Identifier/base:namespace)
        where count(index-of($gmlIds, lower-case(normalize-space($id)))) = 1
                    and count(index-of($inspireIds, lower-case(normalize-space($inspireId)))) = 1
        return
            <tr>
                <td title="gml:id">{distinct-values($x/@gml:id)}</td>
                <td title="aqd:inspireId">{distinct-values($aqdinspireId)}</td>
                <td title="aqd:pollutant">{common:checkLink(distinct-values(data($x/aqd:pollutant/@xlink:href)))}</td>
                <td title="aqd:objectiveType">{common:checkLink(distinct-values(data($x/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:objectiveType/@xlink:href)))}</td>
                <td title="aqd:reportingMetric">{common:checkLink(distinct-values(data($x/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:reportingMetric/@xlink:href)))}</td>
                <td title="aqd:protectionTarget">{common:checkLink(distinct-values(data($x/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:protectionTarget/@xlink:href)))}</td>
                <td title="aqd:zone">{common:checkLink(distinct-values(data($x/aqd:zone/@xlink:href)))}</td>
                <td title="aqd:assessment">{common:checkLink(distinct-values(data($x/aqd:assessment/@xlink:href)))}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G05 Compile & feedback a list of the exceedances situations based on the content of ./aqd:zone, ./aqd:pollutant, ./aqd:objectiveType, ./aqd:reportingMetric,
   ./aqd:protectionTarget, aqd:exceedanceDescription_Final/aqd:ExceedanceDescription/aqd:exceedance :)
let $G05table :=
    try {
        for $rec in $docRoot//aqd:AQD_Attainment[aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:exceedance = "true"]
        return
            <tr>
                <td title="aqd:zone">{common:checkLink(data($rec/aqd:zone/@xlink:href))}</td>
                <td title="aqd:pollutant">{common:checkLink(data($rec/aqd:pollutant/@xlink:href))}</td>
                <td title="aqd:objectiveType">{common:checkLink(data($rec/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:objectiveType/@xlink:href))}</td>
                <td title="aqd:reportingMetric">{common:checkLink(data($rec/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:reportingMetric/@xlink:href))}</td>
                <td title="aqd:protectionTarget">{common:checkLink(data($rec/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:protectionTarget/@xlink:href))}</td>
                <td title="aqd:exceedance">{data($rec/aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:exceedance)}</td>
                <td title="aqd:numberExceedances">{data($rec/aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:numberExceedances)}</td>
                <td title="aqd:numericalExceedance">{data($rec/aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:numericalExceedance)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G06 :)
let $G06table :=
    try {
        let $errorClass := if (number($reportingYear) >= 2015) then $errors:G06 else $errors:INFO
        for $rec in $docRoot//aqd:AQD_Attainment[aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:objectiveType/@xlink:href = "http://dd.eionet.europa.eu/vocabulary/aq/objectivetype/LVmaxMOT"]
        return
            <tr class="{$errorClass}">
                <td title="aqd:zone">{common:checkLink(data($rec/aqd:zone/@xlink:href))}</td>
                <td title="aqd:inspireId">{common:checkLink(data(concat($rec/aqd:inspireId/base:Identifier/base:localId, "/", $rec/aqd:inspireId/base:Identifier/base:namespace)))}</td>
                <td title="aqd:pollutant">{common:checkLink(data($rec/aqd:pollutant/@xlink:href))}</td>
                <td title="aqd:objectiveType">{common:checkLink(data($rec/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:objectiveType/@xlink:href))}</td>
                <td title="aqd:reportingMetric">{common:checkLink(data($rec/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:reportingMetric/@xlink:href))}</td>
                <td title="aqd:protectionTarget">{common:checkLink(data($rec/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:protectionTarget/@xlink:href))}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G07 duplicate @gml:ids and aqd:inspireIds and ef:inspireIds :)
(: Feedback report shall include the gml:id attribute, ef:inspireId, aqd:inspireId, ef:name and/or ompr:name elements as available. :)
let $G07invalid :=
    try {
        let $gmlIds := $docRoot//aqd:AQD_Attainment/lower-case(normalize-space(@gml:id))
        let $inspireIds := $docRoot//aqd:AQD_Attainment/lower-case(normalize-space(aqd:inspireId))
        let $efInspireIds := $docRoot//aqd:AQD_Attainment/lower-case(normalize-space(ef:inspireId))
        let $invalidDuplicateGmlIds :=
            for $attainment in $docRoot//aqd:AQD_Attainment
            let $id := $attainment/@gml:id
            let $inspireId := $attainment/aqd:inspireId
            let $efInspireId := $attainment/ef:inspireId
            where count(index-of($gmlIds, lower-case(normalize-space($id)))) > 1
                    or count(index-of($inspireIds, lower-case(normalize-space($inspireId)))) > 1
                    or (count(index-of($efInspireIds, lower-case(normalize-space($efInspireId)))) > 1 and not(empty($efInspireId)))
            return
                $attainment
        for $rec in $invalidDuplicateGmlIds
        return
            <tr>
                <td title="gml:id">{data($rec/@gml:id)}</td>
                <td title="base:localId">{data($rec/aqd:inspireId/base:Identifier/base:localId)}</td>
                <td title="base:namespace">{data($rec/aqd:inspireId/base:Identifier/base:namespace)}</td>
                <td title="base:versionId">{data($rec/aqd:inspireId/base:Identifier/base:versionId)}</td>
                <td title="base:localId">{data($rec/ef:inspireId/base:Identifier/base:localId)}</td>
                <td title="base:namespace">{data($rec/ef:inspireId/base:Identifier/base:namespace)}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G08 ./aqd:inspireId/base:Identifier/base:localId shall be an unique code for the attainment records starting with ISO2-country code :)
let $G08invalid :=
    try {
        let $localIds :=  $docRoot//aqd:AQD_Attainment/aqd:inspireId/base:Identifier/lower-case(normalize-space(base:localId))
        for $rec in $docRoot//aqd:AQD_Attainment/aqd:inspireId/base:Identifier
        let $id := $rec/lower-case(normalize-space(base:localId))
        where (count(index-of($localIds, lower-case(normalize-space($id)))) > 1 and not(empty($id)))
        return
            <tr>
                <td title="gml:id">{data($rec/../../@gml:id)}</td>
                <td title="base:localId">{data($rec/base:localId)}</td>
                <td title="base:namespace">{data($rec/base:namespace)}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G09 ./ef:inspireId/base:Identifier/base:namespace shall resolve to a unique namespace identifier for the data source (within an annual e-Reporting cycle). :)
let $G09table :=
    try {
        for $id in distinct-values($docRoot//aqd:AQD_Attainment/aqd:inspireId/base:Identifier/base:namespace)
            let $localId := $docRoot//aqd:AQD_Attainment/aqd:inspireId/base:Identifier[base:namespace = $id]/base:localId
        return
            <tr>
                <td title="base:namespace">{$id}</td>
                <td title="base:localId">{count($localId)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G09.1 :)
let $G09.1invalid :=
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

(: G10 pollutant codes :)
let $G10invalid :=
    try {
        let $valid := ($vocabulary:POLLUTANT_VOCABULARY || "1", $vocabulary:POLLUTANT_VOCABULARY || "7", $vocabulary:POLLUTANT_VOCABULARY || "8", $vocabulary:POLLUTANT_VOCABULARY || "9", $vocabulary:POLLUTANT_VOCABULARY || "5",
        $vocabulary:POLLUTANT_VOCABULARY || "6001", $vocabulary:POLLUTANT_VOCABULARY || "10", $vocabulary:POLLUTANT_VOCABULARY || "20", $vocabulary:POLLUTANT_VOCABULARY ||  "5012",
        $vocabulary:POLLUTANT_VOCABULARY || "5014", $vocabulary:POLLUTANT_VOCABULARY || "5015", $vocabulary:POLLUTANT_VOCABULARY || "5018", $vocabulary:POLLUTANT_VOCABULARY || "5029")
        for $x in $docRoot//aqd:AQD_Attainment/aqd:pollutant
        where not($x/@xlink:href = $valid)
        return
            <tr>
                <td title="aqd:AQD_Attainment">{data($x/../aqd:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:pollutant">{data($x/@xlink:href)}</td>
                <td title="aqd:objectiveType">{data($x/../aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:objectiveType/@xlink:href)}</td>
                <td title="aqd:reportingMetric">{data($x/../aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:reportingMetric/@xlink:href)}</td>
                <td title="aqd:protectionTarget">{data($x/../aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:protectionTarget/@xlink:href)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G11 :)
let $G11invalid :=
    try {
        let $valid := ($vocabulary:POLLUTANT_VOCABULARY || "1", $vocabulary:POLLUTANT_VOCABULARY || "5", $vocabulary:POLLUTANT_VOCABULARY || "6001", $vocabulary:POLLUTANT_VOCABULARY || "10")
        for $x in $docRoot//aqd:AQD_Attainment/aqd:pollutant
        where not($x/@xlink:href = $valid) and exists($x/../aqd:exceedanceDescriptionBase)
        return
            <tr>
                <td title="aqd:AQD_Attainment">{$x/../aqd:inspireId/base:Identifier/base:localId/string()}</td>
                <td title="aqd:pollutant">{data($x/@xlink:href)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G12 :)
let $G12invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Attainment/aqd:pollutant
        let $pollutantXlinkG12 := fn:substring-after(data($x/fn:normalize-space(@xlink:href)), "pollutant/")
        where empty(index-of(('1', '5', '6001', '10'), $pollutantXlinkG12)) and (exists($x/../aqd:exceedanceDescriptionAdjustment))
        return
            <tr>
                <td title="aqd:AQD_Attainment">{data($x/../aqd:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:pollutant">{data($x/fn:normalize-space(@xlink:href))}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G13 - :)
let $G13Results :=
    try {
        sparqlx:run(query:getG13($cdrUrl, $reportingYear))
    } catch * {
        ()
    }
let $G13inspireLabels := distinct-values(data($G13Results//sparql:binding[@name='inspireLabel']/sparql:literal))
let $G13invalid :=
    try {
        let $remoteConcats :=
            for $x in $G13Results
            return $x/sparql:binding[@name='inspireLabel']/sparql:literal || $x/sparql:binding[@name='pollutant']/sparql:uri || $x/sparql:binding[@name='objectiveType']/sparql:uri

        for $x in $docRoot//aqd:AQD_Attainment[aqd:assessment/@xlink:href]
        let $xlink := $x/aqd:assessment/@xlink:href
        let $concat := $x/aqd:assessment/@xlink:href/string() || $x/aqd:pollutant/@xlink:href || $x/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:objectiveType/@xlink:href
        where (not($xlink = $G13inspireLabels) or (not($concat = $remoteConcats)))
        return
            <tr>
                <td title="aqd:AQD_Attainment">{data($x/aqd:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:assessment">{data($x/aqd:assessment/@xlink:href)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }
(: G13b :)
let $G13binvalid :=
    try {
        let $remoteConcats :=
            for $x in $G13Results
            return $x/sparql:binding[@name='inspireLabel']/sparql:literal || $x/sparql:binding[@name='pollutant']/sparql:uri || $x/sparql:binding[@name='protectionTarget']/sparql:uri

        for $x in $docRoot//aqd:AQD_Attainment[aqd:assessment/@xlink:href]
        let $xlink := $x/aqd:assessment/@xlink:href
        let $concat := $x/aqd:assessment/@xlink:href/string() || $x/aqd:pollutant/@xlink:href || $x/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:protectionTarget/@xlink:href
        where (not($xlink = $G13inspireLabels) or (not($concat = $remoteConcats)))
        return
            <tr>
                <td title="aqd:AQD_Attainment">{data($x/aqd:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:assessment">{data($x/aqd:assessment/@xlink:href)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }
(: G13c :)
let $G13cinvalid :=
    try {
        let $remoteConcats :=
            for $x in $G13Results
            return $x/sparql:binding[@name='inspireLabel']/sparql:literal || $x/sparql:binding[@name='pollutant']/sparql:uri || $x/sparql:binding[@name='objectiveType']/sparql:uri ||
            $x/sparql:binding[@name='reportingMetric']/sparql:uri || $x/sparql:binding[@name='protectionTarget']/sparql:uri

        for $x in $docRoot//aqd:AQD_Attainment[aqd:assessment/@xlink:href]
        let $xlink := $x/aqd:assessment/@xlink:href
        let $concat := $x/aqd:assessment/@xlink:href/string() || $x/aqd:pollutant/@xlink:href || $x/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:objectiveType/@xlink:href ||
        $x/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:reportingMetric/@xlink:href || $x/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:protectionTarget/@xlink:href
        where (not($xlink = $G13inspireLabels) or (not($concat = $remoteConcats)))
        return
            <tr>
                <td title="aqd:AQD_Attainment">{data($x/aqd:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:assessment">{data($x/aqd:assessment/@xlink:href)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: G14 - COUNT number zone-pollutant-target comibantion to match those in dataset B and dataset C for the same reporting Year & compare it with Attainment. :)
let $G14table :=
    try {
        let $G14resultBC :=
            for $i in sparqlx:run(query:getG14($latestEnvelopeB, $latestEnvelopeC, $reportingYear))
            return
                <result>
                    <pollutantName>{string($i/sparql:binding[@name = "Pollutant"]/sparql:literal)}</pollutantName>
                    <protectionTarget>{string($i/sparql:binding[@name = "ProtectionTarget"]/sparql:literal)}</protectionTarget>
                    <countB>{
                        let $x := string($i/sparql:binding[@name = "countOnB"]/sparql:literal)
                        return if ($x castable as xs:integer) then xs:integer($x) else 0
                    }</countB>
                    <countC>{
                        let $x := string($i/sparql:binding[@name = "countOnC"]/sparql:literal)
                        return if ($x castable as xs:integer) then xs:integer($x) else 0
                    }</countC>
                </result>
        let $G14tmp :=
            for $x in $docRoot//aqd:AQD_Attainment/aqd:environmentalObjective/aqd:EnvironmentalObjective/
                    aqd:protectionTarget[not(../string(aqd:objectiveType/@xlink:href) = ("http://dd.eionet.europa.eu/vocabulary/aq/objectivetype/MO",
                    "http://dd.eionet.europa.eu/vocabulary/aq/objectivetype/ECO", "http://dd.eionet.europa.eu/vocabulary/aq/objectivetype/ALT",
                    "http://dd.eionet.europa.eu/vocabulary/aq/objectivetype/INT"))]
            let $pollutant := string($x/../../../aqd:pollutant/@xlink:href)
            let $zone := string($x/../../../aqd:zone/@xlink:href)
            let $protectionTarget := string($x/@xlink:href)
            let $key := string-join(($zone, $pollutant, $protectionTarget), "#")
            group by $pollutant, $protectionTarget
            return
                <result>
                    <pollutantName>{dd:getNameFromPollutantCode($pollutant)}</pollutantName>
                    <pollutantCode>{tokenize($pollutant, "/")[last()]}</pollutantCode>
                    <protectionTarget>{$protectionTarget}</protectionTarget>
                    <count>{count(distinct-values($key))}</count>
                </result>
        let $G14ResultG := filter:filterByName($G14tmp, "pollutantCode", (
            "1", "7", "8", "9", "5", "6001", "10", "20", "5012", "5018", "5014", "5015", "5029"
        ))

        for $x in $G14resultBC
            let $vsName := string($x/pollutantName)
            let $vsCode := string($x/pollutantCode)
            let $protectionTarget := string($x/protectionTarget)
            let $countB := number($x/countB)
            let $countC := number($x/countC)
            let $countG := number($G14ResultG[pollutantName = $vsName and protectionTarget = $protectionTarget]/count)
            let $errorClass :=
                if ((string($countB), string($countC), string($countG)) = "NaN") then $errors:G14
                else if ($countG > $countC) then $errors:G14
                else if ($countG > $countB) then $errors:G14
                else if ($countC > $countG) then $errors:WARNING
                else if ($countB > $countG) then $errors:WARNING
                else $errors:INFO
        order by $vsName
        return
            <tr class="{$errorClass}">
                <td title="Pollutant Name">{$vsName || " (" || $G14ResultG[pollutantName = $vsName and protectionTarget = $protectionTarget]/pollutantCode || ")"}</td>
                <td title="Protection Target">{$protectionTarget}</td>
                <td title="Count B">{string($countB)}</td>
                <td title="Count C">{string($countC)}</td>
                <td title="Count G">{string($countG)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G14b :)
let $G14binvalid :=
    try {
        let $exception := ($vocabulary:OBJECTIVETYPE_VOCABULARY || "ALT", $vocabulary:OBJECTIVETYPE_VOCABULARY || "INT", $vocabulary:OBJECTIVETYPE_VOCABULARY || "MO")
        let $query :=
            "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
   PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
   PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>

   SELECT ?localId ?inspireLabel
   WHERE {
          ?regime a aqd:AQD_AssessmentRegime ;
          aqd:inspireId ?inspireId ;
          aqd:assessmentThreshold ?assessmentThreshold .
          ?inspireId rdfs:label ?inspireLabel .
          ?inspireId aqd:localId ?localId .
          ?assessmentThreshold aqd:environmentalObjective ?objective .
          ?objective aqd:objectiveType ?objectiveType .
          FILTER (CONTAINS(str(?regime), '" || $latestEnvelopeByYearC || "'))
          FILTER (!(str(?objectiveType) in ('" || string-join($exception, "','") || "')))
   }"
        let $all := distinct-values(data(sparqlx:run($query)/sparql:binding[@name = 'inspireLabel']/sparql:literal))
        let $allLocal := data($docRoot//aqd:AQD_Attainment[not(aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:objectiveType/@xlink:href = $exception)]/aqd:assessment/@xlink:href)
        for $x in $all
        where (not($x = $allLocal))
        return
            <tr>
                <td title="aqd:AQD_AssessmentRegime">{$x}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G15 :)
let $G15invalid :=
    try {
        let $exceptions := ($vocabulary:OBJECTIVETYPE_VOCABULARY || "ALT", $vocabulary:OBJECTIVETYPE_VOCABULARY || "INT", $vocabulary:OBJECTIVETYPE_VOCABULARY || "ECO", $vocabulary:OBJECTIVETYPE_VOCABULARY || "ERT")
        let $valid := distinct-values(data(sparqlx:run(query:getZone($latestEnvelopeByYearB))//sparql:binding[@name='inspireLabel']/sparql:literal))
        for $x in $docRoot//aqd:AQD_Attainment
        let $pollutant := data($x/aqd:pollutant/@xlink:href)
        let $reportingMetric := data($x/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:reportingMetric/@xlink:href)
        let $objectiveType := data($x/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:objectiveType/@xlink:href)
        let $zone := $x/aqd:zone
        where not($objectiveType = $exceptions) and not($zone/@xlink:href = $valid)
        return
            <tr>
                <td title="aqd:AQD_Attainment">{data($x/aqd:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:zone">{data($zone/@xlink:href)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G17 :)
let $G17invalid :=
    try {
        let $zones := if (fn:string-length($countryCode) = 2) then distinct-values(data(sparqlx:run(query:getZone($cdrUrl))//sparql:binding[@name='inspireLabel']/sparql:literal)) else ()
        let $pollutants := if (fn:string-length($countryCode) = 2) then distinct-values(data(sparqlx:run(query:getPollutantlD($cdrUrl))//sparql:binding[@name='key']/sparql:literal)) else ()

        for $x in $docRoot//aqd:AQD_Attainment[aqd:zone/@xlink:href]
        let $zone := data($x/aqd:zone/@xlink:href)
        let $pollutant := concat($x/aqd:zone/@xlink:href, '#', $x/aqd:pollutant/@xlink:href)
        where exists($zones) and exists($pollutants) and ($zone = $zones) and not($pollutant = $pollutants)
        return
            <tr>
                <td title="aqd:AQD_Attainment">{$x/aqd:inspireId/base:Identifier/base:localId/string()}</td>
                <td title="aqd:AQD_Zone">{$zone}</td>
                <td title="Pollutant">{data($x/aqd:pollutant/@xlink:href)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }


(: G18 :)
let $G18invalid :=
    try {
        let $localId :=  if (fn:string-length($countryCode) = 2) then distinct-values(data(sparqlx:run(query:getTimeExtensionExemption($cdrUrl))//sparql:binding[@name='localId']/sparql:literal)) else ""
        for $x in $docRoot//aqd:AQD_Attainment[aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription]
        let $objectiveType := data($x/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:objectiveType/@xlink:href)
        let $reportingMetric := data($x/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:reportingMetric/@xlink:href)
        let $protectionTarget := data($x/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:protectionTarget/@xlink:href)
        let $zone := data($x/aqd:zone/@xlink:href)
        where exists($localId) and ($zone = $localId) and ($objectiveType != "http://dd.eionet.europa.eu/vocabulary/aq/objectivetype/LVmaxMOT")
        return
            <tr>
                <td title="aqd:AQD_Attainment">{$x/aqd:inspireId/base:Identifier/base:localId/string()}</td>
                <td title="aqd:objectiveType">{$objectiveType}</td>
                <td title="aqd:reportingMetric">{$reportingMetric}</td>
                <td title="aqd:protectionTarget">{$protectionTarget}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G19 .//aqd:ExceedanceDescription/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:objectiveType xlink:href attribute shall resolve to one of :)
let $G19invalid :=
    try {
        let $valid := ($vocabulary:OBJECTIVETYPE_VOCABULARY || "TV", $vocabulary:OBJECTIVETYPE_VOCABULARY || "LV",$vocabulary:OBJECTIVETYPE_VOCABULARY || "CL",
        $vocabulary:OBJECTIVETYPE_VOCABULARY || "LVMOT", $vocabulary:OBJECTIVETYPE_VOCABULARY || "LVmaxMOT", $vocabulary:OBJECTIVETYPE_VOCABULARY || "INT",
        $vocabulary:OBJECTIVETYPE_VOCABULARY || "ALT", $vocabulary:OBJECTIVETYPE_VOCABULARY || "LTO", $vocabulary:OBJECTIVETYPE_VOCABULARY || "ECO",
        $vocabulary:OBJECTIVETYPE_VOCABULARY || "LV-S2")
        for $x in $docRoot//aqd:environmentalObjective/aqd:EnvironmentalObjective
        where not($x/aqd:objectiveType/@xlink:href = $valid)
        return
            <tr>
                <td title="aqd:AQD_Attainment">{$x/../../aqd:inspireId/base:Identifier/base:localId/string()}</td>
                <td title="aqd:objectiveType">{data($x/aqd:objectiveType)}</td>
                <td title="aqd:reportingMetric">{data($x/aqd:reportingMetric)}</td>
                <td title="aqd:protectionTarget">{data($x/aqd:protectionTarget)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G20 - ./aqd:exceedanceDescriptionBase/aqd:ExceedanceDescription/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:reportingMetric xlink:href attribute shall resolve to one of
... :)
let $G20invalid :=
    try {
        let $valid := ($vocabulary:REPMETRIC_VOCABULARY || "3hAbove", $vocabulary:REPMETRIC_VOCABULARY || "aMean", $vocabulary:REPMETRIC_VOCABULARY || "wMean",
        $vocabulary:REPMETRIC_VOCABULARY || "hrsAbove", $vocabulary:REPMETRIC_VOCABULARY || "daysAbove", $vocabulary:REPMETRIC_VOCABULARY || "daysAbove-3yr",
        $vocabulary:REPMETRIC_VOCABULARY || "maxd8hrMean", $vocabulary:REPMETRIC_VOCABULARY || "AOT40c", $vocabulary:REPMETRIC_VOCABULARY || "AOT40c-5yr", $vocabulary:REPMETRIC_VOCABULARY || "AEI")
        for $x in $docRoot//aqd:environmentalObjective/aqd:EnvironmentalObjective
        where not($x/aqd:reportingMetric/@xlink:href = $valid)
        return
            <tr>
                <td title="aqd:AQD_Attainment">{$x/../../aqd:inspireId/base:Identifier/base:localId/string()}</td>
                <td title="aqd:objectiveType">{data($x/aqd:objectiveType)}</td>
                <td title="aqd:reportingMetric">{data($x/aqd:reportingMetric)}</td>
                <td title="aqd:protectionTarget">{data($x/aqd:protectionTarget)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G21 - aqd:protectionTarget match with vocabulary codes :)
let $G21invalid :=
    try {
        let $valid := dd:getValidConcepts($vocabulary:PROTECTIONTARGET_VOCABULARY || "rdf")
        for $x in $docRoot//aqd:environmentalObjective/aqd:EnvironmentalObjective
        where not($x/aqd:protectionTarget/@xlink:href = $valid)
        return
            <tr>
                <td title="aqd:AQD_Attainment">{$x/../../aqd:inspireId/base:Identifier/base:localId/string()}</td>
                <td title="aqd:objectiveType">{data($x/aqd:objectiveType/@xlink:href)}</td>
                <td title="aqd:reportingMetric">{data($x/aqd:reportingMetric/@xlink:href)}</td>
                <td title="aqd:protectionTarget">{data($x/aqd:protectionTarget/@xlink:href)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G22 :)
let $G22invalid :=
    try {
        let $environmentalObjectiveCombinations := doc("http://dd.eionet.europa.eu/vocabulary/aq/environmentalobjective/rdf")
        for $x in $docRoot//aqd:environmentalObjective/aqd:EnvironmentalObjective
        let $objectiveType := data($x/aqd:objectiveType/@xlink:href)
        let $reportingMetric := data($x/aqd:reportingMetric/@xlink:href)
        let $protectionTarget := data($x/aqd:protectionTarget/@xlink:href)
        where (not($environmentalObjectiveCombinations//skos:Concept[prop:hasProtectionTarget/@rdf:resource = $protectionTarget
                and prop:hasObjectiveType/@rdf:resource = $objectiveType and prop:hasReportingMetric/@rdf:resource = $reportingMetric]))
        return
            <tr>
                <td title="aqd:AQD_Attainment">{data($x/../../aqd:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:pollutant">{data($x/../../aqd:pollutant/@xlink:href)}</td>
                <td title="aqd:objectiveType">{data($x/aqd:objectiveType/@xlink:href)}</td>
                <td title="aqd:reportingMetric">{data($x/aqd:reportingMetric/@xlink:href)}</td>
                <td title="aqd:protectionTarget">{data($x/aqd:protectionTarget/@xlink:href)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G38 :)
let $G38invalid :=
    try {
        let $valid := ($vocabulary:AREA_CLASSIFICATION_VOCABULARY || "rural", $vocabulary:AREA_CLASSIFICATION_VOCABULARY || "rural-nearcity", $vocabulary:AREA_CLASSIFICATION_VOCABULARY || "rural-regional",
        $vocabulary:AREA_CLASSIFICATION_VOCABULARY || "rural-remote",$vocabulary:AREA_CLASSIFICATION_VOCABULARY || "urban", $vocabulary:AREA_CLASSIFICATION_VOCABULARY || "suburban")
        for $x in $docRoot//aqd:exceedanceDescriptionBase/aqd:ExceedanceDescription/aqd:exceedanceArea/aqd:ExceedanceArea/aqd:areaClassification
        where not($x/@xlink:href = $valid)
        return
            <tr>
                <td title="aqd:AQD_Attainment">{$x/../../aqd:inspireId/base:Identifier/base:localId/string()}</td>
                <td title="aqd:objectiveType">{data($x/aqd:objectiveType)}</td>
                <td title="aqd:reportingMetric">{data($x/aqd:reportingMetric)}</td>
                <td title="aqd:protectionTarget">{data($x/aqd:protectionTarget)}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G39 :)
let $G39invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Attainment/aqd:exceedanceDescriptionBase/aqd:ExceedanceDescription/aqd:exceedanceArea/aqd:ExceedanceArea/aqd:modelUsed
        where (not($x/@xlink:href = $latestModels))
        return
            <tr>
                <td title="Feature type">{"aqd:AQD_Attainment"}</td>
                <td title="gml:id">{data($x/../../../../../@gml:id)}</td>
                <td title="aqd:AQD_Model">{data($x/fn:normalize-space(@xlink:href))}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G40 - :)
let $G40invalid  :=
    try {
        for $r in $validAssessment/../aqd:exceedanceDescriptionBase/aqd:ExceedanceDescription/aqd:exceedanceArea/aqd:ExceedanceArea/aqd:modelUsed[@xlink:href = $assessmentMetadata]
        where exists($assessmentMetadata)
        return
            <tr>
                <td title="gml:id">{data($r/../../../../../@gml:id)}</td>
                <td title="aqd:assessment">{data($r/../../../../../aqd:assessment/fn:normalize-space(@xlink:href))}</td>
                <td title="aqd:modelUsed">{data($r/fn:normalize-space(@xlink:href))}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G41 - :)
let $G41invalid :=
    try {
        for $r in $docRoot//aqd:AQD_Attainment/aqd:exceedanceDescriptionBase/aqd:ExceedanceDescription/aqd:exceedanceArea/aqd:ExceedanceArea/aqd:stationUsed[not(@xlink:href = $latestSamplingPoints)]
        return
            <tr>
                <td title="gml:id">{data($r/../../../../../../../@gml:id)}</td>
                <td title="aqd:SamplingPoint">{data($r/fn:normalize-space(@xlink:href))}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G42 - :)
let $G42invalid  :=
    try {
        for $r in $validAssessment/../aqd:exceedanceDescriptionBase/aqd:ExceedanceDescription/aqd:exceedanceArea/aqd:ExceedanceArea/aqd:stationlUsed[not(@xlink:href = $samplingPointAssessmentMetadata)]
        where exists($samplingPointAssessmentMetadata)
        return
            <tr>
                <td title="gml:id">{data($r/../../../../../@gml:id)}</td>
                <td title="aqd:assessment">{data($r/../../../../../aqd:assessment/fn:normalize-space(@xlink:href))}</td>
                <td title="aqd:stationlUsed">{data($r/fn:normalize-space(@xlink:href))}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G44 - aqd:AQD_Attainment/aqd:exceedanceDescriptionBase/aqd:ExceedanceDescription/aqd:exceedance shall EQUAL “true” or “false” :)
let $G44invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Attainment/aqd:exceedanceDescriptionBase/aqd:ExceedanceDescription/aqd:exceedance[not(string() = ("true", "false"))]
        return
            <tr>
                <td title="base:localId">{$x/../../../aqd:inspireId/base:Identifier/base:localId/string()}</td>
                <td title="aqd:exceedanc">{$x/string()}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
(: G45 - If ./aqd:exceedanceDescriptionBase/aqd:ExceedanceDescription/aqd:exceedance is TRUE EITHER ./aqd:exceedanceDescriptionBase/aqd:ExceedanceDescription/aqd:numericalExceedance
OR ./aqd:exceedanceDescriptionBase/aqd:ExceedanceDescription/aqd:numberExceedances must be provided AS an integer number :)
let $G45invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Attainment[aqd:exceedanceDescriptionBase/aqd:ExceedanceDescription/aqd:exceedance = "true"]
            let $numerical := string($x/aqd:exceedanceDescriptionBase/aqd:ExceedanceDescription/aqd:numericalExceedance)
            let $numbers := string($x/aqd:exceedanceDescriptionBase/aqd:ExceedanceDescription/aqd:numberExceedances)
            let $percentile := string($x/aqd:exceedanceDescriptionBase/aqd:ExceedanceDescription/aqd:percentileExceedance)
        where not(common:containsAnyNumber(($numerical, $numbers, $percentile)))
        return
            <tr>
                <td title="base:localId">{$x/aqd:inspireId/base:Identifier/base:localId/string()}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G46 :)
let $G46invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Attainment[aqd:exceedanceDescriptionBase/aqd:ExceedanceDescription/aqd:exceedance = "false"]
            let $numerical := string($x/aqd:exceedanceDescriptionBase/aqd:ExceedanceDescription/aqd:numericalExceedance)
            let $numbers := string($x/aqd:exceedanceDescriptionBase/aqd:ExceedanceDescription/aqd:numberExceedances)
            let $percentile := string($x/aqd:exceedanceDescriptionBase/aqd:ExceedanceDescription/aqd:percentileExceedance)
        where not(common:containsAnyNumber(($numerical, $numbers, $percentile)))
        return
            <tr>
                <td title="base:localId">{$x/aqd:inspireId/base:Identifier/base:localId/string()}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G47 :)
let $G47invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Attainment[aqd:exceedanceDescriptionBase/aqd:ExceedanceDescription/aqd:deductionAssessmentMethod/aqd:AdjustmentMethod/aqd:adjustmentType/fn:normalize-space(@xlink:href) != "http://dd.eionet.europa.eu/vocabulary/aq/adjustmenttype/noneApplied"]
        return
            <tr>
                <td title="base:localId">{$x/aqd:inspireId/base:Identifier/base:localId/string()}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G52 :)
let $G52invalid :=
    try {
        let $valid := ($vocabulary:AREA_CLASSIFICATION_VOCABULARY || "rural", $vocabulary:AREA_CLASSIFICATION_VOCABULARY || "rural-nearcity", $vocabulary:AREA_CLASSIFICATION_VOCABULARY || "rural-regional",
        $vocabulary:AREA_CLASSIFICATION_VOCABULARY || "rural-remote",$vocabulary:AREA_CLASSIFICATION_VOCABULARY || "urban", $vocabulary:AREA_CLASSIFICATION_VOCABULARY || "suburban")
        for $x in $docRoot//aqd:exceedanceDescriptionAdjustment/aqd:ExceedanceDescription/aqd:exceedanceArea/aqd:ExceedanceArea/aqd:areaClassification
        where not($x/@xlink:href = $valid)
        return
            <tr>
                <td title="aqd:AQD_Attainment">{$x/../../aqd:inspireId/base:Identifier/base:localId/string()}</td>
                <td title="aqd:objectiveType">{data($x/aqd:objectiveType)}</td>
                <td title="aqd:reportingMetric">{data($x/aqd:reportingMetric)}</td>
                <td title="aqd:protectionTarget">{data($x/aqd:protectionTarget)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G53 :)
let $G53invalid :=
    try {
        for $r in $docRoot//aqd:AQD_Attainment/aqd:exceedanceDescriptionAdjustment/aqd:ExceedanceDescription/aqd:exceedanceArea/aqd:ExceedanceArea/aqd:modelUsed[not(@xlink:href = $latestModels)]
        return
            <tr>
                <td title="gml:id">{data($r/../../../../../../../@gml:id)}</td>
                <td title="aqd:Model">{data($r/fn:normalize-space(@xlink:href))}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G54 - :)
let $G54invalid :=
    try {
        for $r in $validAssessment/../aqd:exceedanceDescriptionAdjustment/aqd:ExceedanceDescription/aqd:exceedanceArea/aqd:ExceedanceArea/aqd:modelUsed[not(@xlink:href = $assessmentMetadata)]
        return
            <tr>
                <td title="gml:id">{data($r/../../../../../@gml:id)}</td>
                <td title="aqd:assessment">{data($r/../../../../../aqd:assessment/fn:normalize-space(@xlink:href))}</td>
                <td title="aqd:stationlUsed">{data($r/fn:normalize-space(@xlink:href))}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G55 :)
let $G55invalid :=
    try {
        for $r in $docRoot//aqd:AQD_Attainment/aqd:exceedanceDescriptionAdjustment/aqd:ExceedanceDescription/aqd:exceedanceArea/aqd:ExceedanceArea/aqd:stationUsed[not(@xlink:href = $latestSamplingPoints)]
        return
            <tr>
                <td title="gml:id">{data($r/../../../../../../../@gml:id)}</td>
                <td title="aqd:SamplingPoint">{data($r/fn:normalize-space(@xlink:href))}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G56 :)
let $G56invalid :=
    try {
        for $r in $validAssessment/../aqd:exceedanceDescriptionAdjustment/aqd:ExceedanceDescription/aqd:exceedanceArea/aqd:ExceedanceArea/aqd:stationlUsed[not(@xlink:href = $samplingPointAssessmentMetadata)]
        where exists($samplingPointAssessmentMetadata)
        return
            <tr>
                <td title="gml:id">{data($r/../../../../../@gml:id)}</td>
                <td title="aqd:assessment">{data($r/../../../../../aqd:assessment/fn:normalize-space(@xlink:href))}</td>
                <td title="aqd:stationlUsed">{data($r/fn:normalize-space(@xlink:href))}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }


(: G57 - :)
let $G57invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Attainment
        let $reportingXlink := fn:substring-after(data($x/aqd:exceedanceDescriptionBase/aqd:ExceedanceDescription/aqd:environmentalObjective/aqd:EnvironmentalObjective/aqd:reportingMetric/fn:normalize-space(@xlink:href)), "reportingmetric/")
        where empty(index-of(data($x/aqd:pollutant/fn:normalize-space(@xlink:href)), "http://dd.eionet.europa.eu/vocabulary/aq/pollutant/6001")) = false() and
                (empty(index-of(('aMean'), $reportingXlink)))
        return
            <tr>
                <td title="reporting link">{$reportingXlink}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G58 - aqd:AQD_Attainment/aqd:exceedanceDescriptionAdjustment/aqd:ExceedanceDescription/aqd:exceedance shall EQUAL “true” or “false” :)
let $G58invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Attainment/aqd:exceedanceDescriptionAdjustment/aqd:ExceedanceDescription/aqd:exceedance[not(string() = ("true", "false"))]
        return
            <tr>
                <td title="base:localId">{$x/../../../aqd:inspireId/base:Identifier/base:localId/string()}</td>
                <td title="aqd:exceedanc">{$x/string()}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G59 - If ./aqd:exceedanceDescriptionAdjustment/aqd:ExceedanceDescription/aqd:exceedance is TRUE EITHER ./aqd:exceedanceDescriptionAdjustment/aqd:ExceedanceDescription/aqd:numericalExceedance
OR ./aqd:exceedanceDescriptionAdjustment/aqd:ExceedanceDescription/aqd:numberExceedances must be provided AS an integer number :)
let $G59invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Attainment/aqd:exceedanceDescriptionAdjustment[/aqd:ExceedanceDescription/aqd:exceedance = "true"]
            let $numerical := string($x/aqd:ExceedanceDescription/aqd:numericalExceedance)
            let $numbers := string($x/aqd:ExceedanceDescription/aqd:numberExceedances)
            let $percentile := string($x/aqd:ExceedanceDescription/aqd:percentileExceedance)
        where not(common:containsAnyNumber(($numerical, $numbers, $percentile)))
        return
            <tr>
                <td title="base:localId">{$x/../aqd:inspireId/base:Identifier/base:localId/string()}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G60 - If ./aqd:exceedanceDescriptionAdjustment/aqd:ExceedanceDescription/aqd:exceedance is FALSE EITHER ./aqd:exceedanceDescriptionAdjustment/aqd:ExceedanceDescription/aqd:numericalExceedance
OR ./aqd:exceedanceDescriptionAdjustment/aqd:ExceedanceDescription/aqd:numberExceedances must be provided AS an integer number :)
let $G60invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Attainment/aqd:exceedanceDescriptionAdjustment[aqd:ExceedanceDescription/aqd:exceedance = "false"]
            let $numerical := string($x/aqd:ExceedanceDescription/aqd:numericalExceedance)
            let $numbers := string($x/aqd:ExceedanceDescription/aqd:numberExceedances)
            let $percentile := string($x/aqd:ExceedanceDescription/aqd:percentileExceedance)
        where not(common:containsAnyNumber(($numerical, $numbers, $percentile)))
        return
            <tr>
                <td title="base:localId">{$x/../aqd:inspireId/base:Identifier/base:localId/string()}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G61 :)
let $G61invalid :=
    try {
        let $valid := ($vocabulary:ADJUSTMENTTYPE_VOCABULARY || "nsCorrection", $vocabulary:ADJUSTMENTTYPE_VOCABULARY || "wssCorrection")
        for $x in $docRoot//aqd:exceedanceDescriptionAdjustment/aqd:ExceedanceDescription/aqd:deductionAssessmentMethod/aqd:AdjustmentMethod/aqd:adjustmentType
        where not($x/@xlink:href = $valid)
        return
            <tr>
                <td title="aqd:AQD_Attainment">{$x/../../aqd:inspireId/base:Identifier/base:localId/string()}</td>
                <td title="aqd:objectiveType">{data($x/aqd:objectiveType)}</td>
                <td title="aqd:reportingMetric">{data($x/aqd:reportingMetric)}</td>
                <td title="aqd:protectionTarget">{data($x/aqd:protectionTarget)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G62 - :)
let $G62invalid :=
    try {
        let $valid := ($vocabulary:ADJUSTMENTSOURCE_VOCABULARY || "A1", $vocabulary:ADJUSTMENTSOURCE_VOCABULARY || "A2", $vocabulary:ADJUSTMENTSOURCE_VOCABULARY || "B", $vocabulary:ADJUSTMENTSOURCE_VOCABULARY || "B1",
        $vocabulary:ADJUSTMENTSOURCE_VOCABULARY || "B2", $vocabulary:ADJUSTMENTSOURCE_VOCABULARY || "C1", $vocabulary:ADJUSTMENTSOURCE_VOCABULARY || "C2", $vocabulary:ADJUSTMENTSOURCE_VOCABULARY || "D1",
        $vocabulary:ADJUSTMENTSOURCE_VOCABULARY || "D2", $vocabulary:ADJUSTMENTSOURCE_VOCABULARY || "E1", $vocabulary:ADJUSTMENTSOURCE_VOCABULARY || "E2", $vocabulary:ADJUSTMENTSOURCE_VOCABULARY || "F1",
        $vocabulary:ADJUSTMENTSOURCE_VOCABULARY || "F2", $vocabulary:ADJUSTMENTSOURCE_VOCABULARY || "G1", $vocabulary:ADJUSTMENTSOURCE_VOCABULARY || "G2", $vocabulary:ADJUSTMENTSOURCE_VOCABULARY || "H")
        for $x in $docRoot//aqd:exceedanceDescriptionAdjustment/aqd:ExceedanceDescription/aqd:deductionAssessmentMethod/aqd:AdjustmentMethod/aqd:adjustmentSource
        where not($x/@xlink:href = $valid)
        return
            <tr>
                <td title="aqd:AQD_Attainment">{$x/../../aqd:inspireId/base:Identifier/base:localId/string()}</td>
                <td title="aqd:objectiveType">{data($x/aqd:objectiveType)}</td>
                <td title="aqd:reportingMetric">{data($x/aqd:reportingMetric)}</td>
                <td title="aqd:protectionTarget">{data($x/aqd:protectionTarget)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G63 :)
let $G63invalid :=
    try {
        let $valid := ($vocabulary:ASSESSMENTTYPE_VOCABULARY || "fixed", $vocabulary:ASSESSMENTTYPE_VOCABULARY || "model", $vocabulary:ASSESSMENTTYPE_VOCABULARY || "indicative", $vocabulary:ASSESSMENTTYPE_VOCABULARY || "objective")
        for $x in $docRoot//aqd:exceedanceDescriptionAdjustment/aqd:ExceedanceDescription/aqd:deductionAssessmentMethod/aqd:AdjustmentMethod/aqd:assessmentMethod/aqd:AssessmentMethods/aqd:assessmentType
        where not($x/@xlink:href = $valid)
        return
            <tr>
                <td title="aqd:AQD_Attainment">{$x/../../aqd:inspireId/base:Identifier/base:localId/string()}</td>
                <td title="aqd:objectiveType">{data($x/aqd:objectiveType)}</td>
                <td title="aqd:reportingMetric">{data($x/aqd:reportingMetric)}</td>
                <td title="aqd:protectionTarget">{data($x/aqd:protectionTarget)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G64 :)
let $G64invalid :=
    try {
        let $types := ($vocabulary:ADJUSTMENTTYPE_VOCABULARY || "nsCorrection", $vocabulary:ADJUSTMENTTYPE_VOCABULARY || "wssCorrection")
        for $x in $docRoot//aqd:exceedanceDescriptionAdjustment/aqd:ExceedanceDescription/aqd:deductionAssessmentMethod/aqd:AdjustmentMethod/aqd:adjustmentType[@xlink:href = $types]
        let $model := data($x/../aqd:assessmentMethod/aqd:AssessmentMethods/aqd:modelAssessmentMetadata/@xlink:href)
        let $samplingPoint := data($x/../aqd:assessmentMethod/aqd:AssessmentMethods/aqd:samplingPointAssessmentMetadata/@xlink:href)
        where empty($model) and empty($samplingPoint)
        return
            <tr>
                <td title="aqd:AQD_Attainment">{$x/../../../../../aqd:inspireId/base:Identifier/base:localId/string()}</td>
                <td title="aqd:modelAssessmentMetadata">{$model}</td>
                <td title="aqd:samplingPointAssessmentMetadata">{$samplingPoint}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G65
let $G65invalid :=
    try {
        let $types := ($vocabulary:ADJUSTMENTTYPE_VOCABULARY || "nsCorrection", $vocabulary:ADJUSTMENTTYPE_VOCABULARY || "wssCorrection")
        for $x in $docRoot//aqd:exceedanceDescriptionAdjustment/aqd:ExceedanceDescription/aqd:deductionAssessmentMethod/aqd:AdjustmentMethod/aqd:adjustmentType[@xlink:href = $types]
        let $model := data($x/../aqd:assessmentMethod/aqd:AssessmentMethods/aqd:modelAssessmentMetadata/@xlink:href)
        let $samplingPoint := data($x/../aqd:assessmentMethod/aqd:AssessmentMethods/aqd:samplingPointAssessmentMetadata/@xlink:href)
        where (exists($model) and not($model = $latestModels)) or (exists($samplingPoint) and not($samplingPoint = $latestSamplingPoints))
        return
            <tr>
                <td title="aqd:AQD_Attainment">{$x/../../../../../aqd:inspireId/base:Identifier/base:localId/string()}</td>
                <td title="aqd:modelAssessmentMetadata">{$model}</td>
                <td title="aqd:samplingPointAssessmentMetadata">{$samplingPoint}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }:)

(: G66 :)
let $G66invalid :=
    try {
        for $r in $validAssessment/../aqd:exceedanceDescriptionAdjustment/aqd:ExceedanceDescription/aqd:deductionAssessmentMethod/aqd:AdjustmentMethod/aqd:assessmentMethod/aqd:AssessmentMethods/aqd:modelAssessmentMetadata[not(@xlink:href = $assessmentMetadata)]
        where exists($assessmentMetadata)
        return
            <tr>
                <td title="gml:id">{data($r/../../../../../../../@gml:id)}</td>
                <td title="aqd:assessment">{data($r/../../../../../../../aqd:assessment/fn:normalize-space(@xlink:href))}</td>
                <td title="aqd:stationlUsed">{data($r/fn:normalize-space(@xlink:href))}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G67 - :)
let $G67invalid :=
    try {
        for $x in $validAssessment/../aqd:exceedanceDescriptionAdjustment/aqd:ExceedanceDescription/aqd:deductionAssessmentMethod/aqd:AdjustmentMethod/aqd:assessmentMethod/aqd:AssessmentMethods/aqd:samplingPointAssessmentMetadata[not(@xlink:href = $samplingPointAssessmentMetadata)]
        return
            <tr>
                <td title="aqd:AQD_Attainment">{$x/../../../../../../../aqd:inspireId/base:Identifier/base:localId/string()}</td>
                <td title="aqd:assessment">{data($x/../../../../../../../aqd:assessment/fn:normalize-space(@xlink:href))}</td>
                <td title="aqd:samplingPointAssessmentMetadata">{data($x/fn:normalize-space(@xlink:href))}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G70 :)
let $G70invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Attainment[aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:exceedanceArea/aqd:ExceedanceArea/aqd:surfaceArea[count(@uom) > 0 and fn:normalize-space(@uom) != "http://dd.eionet.europa.eu/vocabulary/uom/area/km2" and fn:normalize-space(@uom) != "http://dd.eionet.europa.eu/vocabularyconcept/uom/area/km2"]]
        return
            <tr>
                <td title="base:localId">{$x/aqd:inspireId/base:Identifier/base:localId/string()}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G71 :)
let $G71invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Attainment[aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:exceedanceArea/aqd:ExceedanceArea/aqd:roadLength[count(@uom) > 0 and fn:normalize-space(@uom) != "http://dd.eionet.europa.eu/vocabulary/uom/length/km" and fn:normalize-space(@uom) != "http://dd.eionet.europa.eu/vocabularyconcept/uom/length/km"]]
        return
            <tr>
                <td title="base:localId">{$x/aqd:inspireId/base:Identifier/base:localId/string()}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G72 :)
let $G72invalid :=
    try {
        let $valid := ($vocabulary:AREA_CLASSIFICATION_VOCABULARY || "rural", $vocabulary:AREA_CLASSIFICATION_VOCABULARY || "rural-nearcity", $vocabulary:AREA_CLASSIFICATION_VOCABULARY ||"rural-regional",
        $vocabulary:AREA_CLASSIFICATION_VOCABULARY || "rural-remote", $vocabulary:AREA_CLASSIFICATION_VOCABULARY || "urban", $vocabulary:AREA_CLASSIFICATION_VOCABULARY || "suburban")
        for $x in $docRoot//aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:exceedanceArea/aqd:ExceedanceArea/aqd:areaClassification
        where not($x/@xlink:href = $valid)
        return
            <tr>
                <td title="aqd:AQD_Attainment">{$x/../../aqd:inspireId/base:Identifier/base:localId/string()}</td>
                <td title="aqd:objectiveType">{data($x/aqd:objectiveType)}</td>
                <td title="aqd:reportingMetric">{data($x/aqd:reportingMetric)}</td>
                <td title="aqd:protectionTarget">{data($x/aqd:protectionTarget)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G73 :)
let $G73invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Attainment/aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:exceedanceArea/aqd:ExceedanceArea/aqd:modelUsed
        where not($x/@xlink:href = $latestModels)
        return
            <tr>
                <td title="Feature type">{"aqd:AQD_Attainment"}</td>
                <td title="gml:id">{data($x/../../../../../@gml:id)}</td>
                <td title="aqd:AQD_Model">{data($x/fn:normalize-space(@xlink:href))}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G74 :)
let $modelUsed_74  :=
    try {
        for $r in $validAssessment/../aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:exceedanceArea/aqd:ExceedanceArea/aqd:modelUsed[not(@xlink:href = $assessmentMetadata)]
        where exists($assessmentMetadata)
        return
            <tr>
                <td title="gml:id">{data($r/../../../../../../../@gml:id)}</td>
                <td title="aqd:assessment">{data($r/../../../../../../../../aqd:assessment/fn:normalize-space(@xlink:href))}</td>
                <td title="aqd:stationlUsed">{data($r/fn:normalize-space(@xlink:href))}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
(: G75 :)
let $G75invalid  :=
    try {
        for $r in $docRoot//aqd:AQD_Attainment//aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:exceedanceArea/aqd:ExceedanceArea/aqd:stationUsed
        where not($r/@xlink:href = $latestSamplingPoints)
        return
            <tr>
                <td title="gml:id">{data($r/../../../../../../../@gml:id)}</td>
                <td title="aqd:stationUsed">{data($r/fn:normalize-space(@xlink:href))}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G76 :)
let $G76invalid  :=
    try {
        for $r in $validAssessment/../aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:exceedanceArea/aqd:ExceedanceArea/aqd:stationlUsed[not(@xlink:href = $samplingPointAssessmentMetadata)]
        where exists($assessmentMetadata)
        return
            <tr>
                <td title="gml:id">{data($r/../../../../../@gml:id)}</td>
                <td title="aqd:assessment">{data($r/../../../../../../aqd:assessment/fn:normalize-space(@xlink:href))}</td>
                <td title="aqd:stationlUsed">{data($r/fn:normalize-space(@xlink:href))}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G78 - ./aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:exceedance shall EQUAL “true” or “false” :)
let $G78invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Attainment/aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:exceedance[not(string() = ("true", "false"))]
        return
            <tr>
                <td title="base:localId">{$x/../../../aqd:inspireId/base:Identifier/base:localId/string()}</td>
                <td title="aqd:exceedanc">{$x/string()}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
(: G79 - If ./aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:exceedance is TRUE EITHER ./aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:numericalExceedance
OR ./aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:numberExceedances must be provided AS an integer number :)
let $G79invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Attainment[aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:exceedance = "true"]
        let $numerical := string($x/aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:numericalExceedance)
        let $numbers := string($x/aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:numberExceedances)
        let $percentile := string($x/aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:percentileExceedance)
        where not(common:containsAnyNumber(($numerical, $numbers, $percentile)))
        return
            <tr>
                <td title="base:localId">{$x/aqd:inspireId/base:Identifier/base:localId/string()}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
(: G80 - If ./aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:exceedance is FALSE EITHER ./aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:numericalExceedance
OR ./aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:numberExceedances must be provided AS an integer number :)
let $G80invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Attainment[aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:exceedance = "false"]
        let $numerical := string($x/aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:numericalExceedance)
        let $numbers := string($x/aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:numberExceedances)
        let $percentile := string($x/aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:percentileExceedance)
        where not(common:containsAnyNumber(($numerical, $numbers, $percentile)))
        return
            <tr>
                <td title="base:localId">{$x/aqd:inspireId/base:Identifier/base:localId/string()}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G81 :)
let $G81invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Attainment[aqd:exceedanceDescriptionAdjustmen/aqd:ExceedanceDescription/aqd:deductionAssessmentMethod/aqd:AdjustmentMethod/aqd:adjustmentType/fn:normalize-space(@xlink:href)!="http://dd.eionet.europa.eu/vocabulary/aq/adjustmenttype/fullyCorrected"]
        return
            <tr>
                <td title="base:localId">{$x/aqd:inspireId/base:Identifier/base:localId/string()}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: G82 - :)
let $G82invalid :=
    try {
        let $valid := ("http://dd.eionet.europa.eu/vocabulary/aq/adjustmenttype/noneApplied","http://dd.eionet.europa.eu/vocabulary/aq/adjustmenttype/noneApplicable", "http://dd.eionet.europa.eu/vocabulary/aq/adjustmenttype/fullyCorrected")
        for $r in $docRoot//aqd:AQD_Attainment//aqd:exceedanceDescriptionAdjustment/aqd:ExceedanceDescription/aqd:deductionAssessmentMethod/aqd:AdjustmentMethod/aqd:adjustmentType[@xlink:href = $valid]
        return
            <tr>
                <td title="gml:id">{data($r/../../../../../@gml:id)}</td>
                <td title="gml:id">{data($r/fn:normalize-space(@xlink:href))}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(:~ G85 - WHERE ./aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:exceedance shall EQUAL “true”
 :  ./aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:exceedanceArea/aqd:ExceedanceArea/aqd:stationUsed OR
 :  ./aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:exceedanceArea/aqd:ExceedanceArea/aqd:modelUsed MUST be populated (At least 1 xlink must be found)
 :)
let $G85invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Attainment[aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:exceedance = "true"]
            let $stationUsed := data($x/aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:exceedanceArea/aqd:ExceedanceArea/aqd:stationUsed/@xlink:href)
            let $modelUsed := data($x/aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription/aqd:exceedanceArea/aqd:ExceedanceArea/aqd:modelUsed/@xlink:href)
        where (count($stationUsed) = 0 and count($modelUsed) = 0)
        return
            <tr>
                <td title="base:localId">{$x/aqd:inspireId/base:Identifier/base:localId/string()}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
(: G86 :)
let $G86invalid :=
    try {
        for $x in $docRoot//aqd:ExceedanceDescription/aqd:exceedanceArea/aqd:ExceedanceArea[aqd:stationUsed/@xlink:href or aqd:modelUsed/@xlink:href]
        let $stationErrors :=
            for $i in data($x/aqd:stationUsed/@xlink:href)
            where (not($i = $latestSamplingPoints))
            return 1
        let $modelErrors :=
            for $i in data($x/aqd:modelUsed/@xlink:href)
            where (not($i = $latestModels))
            return 1
        where (count($stationErrors) >0 or count($modelErrors) >0)
        return
            <tr>
                <td title="base:localId">{string($x/../../../../aqd:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:stationUsed">{data($x/aqd:stationUsed/@xlink:href)}</td>
                <td title="aqd:modelUsed">{data($x/aqd:modelUsed/@xlink:href)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

return
    <table class="maintable hover">
        {html:build2("NS", $labels:NAMESPACES, $labels:NAMESPACES_SHORT, $NSinvalid, "All values are valid", "record", $errors:NS)}
        {html:build3("G0", $labels:G0, $labels:G0_SHORT, $G0table, string($G0table/td), errors:getMaxError($G0table))}
        {html:build1("G01", $labels:G01, $labels:G01_SHORT, $tblAllAttainments, "", string($countAttainments), "", "", $errors:G01)}
        {html:buildSimple("G02", $labels:G02, $labels:G02_SHORT, $G02table, "", "", $G02errorLevel)}
        {html:buildSimple("G03", $labels:G03, $labels:G03_SHORT, $G03table, "", "", $G03errorLevel)}
        {html:build1("G04", $labels:G04, $labels:G04_SHORT, $G04table, "", string(count($G04table)), " ", "", $errors:G04)}
        {html:build1("G05", $labels:G05, $labels:G05_SHORT, $G05table, "", string(count($G05table)), " exceedance", "", $errors:G05)}
        {html:build2("G06", $labels:G06, $labels:G06_SHORT, $G06table, "All values are valid", "record", errors:getMaxError($G06table))}
        {html:build2("G07", $labels:G07, $labels:G07_SHORT, $G07invalid, "No duplicates found", " duplicate", $errors:G07)}
        {html:build2("G08", $labels:G08, $labels:G08_SHORT, $G08invalid, "No duplicate values found", " duplicate value", $errors:G08)}
        {html:buildUnique("G09", $labels:G09, $labels:G09_SHORT, $G09table, "namespace", $errors:G09)}
        {html:build2("G09.1", $labels:G09.1, $labels:G09.1_SHORT, $G09.1invalid, "All values are valid", " invalid namespaces", $errors:G09.1)}
        {html:build2("G10", $labels:G10, $labels:G10_SHORT, $G10invalid, "All values are valid", "", $errors:G10)}
        {html:build2("G11", $labels:G11, $labels:G11_SHORT, $G11invalid, "All values are valid", " invalid value", $errors:G11)}
        {html:build2("G12", $labels:G12, $labels:G12_SHORT, $G12invalid, "All values are valid", " invalid value", $errors:G12)}
        {html:build2("G13", $labels:G13, $labels:G13_SHORT, $G13invalid, "All values are valid", " invalid value", $errors:G13)}
        {html:build2("G13b", $labels:G13b, $labels:G13b_SHORT, $G13binvalid, "All values are valid", " invalid value", $errors:G13b)}
        {html:build2("G13c", $labels:G13c, $labels:G13c_SHORT, $G13cinvalid, "All values are valid", " invalid value", $errors:G13c)}
        {html:build2("G14", $labels:G14, $labels:G14_SHORT, $G14table, "All values are valid", "record", errors:getMaxError($G14table))}
        {html:build2("G14b", $labels:G14b, $labels:G14b_SHORT, $G14binvalid, "All assessment regimes are reported", " missing assessment regime", $errors:G14b)}
        {html:build2("G15", $labels:G15, $labels:G15_SHORT, $G15invalid, "All values are valid", " invalid value", $errors:G15)}
        {html:build2("G17", $labels:G17, $labels:G17_SHORT, $G17invalid, "All values are valid", " invalid value", $errors:G17)}
        {html:build2("G18", $labels:G18, $labels:G18_SHORT, $G18invalid, "All values are valid", " invalid value", $errors:G18)}
        {html:build2("G19", $labels:G19, $labels:G19_SHORT, $G19invalid, "All values are valid", "", $errors:G19)}
        {html:build2("G20", $labels:G20, $labels:G20_SHORT, $G20invalid, "All values are valid", "", $errors:G20)}
        {html:build2("G21", $labels:G21, $labels:G21_SHORT, $G21invalid, "No invalid protection target types found", " invalid value", $errors:G21)}
        {html:build2("G22", $labels:G22, $labels:G22_SHORT, $G22invalid, "No invalid objective types for Health found", " invalid value", $errors:G22)}
        {html:buildInfoTR("Specific checks on aqd:exceedanceDescriptionBase")}
        {html:build2("G38", $labels:G38, $labels:G38_SHORT, $G38invalid, "All values are valid", "", $errors:G38)}
        {html:build2("G39", $labels:G39, $labels:G39_SHORT, $G39invalid, "All values are valid", " invalid value", $errors:G39)}
        {html:build2("G40", $labels:G40, $labels:G40_SHORT, $G40invalid, "All values are valid", " invalid value", $errors:G40)}
        {html:build2("G41", $labels:G41, $labels:G41_SHORT, $G41invalid, "All values are valid", " invalid value", $errors:G41)}
        {html:build2("G42", $labels:G42, $labels:G42_SHORT, $G42invalid, "All values are valid", " invalid value", $errors:G42)}
        {html:build2("G44", $labels:G44, $labels:G44_SHORT, $G44invalid, "All values are valid", " invalid value", $errors:G44)}
        {html:build2("G45", $labels:G45, $labels:G45_SHORT, $G45invalid, "All values are valid", " invalid value", $errors:G45)}
        {html:build2("G46", $labels:G46, $labels:G46_SHORT, $G46invalid, "All values are valid", " invalid value", $errors:G46)}
        {html:build2("G47", $labels:G47, $labels:G47_SHORT, $G47invalid, "All values are valid", " invalid value", $errors:G47)}
        {html:buildInfoTR("Specific checks on aqd:exceedanceDescriptionAdjustment")}
        {html:build2("G52", $labels:G52, $labels:G52_SHORT, $G52invalid, "All values are valid", "", $errors:G52)}
        {html:build2("G53", $labels:G53, $labels:G53_SHORT, $G53invalid, "All values are valid", " invalid value", $errors:G53)}
        {html:build2("G54", $labels:G54, $labels:G54_SHORT, $G54invalid, "All values are valid", " invalid value", $errors:G54)}
        {html:build2("G55", $labels:G55, $labels:G55_SHORT, $G55invalid, "All values are valid", " invalid value", $errors:G55)}
        {html:build2("G56", $labels:G56, $labels:G56_SHORT, $G56invalid, "All values are valid", " invalid value", $errors:G56)}
        {html:build2("G58", $labels:G58, $labels:G58_SHORT, $G58invalid, "All values are valid", " invalid value", $errors:G58)}
        {html:build2("G59", $labels:G59, $labels:G59_SHORT, $G59invalid, "All values are valid", " invalid value", $errors:G59)}
        {html:build2("G60", $labels:G60, $labels:G60_SHORT, $G60invalid, "All values are valid", " invalid value", $errors:G60)}
        {html:build2("G61", $labels:G61, $labels:G61_SHORT, $G61invalid, "All values are valid", "", $errors:G61)}
        {html:build2("G62", $labels:G62, $labels:G62_SHORT, $G62invalid, "All values are valid", "", $errors:G62)}
        {html:build2("G63", $labels:G63, $labels:G63_SHORT, $G63invalid, "All values are valid", "", $errors:G63)}
        {html:build2("G64", $labels:G64, $labels:G64_SHORT, $G64invalid, "All values are valid", " invalid value", $errors:G64)}
        {html:build2("G66", $labels:G66, $labels:G66_SHORT, $G66invalid, "All values are valid", " invalid value", $errors:G66)}
        {html:build2("G67", $labels:G67, $labels:G67_SHORT, $G67invalid, "All values are valid", " invalid value", $errors:G67)}
        {html:buildInfoTR("Specific checks on aqd:exceedanceDescriptionFinal")}
        {html:build2("G70", $labels:G70, $labels:G70_SHORT, $G70invalid, "All values are valid", " invalid value", $errors:G70)}
        {html:build2("G71", $labels:G71, $labels:G71_SHORT, $G71invalid, "All values are valid", " invalid value", $errors:G71)}
        {html:build2("G72", $labels:G72, $labels:G72_SHORT, $G72invalid, "All values are valid", "", $errors:G72)}
        {html:build2("G73", $labels:G73, $labels:G73_SHORT, $G73invalid, "All values are valid", " invalid value", $errors:G73)}
        {html:build2("G74", $labels:G74, $labels:G74_SHORT, $modelUsed_74, "All values are valid", " invalid value", $errors:G74)}
        {html:build2("G75", $labels:G75, $labels:G75_SHORT, $G75invalid, "All values are valid", " invalid value", $errors:G75)}
        {html:build2("G76", $labels:G76, $labels:G76_SHORT, $G76invalid, "All values are valid", " invalid value", $errors:G76)}
        {html:build2("G78", $labels:G78, $labels:G78_SHORT, $G78invalid, "All values are valid", " invalid value", $errors:G78)}
        {html:build2("G79", $labels:G79, $labels:G79_SHORT, $G79invalid, "All values are valid", " invalid value", $errors:G79)}
        {html:build2("G80", $labels:G80, $labels:G80_SHORT, $G80invalid, "All values are valid", " invalid value", $errors:G80)}
        {html:build2("G81", $labels:G81, $labels:G81_SHORT, $G81invalid, "All values are valid", " invalid value", $errors:G81)}
        {html:build2("G85", $labels:G85, $labels:G85_SHORT, $G85invalid, "All values are valid", " invalid value", $errors:G85)}
        {html:build2("G86", $labels:G86, $labels:G86_SHORT, $G86invalid, "All values are valid", " invalid value", $errors:G86)}
        {$G82invalid}
    </table>
};


declare function dataflowG:buildVocItemsList($ruleId as xs:string, $vocabularyUrl as xs:string, $ids as xs:string*)
as element(div) {
    let $list :=
        for $id in $ids
        let $refUrl := concat($vocabularyUrl, $id)
        return
            <li><a href="{ $refUrl }">{ $refUrl } </a></li>


    return
     <div>
         <a id='vocLink-{$ruleId}' href='javascript:toggleItem("vocValuesDiv","vocLink", "{$ruleId}", "item")'>Show items</a>
         <div id="vocValuesDiv-{$ruleId}" style="display:none"><ul>{ $list }</ul></div>
     </div>


};

(:
 : ======================================================================
 : Main function
 : ======================================================================
 :)
declare function dataflowG:proceed($source_url as xs:string, $countryCode as xs:string) {

let $countZones := count(doc($source_url)//aqd:AQD_Attainment)
let $result := if ($countZones > 0) then dataflowG:checkReport($source_url, $countryCode) else ()
let $meta := map:merge((
    map:entry("count", $countZones),
    map:entry("header", "Check air quality attainment of environmental objectives"),
    map:entry("dataflow", "Dataflow G"),
    map:entry("zeroCount", <p>No aqd:AQD_Attainment elements found from this XML.</p>),
    map:entry("report", <p>This check evaluated the delivery by executing the tier-1 tests on air quality assessment regimes data in Dataflow G as specified in <a href="http://www.eionet.europa.eu/aqportal/qaqc/">e-reporting QA/QC rules documentation</a>.</p>)
))
return
    html:buildResultDiv($meta, $result)
};
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





declare variable $dataflowH:ISO2_CODES as xs:string* := ("AL","AT","BA","BE","BG","CH","CY","CZ","DE","DK","DZ","EE","EG","ES","FI",
    "FR","GB","GR","HR","HU","IE","IL","IS","IT","JO","LB","LI","LT","LU","LV","MA","ME","MK","MT","NL","NO","PL","PS","PT",
     "RO","RS","SE","SI","SK","TN","TR","XK","UK");



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

    let $envelopeUrl := common:getEnvelopeXML($source_url)
    let $docRoot := doc($source_url)
    let $cdrUrl := common:getCdrUrl($countryCode)

    let $reportingYear := common:getReportingYear($docRoot)
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

    TODO: implement pollutant lookup

    Blocker
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
                        {common:checkLink(distinct-values(data($x/aqd:usedInPlan/@xlink:href)))}
                    </td>
                    <td title="aqd:parentExceedanceSituation">
                        {common:checkLink(distinct-values(data($att-url)))}
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


    (: I09

    ./aqd:inspireId/base:Identifier/base:namespace

    List base:namespace and count the number of base:localId assigned to each
    base:namespace.

    List unique namespaces used and count number of elements

    BLOCKER

    TODO: check this, $ok is hardcoded
    :)

    let $I09table := try {
        for $namespace in distinct-values($sources/aqd:inspireId/base:Identifier/base:namespace)
            let $localIds := $sources/aqd:inspireId/base:Identifier[base:namespace = $namespace]/base:localId
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

    (: I10

    Check that namespace is registered in vocabulary
    (http://dd.eionet.europa.eu/vocabulary/aq/namespace/view)

    Check namespace is registered

    ERROR
    :)

    (: TODO: should be "and" or "or" in where clause?? :)
    let $I10invalid := try {
        let $vocDoc := doc($vocabulary:NAMESPACE || "rdf")
        let $prefLabel := $vocDoc//skos:Concept[adms:status/@rdf:resource = $dd:VALIDRESOURCE
                and @rdf:about = concat($vocabulary:NAMESPACE, $countryCode)]/skos:prefLabel[1]
        let $altLabel := $vocDoc//skos:Concept[adms:status/@rdf:resource = $dd:VALIDRESOURCE
                and @rdf:about = concat($vocabulary:NAMESPACE, $countryCode)]/skos:altLabel[1]
        for $x in distinct-values($docRoot//base:namespace)
            let $ok := ($x = $prefLabel and $x = $altLabel)
            return common:conditionalReportRow(
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
        let $el := $sources/aqd:usedInPlan
        let $label := data($el/@xlink:href)
        let $ok := query:existsViaNameLocalId($label, 'AQD_Plan')

        (: TODO: check that the Plan is for same year :)

        return common:conditionalReportRow(
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

    BLOCKER
    :)
    let $I11b := try{
        let $el := $sources/aqd:parentExceedanceSituation
        let $label := data($el/@xlink:href)
        let $ok := query:existsViaNameLocalId($label, 'AQD_Attainment')
        (:
        aqd:AQD_Attainment[aqd:exceedanceDescriptionFinal/aqd:ExceedanceDescription]
        :)

        (: TODO: check that the reporting year is for same year :)

        return common:conditionalReportRow(
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
        let $el := $sources/aqd:referenceYear/gml:TimeInstant/gml:timePosition
        let $ok := $el castable as xs:gYear

        return common:conditionalReportRow(
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
    aqd:QuantityCommented/aqd:quantity is an integer or floating point numeric
    >= 0 if attribute xsi:nil="false" (example: <aqd:quantity
    uom="http://dd.eionet.europa.eu/vocabulary/uom/concentration/ug.m-3"
    xsi:nil="false">4.03038</aqd:quantity>)

    Source apportionments should be provided as an integer

    BLOCKER
    :)
    let $I15 := try {
        let $nodes := $sources//aqd:QuantityCommented/aqd:quantity[@xsi:nil="false"]
        let $errors := array {
            for $node in $nodes
            return
                if (not(common:is-a-number(data($node))))
                then
                    [node-name($node), data($node)]
                else
                    ()
        }

        return common:conditionalReportRow(
            array:size($errors) = 0,
            $errors
        )
    } catch * {
        html:createErrorRow($err:code, $err:description)
    }

    (: I16

    Across all the delivery, check that the element
    aqd:QuantityCommented/aqd:quantity is empty if attribute
    xsi:nil="unpopulated" or "unknown" or "withheld" (example: <aqd:quantity
    uom="Unknown" nilReason="Unpopulated" xsi:nil="true"/>)

    If quantification is either "unpopulated" or "unknown" or "withheld", the
    element should be empty

    BLOCKER
    :)

    let $I16 := try {
        let $node := $docRoot//aqd:QuantityCommented/aqd:quantity
        let $ok := (
            (functx:if-empty($node/text(), "") != "")
            or
            (
                lower-case($node/@xsi:nil) = "true"
                and
                (
                    (lower-case($node/@nilReason) = "unknown")
                    or
                    (lower-case($node/@nilReason) = "unpopulated")
                    or
                    (lower-case($node/@nilReason) = "withheld")
                )
            )
        )

        return common:conditionalReportRow(
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

    ERROR
    :)

    let $I17 := try {
        let $quantity := $docRoot//aqd:QuantityCommented/aqd:quantity
        let $comment := $docRoot//aqd:QuantityCommented/aqd:comment

        let $ok := (
            (functx:if-empty($quantity/text(), "") = "")
            or
            (functx:if-empty($comment/text(), "") = "")
        )

        return common:conditionalReportRow(
            $ok,
            [
                (node-name($quantity), data($quantity)),
                (node-name($comment), data($comment))
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

        return common:conditionalReportRow(
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
        return common:conditionalReportRow(
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
        return common:conditionalReportRow(
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
        return common:conditionalReportRow(
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
        return common:conditionalReportRow(
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

                let $ok := common:is-a-number($a) or common:is-a-number($b)

            return
                if (not($ok))
                then
                    [node-name($x), $x]
                else
                    ()
        }
        return common:conditionalReportRow(
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
    let $I24 := common:isInVocabularyReport(
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





declare variable $dataflowJ:ISO2_CODES as xs:string* := ("AL","AT","BA","BE","BG","CH","CY","CZ","DE","DK","DZ","EE","EG","ES","FI",
    "FR","GB","GR","HR","HU","IE","IL","IS","IT","JO","LB","LI","LT","LU","LV","MA","ME","MK","MT","NL","NO","PL","PS","PT",
     "RO","RS","SE","SI","SK","TN","TR","XK","UK");



(: Rule implementations :)
declare function dataflowJ:checkReport($source_url as xs:string, $countryCode as xs:string) as element(table) {

let $docRoot := doc($source_url)
(: example 2014 :)
let $reportingYear := common:getReportingYear($docRoot)
(: example resources/dataflow-j/xml :)
let $envelopeUrl := common:getEnvelopeXML($source_url)
(: example cdr.eionet.europa.eu/be/eu/aqd/ :)
let $cdrUrl := common:getCdrUrl($countryCode)
(: example http://cdr.eionet.europa.eu/be/eu/aqd/j/envwmp5lw :)
let $latestEnvelopeByYearJ := query:getLatestEnvelope($cdrUrl || "j/", $reportingYear)

(: NS
Check prefix and namespaces of the gml:featureCollection according to expected root elements
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
        common:checkDeliveryReport($errors:ERROR, "Reporting Year is missing.")
    else
        if(query:deliveryExists($dataflowJ:OBLIGATIONS, $countryCode, "j/", $reportingYear))
        then
                common:checkDeliveryReport($errors:WARNING, "Updating delivery for " || $reportingYear)
            else
                common:checkDeliveryReport($errors:INFO, "New delivery for " || $reportingYear)


} catch * {
    html:createErrorRow($err:code, $err:description)
}

let $isNewDelivery := errors:getMaxError($J0) = $errors:INFO
let $knownEvaluationScenarios :=
    if ($isNewDelivery)
    then
        distinct-values(data(sparqlx:run(query:getEvaluationScenarios($cdrUrl || "j/"))//sparql:binding[@name='inspireLabel']/sparql:literal))
    else
        distinct-values(data(sparqlx:run(query:getEvaluationScenarios($latestEnvelopeByYearJ))//sparql:binding[@name='inspireLabel']/sparql:literal))

(: J1
Compile & feedback upon the total number of plans records included in the delivery

Number of AQ Plans reported
:)

let $countEvaluationScenario := count($docRoot//aqd:AQD_EvaluationScenario)
let $J1 := try {
    for $rec in $docRoot//aqd:AQD_EvaluationScenario
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

(: J2
Compile & feedback upon the total number of new EvaluationScenarios records included in the delivery.
ERROR will be returned if XML is a new delivery and localId are not new compared to previous deliveries.

Number of new EvaluationScenarios compared to previous report.
:)

let $J2 := try {
    let $el := $docRoot//aqd:AQD_EvaluationScenario
    for $x in $el/aqd:inspireId/base:Identifier
        let $inspireId := concat(data($x/base:namespace), "/", data($x/base:localId))
        let $ok := not($inspireId = $knownEvaluationScenarios)
        return
            common:conditionalReportRow(
            $ok,
            [
                ("gml:id", data($el/@gml:id)),
                ("aqd:inspireId", $inspireId)
            ]
            )
} catch * {
    html:createErrorRow($err:code, $err:description)
}
let $J2errorLevel :=
    if (
        $isNewDelivery
        and
        count(
            for $x in $docRoot//aqd:AQD_EvaluationScenario/aqd:inspireId/base:Identifier
                let $id := $x/base:namespace || "/" || $x/base:localId
                where query:existsViaNameLocalId($id, 'AQD_EvaluationScenario')
                return 1
        ) > 0
        )
    then
        $errors:K02
    else
        $errors:INFO

(: J3
Compile & feedback upon the total number of updated EvaluationScenarios records included in the delivery.
ERROR will be returned if XML is an update and ALL localId (100%) are different
to previous delivery (for the same YEAR).

Number of existing EvaluationScenarios compared to previous report.
ERROR will be returned if XML is an update and ALL localId (100%)
are different to previous delivery (for the same YEAR).
:)

let $J3 := try {
    let $main := $docRoot//aqd:AQD_EvaluationScenario
    for $x in $main/aqd:inspireId/base:Identifier
    let $inspireId := concat(data($x/base:namespace), "/", data($x/base:localId))
    let $ok := not(query:existsViaNameLocalId($inspireId, 'AQD_EvaluationScenario'))
    return
        common:conditionalReportRow(
        $ok,
        [
            ("gml:id", data($main/@gml:id)),
            ("aqd:inspireId", $inspireId),
            ("aqd:classification", common:checkLink(distinct-values(data($main/aqd:classification/@xlink:href))))
        ]
        )
} catch * {
    html:createErrorRow($err:code, $err:description)
}
let $J3errorLevel :=
    if (not($isNewDelivery) and count($J3) = 0)
    then
        $errors:J3
    else
        $errors:INFO

(: J4
Compile & feedback a list of the unique identifier information
for all EvaluationScenarios records included in the delivery.
Feedback report shall include the gml:id attribute, ./aqd:inspireId, ./aqd:pollutant, ./aqd:protectionTarget,

List of unique identifier information for all EvaluationScenarios records. Blocker if no EvaluationScenarios
:)

let $J4 := try {
    let $gmlIds := $docRoot//aqd:AQD_EvaluationScenario/lower-case(normalize-space(@gml:id))
    let $inspireIds := $docRoot//aqd:AQD_EvaluationScenario/lower-case(normalize-space(aqd:inspireId))
    for $x in $docRoot//aqd:AQD_EvaluationScenario
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
                ("aqd:protectionTarget", data($x/aqd:protectionTarget))
            ]
        )
} catch * {
    html:createErrorRow($err:code, $err:description)
}


(: J5 RESERVE :)

let $J5 := ()

(: J6 RESERVE :)

let $J6 := ()

(: J7
All gml:id attributes, ef:inspireId and aqd:inspireId elements shall have unique content

All gml ID attributes shall have unique code
:)

let $J7 := try {
    let $main := $docRoot//aqd:AQD_EvaluationScenario

    let $checks := ('gml:id', 'aqd:inspireId', 'ef:inspireId')

    let $errors := array {

        for $name in $checks
            let $name := lower-case(normalize-space($name))
            let $values := $main//(*[lower-case(normalize-space(name())) = $name] |
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

(: J8
./aqd:inspireId/base:Identifier/base:localId must be unique code for the Plans records

Local Id must be unique for the EvaluationScenarios records
:)

let $J8 := try {
    let $localIds := $docRoot//aqd:AQD_EvaluationScenario/aqd:inspireId/base:Identifier/lower-case(normalize-space(base:localId))
    for $x in $docRoot//aqd:AQD_EvaluationScenario
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

(: J9
 ./aqd:inspireId/base:Identifier/base:namespace List base:namespace
 and count the number of base:localId assigned to each base:namespace.

 List unique namespaces used and count number of elements
:)

let $J9 := try {
    for $namespace in distinct-values($docRoot//aqd:AQD_EvaluationScenario/aqd:inspireId/base:Identifier/base:namespace)
        let $localIds := $docRoot//aqd:AQD_EvaluationScenario/aqd:inspireId/base:Identifier[base:namespace = $namespace]/base:localId
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

(: J10
Check that namespace is registered in vocabulary (http://dd.eionet.europa.eu/vocabulary/aq/namespace/view)

Check namespace is registered
:)

let $J10 := try {
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

(: J11
aqd:AQD_EvaluationScenario/aqd:usedInPlan shall reference an existing AQD_Plan (H) document
for the same reporting year same year via namespace/localId

You must provide a reference to a plan document from data flow H via its namespace & localId.
The plan document must have the same reporting year as the source apportionment document.
:)

let $J11 := try {
    let $el := $docRoot//aqd:AQD_EvaluationScenario/aqd:usedInPlan
    let $label := $el/@xlink:href
    let $ok := query:existsViaNameLocalIdYear(
            $label,
            'AQD_Plan',
            $reportingYear
    )
    return common:conditionalReportRow(
            $ok,
            [
                (node-name($el), $label)
            ]
        )
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: J12
aqd:AQD_EvaluationScenario/aqd:sourceApportionment MUST reference an existing AQD_SourceApportionment (I) document
via namespace/localId record for the same reporting year .

You must provide a link to a Source Apportionment (I) document from data flow I
via its namespace & localId (for the same reporting year)
:)

let $J12 := try {
    let $el := $docRoot//aqd:AQD_EvaluationScenario/aqd:sourceApportionment
    let $label := $el/@xlink:href
    let $ok := query:existsViaNameLocalIdYear(
            $label,
            'AQD_SourceApportionment',
            $reportingYear
    )
    return common:conditionalReportRow(
            $ok,
            [
                (node-name($el), $label)
            ]
        )
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: J13
aqd:AQD_EvaluationScenario/aqd:codeOfScenario should begin with with the 2-digit country code according to ISO 3166-1.

A code of the scenario should be provided as nn alpha-numeric code starting with the country ISO code
:)

let $J13 := try {
    let $el := $docRoot//aqd:AQD_EvaluationScenario/aqd:codeOfScenario
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

(: J14
aqd:AQD_EvaluationScenario/aqd:publication/aqd:Publication/aqd:description shall be a text string

Short textul description of the publication should be provided. If availabel, include the ISBN number.
:)

let $J14 := try {
    let $main := $docRoot//aqd:AQD_EvaluationScenario/aqd:publication/aqd:Publication/aqd:description
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

(: J15
aqd:AQD_EvaluationScenario/aqd:publication/aqd:Publication/aqd:title
shall be a text string

Title as written in the publication.
:)

let $J15 := try {
    let $main := $docRoot//aqd:AQD_EvaluationScenario/aqd:publication/aqd:Publication/aqd:title
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

(: J16
aqd:AQD_EvaluationScenario/aqd:publication/aqd:Publication/aqd:author shall be a text string (if provided)

Author(s) should be provided as text (If there are multiple authors, please provide in one field separated by commas)
:)

let $J16 := try {
    let $main := $docRoot//aqd:AQD_EvaluationScenario/aqd:publication/aqd:Publication/aqd:author
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

(: J17
aqd:AQD_EvaluationScenario/aqd:publication/aqd:Publication/aqd:publicationDate/gml:TimeInstant/gml:timePosition
may be a data in yyyy or yyyy-mm-dd format

The publication date should be provided in yyyy or yyyy-mm-dd format
:)

let $J17 := try {
    let $main := $docRoot//aqd:AQD_EvaluationScenario/aqd:publication/aqd:Publication/aqd:publicationDate/gml:TimeInstant/gml:timePosition
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

(: J18
aqd:AQD_EvaluationScenario/aqd:publication/aqd:Publication/aqd:publisher
shall be a text string

Publisher should be provided as a text (Publishing institution, academic jourmal, etc.)
:)

let $J18 := try {
    let $main := $docRoot//aqd:AQD_EvaluationScenario/aqd:publication/aqd:Publication/aqd:publisher
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

(: J19
aqd:AQD_EvaluationScenario/aqd:publication/aqd:Publication/aqd:webLink
as a valid url (if provided)

Url to the published AQ Plan should be valid (if provided)
:)

let $J19 := try {
    let $main :=  $docRoot//aqd:AQD_EvaluationScenario/aqd:publication/aqd:Publication/aqd:webLink
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

(: J20
aqd:AQD_EvaluationScenario/aqd:attainmentYear/gml:TimeInstant/gml:timePosition must be provided and must conform to yyyy format

The year for which the projections are developed must be provided and the yyyy format used
:)

let $J20 := try {
    let $main := $docRoot//aqd:AQD_EvaluationScenario/aqd:attainmentYear/gml:TimeInstant/gml:timePosition
    for $el in $main
        let $ok := data($el) castable as xs:gYear
        return common:conditionalReportRow(
                $ok,
                [
                    (node-name($el), $el)
                ]
            )

} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: J21
aqd:AQD_EvaluationScenario/aqd:startYear/gml:TimeInstant/gml:timePosition
must be provided and must conform to yyyy format

Reference year from which the projections started and
for which the source apportionment is available must be provided. Format used yyyy.
:)

let $J21 := try {
    let $main := $docRoot//aqd:AQD_EvaluationScenario/aqd:startYear/gml:TimeInstant/gml:timePosition
    for $el in $main
        let $ok := (
            data($el) castable as xs:gYear
            and
            functx:if-empty(data($el), "") != ""
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

(: J22
Check aqd:AQD_EvaluationScenario/aqd:startYear/gml:TimeInstant/gml:timePosition must be equal to
aqd:AQD_SourceApportionment/aqd:referenceYear/gml:TimeInstant/gml:timePosition
referenced via the xlink of (aqd:AQD_EvaluationScenario/aqd:sourceApportionment)

Check if start year of the evaluation scenario is the same as the source apportionment reference year
:)

let $J22 := try {
    let $el := $docRoot//aqd:AQD_EvaluationScenario/aqd:sourceApportionment
    let $year := $docRoot//aqd:AQD_EvaluationScenario/aqd:startYear/gml:TimeInstant/gml:timePosition
    let $ok := query:existsViaNameLocalIdYear(
            $el/@xlink:href,
            'AQD_SourceApportionment',
            $year
    )
    return common:conditionalReportRow(
                $ok,
                [
                    (node-name($el), $el/@xlink:href)
                ]
            )

} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: J23
aqd:AQD_EvaluationScenario/aqd:baselineScenario/aqd:Scenario/aqd:description shall be a text string

A description of the emission scenario used for the baseline analysis should be provided as text
:)

let $J23 := try {
    let $main := $docRoot//aqd:AQD_EvaluationScenario/aqd:baselineScenario/aqd:Scenario/aqd:description
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

(: J24
Check that the element aqd:AQD_EvaluationScenario/aqd:baselineScenario/aqd:Scenario/aqd:totalEmissions
is an integer or floating point numeric >= 0 and the unit (@uom) shall resolve to the codelist
http://dd.eionet.europa.eu/vocabulary/uom/emission/kt.year-1

The baseline total emissions should be provided as integer with correct unit.
:)

let $J24 := try {
    let $el := $docRoot//aqd:AQD_EvaluationScenario/aqd:baselineScenario/aqd:Scenario/aqd:totalEmissions
    let $ok := (
        $el/@uom eq "http://dd.eionet.europa.eu/vocabulary/uom/emission/kt.year-1"
        and
        (data($el) castable as xs:float
        or
        data($el) castable as xs:integer)
        and
        data($el) >= 0
        and
        common:isInVocabulary(
                $el/@uom,
                $vocabulary:UOM_EMISSION_VOCABULARY
        )
    )
    return common:conditionalReportRow(
            $ok,
            [
                ("aqd:totalEmissions", $el),
                ("uom", $el/@uom)
            ]
        )
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: J25
Check that the element aqd:AQD_EvaluationScenario/aqd:baselineScenario/aqd:AQD_Scenario/aqd:expectedConcentration
is an integer or floating point numeric >= 0 and the unit (@uom) shall resolve to the codelist
http://dd.eionet.europa.eu/vocabulary/uom/concentration/

The expected concentration (under baseline scenario) should be provided as an integer and its unit should conform to vocabulary
:)

let $J25 := try {
    let $el := $docRoot//aqd:AQD_EvaluationScenario/aqd:baselineScenario/aqd:AQD_Scenario/aqd:expectedConcentration
    let $ok := (
        (data($el) castable as xs:float
        or
        data($el) castable as xs:integer)
        and
        data($el) >= 0
        and
        common:isInVocabulary(
                $el/@uom,
                $vocabulary:UOM_CONCENTRATION_VOCABULARY
        )
    )
    return common:conditionalReportRow(
            $ok,
            [
                ("aqd:expectedConcentration", $el),
                ("uom", $el/@uom)
            ]
        )
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: J26
Check that the element aqd:AQD_EvaluationScenario/aqd:baselineScenario/aqd:AQD_Scenario/aqd:expectedExceedances
is an integer or floating point numeric >= 0 and the unit (@uom) shall resolve to the codelist
http://dd.eionet.europa.eu/vocabulary/uom/statistics

The number of exceecedance expected (under baseline scenario) should be provided as an integer and its unit should conform to vocabulary
:)

let $J26 := try {
    let $el := $docRoot//aqd:AQD_EvaluationScenario/aqd:baselineScenario/aqd:AQD_Scenario/aqd:expectedExceedances
    let $ok := (
        (data($el) castable as xs:float
        or
        data($el) castable as xs:integer)
        and
        data($el) >= 0
        and
        common:isInVocabulary(
                $el/@uom,
                $vocabulary:UOM_STATISTICS
        )
    )
    return common:conditionalReportRow(
            $ok,
            [
                ("aqd:expectedExceedances", $el),
                ("uom", $el/@uom)
            ]
        )
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: J27
aqd:AQD_EvaluationScenario/aqd:baselineScenario/aqd:Scenario/aqd:measuresApplied
shall reference an existing AQD_Measures delivered within a data flow K
and the reporting year of K & J shall be the same year via namespace/localId.

Measures identified in the AQ-plan that are included in this baseline scenario should be provided (link to dataflow K)
:)

let $J27 := try{
    let $main := $docRoot//aqd:AQD_EvaluationScenario/aqd:baselineScenario/aqd:Scenario/aqd:measuresApplied
    for $el in $main
        let $ok := query:existsViaNameLocalIdYear(
                $el/@xlink:href,
                'AQD_Measures',
                $reportingYear
        )
        return common:conditionalReportRow(
                $ok,
                [
                    (node-name($el), $el/@xlink:href)
                ]
            )
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: J28
aqd:AQD_EvaluationScenario/aqd:projectionScenario/aqd:Scenario/aqd:description shall be a text string

A description of the emission scenario used for the projection analysis should be provided as text
:)

let $J28 := try {
    let $el := $docRoot//aqd:AQD_EvaluationScenario/aqd:projectionScenario/aqd:Scenario/aqd:description
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

(: J29
Check that the element aqd:AQD_EvaluationScenario/aqd:projectionScenario/aqd:Scenario/aqd:totalEmissions
is an integer or floating point numeric >= 0 and the unit (@uom) shall resolve to the codelist
http://dd.eionet.europa.eu/vocabulary/uom/emission/kt.year-1

The projection total emissions should be provided as integer with correct unit.
:)


let $J29 := try {
    let $el := $docRoot//aqd:AQD_EvaluationScenario/aqd:projectionScenario/aqd:Scenario/aqd:totalEmissions
    let $ok := (
        $el/@uom eq "http://dd.eionet.europa.eu/vocabulary/uom/emission/kt.year-1"
        and
        (data($el) castable as xs:float
        or
        data($el) castable as xs:integer)
        and
        data($el) >= 0
        and
        common:isInVocabulary(
                $el/@uom,
                $vocabulary:UOM_EMISSION_VOCABULARY
        )
    )
    return common:conditionalReportRow(
            $ok,
            [
                ("aqd:totalEmissions", $el),
                ("uom", $el/@uom)
            ]
        )
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: J30
Check that the element aqd:AQD_EvaluationScenario/aqd:projectionScenario/aqd:AQD_Scenario/aqd:expectedConcentration
is an integer or floating point numeric >= 0 and the unit (@uom) shall resolve to the codelist
http://dd.eionet.europa.eu/vocabulary/uom/concentration/

The expected concentration (under projection scenario) should be provided as an integer and its unit should conform to vocabulary
:)

let $J30 := try {
    let $el := $docRoot//aqd:AQD_EvaluationScenario/aqd:projectionScenario/aqd:AQD_Scenario/aqd:expectedConcentration
    let $ok := (
        (data($el) castable as xs:float
        or
        data($el) castable as xs:integer)
        and
        data($el) >= 0
        and
        common:isInVocabulary(
                $el/@uom,
                $vocabulary:UOM_CONCENTRATION_VOCABULARY
        )
    )
    return common:conditionalReportRow(
            $ok,
            [
                ("aqd:expectedConcentration", $el),
                ("uom", $el/@uom)
            ]
        )
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: J31
Check that the element aqd:AQD_EvaluationScenario/aqd:projectionScenario/aqd:AQD_Scenario/aqd:expectedExceedances
is an integer or floating point numeric >= 0 and the unit (@uom) shall resolve to the codelist
http://dd.eionet.europa.eu/vocabulary/uom/statistics

The number of exceecedance expected (under projection scenario) should be provided
as an integer and its unit should conform to vocabulary
:)

let $J31 := try {
    let $el := $docRoot//aqd:AQD_EvaluationScenario/aqd:projectionScenario/aqd:AQD_Scenario/aqd:expectedExceedances
    let $ok := (
        (data($el) castable as xs:float
        or
        data($el) castable as xs:integer)
        and
        data($el) >= 0
        and
        common:isInVocabulary(
                $el/@uom,
                $vocabulary:UOM_STATISTICS
        )
    )
    return common:conditionalReportRow(
            $ok,
            [
                ("aqd:expectedExceedances", $el),
                ("uom", $el/@uom)
            ]
        )
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: J32
aqd:AQD_EvaluationScenario/aqd:projectionScenario/aqd:Scenario/aqd:measuresApplied
shall reference an existing AQD_Measures delivered within a data flow K
and the reporting year of K & J shall be the same year via namespace/localId.

Measures identified in the AQ-plan that are included in this projection should be provided (link to dataflow K)
:)

let $J32 := try{
    let $main := $docRoot//aqd:AQD_EvaluationScenario/aqd:projectionScenario/aqd:Scenario/aqd:measuresApplied
    for $el in $main
        let $ok := query:existsViaNameLocalIdYear(
                $el/@xlink:href,
                'AQD_Measures',
                $reportingYear
        )
        return common:conditionalReportRow(
                $ok,
                [
                    (node-name($el), $el/@xlink:href)
                ]
            )
} catch * {
    html:createErrorRow($err:code, $err:description)
}

return
(
    <table class="maintable hover">
        {html:build2("NS", $labels:NAMESPACES, $labels:NAMESPACES_SHORT, $NSinvalid, "All values are valid", "record", $errors:NS)}
        {html:build3("J0", $labels:J0, $labels:J0_SHORT, $J0, string($J0/td), errors:getMaxError($J0))}
        {html:build1("J1", $labels:J1, $labels:J1_SHORT, $J1, "", string($countEvaluationScenario), "", "", $errors:J1)}
        {html:buildSimple("J2", $labels:J2, $labels:J2_SHORT, $J2, "", "", $J2errorLevel)}
        {html:buildSimple("J3", $labels:J3, $labels:J3_SHORT, $J3, "", "", $J3errorLevel)}
        {html:build1("J4", $labels:J4, $labels:J4_SHORT, $J4, "", string(count($J4)), " ", "", $errors:J4)}
        {html:build1("J5", $labels:J5, $labels:J5_SHORT, $J5, "RESERVE", "RESERVE", "RESERVE", "RESERVE", $errors:J5)}
        {html:build1("J6", $labels:J6, $labels:J6_SHORT, $J6, "RESERVE", "RESERVE", "RESERVE", "RESERVE", $errors:J6)}
        {html:build2("J7", $labels:J7, $labels:J7_SHORT, $J7, "No duplicate values found", " duplicate value", $errors:J7)}
        {html:build2("J8", $labels:J8, $labels:J8_SHORT, $J8, "No duplicate values found", " duplicate value", $errors:J8)}
        {html:buildUnique("J9", $labels:J9, $labels:J9_SHORT, $J9, "namespace", $errors:J9)}
        {html:build2("J10", $labels:J10, $labels:J10_SHORT, $J10, "All values are valid", " not conform to vocabulary", $errors:J10)}
        {html:build2("J11", $labels:J11, $labels:J11_SHORT, $J11, "All values are valid", "needs valid input", $errors:J11)}
        {html:build2("J12", $labels:J12, $labels:J12_SHORT, $J12, "All values are valid", "needs valid input", $errors:J12)}
        {html:build2("J13", $labels:J13, $labels:J13_SHORT, $J13, "All values are valid", " not valid", $errors:J13)}
        {html:build2("J14", $labels:J14, $labels:J14_SHORT, $J14, "All values are valid", "needs valid input", $errors:J14)}
        {html:build2("J15", $labels:J15, $labels:J15_SHORT, $J15, "All values are valid", "needs valid input", $errors:J15)}
        {html:build2("J16", $labels:J16, $labels:J16_SHORT, $J16, "All values are valid", "needs valid input", $errors:J16)}
        {html:build2("J17", $labels:J17, $labels:J17_SHORT, $J17, "All values are valid", "not valid", $errors:J17)}
        {html:build2("J18", $labels:J18, $labels:J18_SHORT, $J18, "All values are valid", "needs valid input", $errors:J18)}
        {html:build2("J19", $labels:J19, $labels:J19_SHORT, $J19, "All values are valid", "not valid", $errors:J19)}
        {html:build2("J20", $labels:J20, $labels:J20_SHORT, $J20, "All values are valid", "not valid", $errors:J20)}
        {html:build2("J21", $labels:J21, $labels:J21_SHORT, $J21, "All values are valid", "not valid", $errors:J21)}
        {html:build2("J22", $labels:J22, $labels:J22_SHORT, $J22, "All values are valid", "not valid", $errors:J22)}
        {html:build2("J23", $labels:J23, $labels:J23_SHORT, $J23, "All values are valid", "not valid", $errors:J23)}
        {html:build2("J24", $labels:J24, $labels:J24_SHORT, $J24, "All values are valid", "not valid", $errors:J24)}
        {html:build2("J25", $labels:J25, $labels:J25_SHORT, $J25, "All values are valid", "not valid", $errors:J25)}
        {html:build2("J26", $labels:J26, $labels:J26_SHORT, $J26, "All values are valid", "not valid", $errors:J26)}
        {html:build2("J27", $labels:J27, $labels:J27_SHORT, $J27, "All values are valid", "not valid", $errors:J27)}
        {html:build2("J28", $labels:J28, $labels:J28_SHORT, $J28, "All values are valid", "not valid", $errors:J28)}
        {html:build2("J29", $labels:J29, $labels:J29_SHORT, $J29, "All values are valid", "not valid", $errors:J29)}
        {html:build2("J30", $labels:J30, $labels:J30_SHORT, $J30, "All values are valid", "not valid", $errors:J30)}
        {html:build2("J31", $labels:J31, $labels:J31_SHORT, $J31, "All values are valid", "not valid", $errors:J31)}
        {html:build2("J32", $labels:J32, $labels:J32_SHORT, $J32, "All values are valid", "not valid", $errors:J32)}

    </table>
)
};


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

(:
 : Module Name: Implementing Decision 2011/850/EU: AQ info exchange & reporting (Library module)
 :
 : Version:     $Id$
 : Created:     9 November 2017
 : Copyright:   European Environment Agency
 :
 : XQuery script implements dataflow K checks.
 :
 : @author Laszlo Cseh
 :)







(: These attributes should be unique :)
declare variable $dataflowK:UNIQUE_IDS as xs:string* := (
  "gml:id",
  "ef:inspireId",
  "aqd:inspireId"
);


(: Rule implementations :)
declare function dataflowK:checkReport($source_url as xs:string, $countryCode as xs:string) as element(table) {

let $envelopeUrl := common:getEnvelopeXML($source_url)
let $docRoot := doc($source_url)
(: cdr.eionet.europa.eu/be/eu/aqd/ :)
let $cdrUrl := common:getCdrUrl($countryCode)
let $bdir := if (contains($source_url, "k_preliminary")) then "k_preliminary/" else "k/"
(: 2004  :)
let $reportingYear := common:getReportingYear($docRoot)
let $latestEnvelopeB := query:getLatestEnvelope($cdrUrl || $bdir, $reportingYear)
let $nameSpaces := distinct-values($docRoot//base:namespace)
let $zonesNamespaces := distinct-values($docRoot//aqd:AQD_Zone/am:inspireId/base:Identifier/base:namespace)

let $latestEnvelopeByYearK := query:getLatestEnvelope($cdrUrl || "k/", $reportingYear)

let $namespaces := distinct-values($docRoot//base:namespace)

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

(: K0 Checks if this delivery is new or an update (on same reporting year) :)

let $K0table := try {
    if ($reportingYear = "")
    then
        common:checkDeliveryReport($errors:ERROR, "Reporting Year is missing.")
    else
        if (query:deliveryExists($dataflowK:OBLIGATIONS, $countryCode, "k/", $reportingYear))
            then
            common:checkDeliveryReport($errors:WARNING, "Updating delivery for " || $reportingYear)
            else
            common:checkDeliveryReport($errors:INFO, "New delivery for " || $reportingYear)
} catch * {
    html:createErrorRow($err:code, $err:description)
}
let $isNewDelivery := errors:getMaxError($K0table) = $errors:INFO
let $knownMeasures :=
    if ($isNewDelivery)
    then
        distinct-values(data(sparqlx:run(query:getMeasures($cdrUrl || "k/"))//sparql:binding[@name='inspireLabel']/sparql:literal))
    else
        distinct-values(data(sparqlx:run(query:getMeasures($latestEnvelopeByYearK))//sparql:binding[@name='inspireLabel']/sparql:literal))

(: K01 Number of Measures reported :)

let $countMeasures := count($docRoot//aqd:AQD_Measures)
let $K01 := try {
    for $rec in $docRoot//aqd:AQD_Measures
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

(: K02 Compile & feedback upon the total number of new Measures records included in the delivery.
ERROR will be returned if XML is a new delivery and localId are not new compared to previous deliveries. :)

let $K02table := try {
    let $main := $docRoot//aqd:AQD_Measures
    for $x in $main/aqd:inspireId/base:Identifier
        let $inspireId := concat(data($x/base:namespace), "/", data($x/base:localId))
        let $ok := not($inspireId = $knownMeasures)
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
let $K02errorLevel :=
    if (
        $isNewDelivery
        and
        count(
            for $x in $docRoot//aqd:AQD_Measures/aqd:inspireId/base:Identifier
                let $id := $x/base:namespace || "/" || $x/base:localId
                where query:existsViaNameLocalId($id, 'AQD_Measures')
                return 1
        ) > 0
        )
    then
        $errors:K02
    else
        $errors:INFO

(: K03 Compile & feedback upon the total number of updated Measures included in the delivery.
ERROR will be returned if XML is an update and ALL localId (100%) are different to previous delivery (for the same YEAR). :)

let $K03table := try {
    let $main := $docRoot//aqd:AQD_Measures
    for $x in $main/aqd:inspireId/base:Identifier
    let $inspireId := concat(data($x/base:namespace), "/", data($x/base:localId))
    let $ok := not(query:existsViaNameLocalId($inspireId, 'AQD_Measures'))
    return
        common:conditionalReportRow(
        $ok,
        [
            ("gml:id", data($main/@gml:id)),
            ("aqd:inspireId", $inspireId),
            ("aqd:classification", common:checkLink(distinct-values(data($main/aqd:classification/@xlink:href))))
        ]
        )
} catch * {
    html:createErrorRow($err:code, $err:description)
}
let $K03errorLevel :=
    if (not($isNewDelivery) and count($K03table) = 0)
    then
        $errors:K03
    else
        $errors:INFO

(: K04 Compile & feedback a list of the unique identifier information for all Measures records included in the delivery.
Feedback report shall include the gml:id attribute, ./aqd:inspireId, aqd:AQD_SourceApportionment (via ./exceedanceAffected), aqd:AQD_Scenario (via aqd:usedForScenario) :)

let $K04table := try {
    let $gmlIds := $docRoot//aqd:AQD_Measures/lower-case(normalize-space(@gml:id))
    let $inspireIds := $docRoot//aqd:AQD_Measures/lower-case(normalize-space(aqd:inspireId))
    for $x in $docRoot//aqd:AQD_Measures
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
                ("aqd:AQD_Measures", common:checkLink(distinct-values(data($x/aqd:exceedanceAffected/@xlink:href)))),
                ("aqd:AQD_Scenario", common:checkLink(distinct-values(data($x/aqd:usedForScenario/@xlink:href))))
            ]
        )
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: K05
RESERVE
:)
let $K05 := ()

(: K06
RESERVE
:)
let $K06 := ()

(: K07
All gml:id attributes, ef:inspireId and aqd:inspireId elements shall have unique content

All gml ID attributes shall have unique code

    count(index-of($gmlIds, lower-case(normalize-space($id)))) = 1
    or count(index-of($inspireIds, lower-case(normalize-space($inspireId)))) = 1
    or (
        count(index-of($efInspireIds, lower-case(normalize-space($efInspireId)))) = 1
        and not(empty($efInspireId))
    )

:)

let $K07 := try {
    let $main := $docRoot//aqd:AQD_Measures

    let $checks := ('gml:id', 'aqd:inspireId', 'ef:inspireId')

    let $errors := array {

        for $name in $checks
        (: TODO: would be nice to have something like this, but we have no
           value for error row
            return
                if has-duplicate-children-values($main, $name)
                then
                    [$name, $name]
                else
                    ()
        :)
            let $name := lower-case(normalize-space($name))
            let $values := $main//(*[lower-case(normalize-space(name())) = $name] |
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

    (:
    let $gmlIds := $main//lower-case(normalize-space(@gml:id))
    let $inspireIds := $main//lower-case(normalize-space(aqd:inspireId))
    let $efInspireIds := $main//lower-case(normalize-space(ef:inspireId))
    for $el in $main
        let $id := $el/@gml:id
        let $inspireId := $el/aqd:inspireId
        let $efInspireId := $el/ef:inspireId

        let $ok := (
            c:has-one($gmlIds, $id)
            and
            c:has-one($inspireIds, $inspireId)
            and
            c:has-one($efInspireIds, $efInspireId)
        )
        return c:conditionalReportRow(
            $ok,
            [
                (name($id), data($id)),
                (node-name($inspireId), data($inspireId)),
                (node-name($efInspireId), data($efInspireId))
            ]
        )
    :)
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: K08 ./aqd:inspireId/base:Identifier/base:localId must be unique code for the Measure records :)

let $K08invalid:= try {
    let $localIds := $docRoot//aqd:AQD_Measures/aqd:inspireId/base:Identifier/lower-case(normalize-space(base:localId))
    for $x in $docRoot//aqd:AQD_Measures
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
                ("aqd:inspireId", distinct-values($aqdinspireId)),
                ("aqd:AQD_Measures", common:checkLink(distinct-values(data($x/aqd:exceedanceAffected/@xlink:href)))),
                ("aqd:AQD_Scenario", distinct-values(data($x/aqd:usedForScenario/@xlink:href)))
            ]
        )
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: K09 ./aqd:inspireId/base:Identifier/base:namespace List base:namespace and count the number of base:localId assigned to each base:namespace.  :)

let $K09table := try {
    for $namespace in distinct-values($docRoot//aqd:AQD_Measures/aqd:inspireId/base:Identifier/base:namespace)
        let $localIds := $docRoot//aqd:AQD_Measures/aqd:inspireId/base:Identifier[base:namespace = $namespace]/base:localId
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

(: K10 Check that namespace is registered in vocabulary (http://dd.eionet.europa.eu/vocabulary/aq/namespace/view) :)

(: TODO: should be "and" or "or" in where clause?? :)
let $K10invalid := try {
    let $vocDoc := doc($vocabulary:NAMESPACE || "rdf")
    let $prefLabel := $vocDoc//skos:Concept[adms:status/@rdf:resource = $dd:VALIDRESOURCE
            and @rdf:about = concat($vocabulary:NAMESPACE, $countryCode)]/skos:prefLabel[1]
    let $altLabel := $vocDoc//skos:Concept[adms:status/@rdf:resource = $dd:VALIDRESOURCE
            and @rdf:about = concat($vocabulary:NAMESPACE, $countryCode)]/skos:altLabel[1]
    for $x in distinct-values($docRoot//base:namespace)
        let $ok := ($x = $prefLabel and $x = $altLabel)
        return common:conditionalReportRow(
            $ok,
            [
                ("base:namespace", $x)
            ]
        )

} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: K11
aqd:AQD_Measures/aqd:exceedanceAffected MUST reference
an existing Source Apportionment (I) document via namespace/localId

You must provide a link to a source apportionment document from data flow I via its namespace & localId.
:)

let $K11 := try{
    let $el := $docRoot//aqd:AQD_Measures/aqd:exceedanceAffected
    let $label := data($el/@xlink:href)
    let $ok := query:existsViaNameLocalId($label, 'AQD_SourceApportionment')

    return common:conditionalReportRow(
        $ok,
        [
            (node-name($el), $el/@xlink:href)
        ]
    )
} catch * {
    html:createErrorRow($err:code, $err:description)
}


(: K12
aqd:AQD_Measures/aqd:usedForScenario shall reference an existing Scenario
delivered within a data flow J  via namespace/localId.

A link may be provided to Evaluation Scenario (J). This must be valid via namespace & localId
:)

let $K12 := try {
    let $el := $docRoot//aqd:AQD_Measures/aqd:usedForScenario
    let $label := data($el/@xlink:href)
    let $ok := query:existsViaNameLocalId($label, 'AQD_EvaluationScenario')

    return common:conditionalReportRow(
        $ok,
        [
            (node-name($el), $el/@xlink:href)
        ]
    )
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: K13
aqd:AQD_Measures/aqd:code must be unique and should match base:localId

Unique code of the measure. This may be a unique local code for the measure or
may be identical to the unique code used in K2.1.

TODO: we implemented just first line of the requirement, the second line contradicts it
:)

let $K13invalid := try {
    for $node in $docRoot//aqd:AQD_Measures
        let $code := $node/aqd:code
        let $localId := $node/aqd:inspireId/base:Identifier/base:localId
        let $ok := $code = $localId
        return common:conditionalReportRow(
            $ok,
            [
                (node-name($code), data($code)),
                (node-name($localId), data($localId))
            ]
        )
}  catch * {
    html:createErrorRow($err:code, $err:description)
}


(: K14 aqd:AQD_Measures/aqd:name must be populated with a text string
A short name for the measure :)
let $aqdname := $docRoot//aqd:AQD_Measures/aqd:name
let $K14invalid := common:needsValidString(
        $docRoot//aqd:AQD_Measures, 'aqd:name'
        )

(: K15 aqd:AQD_Measures/aqd:name must be populated with a text string
A short name for the measure :)
let $K15invalid := common:needsValidString(
        $docRoot//aqd:AQD_Measures,
        'aqd:description'
        )

let $errorLevel := 'error'

(: K16 aqd:AQD_Measures/aqd:classification shall resolve to the codelist http://dd.eionet.europa.eu/vocabulary/aq/measureclassification/
Measure classification should conform to vocabulary :)
let $K16 := common:isInVocabularyReport(
        $docRoot//aqd:AQD_Measures/aqd:classification,
        $vocabulary:MEASURECLASSIFICATION_VOCABULARY
        )

(: K17 aqd:AQD_Measures/aqd:measureType shall resolve to the codelist http://dd.eionet.europa.eu/vocabulary/aq/measuretype/
Measure type should conform to vocabulary :)
let $K17 := common:isInVocabularyReport(
        $docRoot//aqd:AQD_Measures/aqd:measureType,
        $vocabulary:MEASURETYPE_VOCABULARY
        )


(: K18 aqd:AQD_Measures/aqd:administrativeLevel shall resolve to the codelist
http://dd.eionet.europa.eu/vocabulary/aq/administrativelevel/
Administrative level should conform to vocabulary
:)
let $K18 := common:isInVocabularyReport(
        $docRoot//aqd:AQD_Measures/aqd:administrativeLevel,
        $vocabulary:ADMINISTRATIVE_LEVEL_VOCABULARY
        )

(: K19
aqd:AQD_Measures/aqd:timeScale shall resolve to the codelist http://dd.eionet.europa.eu/vocabulary/aq/timescale/
The measure's timescale should conform to vocabulary
:)
let $K19 := common:isInVocabularyReport(
        $docRoot//aqd:AQD_Measures/aqd:timeScale,
        $vocabulary:TIMESCALE_VOCABULARY
        )


(: K20 aqd:AQD_Measures/aqd:costs/ should be provided
Information on the cost of the measure should be provided
:)
let $K20 := common:isNodeNotInParentReport(
        $docRoot//aqd:AQD_Measures,
        'aqd:costs'
        )


(: K21
If aqd:costs provided
aqd:AQD_Measures/aqd:costs/aqd:Costs/aqd:estimatedImplementationCosts should be
an integer number. If voided /aqd:AQD_Measures/aqd:costs/aqd:Costs/aqd:comment
must be populated with an explanation of why no costs are available.

The estimated total costs should be provided. If not, an explanation on the
reasons for not providing it should be included.
:)

let $K21 := try {
    let $root := $docRoot//aqd:AQD_Measures
    let $costs := $root/aqd:costs
    let $implCosts := $costs/aqd:Costs/aqd:estimatedImplementationCosts
    let $comment := $root/aqd:costs/aqd:Costs/aqd:comment
    let $costsRoot := $docRoot//aqd:AQD_Measures/aqd:costs/aqd:Costs

    let $isValidCost := common:is-a-number(data($implCosts))
    let $hasCost := common:isNodeInParent($costsRoot, 'aqd:estimatedImplementationCosts')

    return
        if (common:isNodeInParent($root, 'aqd:costs'))
        then (
            if (not($isValidCost))
            then
                if (empty($comment/text()))
                then
                    if ($hasCost)
                    then
                        (
                         <tr> <td title="{node-name($implCosts)}">{$errors:K21}</td> </tr>
                        )
                    else
                        ( <tr><td title="{node-name($comment)}">{$errors:K21}</td></tr>)
                else
                    ()  (: ok, we have a comment :)
            else
                ()      (: ok, cost is a number :)
        )
        else
            <tr><td title="{node-name($costs)}">{$errors:K21}</td></tr>

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

let $K22 := common:validatePossibleNodeValueReport(
    $docRoot//aqd:AQD_Measures/aqd:costs/aqd:Costs,
    'aqd:finalImplementationCosts',
    common:is-a-number#1
)

(: K23
If aqd:AQD_Measures/aqd:costs/aqd:Costs/aqd:estimatedImplementationCosts is
populated aqd:AQD_Measures/aqd:costs/aqd:Costs/aqd:currency must be populated
and shall resolve to the codelist
http://dd.eionet.europa.eu/vocabulary/common/currencies/

If estimated costs are provided, the currency must be provided conforming to
vocabulary

:)

let $K23 := common:validateMaybeNodeWithValueReport(
    $docRoot//aqd:AQD_Measures/aqd:costs/aqd:Costs,
    'aqd:estimatedImplementationCosts',
    common:isInVocabulary(
        $docRoot//aqd:AQD_Measures/aqd:costs/aqd:Costs/aqd:currency/@xlink:href,
        $vocabulary:CURRENCIES
    )
)


(: K24
aqd:AQD_Measures/aqd:sourceSectors shall resolve to the codelist
http://dd.eionet.europa.eu/vocabulary/aq/sourcesectors/

Source sector should conform to vocabulary
:)

let $K24 := common:isInVocabularyReport(
    $docRoot//aqd:AQD_Measures/aqd:sourceSectors,
    $vocabulary:SOURCESECTORS_VOCABULARY
    )

(: K25
aqd:AQD_Measures/aqd:spatialScale shall resolve to the codelist
http://dd.eionet.europa.eu/vocabulary/aq/spatialscale/

Spatial scale should conform to vocabulary
:)

let $K25 := common:isInVocabularyReport(
    $docRoot//aqd:AQD_Measures/aqd:spatialScale,
    $vocabulary:SPACIALSCALE_VOCABULARY
    )

(: K26
aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:status shall resolve to the codelist
http://dd.eionet.europa.eu/vocabulary/aq/measureimplementationstatus/

Measure Implementation Status should conform to vocabulary
:)

let $K26 := common:isInVocabularyReport(
    $docRoot//aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:status,
    $vocabulary:MEASUREIMPLEMENTATIONSTATUS_VOCABULARY
    )

(: K27
aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:implementationPlannedTimePeriod/gml:TimePeriod/gml:beginPosition
must be a date in full ISO date format

The planned start date for the measure should be provided
:)

let $K27 := common:isDateFullISOReport(
    $docRoot//aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:implementationPlannedTimePeriod/gml:TimePeriod/gml:beginPosition
)

(: K28
If not voided, aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:implementationPlannedTimePeriod/gml:TimePeriod/gml:endPosition
must be a date in full ISO format
and must be after aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:implementationPlannedTimePeriod/gml:TimePeriod/gml:beginPosition.
If voided it should be indeterminatePosition="unknown"

The planned end date for the measure should be provided in the right format,
if unknown voided using indeterminatePosition="unknown"
:)

let $K28 := try {
    let $begin := $docRoot//aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:implementationPlannedTimePeriod/gml:TimePeriod/gml:beginPosition
    let $end := $docRoot//aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:implementationPlannedTimePeriod/gml:TimePeriod/gml:endPosition

    let $ok := (
        (common:isDateFullISO($begin) and common:isDateFullISO($end) and $end > $begin)
        or
        ($end/@indeterminatePosition = "unknown" and empty($end/text()))
    )

    return common:conditionalReportRow(
        $ok,
        [
            ("gml:beginPosition", data($begin)),
            ("gml:endPosition", data($end))
        ]
    )
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: K29
aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:implementationActualTimePeriod/gml:TimePeriod/gml:beginPosition
must be a date in full ISO date format

The planned start date for the measure should be provided
:)
let $K29 := common:isDateFullISOReport(
    $docRoot//aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:implementationActualTimePeriod/gml:TimePeriod/gml:beginPosition
)


(: K30
If not voided, aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:implementationActualTimePeriod/gml:TimePeriod/gml:endPosition
must be a date in full ISO format and must be after
aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:implementationActualTimePeriod/gml:TimePeriod/gml:beginPosition.

If voided it should be indeterminatePosition="unknown"
The planned end date for the measure should be provided in the right format,
if unknown, voided using indeterminatePosition="unknown"
:)
let $K30 := try {
    let $begin := $docRoot//aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:implementationActualTimePeriod/gml:TimePeriod/gml:beginPosition
    let $end := $docRoot//aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:implementationActualTimePeriod/gml:TimePeriod/gml:endPosition

    let $ok := (
        (common:isDateFullISO($begin) and common:isDateFullISO($end) and $end > $begin)
        or
        ($end/@indeterminatePosition = "unknown" and empty($end/text()))
    )

    return common:conditionalReportRow(
        $ok,
        [
            ("gml:beginPosition", data($begin)),
            ("gml:endPosition", data($end))
        ]
    )
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: K31
aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:plannedFullEffectDate/gml:TimeInstant/gml:timePosition
to be provided in the following format yyyy or yyyy-mm-dd

The full effect date of the measure must be provided and the format to be yyyy or yyyy-mm-dd
:)

let $K31 := try {
    let $node := $docRoot//aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:plannedFullEffectDate/gml:TimeInstant/gml:timePosition

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

(: K32
/aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:otherDates
RESERVE
:)

let $K32 := <tr><td title="aqd:otherDates">{data($docRoot//aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:otherDates)}</td></tr>

(: K33
A text string may be provided under
aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:monitoringProgressIndicators
If voided an explanation of why this information unavailable shall be provided in
/aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:comment
:)

let $K33 := try {
    let $main := $docRoot//aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:monitoringProgressIndicators
    let $comment := $docRoot//aqd:AQD_Measures/aqd:plannedImplementation/aqd:PlannedImplementation/aqd:comment

    let $ok := (
        not(
            empty($main/text())
            or
            empty($comment/text())
        )
    )

    return common:conditionalReportRow(
        $ok,
        [
            (node-name($main), data($main)),
            (node-name($comment), data($comment))
        ]
    )
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(:
K34
Check that the element
aqd:AQD_Measures/aqd:reductionOfEmissions/aqd:QuantityCommented/aqd:quantity is
an integer or floating point numeric >= 0 if attribute xsi:nil="false"
(example:
    <aqd:quantity uom="http://dd.eionet.europa.eu/vocabulary/uom/emission/t.year-1" xsi:nil="false">273</aqd:quantity>
    )
:)

let $K34 := try {
    let $node := $docRoot//aqd:AQD_Measures/aqd:reductionOfEmissions/aqd:QuantityCommented/aqd:quantity
    (: TODO: should write a function for this? there's already is-a-number :)
    let $isNum := (
        ($node castable as xs:integer)
        or
        ($node castable as xs:float)
    )

    let $ok := (
        ($node/@xsi:nil != 'false')
        or
        ($isNum and ($node cast as xs:float >= 0))
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


(: K35
Check that the element aqd:QuantityCommented/aqd:quantity is empty if attribute xsi:nil="unpopulated" or "unknown" or "withheld"
(example: <aqd:quantity uom="Unknown" nilReason="Unpopulated" xsi:nil="true"/>)

If quantification is either "unpopulated" or "unknown" or "withheld", the element should be empty
:)
let $K35 := try {
    let $node := $docRoot//aqd:QuantityCommented/aqd:quantity
    (:let $asd := trace(functx:if-empty($node/text(), 0), "K35: "):)
    let $ok := (
        (functx:if-empty($node/text(), "") != "")
        or
        (
            lower-case($node/@xsi:nil) = "true"
            and
            (
                (lower-case($node/@nilReason) = "unknown")
                or
                (lower-case($node/@nilReason) = "unpopulated")
                or
                (lower-case($node/@nilReason) = "withheld")
            )
        )
    )

    return common:conditionalReportRow(
        $ok,
        [
            (node-name($node), data($node)),
            (name($node/@nilReason), data($node/@nilReason))
        ]
    )
} catch * {
    html:createErrorRow($err:code, $err:description)
}


(: K36
If aqd:QuantityCommented/aqd:quantity attribute xsi:nil="true"
aqd:QuantityCommented/aqd:comment must be populated

If the quantification is voided an explanation is required in aqd:comment
:)
let $K36 := try {
    let $quantity := $docRoot//aqd:QuantityCommented/aqd:quantity
    let $comment := $docRoot//aqd:QuantityCommented/aqd:comment

    let $ok := (
        (functx:if-empty($quantity/text(), "") = "")
        or
        (functx:if-empty($comment/text(), "") = "")
    )

    return common:conditionalReportRow(
        $ok,
        [
            (node-name($quantity), data($quantity)),
            (node-name($comment), data($comment))
        ]
    )
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: K37
The unit attribute (aqd:AQD_Measures/aqd:reductionOfEmissions/aqd:QuantityCommented/aqd:quantity/@UoM)
shall correspond to http://dd.eionet.europa.eu/vocabulary/uom/emission

the quantification of reductionOfEmissions should conform to vocabulary
:)
let $K37 := try {
    let $el := $docRoot//aqd:AQD_Measures/aqd:reductionOfEmissions/aqd:QuantityCommented/aqd:quantity
    let $uri := data($el/@uom)
    let $validUris := dd:getValidConcepts($vocabulary:UOM_EMISSION_VOCABULARY || "rdf")
    let $ok := ($uri and $uri = $validUris)

    return common:conditionalReportRow(
        $ok,
        [
            (node-name($el), data($el)),
            (name($el/@uom), data($uri))
        ]
    )

} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: K38
Check that the element aqd:AQD_Measures/aqd:expectedImpact/aqd:ExpectedImpact/aqd:levelOfConcentration
is an integer or floating point numeric >= 0
and the unit (@uom) shall resolve to the codelist
http://dd.eionet.europa.eu/vocabulary/uom/concentration/

The level of concentration expected should be provided as an integer and its unit should conform to vocabulary
:)

let $K38 := try {
    let $el := $docRoot//aqd:AQD_Measures/aqd:expectedImpact/aqd:ExpectedImpact/aqd:levelOfConcentration
    let $uri := data($el/@uom)
    let $validVocabulary := common:isInVocabulary($uri, $vocabulary:UOM_CONCENTRATION_VOCABULARY)

    let $isNum := (
        ($el castable as xs:integer)
        or
        ($el castable as xs:float)
    )

    let $ok := (
        $validVocabulary
        and
        ($isNum and ($el cast as xs:float >= 0))
    )

    return common:conditionalReportRow(
        $ok,
        [
            (node-name($el), data($el)),
            (name($el/@uom), data($uri))
        ]
    )
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: K39
Check that the element aqd:AQD_Measures/aqd:expectedImpact/aqd:ExpectedImpact/aqd:numberOfExceedances
is an integer or floating point numeric >= 0
and the unit (@uom) shall resolve to the codelist
http://dd.eionet.europa.eu/vocabulary/uom/statistics

The number of exceecedance expected should be provided as an integer and its unit should conform to vocabulary
:)

let $K39 := try {
    let $el := $docRoot//aqd:AQD_Measures/aqd:expectedImpact/aqd:ExpectedImpact/aqd:numberOfExceedances
    let $uri := data($el/@uom)
    let $validVocabulary := common:isInVocabulary($uri, $vocabulary:UOM_STATISTICS)

    let $isNum := (
        ($el castable as xs:integer)
        or
        ($el castable as xs:float)
    )

    let $ok := (
        $validVocabulary
        and
        ($isNum and ($el cast as xs:float >= 0))
    )

    return common:conditionalReportRow(
        $ok,
        [
            (node-name($el), data($el)),
            (name($el/@uom), data($uri))
        ]
    )
} catch * {
    html:createErrorRow($err:code, $err:description)
}

(: K40
Reserve for specificationOfHours
:)

let $K40 := ()

return
(
    <table class="maintable hover">
        {html:build2("NS", $labels:NAMESPACES, $labels:NAMESPACES_SHORT, $NSinvalid, "All values are valid", "record", $errors:NS)}
        {html:build3("K0", $labels:K0, $labels:K0_SHORT, $K0table, string($K0table/td), errors:getMaxError($K0table))}
        {html:build1("K01", $labels:K01, $labels:K01_SHORT, $K01, "", string($countMeasures), "", "", $errors:K01)}
        {html:buildSimple("K02", $labels:K02, $labels:K02_SHORT, $K02table, "", "", $K02errorLevel)}
        {html:buildSimple("K03", $labels:K03, $labels:K03_SHORT, $K03table, "", "", $K03errorLevel)}
        {html:build1("K04", $labels:K04, $labels:K04_SHORT, $K04table, "", string(count($K04table)), " ", "", $errors:K04)}
        {html:build1("K05", $labels:K05, $labels:K05_SHORT, $K05, "RESERVE", "RESERVE", "RESERVE", "RESERVE", $errors:K05)}
        {html:build1("K06", $labels:K06, $labels:K06_SHORT, $K06, "RESERVE", "RESERVE", "RESERVE", "RESERVE", $errors:K06)}
        {html:build2("K07", $labels:K07, $labels:K07_SHORT, $K07, "No duplicate values found", " duplicate value", $errors:K07)}
        {html:build2("K08", $labels:K08, $labels:K08_SHORT, $K08invalid, "No duplicate values found", " duplicate value", $errors:K08)}
        {html:buildUnique("K09", $labels:K09, $labels:K09_SHORT, $K09table, "namespace", $errors:K09)}
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
        {html:build1("K32", $labels:K32, $labels:K32_SHORT, $K32, "RESERVE", "RESERVE", "RESERVE", "RESERVE", $errors:K32)}
        {html:build2("K33", $labels:K33, $labels:K33_SHORT, $K33, "All values are valid", "not valid", $errors:K33)}
        {html:build2("K34", $labels:K34, $labels:K34_SHORT, $K34, "All values are valid", "not valid", $errors:K34)}
        {html:build2("K35", $labels:K35, $labels:K35_SHORT, $K35, "All values are valid", "not valid", $errors:K35)}
        {html:build2("K36", $labels:K36, $labels:K36_SHORT, $K36, "All values are valid", "not valid", $errors:K36)}
        {html:build2("K37", $labels:K37, $labels:K37_SHORT, $K37, "All values are valid", "not valid", $errors:K37)}
        {html:build2("K38", $labels:K38, $labels:K38_SHORT, $K38, "All values are valid", "not valid", $errors:K38)}
        {html:build2("K39", $labels:K39, $labels:K39_SHORT, $K39, "All values are valid", "not valid", $errors:K39)}
        {html:build1("K40", $labels:K40, $labels:K40_SHORT, $K40, "RESERVE", "RESERVE", "RESERVE", "RESERVE", $errors:K40)}

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
(:
 : Module Name: Implementing Decision 2011/850/EU: AQ info exchange & reporting (Library module)
 :
 : Version:     $Id$
 : Created:     13 September 2013
 : Copyright:   European Environment Agency
 :
 : XQuery script implements dataflow M tier-1 checks as documented in http://taskman.eionet.europa.eu/documents/3 .
 :
 : @author Juri Tõnisson
 : @author George Sofianos
 : small modification added by Jaume Targa (ETC/ACM) to align with QA document
 :)




declare variable $dataflowM:ISO2_CODES as xs:string* := ("AL","AT","BA","BE","BG","CH","CY","CZ","DE","DK","DZ","EE","EG","ES","FI",
    "FR","GB","GR","HR","HU","IE","IL","IS","IT","JO","LB","LI","LT","LU","LV","MA","ME","MK","MT","NL","NO","PL","PS","PT",
     "RO","RS","SE","SI","SK","TN","TR","XK","UK");




(: Rule implementations :)
declare function dataflowM:checkReport($source_url as xs:string, $countryCode as xs:string) as element(table) {
let $docRoot := doc($source_url)
let $cdrUrl := common:getCdrUrl($countryCode)
let $reportingYear := common:getReportingYear($docRoot)
let $latestEnvelopeB := query:getLatestEnvelope($cdrUrl || "b/")
let $modelNamespaces := distinct-values($docRoot//aqd:AQD_Model/ef:inspireId/base:Identifier/base:namespace)
let $modelProcessNamespaces := distinct-values($docRoot//aqd:AQD_ModelProcess/ompr:inspireId/base:Identifier/base:namespace)
let $modelAreaNamespaces := distinct-values($docRoot//aqd:AQD_ModelArea/aqd:inspireId/base:Identifier/base:namespace)
let $namespaces := distinct-values($docRoot//base:namespace)
let $knownFeatures := distinct-values(data(sparqlx:run(query:getAllFeatureIds($dataflowM:FEATURE_TYPES, $namespaces))//sparql:binding[@name = 'inspireLabel']/sparql:literal))

let $MCombinations :=
    for $featureType in $dataflowM:FEATURE_TYPES
    return
        doc($source_url)//gml:featureMember/descendant::*[name()=$featureType]

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

(: M0 :)
let $M0table :=
    try {
        if ($reportingYear = "") then
            <tr class="{$errors:ERROR}">
                <td title="Status">Reporting Year is missing.</td>
            </tr>
        else if (query:deliveryExists($dataflowM:OBLIGATIONS, $countryCode, "d/", $reportingYear)) then
            <tr class="{$errors:WARNING}">
                <td title="Status">Updating delivery for {$reportingYear}</td>
            </tr>
        else if (query:deliveryExists($dataflowM:OBLIGATIONS, $countryCode, "d1b/", $reportingYear)) then
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
let $isNewDelivery := errors:getMaxError($M0table) = $errors:INFO

(: M01 :)
let $countFeatureTypes :=
    for $featureType in $dataflowM:FEATURE_TYPES
    return
        count(doc($source_url)//gml:featureMember/descendant::*[name()=$featureType])
let $M01table :=
    try {
        for $featureType at $pos in $dataflowM:FEATURE_TYPES
        let $errorClass :=
            if ($countFeatureTypes[$pos] > 0) then
                $errors:INFO
            else
                $errors:M01
        return
            <tr class="{$errorClass}">
                <td title="Feature type">{$featureType}</td>
                <td title="Total number">{$countFeatureTypes[$pos]}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: M02 - :)
let $M02table :=
    try {
        for $featureType at $pos in $dataflowM:FEATURE_TYPES
        let $countAll := count($docRoot//descendant::*[name()=$featureType])
        let $count := count(
                for $x in $docRoot//descendant::*[name()=$featureType]
                let $inspireId := $x//base:Identifier/base:namespace/string() || "/" || $x//base:Identifier/base:localId/string()
                where ($inspireId = "/" or not($knownFeatures = $inspireId))
                return
                    <tr>
                        <td title="base:localId">{$x//base:Identifier/base:localId/string()}</td>
                    </tr>)
        let $errorClass :=
            if ($countAll = $count or $count = 0) then
                $errors:WARNING
            else
                $errors:INFO
        return
            <tr class="{$errorClass}">
                <td title="Feature type">{$featureType}</td>
                <td title="Total number">{$count}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
let $M02count :=
    try {
        string(sum($M02table/td[2]))
    } catch * {
        "NaN"
    }

(: M03 - :)
let $M03table :=
    try {
        let $featureTypes := $dataflowM:FEATURE_TYPES
        for $featureType at $pos in $featureTypes
        let $count := count(
                for $x in $docRoot//descendant::*[name()=$featureType]
                let $inspireId := $x//base:Identifier/base:namespace/string() || "/" || $x//base:Identifier/base:localId/string()
                where ($knownFeatures = $inspireId)
                return
                    <tr>
                        <td title="Feature type">{string($x/name())}</td>
                        <td title="base:localId">{$x//base:Identifier/base:localId/string()}</td>
                    </tr>)
        let $errorClass :=
            if ($count = 0) then
                $errors:WARNING
            else
                $errors:INFO
        return
            <tr class="{$errorClass}">
                <td title="Feature type">{$featureType}</td>
                <td title="Total number">{$count}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
let $M03count :=
    try {
        string(sum($M03table/td[2]))
    } catch * {
        "NaN"
    }

(: M04 :)
let $M04table :=
    try {
        let $allM4Combinations :=
            for $aqdModel in $MCombinations
            return $aqdModel/ef:inspireId/base:Identifier/base:localId || "#" || $aqdModel/ompr:inspireId/base:Identifier/base:localId || "#" || $aqdModel/aqd:inspireId/base:Identifier/base:localId || "#" || $aqdModel/ef:name || "#" || $aqdModel/ompr:name

        let $allM4Combinations := fn:distinct-values($allM4Combinations)
        for $x in $allM4Combinations
        let $tokens := tokenize($x, "#")
        return
            <tr>
                <td title="ef:inspireId">{common:checkLink($tokens[1])}</td>
                <td title="ompr:inspireId">{common:checkLink($tokens[2])}</td>
                <td title="aqd:inspireId">{common:checkLink($tokens[3])}</td>
                <td title="ef:name">{common:checkLink($tokens[4])}</td>
                <td title="ompr:name">{common:checkLink($tokens[5])}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: M05 :)
(: TODO: FIX TRY CATCH CODE :)
let $all1 := $MCombinations/lower-case(normalize-space(@gml:id))
let $part1 := distinct-values(
        for $id in $MCombinations/@gml:id
        where string-length(normalize-space($id)) > 0 and count(index-of($all1, lower-case(normalize-space($id)))) > 1
        return
            $id
)
let $part1 :=
    for $x in $part1
    return
        <tr>
            <td title="Duplicate records">@gml:id {$x}</td>
        </tr>
let $all2 := for $id in $MCombinations/ef:inspireId
return lower-case("[" || $id/base:Identifier/base:localId || ", " || $id/base:Identifier/base:namespace || ", " || $id/base:Identifier/base:versionId || "]")

let $part2 := distinct-values(
        for $id in $MCombinations/ef:inspireId
        let $key := "[" || $id/base:Identifier/base:localId || ", " || $id/base:Identifier/base:namespace || ", " || $id/base:Identifier/base:versionId || "]"
        where string-length(normalize-space($id/base:Identifier/base:localId)) > 0 and count(index-of($all2, lower-case($key))) > 1
        return
            $key
)
let $part2 :=
    for $x in $part2
    return
        <tr>
            <td title="Duplicate records">ef:inspireId {$x}</td>
        </tr>


let $all3 := for $id in $MCombinations/am:inspireId
return lower-case("[" || $id/base:Identifier/base:localId || ", " || $id/base:Identifier/base:namespace || ", " || $id/base:Identifier/base:versionId || "]")
let $part3 := distinct-values(
        for $id in $MCombinations/am:inspireId
        let $key := "[" || $id/base:Identifier/base:localId || ", " || $id/base:Identifier/base:namespace || ", " || $id/base:Identifier/base:versionId || "]"
        where  string-length(normalize-space($id/base:Identifier/base:localId)) > 0 and count(index-of($all3, lower-case($key))) > 1
        return
            $key
)
let $part3 :=
    for $x in $part3
    return
        <tr>
            <td title="Duplicate records">am:inspireId {$x}</td>
        </tr>
let $all4 := for $id in $MCombinations/aqd:inspireId
return lower-case("[" || $id/base:Identifier/base:localId || ", " || $id/base:Identifier/base:namespace || ", " || $id/base:Identifier/base:versionId || "]")
let $part4 := distinct-values(
        for $id in $MCombinations/aqd:inspireId
        let $key := "[" || $id/base:Identifier/base:localId || ", " || $id/base:Identifier/base:namespace || ", " || $id/base:Identifier/base:versionId || "]"
        where  string-length(normalize-space($id/base:Identifier/base:localId)) > 0 and count(index-of($all3, lower-case($key))) > 1
        return
            $key
)
let $part4 :=
    for $x in $part4
    return
        <tr>
            <td title="Duplicate records">aqd:inspireId {$x}</td>
        </tr>

let $M05invalid := ($part1, $part2, $part3, $part4)

(: M06 - ./ef:inspireId/base:Identifier/base:localId shall be an unique code for AQD_Model and unique within the namespace.
 It is recommended to start with “MOD” and may include ISO2-country code (e.g.: MOD-ES0001) :)
let $M06invalid :=
    try {
        let $all := $docRoot//aqd:AQD_Model/ef:inspireId/base:Identifier/concat(base:namespace, base:localId)
        for $x in $docRoot//aqd:AQD_Model/ef:inspireId/base:Identifier
        let $namespace := string($x/base:namespace)
        let $localId := string($x/base:localId)
        let $count := count(index-of($all, $namespace || $localId))
        where $count > 1
        return
            <tr>
                <td title="base:namespace">{$namespace}</td>
                <td title="base:localId">{$localId}</td>
                <td title="Count">{$count}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: M07 :)
let $M07table :=
    try {
        for $id in $modelNamespaces
        let $localId := $docRoot//aqd:AQD_Model/ef:inspireId/base:Identifier[base:namespace = $id]/base:localId
        return
            <tr>
                <td title="base:namespace">{$id}</td>
                <td title="base:localId">{count($localId)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: M07.1 :)
let $M07.1invalid :=
    try {
        let $vocDoc := doc($vocabulary:NAMESPACE || "rdf")
        let $prefLabel := $vocDoc//skos:Concept[adms:status/@rdf:resource = $dd:VALIDRESOURCE and @rdf:about = concat($vocabulary:NAMESPACE, $countryCode)]/skos:prefLabel[1]
        let $altLabel := $vocDoc//skos:Concept[adms:status/@rdf:resource = $dd:VALIDRESOURCE and @rdf:about = concat($vocabulary:NAMESPACE, $countryCode)]/skos:altLabel[1]
        for $x in distinct-values($docRoot//aqd:AQD_Model/ef:inspireId/base:Identifier/base:namespaces)
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

(: M08 aqd:AQD_Model/ef:name shall return a string :)
let $M08invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Model[string(ef:name) = ""]
        return
            <tr>
                <td title="base:localId">{string($x/ef:inspireId/base:Identifier/base:localId)}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code"> {$err:code}</td>
            <td title="Error description">{$err:description}</td>
            <td></td>
        </tr>
    }

(: M15 :)
let $M15invalid :=
    try {
        let $allNotNullEndPeriods :=
            for $allPeriod in $docRoot//aqd:AQD_Model/ef:observingCapability/ef:ObservingCapability/ef:observingTime/gml:TimePeriod
            where ($allPeriod/gml:endPosition[normalize-space(@indeterminatePosition) != "unknown"]
                    or fn:string-length($allPeriod/gml:endPosition) > 0)
            return $allPeriod

        for $observingCapabilityPeriod in $allNotNullEndPeriods
        where ((xs:dateTime($observingCapabilityPeriod/gml:endPosition) < xs:dateTime($observingCapabilityPeriod/gml:beginPosition)))
        return
            <tr>
                <td title="aqd:AQD_Model">{data($observingCapabilityPeriod/../../../../@gml:id)}</td>
                <td title="gml:TimePeriod">{data($observingCapabilityPeriod/@gml:id)}</td>
                <td title="gml:beginPosition">{$observingCapabilityPeriod/gml:beginPosition}</td>
                <td title="gml:endPosition">{$observingCapabilityPeriod/gml:endPosition}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: M18 :)
let $M18invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Model
        let $xlink := data($x/ef:observingCapability/ef:ObservingCapability/ef:observedProperty/@xlink:href)
        where not($xlink = $dd:VALIDPOLLUTANTS) or (count(distinct-values($xlink)) > 1)
        return
            <tr>
                <td title="aqd:AQD_Model">{data($x/ef:inspireId/base:Identifier/base:localId)}</td>
                <td title="ef:observedProperty">{$xlink}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: M19 :)
let $M19invalid :=
    try {
        let $all := data($docRoot//aqd:AQD_ModelArea/aqd:inspireId/base:Identifier/concat(base:namespace, "/", base:localId))

        for $x in $docRoot//aqd:AQD_Model/ef:observingCapability/ef:ObservingCapability/ef:featureOfInterest
        let $xlink := data($x/@xlink:href)
        where not($xlink = $all)
        return
            <tr>
                <td title="aqd:AQD_Model">{data($x/../../../ef:inspireId/base:Identifier/base:localId)}</td>
                <td title="ef:featureOfInterest">{$xlink}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
(: M20 :)
let $M20invalid :=
    try {
        let $all := $docRoot//aqd:AQD_ModelProcess/ompr:inspireId/base:Identifier/concat(base:namespace, "/", base:localId)
        for $x in $docRoot//aqd:AQD_Model/ef:observingCapability/ef:ObservingCapability/ef:procedure
        let $xlink := data($x/@xlink:href)
        where not($xlink = $all)
        return
            <tr>
                <td title="aqd:AQD_Model">{data($x/../../../ef:inspireId/base:Identifier/base:localId)}</td>
                <td title="ef:procedure">{$xlink}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: M23 :)
let $M23invalid :=
    try {
        let $exceptions := ($vocabulary:OBJECTIVETYPE_VOCABULARY || "MO")
        let $all :=
            for $x in doc($vocabulary:ENVIRONMENTALOBJECTIVE || "rdf")//skos:Concept[adms:status/@rdf:resource = $dd:VALIDRESOURCE]
            return $x/prop:relatedPollutant/@rdf:resource || "#" || $x/prop:hasObjectiveType/@rdf:resource || "#" || $x/prop:hasReportingMetric/@rdf:resource || "#" || $x/prop:hasProtectionTarget/@rdf:resource

        for $x in $docRoot//aqd:AQD_Model
        for $z in $x/ef:observingCapability
        for $y in $x/aqd:environmentalObjective
        let $pollutant := $z/ef:ObservingCapability/ef:observedProperty/@xlink:href
        let $objectiveType := $y/aqd:EnvironmentalObjective/aqd:objectiveType/@xlink:href
        let $reportingMetric := $y/aqd:EnvironmentalObjective/aqd:reportingMetric/@xlink:href
        let $protectionTarget := $y/aqd:EnvironmentalObjective/aqd:protectionTarget/@xlink:href
        let $combination := $pollutant || "#" || $objectiveType || "#" || $reportingMetric || "#" || $protectionTarget
        where not($objectiveType = $exceptions) and not($combination = $all)
        return
            <tr>
                <td title="aqd:AQD_Model">{data($x/ef:inspireId/base:Identifier/base:localId)}</td>
                <td title="Pollutant">{data($pollutant)}</td>
                <td title="ObjectiveType">{data($objectiveType)}</td>
                <td title="ReportingMetric">{data($reportingMetric)}</td>
                <td title="ProtectionTarget">{data($protectionTarget)}</td>
            </tr>
    }  catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: M24 :)
let $M24invalid :=
    try {
        for $x in $docRoot//aqd:AQD_Model/aqd:assessmentType
        let $xlink := data($x/@xlink:href)
        where not($xlink = $vocabulary:ASSESSMENTTYPE_VOCABULARY || "model") and not($xlink = $vocabulary:ASSESSMENTTYPE_VOCABULARY || "objective")
        return
            <tr>
                <td title="aqd:AQD_Model">{data($x/../ef:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:assessmentType">{$xlink}</td>
            </tr>

    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: M26 :)
let $M26invalid :=
    try {
        let $all := data(sparqlx:run(query:getZone($latestEnvelopeB))//sparql:binding[@name = 'inspireLabel']/sparql:literal)
        for $x in $docRoot//aqd:AQD_Model/aqd:zone
        let $xlink := data($x/@xlink:href)
        where not($x/@nilReason = "inapplicable") and not($xlink = $all)
        return
            <tr>
                <td title="gml:id">{data($x/../ef:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:zone">{$xlink}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: M27 - :)
let $M27invalid :=
    try {
        let $localModelProcessIds := $docRoot//aqd:AQD_ModelProcess/ompr:inspireId/base:Identifier
        for $idModelProcessCode in $docRoot//aqd:AQD_ModelProcess/ompr:inspireId/base:Identifier
        where
            count(index-of($localModelProcessIds/base:localId, normalize-space($idModelProcessCode/base:localId))) > 1 and
                    count(index-of($localModelProcessIds/base:namespace, normalize-space($idModelProcessCode/base:namespace))) > 1
        return
            <tr>
                <td title="aqd:AQD_ModelProcess">{data($idModelProcessCode/../../@gml:id)}</td>
                <td title="base:localId">{data($idModelProcessCode/base:localId)}</td>
                <td title="base:namespace">{data($idModelProcessCode/base:namespace)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: M28 :)
let $M28table :=
    try {
        for $id in $modelProcessNamespaces
        let $localId := $docRoot//aqd:AQD_ModelProcess/ompr:inspireId/base:Identifier[base:namespace = $id]/base:localId
        return
            <tr>
                <td title="base:namespace">{$id}</td>
                <td title="base:localId">{count($localId)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: M28 :)
let $M28.1invalid :=
    try {
        let $vocDoc := doc($vocabulary:NAMESPACE || "rdf")
        let $prefLabel := $vocDoc//skos:Concept[adms:status/@rdf:resource = $dd:VALIDRESOURCE and @rdf:about = concat($vocabulary:NAMESPACE, $countryCode)]/skos:prefLabel[1]
        let $altLabel := $vocDoc//skos:Concept[adms:status/@rdf:resource = $dd:VALIDRESOURCE and @rdf:about = concat($vocabulary:NAMESPACE, $countryCode)]/skos:altLabel[1]
        for $x in distinct-values($docRoot//aqd:AQD_ModelProcess/ef:inspireId/base:Identifier/base:namespaces)
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

(: M29 :)
let $M29invalid :=
    try {
        for $baseLink in $docRoot//aqd:AQD_ModelProcess/ompr:documentation/base2:DocumentationCitation/base2:link
        let $invalidLink := fn:substring-before($baseLink, ":")
        where (fn:lower-case($invalidLink) != "http") and (fn:lower-case($invalidLink) != "https")
        return
            <tr>
                <td title="aqd:AQD_ModelProcess">{data($baseLink/../../../@gml:id)}</td>
                <td title="base2:link">{data($baseLink)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: M30 :)
let $M30invalid :=
    try {
        for $x in $docRoot//aqd:AQD_ModelProcess[string(ompr:name) = ""]
        return
            <tr>
                <td title="aqd:AQD_ModelProcess">{data($x/ompr:inspireId/base:Identifier/base:localId)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: M34 :)
let $M34invalid :=
    try {
        for $x in $docRoot//aqd:AQD_ModelProcess[string(aqd:description) = ""]
        return
            <tr>
                <td title="aqd:AQD_ModelProcess">{data($x/ompr:inspireId/base:Identifier/base:localId)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: M35 :)
let $M35invalid :=
    try {
        let $valid := dd:getValidConcepts($vocabulary:UOM_TIME || "rdf")
        for $x in $docRoot//aqd:AQD_ModelProcess
        let $xlink := data($x/aqd:temporalResolution/aqd:TimeReferences/aqd:unit/@xlink:href)
        where not($xlink = $valid)
        return
            <tr>
                <td title="aqd:AQD_ModelProcess">{data($x/ompr:inspireId/base:Identifier/base:localId)}</td>
                <td title="aqd:unit">{$xlink}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: M39 :)
let $M39invalid :=
    try {
        for $dataQualityReport in $docRoot//aqd:AQD_ModelProcess/dataQualityReport
        let $invalidLink := fn:substring-before($dataQualityReport, ":")
        where (fn:lower-case($invalidLink) != "http") and (fn:lower-case($invalidLink) != "https")
        return
            <tr>
                <td title="aqd:AQD_ModelProcess">{data($dataQualityReport/../@gml:id)}</td>
                <td title="base2:link">{data($dataQualityReport)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: M40 - :)
let $M40invalid :=
    try {
        let $localModelAreaIds := $docRoot//aqd:AQD_ModelArea/ompr:inspireId/base:Identifier
        for $idModelAreaCode in $docRoot//aqd:AQD_ModelArea/ompr:inspireId/base:Identifier
        where
            count(index-of($localModelAreaIds/base:localId, normalize-space($idModelAreaCode/base:localId))) > 1 and
                    count(index-of($localModelAreaIds/base:namespace, normalize-space($idModelAreaCode/base:namespace))) > 1
        return
            <tr>
                <td title="aqd:AQD_ModelProcess">{data($idModelAreaCode/../../@gml:id)}</td>
                <td title="base:localId">{data($idModelAreaCode/base:localId)}</td>
                <td title="base:namespace">{data($idModelAreaCode/base:namespace)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: M41 - :)
let $M41table :=
    try {
        for $id in $modelAreaNamespaces
        let $localId := $docRoot//aqd:AQD_ModelArea/aqd:inspireId/base:Identifier[base:namespace = $id]/base:localId
        return
            <tr>
                <td title="base:namespace">{$id}</td>
                <td title="base:localId">{count($localId)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: M41 :)
let $M41.1invalid :=
    try {
        let $vocDoc := doc($vocabulary:NAMESPACE || "rdf")
        let $prefLabel := $vocDoc//skos:Concept[adms:status/@rdf:resource = $dd:VALIDRESOURCE and @rdf:about = concat($vocabulary:NAMESPACE, $countryCode)]/skos:prefLabel[1]
        let $altLabel := $vocDoc//skos:Concept[adms:status/@rdf:resource = $dd:VALIDRESOURCE and @rdf:about = concat($vocabulary:NAMESPACE, $countryCode)]/skos:altLabel[1]
        for $x in distinct-values($docRoot//aqd:AQD_ModelArea/ef:inspireId/base:Identifier/base:namespaces)
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

(: M43 :)
let $M43invalid :=
    try {
        let $valid := ("urn:ogc:def:crs:EPSG::4258", "urn:ogc:def:crs:EPSG::4326", "urn:ogc:def:crs:EPSG::3035")
        for $x in $docRoot//aqd:AQD_ModelArea[count(sams:shape) > 0]
            for $z in data($x/sams:shape//@srsName)
        where not($z = $valid)
        return
            <tr>
                <td title="aqd:AQD_ModelArea">{data($x/aqd:inspireId/base:Identifier/base:localId)}</td>
                <td title="@srsName">{$z}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }

(: M45 :)
let $M45invalid :=
    try {
        for $posList in $docRoot//gml:posList
        let $posListCount := count(fn:tokenize(normalize-space($posList), "\s+")) mod 2
        where (not(empty($posList)) and $posListCount > 0)
        return
            <tr>
                <td title="Polygon">{string($posList/../../../@gml:id)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
(:
 : M46 - generalized by Hermann
 : In Europe, lat values tend to be bigger than lon values. We use this observation as a poor farmer's son test to check that in a coordinate value pair,
 : the lat value comes first, as defined in the GML schema
:)
let $M46invalid :=
    try {
        for $latLong in $docRoot//gml:posList
        let $latlongToken := fn:tokenize(normalize-space($latLong), "\s+")
        let $lat := number($latlongToken[1])
        let $long := number($latlongToken[2])
        where (not($countryCode = "fr") and ($long > $lat))
        return
            <tr>
                <td title="Polygon">{string($latLong/../../../@gml:id)}</td>
                <td title="First vertex">{string($lat) || string($long)}</td>
            </tr>
    } catch * {
        <tr class="{$errors:FAILED}">
            <td title="Error code">{$err:code}</td>
            <td title="Error description">{$err:description}</td>
        </tr>
    }
let $M46message :=
    if ($countryCode = "fr") then
        "Temporary turned off"
    else
        "All values are valid"

    return
    <table class="maintable hover">
        {html:build2("NS", $labels:NAMESPACES, $labels:NAMESPACES_SHORT, $NSinvalid, "All values are valid", "record", $errors:WARNING)}
        {html:build3("M0", $labels:M0, $labels:M0_SHORT, $M0table, string($M0table/td), errors:getMaxError($M0table))}
        {html:build2("M01", $labels:M01, $labels:M01_SHORT, $M01table, "All values are valid", "record", errors:getMaxError($M01table))}
        {html:buildSimple("M02", $labels:M02, $labels:M02_SHORT, $M02table, $M02count, "feature type", errors:getMaxError($M02table))}
        {html:buildSimple("M03", $labels:M03, $labels:M03_SHORT, $M03table, $M03count, "feature type", errors:getMaxError($M03table))}
        {html:build2("M04", $labels:M04, $labels:M04_SHORT, $M04table, "All values are valid", "record", $errors:M04)}
        {html:build2("M05", $labels:M05, $labels:M05_SHORT, $M05invalid, "All values are valid", "record", $errors:M05)}
        {html:build2("M06", $labels:M06, $labels:M06_SHORT, $M06invalid, "All values are valid", "record", $errors:M06)}
        {html:buildInfoTR("Specific checks on AQD_Models")}
        {html:buildUnique("M07", $labels:M07, $labels:M07_SHORT, $M07table, "namespace", $errors:M07)}
        {html:build2("M07.1", $labels:M07.1, $labels:M07.1_SHORT, $M07.1invalid, "All values are valid", " invalid namespaces", $errors:M07.1)}
        {html:build2("M08", $labels:M08, $labels:M08_SHORT, $M08invalid, "All values are valid", "record", $errors:M08)}
        {html:build2("M15", $labels:M15, $labels:M15_SHORT, $M15invalid, "All values are valid", "", $errors:M15)}
        {html:build2("M18", $labels:M18, $labels:M18_SHORT, $M18invalid, "All values are valid", "record", $errors:M18)}
        {html:build2("M19", $labels:M19, $labels:M19_SHORT, $M19invalid, "All values are valid", " invalid attribute", $errors:M19)}
        {html:build2("M20", $labels:M20, $labels:M20_SHORT, $M20invalid, "All values are valid", "record", $errors:M20)}
        {html:build2("M23", $labels:M23, $labels:M23_SHORT, $M23invalid, "All values are valid", "record", $errors:M23)}
        {html:build2("M24", $labels:M24, $labels:M24_SHORT, $M24invalid, "All values are valid", "record", $errors:M24)}
        {html:build2("M26", $labels:M26, $labels:M26_SHORT, $M26invalid, "All values are valid", "record", $errors:M26)}
        {html:buildInfoTR("Specific checks on AQD_ModelProcess")}
        {html:build2("M27", $labels:M27, $labels:M27_SHORT, $M27invalid, "All values are valid", "record", $errors:M27)}
        {html:buildUnique("M28", $labels:M28, $labels:M28_SHORT, $M28table, "namespace", $errors:M28)}
        {html:build2("M28.1", $labels:M28.1, $labels:M28.1_SHORT, $M28.1invalid, "All values are valid", " invalid namespaces", $errors:M28.1)}
        {html:build2("M29", $labels:M29, $labels:M29_SHORT, $M29invalid, "All attributes are valid"," invalid attribute", $errors:M29)}
        {html:build2("M30", $labels:M30, $labels:M30_SHORT, $M30invalid, "All attributes are valid","record", $errors:M30)}
        {html:build2("M34", $labels:M34, $labels:M34_SHORT, $M34invalid, "All attributes are valid","record", $errors:M34)}
        {html:build2("M35", $labels:M35, $labels:M35_SHORT, $M35invalid, "All attributes are valid","record", $errors:M35)}
        {html:build2("M39", $labels:M39, $labels:M39_SHORT, $M39invalid, "All attributes are valid"," invalid attribute", $errors:M39)}
        {html:buildInfoTR("Specific checks on AQD_ModelArea")}
        {html:build2("M40", $labels:M40, $labels:M40_SHORT, $M40invalid, "All values are valid", "record", $errors:M40)}
        {html:buildUnique("M41", $labels:M41, $labels:M41_SHORT, $M41table, "namespace", $errors:M41)}
        {html:build2("M41.1", $labels:M41.1, $labels:M41.1_SHORT, $M41.1invalid, "All values are valid", " invalid namespaces", $errors:M41.1)}
        {html:build2("M43", $labels:M43, $labels:M43_SHORT, $M43invalid, "All records are valid", "record", $errors:M43)}
        {html:build2("M45", $labels:M45, $labels:M45_SHORT, $M45invalid, "All records are valid", "record", $errors:M45)}
        {html:build2("M46", $labels:M46, $labels:M46_SHORT, $M46invalid, $M46message, "record", $errors:M46)}
    </table>
};

declare function dataflowM:proceed($source_url as xs:string, $countryCode as xs:string) {

let $countFeatures := count(doc($source_url)//descendant::*[$dataflowM:FEATURE_TYPES = name()])
let $result := if ($countFeatures > 0) then dataflowM:checkReport($source_url, $countryCode) else ()
let $meta := map:merge((
    map:entry("count", $countFeatures),
    map:entry("header", "Check environmental monitoring feature types"),
    map:entry("dataflow", "Dataflow D on Models and Objective Estimation"),
    map:entry("zeroCount", <p>No environmental monitoring feature type elements ({string-join($dataflowM:FEATURE_TYPES, ", ")}) found from this XML.</p>),
    map:entry("report", <p>This feedback report provides a summary overview of feature types reported and some consistency checks defined in Dataflow D on Models and Objective Estimation as specified in <a href="http://www.eionet.europa.eu/aqportal/qaqc/">e-reporting QA/QC rules documentation</a>.</p>)
))
return
    html:buildResultDiv($meta, $result)
};

(:~
: User: George Sofianos
: Date: 6/13/2016
: Time: 5:49 PM
:)







declare function dd:getValid($url as xs:string) {
    doc($url || "rdf")//skos:Concept[adms:status/@rdf:resource = $dd:VALIDRESOURCE]
};
declare function dd:getNameFromPollutantCode($code as xs:string) as xs:string? {
    let $code := tokenize($code, "/")[last()]
    let $codes := doc(concat($vocabulary:POLLUTANT_VOCABULARY, "/rdf"))    
    let $num := concat($vocabulary:POLLUTANT_VOCABULARY, $code)
    let $name := $codes//skos:Concept[@rdf:about = $num]/string(skos:prefLabel)
    return $name
};

declare function dd:getValidPollutants() as xs:string* {
    let $codes := doc(concat($vocabulary:POLLUTANT_VOCABULARY, "/rdf"))
    let $validCodes := $codes//skos:Concept[adms:status/@rdf:resource = $dd:VALIDRESOURCE]/string(@rdf:about)
    return $validCodes
};

declare function dd:getValidConcepts($url as xs:string) as xs:string* {    
    data(doc($url)//skos:Concept[adms:status/@rdf:resource = $dd:VALIDRESOURCE]/@rdf:about)
};

declare function dd:getValidNotations($url as xs:string) as xs:string* {
    data(doc($url)//skos:Concept[adms:status/@rdf:resource = $dd:VALIDRESOURCE]/skos:notation)
};

(: Lower case version :)
declare function dd:getValidConceptsLC($url as xs:string) as xs:string* {
    data(doc($url)//skos:Concept[adms:status/@rdf:resource = $dd:VALIDRESOURCE]/lower-case(@rdf:about))
};

declare function dd:getRecommendedUnit($pollutant as xs:string) as xs:string* {
    data(doc($vocabulary:POLLUTANT_VOCABULARY || "rdf")//skos:Concept[@rdf:about = $pollutant and adms:status/@rdf:resource = $dd:VALIDRESOURCE]/prop:recommendedUnit/@rdf:resource)
};

declare function dd:getQAQCMap() as element(QAQCMap) {
    <QAQCMap>{
        for $x in doc($vocabulary:QAQC_VOCABULARY || "rdf")//skos:Concept
        return
            <Entry notation="{string($x/skos:notation)}">
                <PrefLabel>{string($x/skos:prefLabel)}</PrefLabel>
                <Definition>{string($x/skos:definition)}</Definition>
                <ErrorType>{lower-case(string($x/prop:errorType))}</ErrorType>
            </Entry>}
    </QAQCMap>
};

declare function dd:getQAQCLabel($notation as xs:string) as xs:string {
    string($dd:QAQCMAP/Entry[@notation = $notation]/PrefLabel)
};

declare function dd:getQAQCDefinition($notation as xs:string) as xs:string {
    string($dd:QAQCMAP/Entry[@notation = $notation]/Definition)
};

declare function dd:getQAQCErrorType($notation as xs:string) as xs:string {
    string($dd:QAQCMAP/Entry[@notation = $notation]/ErrorType)
};
(:
 : Module Name: AirQuality dataflow envelope level check(Main module)
 :
 : Version:     $Id$
 : Created:     15 November 2013
 : Copyright:   European Environment Agency
 :)




(:declare variable $envelope:SOURCE_URL_PARAM := "source_url=";:)

(: Not documented in QA doc: count only XML files related to AQ e-Reporting :)
declare function envelope:getAQFiles($url as xs:string) {
    for $pn in fn:doc($url)//file[contains(@schema,'AirQualityReporting.xsd') and string-length(@link)>0]
    let $fileUrl := common:replaceSourceUrl($url, string($pn/@link))
    return
        $fileUrl
};

(: QA doc 2.1.3 Check for Reporting Header within an envelope :)
declare function envelope:checkFileReportingHeader($envelope as element(envelope)*, $file as xs:string, $pos as xs:integer) as element(tr)* {
    (:let $obligationYears := sparqlx:run(query:getObligationYears()):)
    let $docRoot := doc($file)

    (: set variables for envelope year :)
    let $minimumYear := number(envelope:getObligationMinMaxYear($envelope)/min)
    let $maximumYear := number(envelope:getObligationMinMaxYear($envelope)/max)

    (:  If AQ e-Reporting XML files in the envelope, at least one must have an aqd:AQD_ReportingHeader element. :)
    let $containsAqdReportingHeader :=
        try {
            if (count($docRoot//aqd:AQD_ReportingHeader) = 0) then
                <tr>
                    <td title="Element">aqd:AQD_ReportingHeader</td>
                    <td title="Status">Missing</td>
                </tr>
            else
                ()
        }  catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    (: The aqd:AQD_ReportingHeader must have the same value for year in aqd:reportingPeriod/beginPosition as in the envelope :)
    let $falseTimePeriod :=
        try {
            let $xmlYear := common:getReportingYear($docRoot)
            let $envelopeYear := $envelope/year
            return
                if ($xmlYear = '' or $xmlYear != $envelopeYear) then
                <tr>
                    <td title="aqd:AQD_ReportingHeader">{data($xmlYear)}</td>
                    <td title="Envelope Year">{data($envelope/year)}</td>
                    <td title="Status">Not equal</td>
                </tr>
            else
                ()
        }  catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }
    (: The aqd:AQD_ReportingHeader must include aqd:inspireId, aqd:reportingAuthority, aqd:change and aqd:reportingPeriod elements :)
    let $missingAqdReportingHeaderSubElements :=
        try {
            for $elem in ("aqd:inspireId", "aqd:reportingAuthority", "aqd:change", "aqd:reportingPeriod")
            where count($docRoot//aqd:AQD_ReportingHeader/*[name()=$elem and string-length(.) > 0]) = 0
            return
                <tr>
                    <td title="Element">{$elem}</td>
                    <td title="Status">Missing</td>
                </tr>
            }  catch * {
                <tr class="{$errors:FAILED}">
                    <td title="Error code">{$err:code}</td>
                    <td title="Error description">{$err:description}</td>
                </tr>
            }
    (: If aqd:change='true' aqd:content and aqd:changeDescription must be provided:)
    let $missingElementsIfAqdChangeIsTrue :=
        try {
            for $x in $docRoot//aqd:AQD_ReportingHeader[aqd:change = 'true']
            let $part1 :=
                if (count($x/aqd:content) = 0) then
                    <tr>
                        <td title="Element">aqd:content</td>
                        <td title="Status">Missing</td>
                    </tr>
                else ()
            let $part2 :=
                if ($x/aqd:changeDescription = '') then
                    <tr>
                        <td title="Element">aqd:changeDescription</td>
                        <td title="Status">Missing or empty</td>
                    </tr>
                else ()
            return
                ($part1, $part2)
        }  catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }
    (: If aqd:change='false', then aqd:content IS NOT expected. :)
    let $appearingElementsIfAqdChangeIsFalse :=
        try {
            if (count($docRoot//aqd:AQD_ReportingHeader[aqd:change = 'false']/aqd:content) > 0) then
                <tr>
                    <td title="Element">aqd:content</td>
                    <td title="Status">Not expected</td>
                </tr>
            else
                ()
        }  catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }
    let $resultTable :=
        <table class="maintable hover" id="fileLink-{$pos}" style="display:none">
            {html:build2("1", $labels:ENV1, $labels:ENV1, $containsAqdReportingHeader, "Check passed", "", $errors:ERROR)}
            {html:build2("2", $labels:ENV2, labels:interpolate($labels:ENV2, ($minimumYear, $maximumYear)), $falseTimePeriod, "Check passed", "", $errors:ERROR)}
            {html:build2("3", $labels:ENV3, $labels:ENV3, $missingAqdReportingHeaderSubElements, "Check passed", "", $errors:ERROR)}
            {html:build2("4", $labels:ENV4, $labels:ENV4, $missingElementsIfAqdChangeIsTrue, "Check passed", "", $errors:ERROR)}
            {html:build2("5", $labels:ENV5, $labels:ENV5, $appearingElementsIfAqdChangeIsFalse, "Check passed", "", $errors:ERROR)}
        </table>
    let $resultErrorClass :=
        errors:getMaxError($resultTable//div)
    return
        (
        <tr>
            <td class="bullet">{html:getBullet(string($pos), $resultErrorClass)}</td>
            <td colspan="2" style="color:{errors:getClassColor($resultErrorClass)}">Checked file: { common:getCleanUrl($file) }</td>
            <td>
                <a id='envelopeLink-{$pos}' href='javascript:toggleItem("fileLink","envelopeLink", "{$pos}", "Check")'>Show Check</a>
            </td>
        </tr>,
        <tr>
            <td></td>
            <td colspan="3">
                {$resultTable}
            </td>
        </tr>)
};

declare function envelope:getObligationMinMaxYear($envelope as element(envelope)) as element(year) {
    let $part1_deadline := xs:date("2017-02-15")
    let $part3_deadline := xs:date("2017-05-31")
    let $deadline := 2017
    let $id := substring-after($envelope/obligation, $vocabulary:OBLIGATIONS)
    let $part1 := ("670", "671", "672", "673", "674", "675", "679", "742")
    let $part2 := ("680", "681", "682", "683")
    let $part3 := ("693", "694")
    let $minYear :=
        if ($id = $part1) then
            if (current-date() <= $part1_deadline) then
                $deadline - 2
            else
                $deadline - 1
        else if ($id = $part2) then
            $deadline - 3
        else if ($id = $part3) then
            if (current-date() <= $part3_deadline) then
                $deadline
            else
                $deadline + 1
        else
            ()
    let $maxYear :=
        if ($id = $part1) then
            $deadline - 1
        else if ($id = $part2) then
            $deadline - 1
        else if ($id = $part3) then
            $deadline + 1
        else
            ()
    return
        <year>
            <min>{$minYear}</min>
            <max>{$maxYear}</max>
        </year>
};

declare function envelope:errorTable($pos, $file) {
    <tr>
        <td class="bullet">{html:getBullet(string($pos), $errors:ERROR)}</td>
        <td colspan="3">File is not available for aqd:AQD_ReportingHeader check: { common:getCleanUrl($file) }</td>
    </tr>
};

declare function envelope:validateEnvelope($source_url as xs:string) as element(div) {

    let $envelope := doc($source_url)/envelope
    let $minimumYear := number(envelope:getObligationMinMaxYear($envelope)/min)
    let $maximumYear := number(envelope:getObligationMinMaxYear($envelope)/max)
    let $xmlFilesWithAQSchema := envelope:getAQFiles($source_url)
    let $filesWithAQSchema := $envelope/file[contains(@schema,'AirQualityReporting.xsd') and string-length(@link)>0]

    let $env1 :=
        try {
            let $validCount := count($filesWithAQSchema[@schema = $schemax:SCHEMA])
            return if ($validCount = 0) then
                <tr>
                    <p>Your delivery cannot be accepted as you did not provide any XML file with correct XML Schema location.<br />
                        Valid XML Schema location is: <strong>{$schemax:SCHEMA}</strong></p>
                </tr>
            else if ($validCount != count($xmlFilesWithAQSchema)) then
                <tr class="{$errors:ERROR}">
                    <p>1 or more AQ e-Reporting XML file(s) with incorrect XML Schema location<br />
                        Valid XML Schema location is: <strong>{$schemax:SCHEMA}</strong></p>
                </tr>
            else
                <tr class="{$errors:INFO}">
                    <p>Your delivery contains {$validCount} AQ e-Reporting XML file{substring("s ", number(not($validCount > 1)) * 2)}with correct XML Schema.</p>
                </tr>
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    let $env2 :=
        try {
            if ($envelope/year[number() != number()])  then
                <tr class="{$errors:ERROR}">
                    <p>Year has not been specified in the envelope period! Keep in mind that the year value must be between {$minimumYear} - {$maximumYear} and it must be equal to the year in gml:beginPosition element (in aqd:AQD_ReportingHeader).</p>
                </tr>
            else if ($envelope/year/number() < $minimumYear or $envelope/year/number() > $maximumYear) then
                <tr class="{$errors:ERROR}">
                    <p>Year specified in the envelope period is outside the allowed range of {$minimumYear} - {$maximumYear}! Keep in mind that the year value must be between {$minimumYear} - {$maximumYear} and it must be equal to the year in gml:beginPosition element (in aqd:AQD_ReportingHeader).</p>
                </tr>
            else
                ()
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }

    let $env3 :=
        try {
            for $file at $pos in $xmlFilesWithAQSchema
            return
                if (doc-available($file)) then
                    envelope:checkFileReportingHeader($envelope, $file, $pos)
                else
                    envelope:errorTable($pos, common:getCleanUrl($file))
        } catch * {
            <tr class="{$errors:FAILED}">
                <td title="Error code">{$err:code}</td>
                <td title="Error description">{$err:description}</td>
            </tr>
        }


    let $errorCount := count($env1[tokenize(@class, "\s+") = $errors:ERROR]) + count($env1[tokenize(@class, "\s+") = $errors:FAILED]) +
            count($env2[tokenize(@class, "\s+") = $errors:ERROR]) + count($env2[tokenize(@class, "\s+") = $errors:FAILED]) +
            count($env3//div[tokenize(@class, "\s+") = $errors:ERROR]) + count($env3//div[tokenize(@class, "\s+") = $errors:FAILED])
    let $errorLevel :=
        if ($errorCount = 0) then
            "INFO"
        else
            "BLOCKER"

    let $feedbackMessage :=
        if ($errorCount = 0) then
            "No envelope-level errors found" 
        else
            $errorCount || ' envelope-level error' || substring('s ', number(not($errorCount > 1)) * 2) || 'found'

    return
        <div class="feedbacktext">
            {html:getHead()}
            {html:getCSS()}
            <div class="row column">
                <span id="feedbackStatus" class="{$errorLevel}" style="display:none">{$feedbackMessage}</span>
                <h3>Checked contents of envelope:</h3>
                {$env1}
                {$env2}
                <table class="maintable hover">
                {$env3}
                </table>
                <br/>
                <div class="footnote"><sup>*</sup>Detailed information about the QA/QC rules checked in this routine can be found from the <a href="http://www.eionet.europa.eu/aqportal/qaqc/">e-reporting QA/QC rules documentation</a> in chapter "2.1.3 Check for Reporting Header within an envelope".</div>
                {html:getFoot()}
                {html:javaScriptRoot()}
            </div>
        </div>
};


(:~
: User: George Sofianos
: Date: 6/23/2016
: Time: 3:59 PM
:)











































































































































































































































































































































































































































































































































































(: Returns error class if there are more than 0 error elements :)
declare function errors:getClass($elems) {
  if (count($elems) > 0) then
      "error"
  else
      "info"
};

declare function errors:getClassColor($class as xs:string) {
    switch ($class)
    case $errors:FAILED return $errors:COLOR_FAILED
    case $errors:BLOCKER return $errors:COLOR_BLOCKER
    case $errors:ERROR return $errors:COLOR_ERROR
    case $errors:WARNING return $errors:COLOR_WARNING
    case $errors:INFO return $errors:COLOR_INFO
    default return $errors:COLOR_SKIPPED
};

declare function errors:getMaxError($records as element()*) as xs:string {
    if (count($records[@class = $errors:FAILED]) > 0) then $errors:FAILED
    else if (count($records[@class = $errors:BLOCKER]) > 0) then $errors:BLOCKER
    else if (count($records[@class = $errors:ERROR]) > 0) then $errors:ERROR
    else if (count($records[@class = $errors:WARNING]) > 0) then $errors:WARNING
    else if (count($records[@class = $errors:SKIPPED]) > 0) then $errors:SKIPPED
    else $errors:INFO
};

declare function errors:hasFailed($records as element()*) as xs:boolean {
    errors:getMaxError($records) = $errors:FAILED
};

declare function errors:getError($notation as xs:string) {
    dd:getQAQCErrorType($notation)
};

(:~
: User: George Sofianos
: Date: 6/14/2016
: Time: 1:22 PM
:)


declare function filter:filterByName($results as element(result)*, $elem as xs:string, $string as xs:string*) as element(result)* {
    for $x in $results
    where ($x/*[local-name() = $elem] = $string)
    return $x
};

(:~
: User: George Sofianos
: Date: 11/14/16
: Time: 2:00 PM
:)

declare function functx:is-leap-year($date as xs:anyAtomicType?) as xs:boolean {
    for $year in xs:integer(substring(string($date),1,4))
    return ($year mod 4 = 0 and
            $year mod 100 != 0) or
            $year mod 400 = 0
};

declare function functx:escape-for-regex($arg as xs:string?) as xs:string {
    replace($arg, '(\.|\[|\]|\\|\||\-|\^|\$|\?|\*|\+|\{|\}|\(|\))','\\$1')
};

declare function functx:if-empty
 ( $arg as item()* ,
   $value as item()* )  as item()* {

    if (string($arg) != '')
        then data($arg)
        else $value
};

(:~
: User: George Sofianos
: Date: 6/17/2016
: Time: 12:03 PM
:)


declare function geox:getX($point) as xs:string {
  substring-before($point, " ")
};

declare function geox:getY($point) as xs:string {
  substring-after($point, " ")
};

declare function geox:parseDateTime($x as xs:string) as xs:dateTime? {
    if ($x castable as xs:dateTime) then
        xs:dateTime($x)
    else if ($x castable as xs:date) then
        xs:dateTime(xs:date($x))
    else ()
};
(:~
 : In Europe, lat values tend to be bigger than lon values. We use this observation as a poor farmer's son test to check that in a coordinate value pair,
 : the lat value comes first, as defined in the GML schema)
 : Normally lat should be larger than long
 :)
declare function geox:compareLatLong($srsName as xs:string, $lat as xs:double, $long as xs:double) {
    let $inverseSrs := ("urn:ogc:def:crs:EPSG::3035")
    return
        if ($srsName = $inverseSrs) then
            $long > $lat
        else
            $lat > $long
};

(:~
:
: User: George Sofianos
: Date: 5/31/2016
: Time: 11:48 AM
:)


declare function html:getHead() as element()* {
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/foundation/6.2.3/foundation.min.css">&#32;</link>,
    <meta charset="utf-8"/>
};

declare function html:getCSS() as element(style) {
    <style>
        <![CDATA[
        .bullet {
            font-size: 0.8em;
            color: white;
            padding-left:5px;
            padding-right:5px;
            margin-right:5px;
            margin-top:2px;
            text-align:center;
            width: 5%;
        }
        table.maintable.hover tbody tr th {
            text-align:left;
            width: 75%;
        }
        table.maintable.hover tbody tr {
            border-top:1px solid #666666;
        }
        table.maintable.hover tbody tr th.separator {
            font-size: 1.1em;
            text-align:center;
            color:#666666;
        }
        .datatable {
            font-size: 0.9em;
            text-align:left;
            vertical-align:top;
            display:none;
            border:0px;
        }
        .datatable tbody tr.warning {
            font-size: 1.2em;
            color:red;
        }
        .datatable tbody tr.error {
            font-size: 1.2em;
            color:red;
        }
        .datatable tbody tr {
            font-size: 0.9em;
            color:#666666;
        }
        .smalltable {
            display:none;
        }
        .smalltable tbody tr {
             font-size: 0.9em;
             color:grey;
        }
        .smalltable tbody td {
            font-style:italic;
            vertical-align:top;
        }
        .header {
            text-align:right;
            vertical-align:top;
            background-color:#F6F6F6;
            font-weight: bold;
        }
        .largeText {
            font-size:1.3em;
        }
        .box {
            padding:10px;
            border:1px solid rgba(0,0,0,0.5);
        }
        .bg-failed {
            background:white;
        }
        .bg-blocker {
            background:firebrick;
        }
        .bg-error {
            background:red;
        }
        .bg-warning {
            background:bisque;
        }
        .bg-info {
            background:#A0D3E8;
        }
        .reveal {
            width:900px;
            border: 7px solid #cacaca;
        }
        ]]>
    </style>
};

declare function html:getFoot() as element()* {
    (<script src="https://cdn.jsdelivr.net/jquery/2.2.4/jquery.min.js">&#32;</script>,
    <script src="https://cdn.jsdelivr.net/foundation/6.2.3/foundation.min.js">&#32;</script>,
    <script type="text/javascript">
        $(document).foundation();
    </script>)
};

declare function html:getModalInfo($ruleCode, $longText) as element()* {
    (<span><a class="largeText" data-open="{concat('text-modal-', $ruleCode)}">&#8520;</a></span>,
    <div class="reveal" id="{concat('text-modal-', $ruleCode)}" data-reveal="">
        <h4>{$ruleCode}</h4>
        <hr/>
        <p>{$longText}</p>
        <button class="close-button" data-close="" aria-label="Close modal" type="button">x</button>
    </div>)
};

declare function html:getBullet($text as xs:string, $level as xs:string) as element(div) {
    let $color :=
        switch ($level)
        case $errors:FAILED return $errors:COLOR_FAILED
        case $errors:BLOCKER return $errors:COLOR_BLOCKER
        case $errors:ERROR return $errors:COLOR_ERROR
        case $errors:WARNING return $errors:COLOR_WARNING
        case $errors:SKIPPED return $errors:COLOR_SKIPPED
        default return $errors:COLOR_INFO
    let $text := if ($text != "NS") then <a target="_blank" href="{$vocabulary:QAQC_VOCABULARY || $text}" style="color: inherit">{$text}</a> else $text
    return
        <div class="{$level}" style="background-color: { $color };">{ $text }</div>
};

declare function html:buildInfoTR($text as xs:string) as element(tr) {
    <tr>
        <th class="separator" colspan="4">{$text}</th>
    </tr>
};

(: JavaScript :)
declare function html:javaScriptRoot(){

    let $js :=
        <script type="text/javascript">
            <![CDATA[
    function showLegend(){
        document.getElementById('legend').style.display='table';
        document.getElementById('legendLink').style.display='none';
    }
    function hideLegend(){
        document.getElementById('legend').style.display='none';
        document.getElementById('legendLink').style.display='table';
    }
    function toggle(divName, linkName, checkId) {{
         toggleItem(divName, linkName, checkId, 'record');
    }}

   function toggleItem(divName, linkName, checkId, itemLabel) {{
        divName = divName + "-" + checkId;
        linkName = linkName + "-" + checkId;

        var elem = document.getElementById(divName);
        var text = document.getElementById(linkName);
        if(elem.style.display == "table") {{
            elem.style.display = "none";
            text.innerHTML = "Show " + itemLabel + "s";
            }}
            else {{
              elem.style.display = "table";
              text.innerHTML = "Hide " + itemLabel + "s";
            }}
      }}

      function toggleComb(divName, linkName, checkId, itemLabel) {{
        divName = divName + "-" + checkId;
        linkName = linkName + "-" + checkId;

        var elem = document.getElementById(divName);
        var text = document.getElementById(linkName);
        if(elem.style.display == "table") {{
            elem.style.display = "none";
            text.innerHTML = "Show " + itemLabel + "s";
            }}
            else {{
              elem.style.display = "table";
              text.innerHTML = "Hide " + itemLabel + "s";
            }}
      }}

            ]]>
        </script>
    return
        <script type="text/javascript">{normalize-space($js)}</script>
};

declare function html:deprecated($ruleCode as xs:string, $longText, $text, $records as element(tr)*,
        $valueHeading as xs:string, $validMsg as xs:string, $invalidMsg as xs:string, $skippedMsg, $errorLevel as xs:string)
as element(tr)*{
    ()
};
declare function html:buildExists($ruleCode as xs:string, $longText, $text, $records as element(tr)*, $validMessage as xs:string, $invalidMessage as xs:string, $errorLevel as xs:string) {

    let $data := html:parseData($records, "data")

    let $countRecords := count($data)
    let $bulletType :=
        if (count($data) = 0) then
            $errors:INFO
        else
            $errorLevel
    let $message :=
        if ($bulletType = $errors:INFO) then
            $validMessage
        else
            $invalidMessage

    let $result :=
        <tr>
            <td class="bullet">{html:getBullet($ruleCode, $bulletType)}</td>
            <th colspan="2">{$text} {html:getModalInfo($ruleCode, $longText)}</th>
            <td><span class="largeText">{$message}</span></td>
        </tr>

    return $result
};

declare function html:buildXML($ruleCode as xs:string, $longText, $text, $records as element(tr)*, $validMessage as xs:string, $invalidMessage as xs:string, $errorLevel as xs:string) {
    let $countRecords := count($records)
    let $ruleCode := "XML"(: || string(random:double() * 100):)
    let $errorClass :=
        if ($countRecords > 0) then
            $errorLevel
        else
            $errors:INFO
    let $message :=
        if ($countRecords > 0) then
            $invalidMessage
        else
            $validMessage
    let $result :=
            (
                <tr>
                    <td class="bullet">{html:getBullet($ruleCode, $errorClass)}</td>
                    <th colspan="2">{$text} {html:getModalInfo($ruleCode, $longText)}</th>
                    <td><span class="largeText">{$message}</span>{
                        if ($countRecords > 0 or count($records)>0) then
                            <a id='feedbackLink-{$ruleCode}' href='javascript:toggle("feedbackRow","feedbackLink", "{$ruleCode}")'>{$labels:SHOWRECORDS}</a>
                        else
                            ()
                    }
                    </td>
                </tr>,
                if (count($records) > 0) then
                    <tr>
                        <td></td>
                        <td colspan="3">
                            <table class="datatable" id="feedbackRow-{$ruleCode}">
                                <tr>{
                                    for $th in $records[1]//td return <th>{ data($th/@title) }</th>
                                }</tr>
                                {$records}
                            </table>
                        </td>
                    </tr>
                else
                    ()
            )
    return $result
};
declare function html:buildSimple($ruleCode as xs:string, $longText, $text, $records as element(tr)*, $message as xs:string, $unit as xs:string, $errorLevel as xs:string) {
    let $data := html:parseData($records, "data")

    let $countRecords := count($records)
    let $message :=
        if ($countRecords = 0) then
            "No records found"
        else if ($message) then
            $message
        else
            $countRecords || " " || $unit || substring("s ", number(not($countRecords > 1)) * 2) || " found"
    let $bulletType := $errorLevel
    return html:buildGeneric($ruleCode, $longText, $text, $records, $message, $bulletType)
};
declare function html:build0($ruleCode as xs:string, $longText, $text, $records as element(tr)*, $unit as xs:string) {
    let $data := html:parseData($records, "data")

    let $countRecords := count($records)
    let $bulletType :=
        if (count($records) = 0) then
            $errors:SKIPPED
        else
            $errors:INFO
    let $message :=
        if ($bulletType = $errors:SKIPPED) then
            "No records found"
        else
            $countRecords || " " || $unit || substring("s ", number(not($countRecords > 1)) * 2) || " found"

        return html:buildGeneric($ruleCode, $longText, $text, $records, $message, $bulletType)
};

declare function html:buildUnique($ruleCode as xs:string, $longText, $text, $records as element(tr)*, $unit as xs:string, $errorLevel as xs:string) {
    let $data := html:parseData($records, "data")

    let $countRecords := count($records)
    let $bulletType :=
        if (count($records) = 1) then
            $errors:INFO
        else
            $errorLevel
    let $message := $countRecords || " " || $unit || substring("s ", number(not($countRecords > 1)) * 2) || " found"
    return
        if (count($records) = 1) then
            <tr>
                <td class="bullet">{html:getBullet($ruleCode, $bulletType)}</td>
                <th colspan="2">{$text} {html:getModalInfo($ruleCode, $longText)}</th>
                <td><span class="largeText">{$message}</span></td>
            </tr>
        else
            html:buildGeneric($ruleCode, $longText, $text, $records, $message, $bulletType)
};

declare function html:build1(
    $ruleCode as xs:string,
    $longText,
    $text,
    $records as element(tr)*,
    $valueHeading as xs:string,
    $validMsg as xs:string,
    $unit as xs:string,
    $skippedMsg,
    $errorLevel as xs:string
) as element(tr)* {

    let $data := html:parseData($records, "data")
    let $countRecords := count($data)
    let $bulletType :=
        if (string-length($skippedMsg) > 0) then
            $errors:SKIPPED
        else if (count($data) > 0) then
            $errors:INFO
        else
            $errorLevel
    let $message :=
        if (string-length($skippedMsg) > 0) then
            $skippedMsg
        else if ($countRecords > 0) then
            $validMsg
        else
            $countRecords || " " || $unit || " found"
    return html:buildGeneric($ruleCode, $longText, $text, $data, $validMsg, $bulletType)
};

declare function html:build2(
    $ruleCode as xs:string,
    $longText,
    $text,
    $records as element(tr)*,
    $validMsg as xs:string,
    $unit as xs:string,
    $errorLevel as xs:string
) as element(tr)* {

    let $metadata := html:parseData($records, "metadata")
    let $thead := html:parseData($records, "thead")
    let $data := html:parseData($records, "data")

    let $countRecords := count($data)
    let $skipped := $metadata/count = "0"

    let $bulletType :=
        if ($skipped) then
            $errors:SKIPPED
        else if (count($data) = 0) then
            $errors:INFO
        else
            $errorLevel

    let $message :=
        if ($skipped) then
            $labels:SKIPPED
        else if ($countRecords = 0) then
            $validMsg
        else
            $countRecords || " " || $unit || substring("s ", number(not($countRecords > 1)) * 2) || " found"

    return html:buildGeneric(
        $ruleCode,
        $longText,
        $text,
        $data,
        $message,
        $bulletType
    )
};

declare function html:build3(
    $ruleCode as xs:string,
    $longText,
    $text,
    $records as element(tr)*,
    $message as xs:string,
    $errorLevel as xs:string
) as element(tr)* {
    let $data := html:parseData($records, "data")
    let $bulletType := $errorLevel
    return
        <tr>
            <td class="bullet">{html:getBullet($ruleCode, $bulletType)}</td>
            <th colspan="2">{$text} {html:getModalInfo($ruleCode, $longText)}</th>
            <td><span class="largeText">{$message}</span></td>
        </tr>
};


(:  Invalid msg: "10 records found"
:)
declare function html:build9(
    $ruleCode as xs:string,
    $longText,
    $text,
    $records as element(tr)*,
    $valueHeading as xs:string,
    $validMsg as xs:string,
    $unit as xs:string,
    $skippedMsg,
    $errorLevel as xs:string
) as element(tr)* {

    let $data := html:parseData($records, "data")
    let $countRecords := count($data)
    let $countInvalid := count($data/@valid = "false")
    let $bulletType :=
        if ($countRecords = 0) then
            $errors:SKIPPED
        else if ($countInvalid > 0) then
            $errorLevel
        else
            $errors:INFO
    let $message :=
        if ($countRecords = 0) then
            $skippedMsg
        else if ($countInvalid > 0) then
            $countInvalid ||
            " " ||
            $unit ||
            substring("s ", number(not($countRecords > 1)) * 2) ||
            " found"
        else
            $validMsg
    return html:buildGeneric($ruleCode, $longText, $text, $data, $message, $bulletType)
};

(:  Invalid msg: "X is not unique"

TODO: maybe remove :)
declare function html:build7(
    $ruleCode as xs:string,
    $longText,
    $text,
    $records as element(tr)*,
    $valueHeading as xs:string,
    $validMsg as xs:string,
    $unit as xs:string,
    $skippedMsg,
    $errorLevel as xs:string
) as element(tr)* {

    let $data := html:parseData($records, "data")
    let $countRecords := count($data)
    let $countInvalid := count($data/@valid = "false")
    let $bulletType :=
        if ($countRecords = 0) then
            $errors:SKIPPED
        else if ($countRecords = 1) then
            $errors:INFO
        else
            $errorLevel
    let $message :=
        if ($countRecords = 0) then
            $skippedMsg
        else if ($countRecords > 1) then
            $unit || "is not unique"
        else if ($countRecords = 1) then
            $validMsg
        else
            "unknown error"

    return html:buildGeneric($ruleCode, $longText, $text, $data, $validMsg, $bulletType)
};

(:~
 : Selects and returns specified data blocks (metadata, data, headers, etc)
 :
 :)
declare %private function html:parseData($records as element(tr)*, $type as xs:string) as element(tr)* {
    if ($type = "metadata") then
        $records[@metadata="true"]
    else if ($type = "thead") then
        $records[@thead="true"]
    else
        $records[not(@metadata) and not(@thead)]
};

(: Builds HTML table rows for rules. :)
declare %private function html:buildGeneric(
    $ruleCode as xs:string,
    $longText,
    $text,
    $records as element(tr)*,
    $message as xs:string,
    $bulletType as xs:string
) as element(tr)* {

    let $countRecords := count($records)
    let $hasFailed := errors:hasFailed(($records, $records//td))
    let $bulletType := if ($hasFailed) then $errors:FAILED else $bulletType
    let $result :=
        (
            <tr>
                <td class="bullet">{html:getBullet($ruleCode, $bulletType)}</td>
                <th colspan="2">{$text} {html:getModalInfo($ruleCode, $longText)}</th>
                <td><span class="largeText">{$message}</span>{
                    if ($countRecords > 0 or count($records)>0) then
                        <a id='feedbackLink-{$ruleCode}' href='javascript:toggle("feedbackRow","feedbackLink", "{$ruleCode}")'>{$labels:SHOWRECORDS}</a>
                    else
                        ()
                }
                </td>
            </tr>,
            if (count($records) > 0) then
                <tr>
                    <td></td>
                    <td colspan="3">
                        <table class="datatable" id="feedbackRow-{$ruleCode}">
                            <tr>{
                                for $th in $records[1]//td return <th>{ data($th/@title) }</th>
                            }</tr>
                            {$records}
                        </table>
                    </td>
                </tr>
            else
                ()
        )
    return $result

};

declare function html:buildResultsSimpleRow($ruleCode as xs:string, $longText, $text, $count, $errorLevel) {
    let $bulletType := $errorLevel
    return
    <tr>
        <td class="bullet">{html:getBullet($ruleCode, $bulletType)}</td>
        <th colspan="2">{$text} {html:getModalInfo($ruleCode, $longText)}</th>
        <td class="largeText">{$count}</td>
    </tr>
};

declare function html:buildItemsList($ruleId as xs:string, $vocabularyUrl as xs:string, $ids as xs:string*) as element(div) {
    let $list :=
        for $id in $ids
        let $refUrl := concat($vocabularyUrl, $id)
        return
            <p>{ $refUrl }</p>

    return
        <div>
            <a id='vocLink-{$ruleId}' href='javascript:toggleItem("vocValuesDiv","vocLink", "{$ruleId}", "combination")'>{$labels:SHOWCOMBINATIONS}</a>
            <div id="vocValuesDiv-{$ruleId}" style="display:none">{ $list }</div>
        </div>
};

declare function html:buildInfoTable($ruleId as xs:string, $table as element(table)) {
    <div>
        <a id='vocLink-{$ruleId}' href='javascript:toggleItem("vocValuesDiv","vocLink", "{$ruleId}", "combination")'>{$labels:SHOWCOMBINATIONS}</a>
        <div id="vocValuesDiv-{$ruleId}" style="display:none">{ $table }</div>
    </div>
};

declare function html:getErrorTD($errValue,  $element as xs:string, $showMissing as xs:boolean) as element(td) {
    let $val := if ($showMissing and string-length($errValue)=0) then "-blank-" else $errValue
    return
        <td title="{$element}" style="color:red">{$val}</td>
};

declare function html:buildConcatRow($elems, $header as xs:string) as element(tr)? {
    if (count($elems) > 0) then
        <tr style="font-size: 0.9em;color:grey;">
            <td colspan="2" style="text-align:right;vertical-align:top;">{$header}</td>
            <td style="font-style:italic;vertical-align:top;">{ string-join($elems, ", ")}</td>
        </tr>
    else
        ()
};
declare function html:buildCountRow0($ruleCode as xs:string, $longText, $text, $count as xs:integer, $validMessage as xs:string?, $unit as xs:string?, $errorClass as xs:string?) as element(tr) {
    let $errorClsas :=
        if ($count > 0) then
            $errors:INFO
        else if (empty($errorClass)) then $errors:ERROR
        else $errorClass
    let $message :=
        if ($count = 0) then
            "No " || $unit || "s found"
        else
            $count || " " || $unit || substring("s ", number(not($count > 1)) * 2) || "found"
    return
        <tr>
            <td class="bullet">{html:getBullet($ruleCode, $errorClsas)}</td>
            <th colspan="2">{$text} {html:getModalInfo($ruleCode, $longText)}</th>
            <td class="largeText">{$message}</td>
        </tr>
};

declare function html:buildCountRow($ruleCode as xs:string, $longText, $text, $count as xs:integer, $validMessage as xs:string?, $unit as xs:string?, $errorClass as xs:string?) as element(tr) {
    let $class :=
        if ($count = 0) then
            $errors:INFO
        else if (empty($errorClass)) then $errors:ERROR
        else $errorClass
    let $validMessage := if (empty($validMessage)) then "All Ids are unique" else $validMessage
    let $message :=
        if ($count = 0) then
            $validMessage
        else
            $count || $unit || substring("s ", number(not($count > 1)) * 2) || "found"
    return
    <tr>
        <td class="bullet">{html:getBullet($ruleCode, $class)}</td>
        <th colspan="2">{$text} {html:getModalInfo($ruleCode, $longText)}</th>
        <td class="largeText">{$message}</td>
    </tr>
};
declare function html:buildCountRow2($ruleCode as xs:string, $longText, $text, $records as element(tr), $header as xs:string,
        $validMessage as xs:string?, $unit as xs:string?, $errorClass as xs:string?) as element(tr)* {
    let $status := xs:string($records/@status)
    let $count := $records/@count
    let $class :=
        if ($status = $errors:FAILED) then
            $errors:FAILED
        else if ($count = 0) then
            if (empty($errorClass)) then
                $errors:ERROR
            else
                $errorClass
        else
            $errors:INFO
    let $unit := if (empty($unit)) then "error" else $unit
    let $validMessage := if (empty($validMessage)) then "All Ids are unique" else $validMessage
    let $message :=
        if ($status = $errors:FAILED) then
            "Check failed:"
        else if ($count = 0) then
            "No " || $unit || "s found"
        else
            $validMessage
    return
        (<tr>
            <td class="bullet">{html:getBullet($ruleCode, $class)}</td>
            <th colspan="2">{$text} {html:getModalInfo($ruleCode, $longText)}</th>
            <td><span class="largeText">{$message}</span>{
                if ($status = $errors:FAILED) then
                    <a id='feedbackLink-{$ruleCode}' href='javascript:toggle("feedbackRow","feedbackLink", "{$ruleCode}")' style="padding-left:10px;">{$labels:SHOWERRORS}</a>
                else ()}
            </td>
        </tr>,
        if ($status = $errors:FAILED) then
        <tr>
            <td></td>
            <td colspan="3">
                <table class="datatable" id="feedbackRow-{$ruleCode}">
                    <tr>{
                        for $th in $records[1]//td return <th>{ data($th/@title) }</th>
                    }</tr>
                    {$records}
                </table>
            </td>
        </tr> else ())
};

declare function html:buildResultDiv($meta as map(*), $result as element(table)?) {
    let $count := map:get($meta, "count")
    let $header := map:get($meta, "header")
    let $dataflow := map:get($meta, "dataflow")
    let $zeroCount := map:get($meta, "zeroCount")
    let $report := map:get($meta, "report")
    return
    <div>
        <h2>{$header} - {$dataflow}</h2>
        {
            if ($count = 0) then
                $zeroCount
            else
                <div>
                    {
                        if ($result//div/tokenize(@class, "\s+") = $errors:FAILED) then
                            <p class="{$errors:FAILED} bg-failed box" style="color:black">
                                <strong>The following checks have failed to execute: {string-join($result//div[tokenize(@class, "\s+") = $errors:FAILED], ',')}</strong>
                            </p>
                        else ()
                    }
                    {
                        if ($result//div/tokenize(@class, "\s+") = $errors:BLOCKER) then
                            <p class="{$errors:BLOCKER} bg-blocker box" style="color:white">
                                <strong>This XML file did NOT pass the following BLOCKER check(s): {string-join($result//div[tokenize(@class, "\s+") = $errors:BLOCKER], ',')}</strong>
                            </p>
                        else
                            (:color:#0080FF:)
                            <p class="{$errors:INFO} bg-info box" style="color:white">
                                <strong>This XML file passed all BLOCKER checks.</strong>
                            </p>
                    }
                    {
                        if ($result//div/tokenize(@class, "\s+") = $errors:ERROR) then
                            <p class="{$errors:ERROR} bg-error box" style="color:white">
                                <strong>This XML file did NOT pass the following ERROR check(s): {string-join($result//div[tokenize(@class, "\s+") = $errors:ERROR], ',')}</strong>
                            </p>
                        else
                            <p class="{$errors:INFO} bg-info box" style="color:white">
                                <strong>This XML file passed all ERROR checks.</strong>
                            </p>
                    }
                    {
                        if ($result//div/tokenize(@class, "\s+") = $errors:WARNING) then
                            <p class="{$errors:WARNING} bg-warning box" style="color:{$errors:COLOR_WARNING}">
                                <strong>This XML file generated warnings during the following check(s): {string-join($result//div[tokenize(@class, "\s+") = $errors:WARNING], ',')}</strong>
                            </p>
                        else
                            ()
                    }
                    {$report}
                    <div><a id='legendLink' href="javascript: showLegend()" style="padding-left:10px;">How to read the test results?</a></div>
                    <fieldset style="font-size: 90%; display:none" id="legend">
                        <legend>How to read the test results</legend>
                        All test results are labeled with coloured bullets. The number in the bullet reffers to the rule code. The background colour of the bullets means:
                        <ul style="list-style-type: none;">
                            <li><div style="width:50px; display:inline-block;margin-left:10px">{html:getBullet('Blue', $errors:INFO)}</div> - the data confirms to the rule, but additional feedback could be provided in QA result.</li>
                            <li><div style="width:50px; display:inline-block;margin-left:10px">{html:getBullet('Red', $errors:BLOCKER)}</div> - the crucial check did NOT pass and errenous records found from the delivery.</li>
                            <li><div style="width:50px; display:inline-block;margin-left:10px">{html:getBullet('Red', $errors:ERROR)}</div> - the serious check did NOT pass and errenous records found from the delivery.</li>
                            <li><div style="width:50px; display:inline-block;margin-left:10px">{html:getBullet('Orange', $errors:WARNING)}</div> - the non-crucial check did NOT pass.</li>
                            <li><div style="width:50px; display:inline-block;margin-left:10px">{html:getBullet('Grey', $errors:SKIPPED)}</div> - the check was skipped due to no relevant values found to check.</li>
                        </ul>
                        <p>Click on the "{$labels:SHOWRECORDS}" link to see more details about the test result.</p>
                    </fieldset>
                    <h3>Test results</h3>
                    {$result}
                </div>
        }
    </div>
};

declare function html:createMetadataTR($rowsCount as xs:integer) {
    <tr metadata="true">
        <count>{$rowsCount}</count>
    </tr>
};

(: TODO: correct name for this function would be html:errorRow :)
declare function html:createErrorRow(
    $errCode as xs:anyAtomicType,
    $errDesc as xs:string
) {
    <tr class="{$errors:FAILED}">
        <td title="Error code">{$errCode}</td>
        <td title="Error description">{$errDesc}</td>
    </tr>
};

(:~
: AQD Labels
: @author George Sofianos
: Date: 5/31/2016
: Time: 1:32 PM
:)

(: HTML Labels :)





(: ENVELOPE QC LABELS :)






(: QC Labels :)

























































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































declare function labels:getPrefLabel($notation as xs:string) {
  dd:getQAQCLabel($notation)
};

declare function labels:getDefinition($notation as xs:string) {
  dd:getQAQCDefinition($notation)
};

declare function labels:interpolate($label as xs:string, $values) {
  labels:interpolate($label, $values, 1)
};
declare %private function labels:interpolate($input as xs:string, $values, $count as xs:integer) {
  if (count($values) > 0) then
    labels:interpolate(replace($input, "\$" || $count, string(head($values))), tail($values), $count + 1)
  else $input
};
(:
 : Module Name: Implementing Decision 2011/850/EU: AQ info exchange & reporting (Main module)
 :
 : Version:     $Id$
 : Created:     30 December 2014
 : Copyright:   European Environment Agency
 :
 : AirQuality obligation dependentent XQuery script call library modules based on the obligation URL extracted from CDR envelope XML.
 : The original request: http://taskman.eionet.europa.eu/issues/21548
 :
 : @author Enriko Käsper
 : @author George Sofianos
 : BLOCKER logic added and other changes by Hermann Peifer, EEA, August 2015
 :)

(:~
 : Dataflow B script - Zones
 : Dataflow C script - Assessment regimes
 : Dataflow D script -
 : Dataflow G script -
 : Dataflow H script -
 : Dataflow I script -
 : Dataflow J script -
 : Dataflow K script -
 : Dataflow M script -
 :)



declare function obligations:proceed($source_url as xs:string) {

    (: get reporting obligation & country :)
    let $envelopeUrl := common:getEnvelopeXML($source_url)
    let $obligations := doc($envelopeUrl)/envelope/obligation
    let $countryCode := lower-case(doc($envelopeUrl)/envelope/countrycode)

    let $validObligations := common:getSublist($obligations,
            ($dataflowB:OBLIGATIONS, $dataflowC:OBLIGATIONS, $dataflowD:OBLIGATIONS, $dataflowG:OBLIGATIONS,
            $dataflowH:OBLIGATIONS, $dataflowI:OBLIGATIONS, $dataflowJ:OBLIGATIONS, $dataflowK:OBLIGATIONS,
            $dataflowM:OBLIGATIONS, $dataflowEa:OBLIGATIONS, $dataflowEb:OBLIGATIONS))

    let $result := ()
    let $resultB :=
        if (common:containsAny($obligations, $dataflowB:OBLIGATIONS)) then
            dataflowB:proceed($source_url, $countryCode)
        else
            ()
    let $resultC :=
        if (common:containsAny($obligations, $dataflowC:OBLIGATIONS)) then
            dataflowC:proceed($source_url, $countryCode)
        else
            ()
    let $resultD :=
        if (common:containsAny($obligations, $dataflowD:OBLIGATIONS)) then
            dataflowD:proceed($source_url, $countryCode)
        else
            ()
    let $resultG :=
        if (common:containsAny($obligations, $dataflowG:OBLIGATIONS)) then
            dataflowG:proceed($source_url, $countryCode)
        else
            ()
    let $resultH :=
        if (common:containsAny($obligations, $dataflowH:OBLIGATIONS)) then
            dataflowH:proceed($source_url, $countryCode)
        else
            ()
    let $resultI :=
        if (common:containsAny($obligations, $dataflowI:OBLIGATIONS)) then
            dataflowI:proceed($source_url, $countryCode)
        else
            ()
    let $resultJ :=
        if (common:containsAny($obligations, $dataflowJ:OBLIGATIONS)) then
            dataflowJ:proceed($source_url, $countryCode)
        else
            ()
    let $resultK :=
        if (common:containsAny($obligations, $dataflowK:OBLIGATIONS)) then
            dataflowK:proceed($source_url, $countryCode)
        else
            ()
    let $resultM :=
        if (common:containsAny($obligations, $dataflowM:OBLIGATIONS)) then
            dataflowM:proceed($source_url, $countryCode)
        else
            ()
    let $resultE :=
        if (common:containsAny($obligations, $dataflowEa:OBLIGATIONS)) then
            dataflowEa:proceed($source_url, $countryCode)
        else
            ()
    let $resultEb :=
        if (common:containsAny($obligations, $dataflowEb:OBLIGATIONS)) then
            dataflowEb:proceed($source_url, $countryCode)
        else
            ()

    let $messages := ($resultB, $resultC, $resultD, $resultE, $resultEb, $resultG, $resultH, $resultI, $resultJ, $resultK, $resultM)
    let $failedString := string-join($messages//p[tokenize(@class, "\s+") = $errors:FAILED], ' || ')
    let $blockerString := normalize-space(string-join($messages//p[tokenize(@class, "\s+") = $errors:BLOCKER], ' || '))
    let $errorString := normalize-space(string-join($messages//p[tokenize(@class, "\s+") = $errors:ERROR], ' || '))
    let $warningString := normalize-space(string-join($messages//p[tokenize(@class, "\s+") = $errors:WARNING], ' || '))

	let $errorLevel :=
        if ($blockerString) then
            "BLOCKER"
        else if ($failedString) then
            "FAILED"
		else if ($errorString) then
            "ERROR"
        else if ($warningString) then
            "WARNING"
        else
            "INFO"

	let $feedbackmessage :=
		if ($errorLevel = 'BLOCKER') then
            $blockerString
        else if ($errorLevel = "FAILED") then
            $failedString
        else if ($errorLevel = 'ERROR') then
            $errorString
        else if ($errorLevel = 'WARNING') then
            $warningString
        else if (empty($validObligations)) then
            "Nothing to check"
        else
            "This XML file passed all checks without errors or warnings"

return
    <div class="feedbacktext">
        {html:getHead()}
        {html:getCSS()}
        <span id="feedbackStatus" class="{$errorLevel}" style="display:none">{$feedbackmessage}</span>
        <div class="column row">
            <p>Checked XML file: <a href="{common:getCleanUrl($source_url)}">{common:getCleanUrl($source_url)}</a></p>
        </div>
        <div class="column row">{
            if (empty($validObligations)) then
                <p>Nothing to check - the envelope is not attached to any of the Air Quality obligation where QA script is available.</p>
            else
                <div>
                    {html:javaScriptRoot()}
                    {
                    if (count($validObligations) = 1) then
                        <p>The envelope is attached to the following obligation: <a href="{$validObligations[1]}">{$validObligations[1]}</a></p>
                    else
                        (<p>The envelope is attached to the following obligations:</p>,
                        <ul>
                            {
                                for $obligation in $validObligations
                                return
                                    <li><a href="{$obligation}">{$obligation}</a></li>
                            }
                        </ul>)
                    }
                    {$messages}
                </div>
            }
            {html:getFoot()}
        </div>
    </div>
};

(:~
: User: George Sofianos
: Date: 6/21/2016
: Time: 6:37 PM
:)


(: Normal InspireId Fetch - This should be the default :)
(: B :)
declare function query:getZone($url as xs:string?) as xs:string {
  "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
  PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
  PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>
  PREFIX aq: <http://reference.eionet.europa.eu/aq/ontology/>

  SELECT ?inspireLabel
  WHERE {
      ?zone a aqd:AQD_Zone ;
      aqd:inspireId ?inspireId .
      ?inspireId rdfs:label ?inspireLabel .
  FILTER (CONTAINS(str(?zone), '" || $url || "'))
  }"
};

(: C :)
declare function query:getAssessmentRegime($url as xs:string) as xs:string {
  "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
   PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
   PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>

   SELECT ?localId ?inspireLabel
   WHERE {
          ?regime a aqd:AQD_AssessmentRegime ;
          aqd:inspireId ?inspireId .
          ?inspireId rdfs:label ?inspireLabel .
          ?inspireId aqd:localId ?localId .
          FILTER (CONTAINS(str(?regime), '" || $url || "'))
   }"
};

(: D :)
declare function query:getSamplingPointProcess($url as xs:string) as xs:string {
  "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
   PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
   PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>

   SELECT ?samplingPointProcess ?inspireId ?inspireLabel ?localId ?namespace
   WHERE {
           ?samplingPointProcess a aqd:AQD_SamplingPointProcess;
           aqd:inspireId ?inspireId .
           ?inspireId rdfs:label ?inspireLabel .
           ?inspireId aqd:localId ?localId .
           ?inspireId aqd:namespace ?namespace .
   FILTER(CONTAINS(str(?samplingPointProcess), '" || $url || "'))
   }"
};

declare function query:getModelProcess($url as xs:string) as xs:string {
  "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
   PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
   PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>

   SELECT ?samplingPointProcess ?inspireId ?inspireLabel ?localId ?namespace
   WHERE {
           ?samplingPointProcess a aqd:AQD_ModelProcess;
           aqd:inspireId ?inspireId .
           ?inspireId rdfs:label ?inspireLabel .
           ?inspireId aqd:localId ?localId .
           ?inspireId aqd:namespace ?namespace .
   FILTER(CONTAINS(str(?samplingPointProcess), '" || $url || "'))
   }"
};

declare function query:getSample($url as xs:string) as xs:string {
  "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
   PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
   PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>

   SELECT ?sample ?inspireId ?inspireLabel ?localId ?namespace
   WHERE {
           ?sample a aqd:AQD_Sample;
           aqd:inspireId ?inspireId .
           ?inspireId rdfs:label ?inspireLabel .
           ?inspireId aqd:localId ?localId .
           ?inspireId aqd:namespace ?namespace .
   FILTER(CONTAINS(str(?sample), '" || $url || "'))
   }"
};

declare function query:getModelArea($url as xs:string) as xs:string {
  "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
   PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
   PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>

   SELECT ?sample ?inspireId ?inspireLabel ?localId ?namespace
   WHERE {
           ?sample a aqd:AQD_modelArea;
           aqd:inspireId ?inspireId .
           ?inspireId rdfs:label ?inspireLabel .
           ?inspireId aqd:localId ?localId .
           ?inspireId aqd:namespace ?namespace .
   FILTER(CONTAINS(str(?sample), '" || $url || "'))
   }"
};

declare function query:getSamplingPoint($cdrUrl as xs:string) as xs:string {
  "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
   PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
   PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>

   SELECT ?localId ?inspireLabel
   WHERE {
         ?samplingPoint a aqd:AQD_SamplingPoint;
         aqd:inspireId ?inspireId .
         ?inspireId rdfs:label ?inspireLabel .
         ?inspireId aqd:localId ?localId .
         ?inspireId aqd:namespace ?namespace .
   FILTER(CONTAINS(str(?samplingPoint), '" || $cdrUrl || "'))
   }"
};

(: M :)
declare function query:getModel($url as xs:string) as xs:string {
  "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
   PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
   PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>

   SELECT ?model ?inspireId ?inspireLabel ?localId ?namespace
   WHERE {
      ?model a aqd:AQD_Model ;
      aqd:inspireId ?inspireId .
      ?inspireId rdfs:label ?inspireLabel .
      ?inspireId aqd:localId ?localId .
      ?inspireId aqd:namespace ?namespace .
      FILTER(CONTAINS(str(?model), '" || $url || "'))
      }"
};

(: Checks if X references an existing Y via namespace/localid :)
declare function query:existsViaNameLocalId(
        $label as xs:string,
        $name as xs:string
) as xs:boolean {
  let $query := "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX aq: <http://rdfdata.eionet.europa.eu/airquality/ontology/>
       SELECT count(?label) as ?cnt
       WHERE {
?scenariosXMLURI a aq:" || $name ||";
aq:inspireId ?inspireId.
?inspireId rdfs:label ?label.
?inspireId aq:namespace ?name.
?inspireId aq:localId ?localId
FILTER (concat(?name,'/',?localId) = '" || $label || "')
   }"

  let $count := data(sparqlx:run($query)//sparql:binding[@name='cnt']/sparql:literal)
  return
    if ($count > 0)
    then
      true()
    else
      false()
};
(: Checks if X references an existing Y via namespace/localid and reporting year :)
declare function query:existsViaNameLocalIdYear(
        $label as xs:string,
        $name as xs:string,
        $year as xs:string
) as xs:boolean {
  let $query := "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX aq: <http://rdfdata.eionet.europa.eu/airquality/ontology/>
       SELECT count(?label) as ?cnt
       WHERE {
?scenariosXMLURI a aq:" || $name ||";
aq:inspireId ?inspireId.
?inspireId rdfs:label ?label.
?inspireId aq:namespace ?name.
?inspireId aq:localId ?localId
FILTER (concat(?name,'/',?localId) = '" || $label || "')
FILTER (CONTAINS(str(?scenariosXMLURI), '" || $year || "'))
   }"

  let $count := data(sparqlx:run($query)//sparql:binding[@name='cnt']/sparql:literal)
  return
    if ($count > 0)
    then
      true()
    else
      false()
};


(: G :)
declare function query:getAttainment($url as xs:string) as xs:string {
  "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
   PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
   PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>

   SELECT ?inspireLabel
   WHERE {
      ?attainment a aqd:AQD_Attainment;
      aqd:inspireId ?inspireId .
      ?inspireId rdfs:label ?inspireLabel .
      FILTER (CONTAINS(str(?attainment), '" || $url || "'))
   }"
};

(:~ Creates a SPARQL query string to query all objects of given type in a URL

The result is a list of inspireLabels

Used for dataflow I, can be used for any other

TODO: reuse in other workflows
:)
declare function query:sparql-objects-in-subject(
        $url as xs:string,
        $type as xs:string
) as xs:string {
  "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
   PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
   PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>

   SELECT ?inspireLabel
   WHERE {
      ?s a " || $type || ";
      aqd:inspireId ?inspireId .
      ?inspireId rdfs:label ?inspireLabel .
      FILTER (CONTAINS(str(?s), '" || $url || "'))
   }"
};

(:~ Creates a SPARQL query to return all inspireIds for given aqd:namespace

Used for dataflow I, can be used for any other

TODO: reuse in other workflows
:)
declare function query:sparql-objects-ids(
        $namespaces as xs:string*,
        $type as xs:string
) as xs:string* {
  let $query := "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
   PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
   PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>
   PREFIX aq: <http://reference.eionet.europa.eu/aq/ontology/>

   SELECT *
   WHERE {
        ?attainment a " || $type || ";
        aqd:inspireId ?inspireId .
        ?inspireId rdfs:label ?inspireLabel .
        ?inspireId aqd:namespace ?namespace
        FILTER(str(?namespace) in ('" || string-join($namespaces, "','") || "'))
  }"
  return data(sparqlx:run($query)//sparql:binding[@name='inspireLabel']/sparql:literal)
};

(: J :)
declare function query:getEvaluationScenarios($url as xs:string) as xs:string {
  "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
   PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
   PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>

   SELECT ?inspireLabel
   WHERE {
      ?EvaluationScenario a aqd:AQD_EvaluationScenario;
      aqd:inspireId ?inspireId .
      ?inspireId rdfs:label ?inspireLabel .
      FILTER (CONTAINS(str(?EvaluationScenario), '" || $url || "'))
   }"
};

(: K :)
declare function query:getMeasures($url as xs:string) as xs:string {
  "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
   PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
   PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>

   SELECT ?inspireLabel
   WHERE {
      ?measure a aqd:AQD_Measures;
      aqd:inspireId ?inspireId .
      ?inspireId rdfs:label ?inspireLabel .
      FILTER (CONTAINS(str(?measure), '" || $url || "'))
   }"
};

(: Feature Types queries - These queries return all ids of the specified feature type :)
declare function query:getAllZoneIds($namespaces as xs:string*) as xs:string {
  "PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>
   PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
    SELECT ?inspireLabel
    WHERE {
      ?zone a aqd:AQD_Zone;
      aqd:inspireId ?inspireid .
      ?inspireid rdfs:label ?inspireLabel .
      ?inspireid aqd:namespace ?namespace
      FILTER (?namespace in ('" || string-join($namespaces, "' , '") || "'))
     }"
};

declare function query:getAllFeatureIds($featureTypes as xs:string*, $namespaces as xs:string*) as xs:string {
  let $pre := "PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>
   PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
    SELECT ?inspireLabel WHERE {"
  let $mid := string-join(
          for $featureType in $featureTypes
          return "
    {
      ?zone a " || $featureType || ";
      aqd:inspireId ?inspireid .
      ?inspireid rdfs:label ?inspireLabel .
      ?inspireid aqd:namespace ?namespace
      FILTER (?namespace in ('" || string-join($namespaces, "' , '") || "'))
     }", " UNION ")
  let $end := "}"
  return $pre || $mid || $end
};

(: Generic queries :)
declare function query:deliveryExists($obligations as xs:string*, $countryCode as xs:string, $dir as xs:string, $reportingYear as xs:string) as xs:boolean {
  let $query :=
    "PREFIX aqd: <http://rod.eionet.europa.eu/schema.rdf#>
       SELECT ?envelope
       WHERE {
          ?envelope a aqd:Delivery ;
          aqd:obligation ?obligation ;
          aqd:released ?date ;
          aqd:hasFile ?file ;
          aqd:period ?period
          FILTER(str(?obligation) in ('" || string-join($obligations, "','") || "'))
          FILTER(CONTAINS(str(?envelope), '" || common:getCdrUrl($countryCode) || $dir || "'))
          FILTER(STRSTARTS(str(?period), '" || $reportingYear || "'))
       }"
  return count(sparqlx:run($query)//sparql:binding[@name = 'envelope']/sparql:uri) > 0
};

declare function query:getLangCodesSparql() as xs:string {
  "PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
   SELECT distinct ?code ?label ?concepturl
   WHERE {
      ?concepturl a skos:Concept .
      {?concepturl skos:inScheme <http://dd.eionet.europa.eu/vocabulary/common/iso639-3/>;
                  skos:prefLabel ?label;
                  skos:notation ?code}
      UNION
      {?concepturl skos:inScheme <http://dd.eionet.europa.eu/vocabulary/common/iso639-5/>;
                  skos:prefLabel ?label;
                  skos:notation ?code}

    }"
};

(: C - Remove comment after migration :)
declare function query:getModelEndPosition($latestDEnvelopes as xs:string*, $startDate as xs:string, $endDate as xs:string) as xs:string {
  let $last := count($latestDEnvelopes)
  let $filters :=
    for $x at $pos in $latestDEnvelopes
    return
      if (not($pos = $last)) then
        concat("CONTAINS(str(?zone), '", $x , "') || ")
      else
        concat("CONTAINS(str(?zone), '", $x , "')")
  let $filters := string-join($filters, "")
  return
    concat("PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
    PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
    PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>

SELECT DISTINCT ?inspireLabel
    WHERE {
        ?zone a aqd:AQD_Model ;
        aqd:inspireId ?inspireId .
        ?inspireId rdfs:label ?inspireLabel .
        ?zone aqd:observingCapability ?observingCapability .
        ?observingCapability aqd:observingTime ?observingTime .
        ?observingTime aqd:beginPosition ?beginPosition .
        optional {?observingTime aqd:endPosition ?endPosition} .
        FILTER(xsd:date(SUBSTR(xsd:string(?beginPosition),1,10)) <= xsd:date('", $endDate, "')) .
        FILTER(!bound(?endPosition) or (xsd:date(SUBSTR(xsd:string(?endPosition),1,10)) > xsd:date('", $startDate, "'))) .
        FILTER(", $filters, ")
}")
};

declare function query:getSamplingPointEndPosition($latestDEnvelopes as xs:string*, $startDate as xs:string, $endDate as xs:string) as xs:string {
  let $last := count($latestDEnvelopes)
  let $filters :=
    for $x at $pos in $latestDEnvelopes
    return
      if (not($pos = $last)) then
        concat("CONTAINS(str(?zone), '", $x , "') || ")
      else
        concat("CONTAINS(str(?zone), '", $x , "')")
  let $filters := string-join($filters, "")
  return
    concat("PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
        PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
        PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>

        SELECT DISTINCT ?inspireLabel
        WHERE {
            ?zone a aqd:AQD_SamplingPoint ;
            aqd:inspireId ?inspireId .
            ?inspireId rdfs:label ?inspireLabel .
            ?zone aqd:observingCapability ?observingCapability .
            ?observingCapability aqd:observingTime ?observingTime .
            ?observingTime aqd:beginPosition ?beginPosition .
            optional {?observingTime aqd:endPosition ?endPosition }
            FILTER(xsd:date(SUBSTR(xsd:string(?beginPosition),1,10)) <= xsd:date('", $endDate, "')) .
            FILTER(!bound(?endPosition) or (xsd:date(SUBSTR(xsd:string(?endPosition),1,10)) > xsd:date('", $startDate, "'))) .
            FILTER(", $filters, ")
    }")
};

(: Returns latest report envelope for this country and Year :)
declare function query:getLatestEnvelope($cdrUrl as xs:string, $reportingYear as xs:string) as xs:string {
  let $query := concat("PREFIX aqd: <http://rod.eionet.europa.eu/schema.rdf#>
  SELECT *
   WHERE {
        ?envelope a aqd:Delivery ;
        aqd:released ?date ;
        aqd:hasFile ?file ;
        aqd:period ?period
        FILTER(CONTAINS(str(?envelope), '", $cdrUrl, "'))
        FILTER(STRSTARTS(str(?period), '", $reportingYear, "'))
  } order by desc(?date)
limit 1")
  let $result := data(sparqlx:run($query)//sparql:binding[@name='envelope']/sparql:uri)
  return if ($result) then $result else "FILENOTFOUND"
};

(: Returns latest report envelope for this country :)
declare function query:getLatestEnvelope($cdrUrl as xs:string) as xs:string {
  let $query :=
    "PREFIX aqd: <http://rod.eionet.europa.eu/schema.rdf#>
     SELECT *
     WHERE {
        ?envelope a aqd:Delivery ;
        aqd:released ?date ;
        aqd:hasFile ?file ;
        aqd:period ?period
        FILTER(CONTAINS(str(?envelope), '" || $cdrUrl || "'))
  } order by desc(?date)
limit 1"
  let $result := data(sparqlx:run($query)//sparql:binding[@name='envelope']/sparql:uri)
  return if ($result) then $result else "FILENOTFOUND"
};

declare function query:getEnvelopes($cdrUrl as xs:string, $reportingYear as xs:string) as xs:string* {
  let $query :=
    "PREFIX aqd: <http://rod.eionet.europa.eu/schema.rdf#>
     SELECT *
     WHERE {
        ?envelope a aqd:Delivery ;
        aqd:released ?date ;
        aqd:hasFile ?file ;
        aqd:period ?period
        FILTER(CONTAINS(str(?envelope), '" || $cdrUrl || "'))
        FILTER(STRSTARTS(str(?period), '" || $reportingYear || "'))
     } order by desc(?date)"
  let $result := data(sparqlx:run($query)//sparql:binding[@name='envelope']/sparql:uri)
  return $result
};

declare function query:getAllRegimeIds($namespaces as xs:string*) as xs:string* {
  let $query := "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
   PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
   PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>
   PREFIX aq: <http://reference.eionet.europa.eu/aq/ontology/>

   SELECT *
   WHERE {
        ?regime a aqd:AQD_AssessmentRegime ;
        aqd:inspireId ?inspireId .
        ?inspireId rdfs:label ?inspireLabel .
        ?inspireId aqd:namespace ?namespace
        FILTER(!(CONTAINS(str(?regime), 'c_preliminary')))
        FILTER(str(?namespace) in ('" || string-join($namespaces, "','") || "'))
  }"
  return data(sparqlx:run($query)//sparql:binding[@name='inspireLabel']/sparql:literal)
};

declare function query:getAllAttainmentIds2($namespaces as xs:string*) as xs:string* {
  let $query := "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
   PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
   PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>
   PREFIX aq: <http://reference.eionet.europa.eu/aq/ontology/>

   SELECT *
   WHERE {
        ?attainment a aqd:AQD_Attainment ;
        aqd:inspireId ?inspireId .
        ?inspireId rdfs:label ?inspireLabel .
        ?inspireId aqd:namespace ?namespace
        FILTER(str(?namespace) in ('" || string-join($namespaces, "','") || "'))
  }"
  return data(sparqlx:run($query)//sparql:binding[@name='inspireLabel']/sparql:literal)
};

(: Returns the pollutants for an attainment



declare function query:sparql-objects-in-subject(
    $url as xs:string,
    $type as xs:string
) as xs:string {
  "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
   PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
   PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>

   SELECT ?inspireLabel
   WHERE {
      ?s a " || $type || ";
      aqd:inspireId ?inspireId .
      ?inspireId rdfs:label ?inspireLabel .
      FILTER (CONTAINS(str(?s), '" || $url || "'))
   }"
};







:)
declare function query:get-pollutant-for-attainment(
        $subj-url as xs:string
) as xs:string {
  let $query := "
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>

SELECT distinct

  ?pollutant

WHERE {
 ?s ?p ?o .

 optional { ?s aqd:declarationFor ?uf}
 optional { ?s aqd:pollutant ?pollutant}

 filter(?p = <http://www.w3.org/1999/02/22-rdf-syntax-ns#type>).
 filter(?o = aqd:AQD_Attainment) .
 filter(contains(str(?uf), '" || $subj-url || "'))

} LIMIT 50
"
  let $res := sparqlx:run($query)
  return data($res//sparql:binding[@name='pollutant']/sparql:uri)
};

declare function query:getPollutantCodeAndProtectionTarge($cdrUrl as xs:string, $bDir as xs:string) as xs:string {
  concat("PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
    PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
    PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>

      SELECT ?zone ?inspireId ?inspireLabel ?pollutants ?pollutantCode ?protectionTarget
        WHERE {
              ?zone a aqd:AQD_Zone ;
              aqd:inspireId ?inspireId .
              ?inspireId rdfs:label ?inspireLabel .
              ?zone aqd:pollutants ?pollutants .
              ?pollutants aqd:pollutantCode ?pollutantCode .
              ?pollutants aqd:protectionTarget ?protectionTarget .
      FILTER (CONTAINS(str(?zone), '", $cdrUrl, $bDir, "'))
    }")
};

declare function query:getC31($cdrUrl as xs:string, $reportingYear as xs:string) as xs:string {
  "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
  PREFIX aq: <http://reference.eionet.europa.eu/aq/ontology/>
  PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>

  SELECT DISTINCT
  ?Pollutant
  ?ProtectionTarget
  count(distinct bif:concat(str(?Zone), str(?pollURI), str(?ProtectionTarget))) AS ?countOnB

  WHERE {
  ?zoneURI a aqd:AQD_Zone;
  aqd:zoneCode ?Zone;
  aqd:pollutants ?polltargetURI;
  aqd:inspireId ?inspireId;
  aqd:designationPeriod ?designationPeriod .
  ?designationPeriod aqd:beginPosition ?beginPosition .
  OPTIONAL { ?designationPeriod aqd:endPosition ?endPosition . }
  ?inspireId aqd:namespace ?Namespace .

  ?polltargetURI aqd:protectionTarget ?ProtectionTarget .
  ?polltargetURI aqd:pollutantCode ?pollURI .
  ?pollURI rdfs:label ?Pollutant .
  FILTER regex(?pollURI,'') .
  FILTER (((xsd:date(substr(str(?beginPosition),1,10)) <= xsd:date('" || $reportingYear || "-01-01')) AND (!(bound(?endPosition)) ||
xsd:date(substr(str(?endPosition),1,10)) >= xsd:date('" || $reportingYear || "-12-31')))) .
  FILTER CONTAINS(str(?zoneURI),'" || $cdrUrl || "') .
  }"
};

declare function query:getG14($envelopeB as xs:string, $envelopeC as xs:string, $reportingYear as xs:string) as xs:string {
  "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX aq: <http://reference.eionet.europa.eu/aq/ontology/>
PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>
PREFIX prop: <http://dd.eionet.europa.eu/property/>

  SELECT *

  WHERE {{
  SELECT DISTINCT
  str(?Pollutant) as ?Pollutant
  str(?ProtectionTarget) as ?ProtectionTarget
  count(distinct bif:concat(str(?Zone), str(?pollURI), str(?ProtectionTarget))) AS ?countOnB

  WHERE {
    ?zoneURI a aqd:AQD_Zone;
       aqd:zoneCode ?Zone;
       aqd:pollutants ?polltargetURI;
       aqd:inspireId ?inspireId;
       aqd:designationPeriod ?designationPeriod .
       ?designationPeriod aqd:beginPosition ?beginPosition .
       OPTIONAL { ?designationPeriod aqd:endPosition ?endPosition . }
       ?inspireId aqd:namespace ?Namespace .
       ?polltargetURI aqd:protectionTarget ?ProtectionTarget .
       ?polltargetURI aqd:pollutantCode ?pollURI .
       ?pollURI rdfs:label ?Pollutant
       FILTER (((xsd:date(substr(str(?beginPosition),1,10)) <= xsd:date('" || $reportingYear || "-01-01')) AND (!(bound(?endPosition)) ||
xsd:date(substr(str(?endPosition),1,10)) >= xsd:date('" || $reportingYear || "-12-31')))) .
       FILTER CONTAINS(str(?zoneURI),'" || $envelopeB || "') .
  }}
  {
  SELECT DISTINCT
  str(?Pollutant) as ?Pollutant
  str(?ProtectionTarget) as ?ProtectionTarget
  count(distinct bif:concat(str(?Zone), str(?pollURI), str(?ProtectionTarget))) AS ?countOnC

  WHERE {
    ?areURI a aqd:AQD_AssessmentRegime;
       aqd:zone ?Zone;
       aqd:pollutant ?pollURI;
       aqd:assessmentThreshold ?areThre ;
       aqd:inspireId ?inspireId .
       ?inspireId aqd:namespace ?Namespace .
       ?areThre aqd:environmentalObjective ?envObj .
       ?envObj aqd:protectionTarget ?ProtectionTarget .
       ?pollURI rdfs:label ?Pollutant .
  FILTER CONTAINS(str(?areURI),'" || $envelopeC || "') .
  }}
  }"
};

(: ---- SPARQL methods --- :)
declare function query:getTimeExtensionExemption($cdrUrl as xs:string) as xs:string {
  "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
        PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
        PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>

        SELECT ?zone ?timeExtensionExemption ?localId
        WHERE {
                ?zone a aqd:AQD_Zone ;
                aqd:timeExtensionExemption ?timeExtensionExemption .
                ?zone aqd:inspireId ?inspireid .
                ?inspireid aqd:localId ?localId
        FILTER (CONTAINS(str(?zone), '" || $cdrUrl || "b/') and (?timeExtensionExemption != 'http://dd.eionet.europa.eu/vocabulary/aq/timeextensiontypes/none'))
      }"
};

declare function query:getG13($envelopeUrl as xs:string, $reportingYear as xs:string) as xs:string {
  "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>
PREFIX aq: <http://reference.eionet.europa.eu/aq/ontology/>

           SELECT ?inspireLabel ?pollutant ?objectiveType ?reportingMetric ?protectionTarget
           WHERE {
                  ?regime a aqd:AQD_AssessmentRegime ;
                  aqd:assessmentThreshold ?assessmentThreshold ;
                  aqd:pollutant ?pollutant ;
                  aqd:inspireId ?inspireId .
                  ?inspireId rdfs:label ?inspireLabel .
                  ?inspireId aqd:localId ?localId .
                  ?regime aqd:declarationFor ?declaration .
                  ?declaration aq:reportingBegin ?reportingYear .
                  ?assessmentThreshold aq:objectiveType ?objectiveType .
                  ?assessmentThreshold aq:reportingMetric ?reportingMetric .
                  ?assessmentThreshold aq:protectionTarget ?protectionTarget .
           FILTER (CONTAINS(str(?regime), '" || $envelopeUrl || "c/'))
           FILTER (strstarts(str(?reportingYear), '" || $reportingYear || "'))

       }"
};

declare function query:getAssessmentMethods() as xs:string {
  "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
   PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
   PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>
   PREFIX aq: <http://reference.eionet.europa.eu/aq/ontology/>

   SELECT ?assessmentRegime ?inspireId ?localId ?inspireLabel ?assessmentMethods  ?assessmentMetadata ?assessmentMetadataNamespace ?assessmentMetadataId ?samplingPointAssessmentMetadata ?metadataId ?metadataNamespace
   WHERE {
          ?assessmentRegime a aqd:AQD_AssessmentRegime ;
          aqd:inspireId ?inspireId .
          ?inspireId rdfs:label ?inspireLabel .
          ?inspireId aqd:localId ?localId .
          ?assessmentRegime aqd:assessmentMethods ?assessmentMethods .
          ?assessmentMethods aqd:modelAssessmentMetadata ?assessmentMetadata .
          ?assessmentMetadata aq:inspireNamespace ?assessmentMetadataNamespace .
          ?assessmentMetadata aq:inspireId ?assessmentMetadataId .
          OPTIONAL { ?assessmentMethods aqd:samplingPointAssessmentMetadata ?samplingPointAssessmentMetadata. }
          OPTIONAL {?samplingPointAssessmentMetadata aq:inspireId ?metadataId. }
          OPTIONAL {?samplingPointAssessmentMetadata aq:inspireNamespace ?metadataNamespace . }
         }"
};

declare function query:getSamplingPointAssessmentMetadata() as xs:string {
  "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
   PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
   PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>
   PREFIX aq: <http://reference.eionet.europa.eu/aq/ontology/>

   SELECT ?assessmentRegime ?inspireId ?localId ?inspireLabel ?assessmentMethods  ?samplingPointAssessmentMetadata ?metadataId ?metadataNamespace
   WHERE {
          ?assessmentRegime a aqd:AQD_AssessmentRegime ;
          aqd:inspireId ?inspireId .
          ?inspireId rdfs:label ?inspireLabel .
          ?inspireId aqd:localId ?localId .
          ?assessmentRegime aqd:assessmentMethods ?assessmentMethods .
          ?assessmentMethods aqd:samplingPointAssessmentMetadata ?samplingPointAssessmentMetadata.
          ?samplingPointAssessmentMetadata aq:inspireId ?metadataId.
          ?samplingPointAssessmentMetadata aq:inspireNamespace ?metadataNamespace.
          }"
};
(: TODO fix this to look at latest envelope :)
declare function query:getPollutantlD($cdrUrl as xs:string) as xs:string {
  concat("PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
            PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
            PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>

          SELECT distinct concat(?inspireLabel, '#', str(?pollutantCode)) as ?key
          WHERE {
                 ?zone a aqd:AQD_Zone ;
                  aqd:inspireId ?inspireId .
                 ?inspireId rdfs:label ?inspireLabel .
                 ?zone aqd:pollutants ?pollutants .
                 ?pollutants aqd:pollutantCode ?pollutantCode .
          FILTER (CONTAINS(str(?zone), '", $cdrUrl, "b/'))
          }")
};

declare function query:getSamplingPointFromFiles($url as xs:string*) as xs:string {
  let $filters :=
    for $x in $url
    return "STRSTARTS(str(?samplingPoint), '" || $x || "')"
  let $filters := "FILTER(" || string-join($filters, " OR ") || ")"
  return
    "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
   PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
   PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>

   SELECT ?samplingPoint ?inspireLabel
   WHERE {
         ?samplingPoint a aqd:AQD_SamplingPoint;
         aqd:inspireId ?inspireId .
         ?inspireId rdfs:label ?inspireLabel .
         ?inspireId aqd:localId ?localId .
         ?inspireId aqd:namespace ?namespace . " || $filters ||"
   }"
};

declare function query:getModelFromFiles($url as xs:string*) as xs:string {
  let $filters :=
    for $x in $url
    return "STRSTARTS(str(?samplingPoint), '" || $x || "')"
  let $filters := "FILTER(" || string-join($filters, " OR ") || ")"
  return
    "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
   PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
   PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>

   SELECT ?samplingPoint ?inspireLabel
   WHERE {
         ?samplingPoint a aqd:AQD_Model;
         aqd:inspireId ?inspireId .
         ?inspireId rdfs:label ?inspireLabel .
         ?inspireId aqd:localId ?localId .
         ?inspireId aqd:namespace ?namespace . " || $filters ||"
   }"
};

declare function query:getSamplingPointMetadataFromFiles($url as xs:string*) as xs:string {
  let $filters :=
    for $x in $url
    return "STRSTARTS(str(?samplingPoint), '" || $x || "')"
  let $filters := "FILTER(" || string-join($filters, " OR ") || ")"
  return
    "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
   PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
   PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>

   SELECT ?localId ?featureOfInterest ?procedure ?observedProperty ?inspireLabel
   WHERE {
         ?samplingPoint a aqd:AQD_SamplingPoint;
         aqd:observingCapability ?observingCapability;
         aqd:inspireId ?inspireId .
         ?inspireId rdfs:label ?inspireLabel .
         ?inspireId aqd:localId ?localId .
         ?inspireId aqd:namespace ?namespace .
         ?observingCapability aqd:featureOfInterest ?featureOfInterest .
         ?observingCapability aqd:procedure ?procedure .
         ?observingCapability aqd:observedProperty ?observedProperty . " || $filters ||"
   }"
};

declare function query:getModelMetadataFromFiles($url as xs:string*) as xs:string {
  let $filters :=
    for $x in $url
    return "STRSTARTS(str(?samplingPoint), '" || $x || "')"
  let $filters := "FILTER(" || string-join($filters, " OR ") || ")"
  return
    "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
   PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
   PREFIX aqd: <http://rdfdata.eionet.europa.eu/airquality/ontology/>

   SELECT ?localId ?featureOfInterest ?procedure ?observedProperty ?inspireLabel
   WHERE {
         ?samplingPoint a aqd:AQD_Model;
         aqd:observingCapability ?observingCapability;
         aqd:inspireId ?inspireId .
         ?inspireId rdfs:label ?inspireLabel .
         ?inspireId aqd:localId ?localId .
         ?inspireId aqd:namespace ?namespace .
         ?observingCapability aqd:featureOfInterest ?featureOfInterest .
         ?observingCapability aqd:procedure ?procedure .
         ?observingCapability aqd:observedProperty ?observedProperty . " || $filters ||"
   }"
};

declare function query:getObligationYears() {
  "PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
   PREFIX dct: <http://purl.org/dc/terms/>
   PREFIX cr: <http://cr.eionet.europa.eu/ontologies/contreg.rdf#>
   PREFIX rod: <http://rod.eionet.europa.eu/schema.rdf#>

   SELECT DISTINCT
   ?countryCode
   ?delivery
   year(?start) as ?ReportingYear
   ?obligation
   ?obligation_nr
   ?deadline
   bif:either(xsd:int(?obligation_nr) < 680,(year(?deadline) - 2),bif:either(xsd:int(?obligation_nr) < 690,(year(?deadline) - 3),(year(?deadline))) ) as ?minimum
   bif:either(xsd:int(?obligation_nr) < 680,(year(?deadline) - 1),bif:either(xsd:int(?obligation_nr) < 690,(year(?deadline) - 2),(year(?deadline)+1)) ) as ?maximum

   WHERE {
   ?delivery rod:released ?released ;
              rod:obligation ?obluri ;
              rod:startOfPeriod ?start ;
              rod:locality ?locality .

   ?locality rod:loccode ?countryCode .
   ?obluri rod:instrument <http://rod.eionet.europa.eu/instruments/650> ;
           skos:notation ?obligation_nr ;
           rod:nextdeadline  ?deadline ;
           dct:title ?obligation .

   FILTER (year(?released) > 2014) .
   } ORDER BY ?countryCode ?ReportingYear ?obligation_nr"
};

(:~
: User: George Sofianos
: Date: 7/19/2016
: Time: 4:40 PM
:)





declare variable $schemax:IGNORED := ("cvc-elt.1: Cannot find the declaration of element 'gml:FeatureCollection'.",
"cvc-elt.4.2: Cannot resolve 'gco:RecordType_Type' to a type definition for element 'gco:Record'.",
"cvc-elt.4.2: Cannot resolve 'ns:DataArrayType' to a type definition for element 'om:result'.",
"cvc-elt.4.2: Cannot resolve 'ns:ReferenceType' to a type definition for element 'om:value'.");
declare variable $schemax:IGNORED_NEW := ("cvc-elt.1.a: Cannot find the declaration of element 'gml:FeatureCollection'.",
"cvc-elt.4.2.a: Cannot resolve 'gco:RecordType_Type' to a type definition for element 'gco:Record'.",
"cvc-elt.4.2.a: Cannot resolve 'ns:DataArrayType' to a type definition for element 'om:result'.",
"cvc-elt.4.2.a: Cannot resolve 'ns:ReferenceType' to a type definition for element 'om:value'.");

declare function schemax:validateXmlSchema($source_url as xs:string) {
    (: Change this to doc($source_url) after the BaseX bug is fixed :)
    let $validationResult := validate:xsd-report(($source_url))
    let $finalResult :=
        for $node in $validationResult/message
        where not($node = $schemax:IGNORED) and not($node = $schemax:IGNORED_NEW)
        return
            <tr>
                <td title="Status">{string($node/@level)}</td>
                <td title="Line">{string($node/@line)}</td>
                <td title="Column">{string($node/@column)}</td>
                <td title="Message">{string($node)}</td>
            </tr>
    return $finalResult
(:    let $hasErrors := count($validationResult//*[local-name() = "tr"]) > 1

    let $filteredResult :=
        if ($hasErrors) then
            <div class="feedbacktext">
                {
                    for $elem in $validationResult/child::div/child::*
                    return
                        if ($elem/local-name() = "table") then
                            <table class="datatable" border="1">
                                {
                                    for $tr in $elem//tr
                                    return
                                        if (not(empty(index-of($schema:IGNORED, normalize-space($tr/td[3]/text()))))) then
                                            ()
                                        else
                                            $tr
                                }
                            </table>
                        else
                            $elem
                }
            </div>
        else
            $validationResult

    let $hasErrorsAfterFiltering := count($filteredResult//*[local-name()="tr"]) > 1

    return
        if ($hasErrors and not($hasErrorsAfterFiltering)) then
            $successfulResult
        else
            $filteredResult:)
};
declare function schemax:getErrorClass($result as element(report)) {
    let $status := string($result/status)
    return
        if ($status = $schemax:INVALIDSTATUS) then
            $errors:ERROR
        else
            $errors:INFO
};

(:~
: User: dev-gso
: Date: 5/31/2016
: Time: 12:44 PM
: To change this template use File | Settings | File Templates.
:)

(:~ declare Content Registry SPARQL endpoint :)


declare function sparqlx:run($sparql as xs:string) as element(sparql:result)* {
    doc("http://cr.eionet.europa.eu/sparql?query=" || encode-for-uri($sparql) || "&amp;format=application/xml")//sparql:result
};

(:~
 : Get the SPARQL endpoint URL.
 : @param $sparql SPARQL query.
 : @param $format xml or html.
 : @param $inference use inference when executing sparql query.
 : @return link to sparql endpoint
 :)
declare function sparqlx:getSparqlEndpointUrlz($sparql as xs:string, $format as xs:string) as xs:string {
    let $sparql := fn:encode-for-uri(fn:normalize-space($sparql))
    let $resultFormat :=
        if ($format = "xml") then
            "application/xml"
        else if ($format = "html") then
            "text/html"
        else
            $format
    let $defaultGraph := ""
    let $uriParams := concat("query=", $sparql, "&amp;format=", $resultFormat, $defaultGraph)
    let $uri := concat($sparqlx:CR_SPARQL_URL, "?", $uriParams)
    return $uri
};

declare function sparqlx:toCountSparql($sparql as xs:string) as xs:string {
    let $s :=if (fn:contains($sparql,"order")) then tokenize($sparql, "order") else tokenize($sparql, "ORDER")
    let $firstPart := tokenize($s[1], "SELECT")
    let $secondPart := tokenize($s[1], "WHERE")
    return concat($firstPart[1], " SELECT count(*) WHERE ", $secondPart[2])
};

declare function sparqlx:countsSparqlResults($sparql as xs:string) as xs:integer {
    let $countingSparql := sparqlx:toCountSparql($sparql)
    let $endpoint := sparqlx:run($countingSparql)

    (: Counting all results:)
    let $count := $countingSparql
    let $countResult := data($endpoint//sparql:binding[@name='callret-0']/sparql:literal)
    return $countResult[1]
};

(: TODO: Probably deprecated, seems useful, but might better be removed :)
declare function sparqlx:executeSparqlQueryOld($sparql as xs:string) as element(sparql:result)* {
    let $limit := number(2000)
    let $countResult := sparqlx:countsSparqlResults($sparql)

    (:integer - how many times must sparql function repeat :)
    let $divCountResult := if($countResult>0) then ceiling(number($countResult) div number($limit)) else number("1")

    (:Collects all sparql results:)
    let $allResults :=
        for $r in (1 to  xs:integer(number($divCountResult)))
        let $offset := if ($r > 1) then string(((number($r)-1) * $limit)) else "0"
        let $resultXml := sparqlx:setLimitAndOffset($sparql,xs:string($limit), $offset)
        let $isResultsAvailable := string-length($resultXml) > 0 and doc-available(sparqlx:getSparqlEndpointUrlz($resultXml, "xml"))
        let $result := if($isResultsAvailable) then sparqlx:run($resultXml) else ()
        return $result

    return  $allResults
};

declare function sparqlx:setLimitAndOffset($sparql as xs:string, $limit as xs:string, $offset as xs:string) as xs:string {
    concat($sparql," offset ",$offset," limit ",$limit)
};


(:---------------------------------Old xmlconv:executeSparqlQuery function----------------------------------------------------------------------:)
(:~ Function executes given SPARQL query and returns result elements in SPARQL result format.
 : URL parameters will be correctly encoded.
 : @param $sparql SPARQL query.
 : @return sparql:results element containing zero or more sparql:result subelements in SPARQL result format.
 :)
declare function sparqlx:executeSparqlEndpoint_D($sparql as xs:string) as element(sparql:results) {
    let $uri := sparqlx:getSparqlEndpointUrlz($sparql, "xml")

    return
        if(doc-available($uri))then
            fn:doc($uri)//sparql:results
        else
            <sparql:results/>

};

(:~
: User: George Sofianos
: Date: 6/6/2016
: Time: 6:30 PM
:)































































(:~
: User: George Sofianos
: Date: 7/26/2016
: Time: 1:41 PM
:)


declare variable $source_url as xs:string external;
declare option output:method "html";
declare option db:inlinelimit '0';

obligations:proceed($source_url)
