library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity instructionMemory is
port (rst : in  STD_LOGIC;
      EN : in std_logic;
      ADDR : in std_logic_vector(31 downto 0);
      DATA : out std_logic_vector(31 downto 0));
end instructionMemory;

architecture syn of instructionMemory is
    type rom_type is array (0 to 63) of std_logic_vector (31 downto 0);                 
    signal ROM : rom_type:= (X"82102008", X"84103FF9", X"90004002", X"92184002", X"94284002", X"96384002",
                             X"98204002", "00000000000000000000000000000000","00000000000000000000000000000000", "00000000000000000000000000000000", "00000000000000000000000000000000", "00000000000000000000000000000000",
                             "00000000000000000000000000000000", "00000000000000000000000000000000","00000000000000000000000000000000", "00000000000000000000000000000000", "00000000000000000000000000000000", "00000000000000000000000000000000",
                              "00000000000000000000000000000000", "00000000000000000000000000000000","00000000000000000000000000000000", "00000000000000000000000000000000", "00000000000000000000000000000000", "00000000000000000000000000000000",
                              "00000000000000000000000000000000", "00000000000000000000000000000000","00000000000000000000000000000000", "00000000000000000000000000000000", "00000000000000000000000000000000", "00000000000000000000000000000000",
                              "00000000000000000000000000000000", "00000000000000000000000000000000","00000000000000000000000000000000", "00000000000000000000000000000000", "00000000000000000000000000000000", "00000000000000000000000000000000",
                              "00000000000000000000000000000000", "00000000000000000000000000000000","00000000000000000000000000000000", "00000000000000000000000000000000", "00000000000000000000000000000000", "00000000000000000000000000000000",
                              "00000000000000000000000000000000", "00000000000000000000000000000000","00000000000000000000000000000000", "00000000000000000000000000000000", "00000000000000000000000000000000", "00000000000000000000000000000000",
                              "00000000000000000000000000000000", "00000000000000000000000000000000","00000000000000000000000000000000", "00000000000000000000000000000000", "00000000000000000000000000000000", "00000000000000000000000000000000",
                              "00000000000000000000000000000000", "00000000000000000000000000000000","00000000000000000000000000000000", "00000000000000000000000000000000", "00000000000000000000000000000000", "00000000000000000000000000000000",
                             "00000000000000000000000000000000", "00000000000000000000000000000000","00000000000000000000000000000000", "00000000000000000000000000000000" );                        



begin


	 
	
process(rst,ADDR)
	begin
	
	if rst = '1' then
		DATA<="00000000000000000000000000000000";
	else
		DATA <= ROM(conv_integer(ADDR(5 downto 0))); 
	end if;

end process;

end syn;