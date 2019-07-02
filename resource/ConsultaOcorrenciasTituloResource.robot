*** Settings ***
Library  SudsLibrary
Library  OperatingSystem
Library  XML
Library  String
Library  BuiltIn


*** Variable ***
${wsdl_url}  http://ws-cobranca12c2.hom.sicredi.net:80/ConsultasBean/ConsultasService?wsdl

*** Keywords ***
Busca Ocorrencias
  ${ag_emissora}=  Set Variable  0307

  Create Soap Client  ${wsdl_url}
  ${request}=  Get File  ${CURDIR}\\xml\\consulta_ocorrencias_titulo.xml
#  ${request}    Replace String  ${request}  tipo  ${tipo_documento}

  ${request}=  Create Raw Soap Message  ${request}

  Call Soap Method   consultaOcorrenciasTitulo  ${request}

  ${response}=  Get Last Received

  ${parse_string}=	Convert To String	 ${response}
  ${parse_xml}=    Parse XML    ${parse_string}

  @{lst_oidMovimento}=  Get Elements Texts  ${parse_xml}  *//titulos//oidMovimento
  @{lst_agCedente}=  Get Elements Texts  ${parse_xml}  *//titulos//agCedente
  @{lst_beneficiario}=  Get Elements Texts  ${parse_xml}  *//titulos//beneficiario
  @{lst_nossoNumero}=  Get Elements Texts  ${parse_xml}  *//titulos//nossoNumero
  @{lst_seuNumero}=  Get Elements Texts  ${parse_xml}  *//titulos//seuNumero
  @{lst_vlrNominal}=  Get Elements Texts  ${parse_xml}  *//titulos//vlrNominal
  @{lst_dataOcorrencia}=  Get Elements Texts  ${parse_xml}  *//titulos//dataOcorrencia
  @{lst_ocorrencia}=  Get Elements Texts  ${parse_xml}  *//titulos//ocorrencia
  @{lst_codOcorrencia}=  Get Elements Texts  ${parse_xml}  *//titulos//codOcorrencia
  @{lst_numParcela}=  Get Elements Texts  ${parse_xml}  *//titulos//numParcela
  @{lst_motivo}=  Get Elements Texts  ${parse_xml}  *//titulos//motivo

  ${lst_count}=    Get length    ${lst_oidMovimento}

  FOR  ${count}    IN RANGE    0    ${lst_count}
    ${oidMovimento}=	Set Variable  @{lst_oidMovimento}[${count}]
    ${agCedente}=	Set Variable  @{lst_agCedente}[${count}]
    ${beneficiario}=	Set Variable  @{lst_beneficiario}[${count}]
    ${nossoNumero}=	Set Variable  @{lst_nossoNumero}[${count}]
    ${seuNumero}=	Set Variable  @{lst_seuNumero}[${count}]
    ${vlrNominal}=	Set Variable  @{lst_vlrNominal}[${count}]
    ${dataOcorrencia}=	Set Variable  @{lst_dataOcorrencia}[${count}]
    ${ocorrencia}=	Set Variable  @{lst_ocorrencia}[${count}]
    ${codOcorrencia}=	Set Variable  @{lst_codOcorrencia}[${count}]
    ${numParcela}=	Set Variable  @{lst_numParcela}[${count}]
    ${motivo}=	Set Variable  @{lst_motivo}[${count}]

    Log To Console  \n-> Ocorrências:
    Log To Console  oidMovimento: ${oidMovimento}\nagCedente:${agCedente}\nbeneficiario:${beneficiario}\nnossoNumero:${nossoNumero}\nseuNumero:${seuNumero}\nvlrNominal:${vlrNominal}\ndataOcorrencia:${dataOcorrencia}\nocorrencia:${ocorrencia}\ncodOcorrencia:${codOcorrencia}\nnumParcela:${numParcela}\nmotivo:${motivo}
    ${count}=  Evaluate  ${count}+1
  END













