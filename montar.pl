use strict; use warnings;
# Gera index.html a partir do artefato, trocando o Google Fonts por fonte local.
# É a única diferença entre a versão publicada como artifact e a que vai ao ar.

my $src = shift || 'fonte/acessa.html';   # a fonte vive no repositório
open my $fh, '<:raw', $src or die "$src: $!";
my $c = do { local $/; <$fh> }; close $fh;

my $LATIN = 'U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+0304, U+0308, U+0329, U+2000-206F, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD';
my $LATEXT = 'U+0100-02BA, U+02BD-02C5, U+02C7-02CC, U+02CE-02D7, U+02DD-02FF, U+0304, U+0308, U+0329, U+1D00-1DBF, U+1E00-1E9F, U+1EF2-1EFF, U+2020, U+20A0-20AB, U+20AD-20C0, U+2113, U+2C60-2C7F, U+A720-A7FF';

my $faces = "<style>\n/* Fonte hospedada junto do site. Sem isto, cada visitante entrega o seu IP\n"
          . "   ao servidor de fontes de terceiro só para ler sobre um direito. */\n";
for my $w (400, 500, 600, 700) {
  for my $pair (["latin", $LATIN], ["latin-ext", $LATEXT]) {
    my ($sub, $range) = @$pair;
    $faces .= "\@font-face { font-family:'Poppins'; font-style:normal; font-weight:$w; font-display:swap;\n"
            . "  src:url('fontes/poppins-$w-$sub.woff2') format('woff2');\n"
            . "  unicode-range:$range; }\n";
  }
}
$faces .= "</style>";

my $antigo = qq{<link rel="preconnect" href="https://fonts.googleapis.com">\n}
          . qq{<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>\n}
          . qq{<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght\@400;500;600;700&display=swap">};

my $i = index($c, $antigo);
die "não encontrei o bloco do Google Fonts no arquivo de origem\n" if $i < 0;
substr($c, $i, length($antigo), $faces);

# o artifact é envolvido num doctype pelo publicador; aqui o arquivo é servido cru
unless ($c =~ /^<!doctype/i) {
  $c = qq{<!doctype html>\n<html lang="pt-BR">\n<head>\n<meta charset="utf-8">\n}
     . qq{<meta name="viewport" content="width=device-width,initial-scale=1">\n}
     . $c;
}
$c .= "\n" unless $c =~ /\n\z/;

open my $out, '>:raw', 'index.html' or die $!;
print $out $c; close $out;
printf "index.html gerado: %.1f KB\n", (-s 'index.html')/1024;

# --- normaliza o invólucro herdado do publicador de artifacts ---
{
  open my $in, '<:raw', 'index.html' or die $!;
  my $h = do { local $/; <$in> }; close $in;
  my $n = 0;
  $n += $h =~ s/<html><head>/<html lang="pt-BR"><head>/;
  $n += $h =~ s/:root\{color-scheme:light\}/:root{color-scheme:light dark}/;
  open my $o, '>:raw', 'index.html' or die $!;
  print $o $h; close $o;
  print "cabeçalho normalizado ($n ajustes)\n";
}
