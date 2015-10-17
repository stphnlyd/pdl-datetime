use strict;
use warnings;

use Test::More;
use PDL;
use PDL::DateTime;

my @data = (
  # len = 140, start = 0001-01-01T00:00:00.987654Z
  { unit=>'second', step=>11009, min=>-62135596799012346, max=>-62134066548012346, dtmax=>'0001-01-18T17:04:11.987654', sum=>-8698876434291728440},
  { unit=>'second', step=>110009, min=>-62135596799012346, max=>-62120305548012346, dtmax=>'0001-06-26T23:34:11.987654', sum=>-8697913164291728440},
  { unit=>'second', step=>11000009, min=>-62135596799012346, max=>-60606595548012346, dtmax=>'0049-06-14T18:34:11.987654', sum=>-8591953464291728440},
  { unit=>'second', step=>110000009, min=>-62135596799012346, max=>-46845595548012346, dtmax=>'0485-07-09T14:34:11.987654', sum=>-7628683464291728440},
  { unit=>'second', step=>1100000009, min=>-62135596799012346, max=>90764404451987654, dtmax=>'4846-03-17T22:34:11.987654', sum=>2004016535708271560},
  { unit=>'minute', step=>1100, min=>-62135596799012346, max=>-62126422799012346, dtmax=>'0001-04-17T04:20:00.987654', sum=>-8698341371861728440},
  { unit=>'minute', step=>11000, min=>-62135596799012346, max=>-62043856799012346, dtmax=>'0003-11-28T19:20:00.987654', sum=>-8692561751861728440},
  { unit=>'minute', step=>1100000, min=>-62135596799012346, max=>-52961596799012346, dtmax=>'0291-09-18T13:20:00.987654', sum=>-8056803551861728440},
  { unit=>'minute', step=>11000000, min=>-62135596799012346, max=>29604403200987654, dtmax=>'2908-02-16T13:20:00.987654', sum=>-2277183551861728440},
  { unit=>'hour', step=>1, min=>-62135596799012346, max=>-62135096399012346, dtmax=>'0001-01-06T19:00:00.987654', sum=>-8698948523861728440},
  { unit=>'hour', step=>11, min=>-62135596799012346, max=>-62130092399012346, dtmax=>'0001-03-05T17:00:00.987654', sum=>-8698598243861728440},
  { unit=>'hour', step=>110, min=>-62135596799012346, max=>-62080552799012346, dtmax=>'0002-09-30T02:00:00.987654', sum=>-8695130471861728440},
  { unit=>'hour', step=>1100, min=>-62135596799012346, max=>-61585156799012346, dtmax=>'0018-06-11T20:00:00.987654', sum=>-8660452751861728440},
  { unit=>'hour', step=>110000, min=>-62135596799012346, max=>-7091596799012346, dtmax=>'1745-04-11T08:00:00.987654', sum=>-4845903551861728440},
  { unit=>'hour', step=>510000, min=>-62135596799012346, max=>193068403200987654, dtmax=>'8088-02-04T00:00:00.987654', sum=>9165296448138271560},
  { unit=>'day', step=>1, min=>-62135596799012346, max=>-62123587199012346, dtmax=>'0001-05-20T00:00:00.987654', sum=>-8698142879861728440},
  { unit=>'day', step=>2, min=>-62135596799012346, max=>-62111577599012346, dtmax=>'0001-10-06T00:00:00.987654', sum=>-8697302207861728440},
  { unit=>'day', step=>20, min=>-62135596799012346, max=>-61895404799012346, dtmax=>'0008-08-12T00:00:00.987654', sum=>-8682170111861728440},
  { unit=>'day', step=>200, min=>-62135596799012346, max=>-59733676799012346, dtmax=>'0077-02-11T00:00:00.987654', sum=>-8530849151861728440},
  { unit=>'day', step=>2000, min=>-62135596799012346, max=>-38116396799012346, dtmax=>'0762-02-21T00:00:00.987654', sum=>-7017639551861728440},
  { unit=>'day', step=>20000, min=>-62135596799012346, max=>178056403200987654, dtmax=>'7612-05-20T00:00:00.987654', sum=>8114456448138271560},
  { unit=>'week', step=>1, min=>-62135596799012346, max=>-62051529599012346, dtmax=>'0003-09-01T00:00:00.987654', sum=>-8693098847861728440},
  { unit=>'week', step=>2, min=>-62135596799012346, max=>-61967462399012346, dtmax=>'0006-05-01T00:00:00.987654', sum=>-8687214143861728440},
  { unit=>'week', step=>20, min=>-62135596799012346, max=>-60454252799012346, dtmax=>'0054-04-13T00:00:00.987654', sum=>-8581289471861728440},
  { unit=>'week', step=>200, min=>-62135596799012346, max=>-45322156799012346, dtmax=>'0533-10-19T00:00:00.987654', sum=>-7522042751861728440},
  { unit=>'week', step=>2000, min=>-62135596799012346, max=>105998803200987654, dtmax=>'5328-12-20T00:00:00.987654', sum=>3070424448138271560},
  { unit=>'week', step=>3000, min=>-62135596799012346, max=>190066003200987654, dtmax=>'7992-12-14T00:00:00.987654', sum=>8955128448138271560},
  { unit=>'month', step=>1, min=>-62135596799012346, max=>-61770124799012346, dtmax=>'0012-08-01T00:00:00.987654', sum=>-8673408806261728440},
  { unit=>'month', step=>5, min=>-62135596799012346, max=>-60307977599012346, dtmax=>'0058-12-01T00:00:00.987654', sum=>-8571056601461728440},
  { unit=>'month', step=>50, min=>-62135596799012346, max=>-43858972799012346, dtmax=>'0580-03-01T00:00:00.987654', sum=>-7419625919861728440},
  { unit=>'month', step=>150, min=>-62135596799012346, max=>-7305551999012346, dtmax=>'1738-07-01T00:00:00.987654', sum=>-4860882403061728440},
  { unit=>'month', step=>250, min=>-62135596799012346, max=>29248128000987654, dtmax=>'2896-11-01T00:00:00.987654', sum=>-2302140700661728440},
  { unit=>'month', step=>450, min=>-62135596799012346, max=>102354883200987654, dtmax=>'5213-07-01T00:00:00.987654', sum=>2815345900938271560},
  { unit=>'month', step=>650, min=>-62135596799012346, max=>175461724800987654, dtmax=>'7530-03-01T00:00:00.987654', sum=>7932830428938271560},
  { unit=>'year', step=>1, min=>-62135596799012346, max=>-57749241599012346, dtmax=>'0140-01-01T00:00:00.987654', sum=>-8391936095861728440},
  { unit=>'year', step=>2, min=>-62135596799012346, max=>-53362799999012346, dtmax=>'0279-01-01T00:00:00.987654', sum=>-8084886911861728440},
  { unit=>'year', step=>10, min=>-62135596799012346, max=>-18271439999012346, dtmax=>'1391-01-01T00:00:00.987654', sum=>-5628495167861728440},
  { unit=>'year', step=>20, min=>-62135596799012346, max=>25592716800987654, dtmax=>'2781-01-01T00:00:00.987654', sum=>-2558001599861728440},
  { unit=>'year', step=>40, min=>-62135596799012346, max=>113321030400987654, dtmax=>'5561-01-01T00:00:00.987654', sum=>3582981561738271560},
);

