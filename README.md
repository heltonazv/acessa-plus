# ACESSA+

Plataforma de orientação sobre direitos e benefícios de pessoas com deficiência
e suas famílias. Artefato de tese de doutorado profissional da Universidade
Positivo, com apoio do ecohub espaço maker.

Piloto com 11 benefícios: federais, estaduais do Paraná e municipais de Londrina.
No ar em <https://acessa-plus.vercel.app>.

## O que este repositório é

Um site estático publicado pelo Vercel, com uma única função no servidor: a que
recebe os avisos enviados pelo site. Não há build nem banco de dados.

```
fonte/acessa.html   o arquivo que se edita: conteúdo, motor de decisão e interface
index.html          gerado a partir da fonte, com a tipografia local; não edite à mão
api/aviso.js        recebe os avisos e guarda cada um como arquivo privado no Vercel Blob
fontes/             Poppins hospedada aqui, para não entregar o IP de quem visita
                    a um servidor de terceiro
docs/               arquitetura, protocolo de teste de acessibilidade e roteiro do piloto
vercel.json         cabeçalhos de segurança e política de cache
package.json        dependência da função de avisos
montar.pl           gera o index.html a partir da fonte
previa.pl           servidor local com os mesmos cabeçalhos da produção
CHANGELOG.md        o que mudou em cada versão
```

## Rodar localmente

```
perl montar.pl
perl previa.pl 8790
```

Abre em `http://127.0.0.1:8790`. Usa a mesma Content-Security-Policy da
produção, então um recurso externo que passar despercebido quebra aqui antes de
quebrar no ar. Na prévia, os avisos enviados ficam em `avisos-locais.txt`, fora
do git.

## Editar e publicar

Edite `fonte/acessa.html`, gere o site com `perl montar.pl` e confira na prévia.
Depois publique. O Vercel observa a branch principal: todo push publica.

```
git add -A
git commit -m "descrição da mudança"
git push
```

## Piloto com agentes comunitários

O roteiro para começar os testes está em [docs/piloto-agentes.md](docs/piloto-agentes.md).
Os links por unidade ficam em `#/links-piloto`. Os avisos enviados pelo site ficam
em *Vercel → acessa-plus → Storage → acessa-plus-blob*, na pasta `avisos/`.

## Verificações antes de publicar

- `#/autoteste` — 27 verificações sobre o motor de decisão, com sete perfis
  fixos. Se alguma falhar, a triagem está decidindo diferente do esperado.
- `#/curadoria` — procedência, classe e custo de cada afirmação. Mostra o que
  está em conferência e ainda não deve ser tratado como confirmado.

Ambas rodam no navegador, sem ferramenta externa.

## Como o conteúdo é tratado

Cada afirmação normativa é um dado com quatro campos: texto, fonte, data em que
foi conferida e data em que essa conferência vence. O selo de revisão é
calculado a partir disso, afirmação por afirmação, e não declarado por página.

Cada afirmação também carrega a sua classe, porque confundir o que está na lei
com o que o órgão costuma fazer é o erro que mais gera informação errada em
serviços como este:

- **norma** — está escrito na lei, no decreto ou na resolução citada
- **jurisprudência** — decisão de tribunal, não vale automaticamente
- **prática** — é como o órgão opera, não está na norma
- **relato** — o que costuma acontecer no atendimento

Endereços e telefones de locais só entram quando copiados de página oficial, com
a data em que foram conferidos.

As novidades sobre direitos ficam em `PUBLICACOES`. Cada uma aponta para os
benefícios que mexe e tem fonte oficial, data de conferência e validade. Vencida
a validade, ela sai do início e passa a se mostrar em revisão.

## Instrumentos e padrões

- **Triagem de funcionalidade**: os cinco quesitos do Censo Demográfico 2022 do
  IBGE, na redação e na escala oficiais, com o mesmo corte — muita dificuldade
  ou não consegue de modo algum em pelo menos um quesito.
- **Classificação dos direitos**: taxonomia aberta Open Eligibility 2.0, com o
  equivalente na AIRS/211 registrado ao lado.
- **Custo de cada caminho**: decomposição de custo administrativo em aprendizado,
  conformidade e desgaste, calculada do próprio mapa de cada benefício.
- **Acessibilidade**: meta de WCAG 2.2 AA e eMAG 3.1. A conformidade ainda não
  foi verificada com usuários; enquanto isso, o rodapé diz *meta*, não
  conformidade.

## O que o ACESSA+ não faz

Não protocola pedido, não substitui atendimento presencial, não emite parecer
sobre caso individual e não calcula quanto a pessoa vai receber. Quem decide o
grau de deficiência é a avaliação biopsicossocial do INSS, aplicada por médico
perito e assistente social com o IFBrM. Nenhum site reproduz esse resultado.

## Estado

Protótipo. O conteúdo é de demonstração e cada página indica o que ainda está em
conferência. Não use para orientação real antes da revisão da curadoria.
