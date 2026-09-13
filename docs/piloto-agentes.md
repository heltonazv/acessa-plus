# Piloto com agentes comunitários

Como deixar o ACESSA+ pronto para os primeiros testes com agentes comunitários
de saúde, e o que conferir no dia.

## Antes do primeiro teste

1. **Site no ar.** Já está: <https://acessa-plus.vercel.app>. O Vercel observa a
   branch `main` do GitHub e publica sozinho a cada push.
2. **Recebimento de avisos.** O projeto `acessa-plus` no Vercel precisa ter um
   armazenamento Blob **privado** conectado (*Storage → acessa-plus-blob*). É lá
   que a função `api/aviso.js` guarda cada aviso.
3. **Um código por UBS ou equipe.** Cadastre em `ENTIDADES`, no arquivo
   `fonte/acessa.html`. O código só pode ter letras minúsculas, números e hífen.
4. **Gerar e conferir.** Rode `perl montar.pl`, abra `perl previa.pl 8790` e veja
   os links prontos em `#/links-piloto`.
5. **Publicar e entregar.** `git push`, e mande a cada equipe o link dela.

## O que o link de cada equipe registra

Só a unidade de onde a pessoa chegou. O site continua sem cadastro, sem login e
sem guardar resposta nenhuma. Serve para saber de onde vem a demanda e de onde
vêm os avisos, não para identificar família.

## Onde ler os avisos

*Vercel → acessa-plus → Storage → acessa-plus-blob*, pasta `avisos/`, separada
por dia. Cada aviso é um arquivo com o tipo, a mensagem, o benefício, a página, a
unidade de origem e a hora. Não guarda nome, telefone, e-mail nem IP, e a função
recusa o envio se houver um CPF no texto.

## O que o agente testa

As seis tarefas do protocolo em `docs/teste-acessibilidade.html`, usando os
**perfis fictícios** do protocolo. O agente não informa dados de família real.

## Cuidados

- Teste com famílias reais só depois da aprovação do CEP.
- Oriente o agente a nunca escrever nome, CPF, telefone ou endereço de alguém no
  aviso.
- O plano gratuito do Vercel é para uso pessoal e não comercial. Serve ao piloto
  de pesquisa; um serviço oficial precisaria de plano pago ou servidor
  institucional.

## Checklist do dia

- [ ] O link da equipe abre e mostra *Você chegou aqui por…* no topo
- [ ] `#/autoteste` com todas as verificações passando
- [ ] Um telefone de CRAS toca no celular do agente
- [ ] Um aviso de teste aparece na pasta `avisos/` do Blob no Vercel