for (@data) {
  my $dt = PDL::DateTime->new_sequence('0001-01-01T00:00:00.987654', 140, $_->{unit}, $_->{step});
  is($dt->max,   $_->{max}, "day max $_->{unit}/$_->{step}");
  is($dt->min,   $_->{min}, "day min $_->{unit}/$_->{step}");
  is($dt->sum,   $_->{sum}, "day sum $_->{unit}/$_->{step}");
  is($dt->nelem, 140,       "day nelem $_->{unit}/$_->{step}");
  is($dt->slice("-1")->dt_unpdl("%Y-%m-%dT%H:%M:%S.%6N")->[0], $_->{dtmax}, "dtmax nelem $_->{unit}/$_->{step}");
}

{
  my $dt = PDL::DateTime->new_sequence('0399-01-31T11:12:13.456789', 50, 'month');
  my @d = (qw/
  0399-01-31T11:12:13.456789 0399-02-28T11:12:13.456789 0399-03-31T11:12:13.456789 0399-04-30T11:12:13.456789 0399-05-31T11:12:13.456789
  0399-06-30T11:12:13.456789 0399-07-31T11:12:13.456789 0399-08-31T11:12:13.456789 0399-09-30T11:12:13.456789 0399-10-31T11:12:13.456789
  0399-11-30T11:12:13.456789 0399-12-31T11:12:13.456789 0400-01-31T11:12:13.456789 0400-02-29T11:12:13.456789 0400-03-31T11:12:13.456789
  0400-04-30T11:12:13.456789 0400-05-31T11:12:13.456789 0400-06-30T11:12:13.456789 0400-07-31T11:12:13.456789 0400-08-31T11:12:13.456789
  0400-09-30T11:12:13.456789 0400-10-31T11:12:13.456789 0400-11-30T11:12:13.456789 0400-12-31T11:12:13.456789 0401-01-31T11:12:13.456789
  0401-02-28T11:12:13.456789 0401-03-31T11:12:13.456789 0401-04-30T11:12:13.456789 0401-05-31T11:12:13.456789 0401-06-30T11:12:13.456789
  0401-07-31T11:12:13.456789 0401-08-31T11:12:13.456789 0401-09-30T11:12:13.456789 0401-10-31T11:12:13.456789 0401-11-30T11:12:13.456789
  0401-12-31T11:12:13.456789 0402-01-31T11:12:13.456789 0402-02-28T11:12:13.456789 0402-03-31T11:12:13.456789 0402-04-30T11:12:13.456789
  0402-05-31T11:12:13.456789 0402-06-30T11:12:13.456789 0402-07-31T11:12:13.456789 0402-08-31T11:12:13.456789 0402-09-30T11:12:13.456789
  0402-10-31T11:12:13.456789 0402-11-30T11:12:13.456789 0402-12-31T11:12:13.456789 0403-01-31T11:12:13.456789 0403-02-28T11:12:13.456789
  /);
  is_deeply($dt->dt_unpdl, \@d, "month spec1");
}

