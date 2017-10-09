
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity processor is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           result : out  STD_LOGIC_VECTOR (31 downto 0));
end processor;

architecture Behavioral of processor is

component datapath is
    Port ( rstP : in  STD_LOGIC;
           clkP : in  STD_LOGIC;
           ins : out  STD_LOGIC_vector (31 downto 0));
end component;

component RF is
    port (
          RD : in std_logic_vector(4 downto 0);
          DWR   : in std_logic_vector(31 downto 0);
			 RS1   : in std_logic_vector(4 downto 0);
			 RS2   : in std_logic_vector(4 downto 0);
          CRS1   : out std_logic_vector(31 downto 0);
			 CRS2   : out std_logic_vector(31 downto 0);
			 rst: in std_logic
			 );
end component;

component ControlUnit is
    Port ( op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           aluop : out  STD_LOGIC_VECTOR (5 downto 0));
end component;




component SEU is
    Port ( imm : in  STD_LOGIC_VECTOR (12 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;


component multiplex is
    Port ( i : in  STD_LOGIC;
           R : in  STD_LOGIC_VECTOR (31 downto 0);
           imm : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component ALU is
    Port ( op : in  STD_LOGIC_VECTOR (5 downto 0);
           d1 : in  STD_LOGIC_VECTOR (31 downto 0);
           d2 : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

signal instruction: std_logic_vector (31 downto 0);
signal operation: std_logic_vector(5 downto 0);
signal outSEU: std_logic_vector(31 downto 0);
signal source1: std_logic_vector(31 downto 0);
signal source2: std_logic_vector(31 downto 0);
signal data1: std_logic_vector(31 downto 0);
signal data2: std_logic_vector(31 downto 0);
signal outALU: std_logic_vector(31 downto 0);

begin

datapathI: datapath
port map(
				rstP => rst,
           clkP => clk,
           ins => instruction
	);
	
CU: ControlUnit
port map(
	op => instruction(31 downto 30),
   op3 => instruction(24 downto 19),
   aluop => operation
);

signeExtension: SEU
port map(
	imm => instruction(12 downto 0),
   output => outSEU
);

MUX: multiplex
port map(
				i => instruction(13),
           R => source2,
           imm => outSEU,
           output => data2
);

RegisterFile: RF
port map(
			RD => instruction(29 downto 25),
          DWR   => outALU,
			 RS1   => instruction(18 downto 14),
			 RS2   => instruction(4 downto 0),
          CRS1   => source1,
			 CRS2   => source2,
			 rst => rst
);

ALU1: ALU
port map(
				op => operation,
           d1 => source1,
           d2 => data2,
           output => outAlu
);

result <= outALU;
end Behavioral;

