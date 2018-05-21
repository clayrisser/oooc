#!/usr/bin/perl

use strict;

my $stdin = <STDIN>;

my $regex = qr/(?(DEFINE)
(?<jsonarray>(?>\[\s*(?>(?&value)(?>\s*,\s*(?&value))*)?\s*,?\s*\]))
(?<jsonlike>(?>\s*(?&jsonobject)\s*|\s*(?&jsonarray)\s*))
(?<jsonobject>(?>\{\s*(?>(?&jsonpair)(?>\s*,\s*(?&jsonpair))*)?\s*\}))
(?<jsonpair>(?>(?&strquote)\s*:\s*(?&value)))
(?<num>(?>-?(?>0|[1-9][0-9]*)(?>\.[0-9]+)?(?>[eE][+-]?[0-9]+)?))
(?<str>(?>(?&strquote)|([\w\d-_.~@]|(\\[\\'":]))+))
(?<strdouble>(?>"(?>\\(?>["\\\/bfnrt]|u[a-fA-F0-9]{4})|[^"\\\0-\x1F\x7F]+)*"))
(?<strquote>(?>(?&strdouble)|(?&strsingle)))
(?<strsingle>(?>'(?>\\(?>['\\\/bfnrt]|u[a-fA-F0-9]{4})|[^'\\\0-\x1F\x7F]+)*'))
(?<value>(?>true|false|null|none|nill|(?&strquote)|(?&num)|(?&jsonobject)|(?&jsonarray)))
(?<yml>(?>\s*(((?&ymlkey):\s+(?&str))|(?&ymlarray))\s*))
(?<ymlarray>(?>-\s+(?&str)))
(?<ymlkey>(?>(?&str)(?=:)))
)
(?&jsonlike)|(?&yml)/xip;

if ( $stdin =~ /$regex/g ) {
  print "${^MATCH}"
}
