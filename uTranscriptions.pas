unit uTranscriptions;

interface

uses System.SysUtils, System.Types;

function ConvertToEng(textRU: string): string;

const

  arrayL: array [0 .. 31, 0 .. 1] of Char = (('Q', 'É'), ('W', 'Ö'), ('E', 'Ó'), ('R', 'Ê'), ('T', 'Å'), ('Y', 'Í'), ('U', 'Ã'), ('I', 'Ø'), ('O', 'Ù'), ('P', 'Ç'), (CHR(219), 'Õ'), (CHR(221), 'Ú'), ('A', 'Ô'), ('S', 'Û'), ('D', 'Â'), ('F', 'À'), ('G', 'Ï'),
    ('H', 'Ð'), ('J', 'Î'), ('K', 'Ë'), ('L', 'Ä'), (CHR(186), 'Æ'), (CHR(222), 'Ý'), ('Z', 'ß'), ('X', '×'), ('C', 'Ñ'), ('V', 'Ì'), ('B', 'È'), ('N', 'Ò'), ('M', 'Ü'), (CHR(188), 'Á'), (CHR(190), 'Þ'));

implementation

function FindTo(charIN: Char): Char;
var
  I: Integer;
begin
  result := ' ';
  for I := 0 to 31 do
    if charIN = arrayL[I][1] then
      result := arrayL[I][0];
end;

function ConvertToEng(textRU: string): string;
var
  I: Integer;
begin
  result := '';
  for I := 1 to textRU.Length do
    result := result + FindTo(textRU[I]);
end;

end.
