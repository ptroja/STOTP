with Ada.Text_Io;
with LSC.Types;
with LSC.Byte_Arrays;
with HMAC;
with HOTP;
use all type HOTP.HOTP_Token;
use all type HOTP.HOTP_Value;

procedure Test_HOTP
  with SPARK_Mode
is
   Key         : constant LSC.Byte_Arrays.Byte_Array_Type :=
                   (16#48#, 16#48#, 16#48#, 16#48#);
   Counter     : constant LSC.Types.Word64 := 16#1bc#;
   Value       : constant HOTP.HOTP_Value := "194660";
   Rfc_Hmac    : constant HMAC.HMAC_Type :=
                   (16#1f#, 16#86#, 16#89#, 16#69#,
                    16#0e#, 16#02#, 16#ca#, 16#16#,
                    16#61#, 16#85#, 16#50#, 16#ef#,
                    16#7f#, 16#19#, 16#da#, 16#8e#,
                    16#94#, 16#5b#, 16#55#, 16#5a#);
   Rfc_Token   : constant HOTP.HOTP_Token := 16#50ef7f19#;
   Rfc_Value   : constant HOTP.HOTP_Value := "872921";
   Rfc_Value10 : constant HOTP.HOTP_Value := "1357872921";
begin
   pragma Warnings (Off, "no Global contract");
   Ada.Text_IO.Put_Line (Boolean'Image (
                         HOTP.Image (HOTP.HOTP (Key, Counter), 6) = Value));
   Ada.Text_Io.Put_Line (Boolean'Image (
                         HOTP.Extract (Rfc_Hmac) = Rfc_Token));
   Ada.Text_Io.Put_Line (Boolean'Image (
                         HOTP.Image (Rfc_Token, 6) = Rfc_Value));
   Ada.Text_Io.Put_Line (Boolean'Image (
                         HOTP.Image (Rfc_Token, 10) = Rfc_Value10));
end Test_HOTP;