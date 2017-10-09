
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.all;

entity ALU is
    Port ( op : in  STD_LOGIC_VECTOR (5 downto 0);
           d1 : in  STD_LOGIC_VECTOR (31 downto 0);
           d2 : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end ALU;

architecture Behavioral of ALU is

begin

process(op,d1,d2)
begin
	case(op) is
		when "000000" =>
			output <= d1 + d2;
		when "000100" =>
			output <= d1 - d2;
		when "000001" =>
			output <= d1 and d2;
		when "000010" =>
			output <= d1 or d2;
		when "000011" =>
			output <= d1 xor d2;
		when "000101" =>
			output <= d1 nand d2;
		when "000110" =>
			output <= d1 nor d2;
		when "000111" =>
			output <= d1 xnor d2;			
		when others => output <= "00000000000000000000000000000000";
	end case;
end process;

end Behavioral;

