# Mudanças

## v0.1.2-piloto — 14/09/2026

- Novidades sobre direitos, em `#/novidades`: o que mudou, dúvida comum e
  caminho de uma família fictícia. Cada novidade aponta para os benefícios que
  mexe, tem fonte oficial e validade, compara com as respostas da pessoa sem
  salvar nada e sai pronta para mandar no WhatsApp.
- Salário mínimo de 2026 amarrado ao Decreto 12.797 de 2025.
- Corrigido: contagem de benefícios no início, texto da pergunta do município e
  da tela de resultado, linha de prazo do Energia Solidária e o passo 2 do
  equipamento vital, que é presencial.

## v0.1.1-piloto — 12/09/2026

- Publicação pelo Vercel, em https://acessa-plus.vercel.app, com os mesmos
  cabeçalhos de segurança no `vercel.json`. O `netlify.toml` saiu.
- Avisos gravados pela função `api/aviso.js` num armazenamento Blob privado do
  Vercel, na região de São Paulo. Sem IP, nome, telefone ou e-mail; CPF recusado
  também no servidor.
- Links do piloto já usam o endereço publicado.

## v0.1-piloto — 12/09/2026

Primeira versão preparada para teste com agentes comunitários.

- 11 benefícios: federais, estaduais do Paraná e municipais de Londrina.
- Triagem de funcionalidade com os cinco quesitos do Censo 2022 do IBGE, na
  redação e escala oficiais, a partir dos 2 anos.
- Motor de decisão declarativo, com autoteste em `#/autoteste`.
- Procedência por afirmação: fonte, classe, data de conferência e validade,
  visível na curadoria em `#/curadoria`.
- Passo a passo com ação em cada etapa: link oficial, telefone gratuito ou lista
  do que levar.
- Endereço e telefone oficiais dos locais de Londrina: 10 CRAS, Copel, TCGL,
  CMTU, Farmácia do Paraná, Defensoria do Paraná e Secretaria de Educação.
- Aviso de informação errada que chega de fato à curadoria, sem dado pessoal.
- Links por unidade de saúde ou equipe em `#/links-piloto`.
- Fonte hospedada junto do site e política de segurança restritiva.
