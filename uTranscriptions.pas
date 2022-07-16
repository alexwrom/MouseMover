unit uTranscriptions;

interface

uses System.SysUtils, System.Types;

function ConvertToEng(textRU: string): string;

const

  arrayL: array [0 .. 31, 0 .. 1] of Char = (('Q', '�'), ('W', '�'), ('E', '�'), ('R', '�'), ('T', '�'), ('Y', '�'), ('U', '�'), ('I', '�'), ('O', '�'), ('P', '�'), (CHR(219), '�'), (CHR(221), '�'), ('A', '�'), ('S', '�'), ('D', '�'), ('F', '�'), ('G', '�'),
    ('H', '�'), ('J', '�'), ('K', '�'), ('L', '�'), (CHR(186), '�'), (CHR(222), '�'), ('Z', '�'), ('X', '�'), ('C', '�'), ('V', '�'), ('B', '�'), ('N', '�'), ('M', '�'), (CHR(188), '�'), (CHR(190), '�'));

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
