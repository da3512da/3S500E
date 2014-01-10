----------------------------------------------------------------------------------------
-- Filename �s lcd.vhd
-- Author �s  ZJ
-- Description �s12864    
-- Called by �sTop module
-- Revision History �s10-5-20
-- Revision 1.0
-- Company �s WAVESHARE  
-- Copyright(c) 2010, WAVESHARE Technology Inc, All right reserved
-----------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;


ENTITY lcd12864 IS
   PORT (
      clk                     : IN std_logic;   
      --reset                   : IN std_logic;   
      rs                      : OUT std_logic;   
      rw                      : OUT std_logic;  
      en                      : OUT std_logic;   
      dat                     : OUT std_logic_vector(7 DOWNTO 0); 
      --rst                     : OUT std_logic);   
		LCD_N							: OUT std_logic;   
		LCD_P							: OUT std_logic;   
		PSB							: OUT std_logic;   
		LCD_RST						: OUT std_logic;
		s1  : in std_logic_vector(10 downto 0) 
		);  
		
END lcd12864;

ARCHITECTURE fun OF lcd12864 IS

	SIGNAL y :  BIT_vector (10 DOWNTO 0);
 	signal var1,var2,var3,var33:integer;--�ֱ��Ӧ������������ת��Ϊʮ��������ĸ�λ��С�����һλ���ڶ�λ
	SIGNAL a :  std_logic_vector (7 DOWNTO 0);
	SIGNAL b :  std_logic_vector (7 DOWNTO 0);
	SIGNAL c :  std_logic_vector (7 DOWNTO 0);
--//״̬����
   SIGNAL e                        :  std_logic;   
   SIGNAL counter                  :  std_logic_vector(15 DOWNTO 0);   
   SIGNAL current                  :  std_logic_vector(7 DOWNTO 0);   
   SIGNAL clkr                     :  std_logic;   
   SIGNAL cnt                      :  std_logic_vector(1 DOWNTO 0);   
   CONSTANT  set0                  :  std_logic_vector(7 DOWNTO 0) := "00000000";    
   CONSTANT  set1                  :  std_logic_vector(7 DOWNTO 0) := "00000001";    
   CONSTANT  set2                  :  std_logic_vector(7 DOWNTO 0) := "00000010";    
   CONSTANT  set3                  :  std_logic_vector(7 DOWNTO 0) := "00000011";    
   CONSTANT  set4                  :  std_logic_vector(7 DOWNTO 0) := "00100101";    
   CONSTANT  set5                  :  std_logic_vector(7 DOWNTO 0) := "00100110";    
   CONSTANT  dat0                  :  std_logic_vector(7 DOWNTO 0) := "00000100";    
   CONSTANT  dat1                  :  std_logic_vector(7 DOWNTO 0) := "00000101";    
   CONSTANT  dat2                  :  std_logic_vector(7 DOWNTO 0) := "00000110";    
   CONSTANT  dat3                  :  std_logic_vector(7 DOWNTO 0) := "00000111";    
   CONSTANT  dat4                  :  std_logic_vector(7 DOWNTO 0) := "00001000";    
   CONSTANT  dat5                  :  std_logic_vector(7 DOWNTO 0) := "00001001";    
   CONSTANT  dat6                  :  std_logic_vector(7 DOWNTO 0) := "00001010";    
   CONSTANT  dat7                  :  std_logic_vector(7 DOWNTO 0) := "00001011";    
   CONSTANT  dat8                  :  std_logic_vector(7 DOWNTO 0) := "00001100";      
   CONSTANT  dat9                  :  std_logic_vector(7 DOWNTO 0) := "00001101";    
   CONSTANT  dat10                 :  std_logic_vector(7 DOWNTO 0) := "00001110";    
   CONSTANT  dat11                 :  std_logic_vector(7 DOWNTO 0) := "00001111";    
   CONSTANT  dat12                 :  std_logic_vector(7 DOWNTO 0) := "00010000";    
   CONSTANT  dat13                 :  std_logic_vector(7 DOWNTO 0) := "00010001";    
   CONSTANT  dat14                 :  std_logic_vector(7 DOWNTO 0) := "00010010";    
   CONSTANT  dat15                 :  std_logic_vector(7 DOWNTO 0) := "00010011";    
   CONSTANT  dat16                 :  std_logic_vector(7 DOWNTO 0) := "00010100";    
   CONSTANT  dat17                 :  std_logic_vector(7 DOWNTO 0) := "00010101";    
   CONSTANT  dat18                 :  std_logic_vector(7 DOWNTO 0) := "00010110";    
   CONSTANT  dat19                 :  std_logic_vector(7 DOWNTO 0) := "00010111";    
   CONSTANT  dat20                 :  std_logic_vector(7 DOWNTO 0) := "00011000";    
   CONSTANT  dat21                 :  std_logic_vector(7 DOWNTO 0) := "00011001";    
   CONSTANT  dat22                 :  std_logic_vector(7 DOWNTO 0) := "00011010";    
   CONSTANT  dat23                 :  std_logic_vector(7 DOWNTO 0) := "00011011";    
   CONSTANT  dat24                 :  std_logic_vector(7 DOWNTO 0) := "00011100";    
   CONSTANT  dat25                 :  std_logic_vector(7 DOWNTO 0) := "00011101";    
   CONSTANT  dat26                 :  std_logic_vector(7 DOWNTO 0) := "00011111";    
   CONSTANT  dat27                 :  std_logic_vector(7 DOWNTO 0) := "00100000";    
   CONSTANT  dat28                 :  std_logic_vector(7 DOWNTO 0) := "00100001";    
   CONSTANT  dat29                 :  std_logic_vector(7 DOWNTO 0) := "00100010";    
   CONSTANT  dat30                 :  std_logic_vector(7 DOWNTO 0) := "00100011";    
   CONSTANT  nul                   :  std_logic_vector(7 DOWNTO 0) := "00110000";    
   SIGNAL dat_r                :  std_logic_vector(7 DOWNTO 0);   
   SIGNAL rs_r                 :  std_logic;   
   SIGNAL rw_r                 :  std_logic;   
   SIGNAL en_r                 :  std_logic;   



