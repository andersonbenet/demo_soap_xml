*** Settings ***
Library  SudsLibrary
Library  OperatingSystem
Library  XML
Library  String
Library  BuiltIn
Library  JenkinsLibrary

*** Variable ***

*** Keywords ***
Listar Tipo Documentos
  Set Jenkins Server    url=http://localhost:9090   username=anderson_benet    password=Javac@2019
  Create Jenkins Job    test_job
  Start Jenkins Job    test_job
  Create Soap Client  http://ws-cred12c.hom.sicredi.net:80/UploadDocumentosVeiculosBean/UploadDocumentosVeiculosService?wsdl
  ${payload_xml}=  Get File  C:\\Users\\anderson_benet\\Documents\\git_robotframework\\demo_soap_xml\\xml\\search_book.xml
  Log  ${payload_xml}
  ${result}    Call Soap Method    listarTiposDeDocumentos    ${payload_xml}
  ${result}    Get Last Received

  Log  ${result}

  ${result_string}=	Convert To String	 ${result}
  ${result_xml}=    Parse XML    ${result_string}

  Log  ${result_xml}
  Log    ${result_string}

  ${count_tipo_documento}=	Get Element Count	${result_string}	 *//tiposDocumento//tipoDocumento
  :FOR  ${count}  IN RANGE  0  ${count_tipo_documento}
  \  ${tipo_documento}=	Get Element Text	${result_xml}	 *//tiposDocumento//tipoDocumento[${count+1}]  utf-8
  \  Log  ${tipo_documento}
  \  Log To Console  ${tipo_documento}

  # FOR  ${count}  IN RANGE  0  ${count_tipo_documento}
  #
  #     ${tipo_documento}=	Get Element Text	${result_xml}	 *//tiposDocumento//tipoDocumento[${count+1}]  utf-8
  #     # ${tipo_documento}=	Get Element Attributes	${result_xml}	 *//tiposDocumento//tipoDocumento[${count+1}]
  #     # @{tipo_documento}=	Get Elements Texts	${result_xml}	 *//tiposDocumento//tipoDocumento[${count+1}]
  #     Log  ${tipo_documento}
  #     Log To Console  ${tipo_documento}
  # END
