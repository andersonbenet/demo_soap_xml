*** Settings ***
Resource  ../resource/ConsultaOcorrenciasTituloResource.robot

*** Test Cases ***
TC 001: Buscar ocorrências de título por agência
  Busca Ocorrencias  ${agencia}
