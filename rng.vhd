--library assignments
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--package assignments

entity rng is
	generic
	(
		--generic assignments
		init_z1	: std_logic_vector(63 downto 0) := 64d"5030521883283424767";
		init_z2	: std_logic_vector(63 downto 0) := 64d"18445829279364155008";
		init_z3	: std_logic_vector(63 downto 0) := 64d"18436106298727503359"
	);
	port
	(
		--port assignments
		i_clk					: in std_logic;
		i_rst					: in std_logic;
		i_enable				: in std_logic;
		o_valid					: out std_logic;
		o_data					: out std_logic_vector(63 downto 0)
	);
end rng;

architecture rtl of rng is
	signal z1 			: std_logic_vector(63 downto 0);
	signal z2 			: std_logic_vector(63 downto 0);
	signal z3 			: std_logic_vector(63 downto 0);
	signal z1_next 	: std_logic_vector(63 downto 0);
	signal z2_next 	: std_logic_vector(63 downto 0);
	signal z3_next 	: std_logic_vector(63 downto 0);
	
	
begin
	
	z1_next <= z1(39 downto 1) & (z1(58 downto 34) xor z1(63 downto 39));
	z2_next <= z2(50 downto 6) & (z2(44 downto 26) xor z2(63 downto 45));
	z3_next <= z3(56 downto 9) & (z3(39 downto 24) xor z3(63 downto 48));	
	
	process (i_clk, i_rst)
	begin
		if(i_rst='1') then
			--reset statements
			o_valid <='0';
			o_data <= (others=>'0');
			z1 <= init_z1;
			z2 <= init_z2;
			z3 <= init_z3;
		elsif (i_clk'event and i_clk = '1') then
		--main function statements
			o_valid <=i_enable;
			if(i_enable='1') then
			o_data <= z1_next xor z2_next xor z3_next;
			z1 <= z1_next;
			z2 <= z2_next;
			z3 <= z3_next;
			end if;
		end if;
	end process;
end rtl;
