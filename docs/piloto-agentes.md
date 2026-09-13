# Piloto com agentes comunitários

Como deixar o ACESSA+ pronto para os primeiros testes com agentes comunitários
de saúde, e o que conferir no dia.

## Antes do primeiro teste

1. **Site no ar.** No Netlify: *Add new site → Import an existing project →
   GitHub → heltonazv/acessa-plus*. Build command vazio, publish directory `.`.
   Todo push na branch `main` publica sozinho.
2. **Recebimento de avisos.** Depois do primeiro deploy, abra *Netlify → Forms*
   e confirme que o formulário `aviso` aparece. É lá que chegam os retornos
   enviados pelo botão *Avisar sobre esta informação*.
3. **Um código por UBS ou equipe.** Cadastre em `ENTIDADES`, no arquivo
   `fonte/acessa.html`. O código só pode ter letras minúsculas, números e hífen.
4. **Gerar e conferir.** Rode `perl montar.pl`, abra `perl previa.pl 8790` e
   veja os links prontos em `#/links-piloto`.
5. **Publicar e entregar.** `git push`, e mande a cada equipe o link dela.

## O que o link de cada equipe registra

Só a unidade de onde a pessoa chegou. O site continua sem cadastro, sem login e
sem guardar resposta nenhuma. Serve para saber de onde vem a demanda e de onde
vêm os avisos, não para identificar família.

## Onde ler os avisos

*Netlify → Forms → aviso*. Cada aviso traz o tipo, a mensagem, o benefício, a
página e a unidade de origem. Não pede nome, telefone nem e-mail, e bloqueia o
envio se alguém digitar um CPF por engano.

## O que o agente testa

As seis tarefas do protocolo em `docs/teste-acessibilidade.html`, usando os
**perfis fictícios** do protocolo. O agente não informa dados de família real.

## Cuidados

- Teste com famílias reais só depois da aprovação do CEP.
- Oriente o agente a nunca escrever nome, CPF, telefone ou endereço de alguém no
  aviso.
- O conteúdo ainda é de protótipo: as páginas avisam o que está em conferência.

## Checklist do dia

- [ ] O link da equipe abre e mostra *Você chegou aqui por…* no topo
- [ ] `#/autoteste` com todas as verificações passando
- [ ] Um telefone de CRAS toca no celular do agente
- [ ] Um aviso de teste enviado aparece em *Netlify → Forms*
