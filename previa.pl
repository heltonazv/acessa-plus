use strict; use warnings;
use IO::Socket::INET;
my $port = shift || 8790;
my %TYPE = ('html'=>'text/html; charset=utf-8', 'woff2'=>'font/woff2', 'toml'=>'text/plain', 'md'=>'text/plain');
my $CSP = "default-src 'none'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'; font-src 'self'; img-src 'self' data:; base-uri 'none'; form-action 'none'; frame-ancestors 'self'";
my $srv = IO::Socket::INET->new(LocalAddr=>'127.0.0.1', LocalPort=>$port, Proto=>'tcp', Listen=>16, ReuseAddr=>1) or die "listen: $!";
$| = 1; print "prévia com os cabeçalhos do netlify.toml em http://127.0.0.1:$port/\n";
while (my $cli = $srv->accept) {
  my $req = <$cli> || ''; while (defined(my $h = <$cli>)) { last if $h =~ /^\r?$/ }
  my ($path) = $req =~ m{^GET\s+(\S+)}; $path ||= '/'; $path =~ s/\?.*//; $path =~ s/#.*//;
  $path = '/index.html' if $path eq '/';
  $path =~ s{\.\.}{}g;
  my $file = ".$path";
  if (!-f $file) { print $cli "HTTP/1.1 404 Not Found\r\nContent-Length: 0\r\nConnection: close\r\n\r\n"; close $cli; next }
  my ($ext) = $file =~ /\.(\w+)$/; my $ct = $TYPE{$ext || ''} || 'application/octet-stream';
  open my $fh, '<:raw', $file or next; my $body = do { local $/; <$fh> }; close $fh;
  print $cli "HTTP/1.1 200 OK\r\nContent-Type: $ct\r\nContent-Length: " . length($body)
    . "\r\nContent-Security-Policy: $CSP\r\nX-Content-Type-Options: nosniff\r\nReferrer-Policy: no-referrer\r\nConnection: close\r\n\r\n" . $body;
  close $cli;
}