{
  my $dt = PDL::DateTime->new_sequence('1899-01-30T11:12:13.456789', 50, 'month');
  my @d = (qw/
  1899-01-30T11:12:13.456789 1899-02-28T11:12:13.456789 1899-03-30T11:12:13.456789 1899-04-30T11:12:13.456789 1899-05-30T11:12:13.456789
  1899-06-30T11:12:13.456789 1899-07-30T11:12:13.456789 1899-08-30T11:12:13.456789 1899-09-30T11:12:13.456789 1899-10-30T11:12:13.456789
  1899-11-30T11:12:13.456789 1899-12-30T11:12:13.456789 1900-01-30T11:12:13.456789 1900-02-28T11:12:13.456789 1900-03-30T11:12:13.456789
  1900-04-30T11:12:13.456789 1900-05-30T11:12:13.456789 1900-06-30T11:12:13.456789 1900-07-30T11:12:13.456789 1900-08-30T11:12:13.456789
  1900-09-30T11:12:13.456789 1900-10-30T11:12:13.456789 1900-11-30T11:12:13.456789 1900-12-30T11:12:13.456789 1901-01-30T11:12:13.456789
  1901-02-28T11:12:13.456789 1901-03-30T11:12:13.456789 1901-04-30T11:12:13.456789 1901-05-30T11:12:13.456789 1901-06-30T11:12:13.456789
  1901-07-30T11:12:13.456789 1901-08-30T11:12:13.456789 1901-09-30T11:12:13.456789 1901-10-30T11:12:13.456789 1901-11-30T11:12:13.456789
  1901-12-30T11:12:13.456789 1902-01-30T11:12:13.456789 1902-02-28T11:12:13.456789 1902-03-30T11:12:13.456789 1902-04-30T11:12:13.456789
  1902-05-30T11:12:13.456789 1902-06-30T11:12:13.456789 1902-07-30T11:12:13.456789 1902-08-30T11:12:13.456789 1902-09-30T11:12:13.456789
  1902-10-30T11:12:13.456789 1902-11-30T11:12:13.456789 1902-12-30T11:12:13.456789 1903-01-30T11:12:13.456789 1903-02-28T11:12:13.456789
  /);
  is_deeply($dt->dt_unpdl, \@d, "month spec2");
}