BEGIN
   dat <= dat_r;
   rs <= rs_r;
   rw <= rw_r;
   en <= en_r;

	PSB <= '1' ; 
	LCD_RST <= '1' ; 
	LCD_N<='0';
	LCD_P<='1';
--ʱ�ӷ�Ƶ
   PROCESS(clk)
   BEGIN
   IF(clk'EVENT AND clk = '1') THEN
      counter <= counter + "0000000000000001";    
      IF (counter = "0000000000001111") THEN
         clkr <= NOT clkr;    
      END IF;
   END IF;
   END PROCESS;

   PROCESS(clkr)
   BEGIN
      IF(clkr'EVENT AND clkr = '1') THEN   
      CASE current IS
         WHEN set0 =>
                  rs_r <= '0';    
                  dat_r <= "00110000";    --��ʼ�� --����ָ�
                  current <= set1;    
         WHEN set1 =>
                  rs_r <= '0';    
                  dat_r <= "00001100";    --����ʾ
                  current <= set2;    
         WHEN set2 =>
                  rs_r <= '0';    
                  dat_r <= "00000110";    --�������
                  current <= set3;    
         WHEN set3 =>
                  rs_r <= '0';    
                  dat_r <= "00000001";    --����
                  current <= set4;    
         WHEN set4 =>
                  rs_r <= '0';    
                  dat_r <= "10000000";    --��������λ�� ����ַ����Ϊ��1�У�
                  current <= dat0;    
         WHEN dat0 =>
                  rs_r <= '1';    
                  dat_r <= x"30";    --���͵�һ������
                  current <= dat1;    
         WHEN dat1 =>
                  rs_r <= '1';    
                  dat_r <= c;    
                  current <= dat2;    
         WHEN dat2 =>
                  rs_r <= '1';    
                  dat_r <= b;    
                  current <= dat3;    
         WHEN dat3 =>
                  rs_r <= '1';    
                  dat_r <= x"A5";    
                  current <= dat4;    
         WHEN dat4 =>
                  rs_r <= '1';    
                  dat_r <= a;    
                  current <= dat5;    
         WHEN dat5 =>
                  rs_r <= '1';    
                  dat_r <= CONV_STD_LOGIC_VECTOR(104, 8);    
                  current <= dat6;    
         WHEN dat6 =>
                  rs_r <= '1';    
                  dat_r <= CONV_STD_LOGIC_VECTOR(97, 8);    
                  current <= dat7;    
         WHEN dat7 =>
                  rs_r <= '1';    
                  dat_r <= CONV_STD_LOGIC_VECTOR(114, 8);    
                  current <= dat8;    
         WHEN dat8 =>
                  rs_r <= '1';    
                  dat_r <= CONV_STD_LOGIC_VECTOR(101, 8);    
                 current <= nul;    
 
     
         WHEN nul =>   --��α�֤ǰ����ʾ��������ִ��һ�� 
                       --Ȼ���Һ����En������,���һ�ζ�д����
                  rs_r <= '0';    
                  dat_r <= "00000000";    
                  IF (cnt /= "10") THEN
                     e <= '0';    
                     current <= set0;    
                     cnt <= cnt + "01";    
                  ELSE
                     current <= set0;    
                     e <= '1';    
                     cnt <= "00";    
                  END IF;

         WHEN OTHERS  =>
                  current <= nul;    
         
      END CASE;
      END IF;
   END PROCESS;
   en_r <= clkr OR e ; --��LCDʼ��Ϊд����
   rw_r <= '0' ;  --��LCDʼ��Ϊд����
  -- rst <= reset ;

process(s1)

begin
	
	
	var3<=CONV_INTEGER(To_StdLogicVector(To_bitvector(s1) SRL 7)(3 DOWNTO 0)); --CONV_INTEGER(s1)/160 rem 10
	var2<=CONV_INTEGER(To_StdLogicVector(To_bitvector(s1) SRL 4 )(3 DOWNTO 0));        --((CONV_INTEGER(s1))SRL 4 )rem 10;   --��λ
	var1<=CONV_INTEGER(To_StdLogicVector(To_bitvector(CONV_STD_LOGIC_VECTOR(CONV_INTEGER(s1)*10,11)) SRL 4)(3 DOWNTO 0));--((CONV_INTEGER(s1)*10)SRL 4 )rem 10;   --С�����һλ
-- y<=y  sRL 4;
case var3 is--ʮλ
	when 0=>c<= x"30";
    when 1=>c<= x"31"; 
	when 2=>c<= x"32";  
	when 3=>c<= x"33";  
	when 4=>c<= x"34" ; 
	when 5=>c<= x"35" ; 
	when 6=>c<= x"36" ; 
	when 7=>c<= x"37" ; 
	when 8=>c<= x"38" ; 
	when 9=>c<= x"39" ; 
	when others =>c<=  x"ff" ;
	end case;

case var2 is--��λ
	when 0=>b<= x"30";
    when 1=>b<= x"31"; 
	when 2=>b<= x"32";  
	when 3=>b<= x"33";  
	when 4=>b<= x"34"; 
	when 5=>b<= x"35"; 
	when 6=>b<= x"36"; 
	when 7=>b<= x"37"; 
	when 8=>b<= x"38"; 
	when 9=>b<= x"39"; 
	when others =>b<= x"ff" ;
	end case;

case var1 is--��С������һλ����
when 0 =>A<= x"30";
    when 1 =>A<= x"31"; 
	when 2=>A<= x"32";  
	when 3=>A<= x"33";  
	when 4=>A<= x"34" ; 
	when 5=>A<= x"35" ; 
	when 6=>A<= x"36" ; 
	when 7=>A<= x"37" ; 
	when 8=>A<= x"38" ; 
	when 9=>A<= x"39" ; 
	when others =>a<=x"ff" ;
	end case;
end process;

END fun;
