<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:ns prefix="f" uri="http://hl7.org/fhir"/>
  <sch:ns prefix="a" uri="http://www.w3.org/2005/Atom"/>
  <sch:ns prefix="h" uri="http://www.w3.org/1999/xhtml"/>
  <sch:pattern>
    <sch:title>DeviceLog</sch:title>
    <sch:rule context="/f:DeviceLog/f:capabilities">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::a:content/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')]|/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')])">Inv-2: Must have a local reference if the resource is provided inline</sch:assert>
      <sch:assert test="exists(f:type) or not(exists(f:reference))">Inv-1: Must have a type if a reference is provided</sch:assert>
    </sch:rule>
    <sch:rule context="/f:DeviceLog/f:subject">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::a:content/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')]|/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')])">Inv-2: Must have a local reference if the resource is provided inline</sch:assert>
      <sch:assert test="exists(f:type) or not(exists(f:reference))">Inv-1: Must have a type if a reference is provided</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