{
  my $dt = PDL::DateTime->new_sequence('5899-01-29T11:12:13.456789', 50, 'month');
  my @d = (qw/
  5899-01-29T11:12:13.456789 5899-02-28T11:12:13.456789 5899-03-29T11:12:13.456789 5899-04-29T11:12:13.456789 5899-05-29T11:12:13.456789
  5899-06-29T11:12:13.456789 5899-07-29T11:12:13.456789 5899-08-29T11:12:13.456789 5899-09-29T11:12:13.456789 5899-10-29T11:12:13.456789
  5899-11-29T11:12:13.456789 5899-12-29T11:12:13.456789 5900-01-29T11:12:13.456789 5900-02-28T11:12:13.456789 5900-03-29T11:12:13.456789
  5900-04-29T11:12:13.456789 5900-05-29T11:12:13.456789 5900-06-29T11:12:13.456789 5900-07-29T11:12:13.456789 5900-08-29T11:12:13.456789
  5900-09-29T11:12:13.456789 5900-10-29T11:12:13.456789 5900-11-29T11:12:13.456789 5900-12-29T11:12:13.456789 5901-01-29T11:12:13.456789
  5901-02-28T11:12:13.456789 5901-03-29T11:12:13.456789 5901-04-29T11:12:13.456789 5901-05-29T11:12:13.456789 5901-06-29T11:12:13.456789
  5901-07-29T11:12:13.456789 5901-08-29T11:12:13.456789 5901-09-29T11:12:13.456789 5901-10-29T11:12:13.456789 5901-11-29T11:12:13.456789
  5901-12-29T11:12:13.456789 5902-01-29T11:12:13.456789 5902-02-28T11:12:13.456789 5902-03-29T11:12:13.456789 5902-04-29T11:12:13.456789
  5902-05-29T11:12:13.456789 5902-06-29T11:12:13.456789 5902-07-29T11:12:13.456789 5902-08-29T11:12:13.456789 5902-09-29T11:12:13.456789
  5902-10-29T11:12:13.456789 5902-11-29T11:12:13.456789 5902-12-29T11:12:13.456789 5903-01-29T11:12:13.456789 5903-02-28T11:12:13.456789
  /);
  is_deeply($dt->dt_unpdl, \@d, "month spec3");
}

{
  my $dt = PDL::DateTime->new_sequence('7999-01-28T11:12:13.456789', 50, 'month');
  my @d = (qw/
  7999-01-28T11:12:13.456789 7999-02-28T11:12:13.456789 7999-03-28T11:12:13.456789 7999-04-28T11:12:13.456789 7999-05-28T11:12:13.456789
  7999-06-28T11:12:13.456789 7999-07-28T11:12:13.456789 7999-08-28T11:12:13.456789 7999-09-28T11:12:13.456789 7999-10-28T11:12:13.456789
  7999-11-28T11:12:13.456789 7999-12-28T11:12:13.456789 8000-01-28T11:12:13.456789 8000-02-28T11:12:13.456789 8000-03-28T11:12:13.456789
  8000-04-28T11:12:13.456789 8000-05-28T11:12:13.456789 8000-06-28T11:12:13.456789 8000-07-28T11:12:13.456789 8000-08-28T11:12:13.456789
  8000-09-28T11:12:13.456789 8000-10-28T11:12:13.456789 8000-11-28T11:12:13.456789 8000-12-28T11:12:13.456789 8001-01-28T11:12:13.456789
  8001-02-28T11:12:13.456789 8001-03-28T11:12:13.456789 8001-04-28T11:12:13.456789 8001-05-28T11:12:13.456789 8001-06-28T11:12:13.456789
  8001-07-28T11:12:13.456789 8001-08-28T11:12:13.456789 8001-09-28T11:12:13.456789 8001-10-28T11:12:13.456789 8001-11-28T11:12:13.456789
  8001-12-28T11:12:13.456789 8002-01-28T11:12:13.456789 8002-02-28T11:12:13.456789 8002-03-28T11:12:13.456789 8002-04-28T11:12:13.456789
  8002-05-28T11:12:13.456789 8002-06-28T11:12:13.456789 8002-07-28T11:12:13.456789 8002-08-28T11:12:13.456789 8002-09-28T11:12:13.456789
  8002-10-28T11:12:13.456789 8002-11-28T11:12:13.456789 8002-12-28T11:12:13.456789 8003-01-28T11:12:13.456789 8003-02-28T11:12:13.456789
  /);
  is_deeply($dt->dt_unpdl, \@d, "month spec4");
}

is_deeply(PDL::DateTime->new_sequence('2014-12-05', 15, 'month')->dt_quarter->unpdl, [4,1,1,1,2,2,2,3,3,3,4,4,4,1,1]);

done_testing;