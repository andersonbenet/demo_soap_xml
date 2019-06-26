*** Settings ***
Library  SudsLibrary
Library  OperatingSystem
Library  XML
Library  String
Library  BuiltIn
Library  Collections
# Library  JenkinsLibrary

*** Variable ***
${wsdl_url}  http://ws-cred12c.hom.sicredi.net:80/UploadDocumentosVeiculosBean/UploadDocumentosVeiculosService?wsdl

*** Keywords ***
Listar Tipo Documentos
  # Set Jenkins Server    url=http://localhost:9090   username=anderson_benet    password=Javac@2019
  # Create Jenkins Job    test_job
  # Start Jenkins Job    test_job

  Create Soap Client  ${wsdl_url}
  ${request}=  Get File  ${CURDIR}\\xml\\search_book.xml
  ${request}=  Create Raw Soap Message  ${request}

  ${response}=  Call Soap Method  listarTiposDeDocumentos  ${request}
  # @{price}=	 Get Wsdl Object Attribute	${response}  tiposDocumento

  ${response}=  Get Last Received

  ${parse_string}=	Convert To String	 ${response}
  ${parse_xml}=    Parse XML    ${parse_string}

  @{document}=  Get Elements Texts  ${parse_xml}  *//tiposDocumento//tipoDocumento
  # ${x} =	Get Index From List	${document}	CRV assinado  #busca um determinado valor na lista true = 0 false=-1
  ${count_list_document}=    Get length    ${document}  #realiza a contagem de valores na lista

  FOR  ${count}  IN RANGE  0  ${count_list_document}
      ${tipo_documento}=	Get Elements Texts	${parse_xml}	 *//tiposDocumento//tipoDocumento[${count+1}]
      Log  ${tipo_documento}
  END
