// Recebe os avisos enviados pelo site e guarda cada um como arquivo privado no
// Vercel Blob. Nada aqui identifica quem enviou: não grava IP, nome, telefone
// nem e-mail, e recusa texto com CPF, porque quem avisa pode estar escrevendo
// sobre uma família real.
//
// Usa a assinatura por método HTTP (export function POST), em que o Vercel
// entrega um Request e espera um Response. Um "export default function" seria
// tratado no estilo Node (req, res), e o Response devolvido nunca chegaria ao
// navegador: a requisição ficaria pendurada até estourar o tempo.
import { put } from "@vercel/blob";

// campo aceito → tamanho máximo guardado
const CAMPOS = { tipo: 120, mensagem: 2000, fonte_correta: 500, beneficio: 60, pagina: 200, origem: 60 };
const CPF = /\b\d{3}\.?\d{3}\.?\d{3}-?\d{2}\b/;

function responder(status, corpo) {
  return new Response(JSON.stringify(corpo), {
    status,
    headers: { "Content-Type": "application/json; charset=utf-8", "Cache-Control": "no-store" },
  });
}

export function GET() {
  return responder(405, { ok: false });
}

export async function POST(request) {
  let dados;
  try {
    dados = Object.fromEntries(new URLSearchParams(await request.text()));
  } catch {
    return responder(400, { ok: false, erro: "formato inválido" });
  }

  // campo-isca só é preenchido por robô: finge sucesso e descarta
  if (dados["campo-isca"]) return responder(200, { ok: true });

  const aviso = {};
  for (const [campo, limite] of Object.entries(CAMPOS)) {
    aviso[campo] = String(dados[campo] || "").trim().slice(0, limite);
  }
  if (!aviso.mensagem) return responder(400, { ok: false, erro: "mensagem vazia" });
  if (CPF.test(aviso.mensagem) || CPF.test(aviso.fonte_correta)) {
    return responder(422, { ok: false, erro: "dado pessoal" });
  }

  aviso.recebido_em = new Date().toISOString();
  const caminho = `avisos/${aviso.recebido_em.slice(0, 10)}/${aviso.recebido_em.replace(/[:.]/g, "-")}.json`;

  try {
    await put(caminho, JSON.stringify(aviso, null, 2), {
      access: "private",
      contentType: "application/json",
      addRandomSuffix: true,
    });
  } catch {
    return responder(500, { ok: false, erro: "não foi possível guardar" });
  }
  return responder(200, { ok: true });
}
