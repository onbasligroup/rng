-- ===============================================================================================
-- (C) COPYRIGHT 2020 Koç University - Magnonic and Photonic Devices Research Group
-- All rights reserved.
-- ===============================================================================================
-- Creator: bugra
-- ===============================================================================================
-- Project           : rng
-- File ID           : rng
-- Design Unit Name  :
-- Description       :
-- Comments          :
-- Revision          : %%
-- Last Changed Date : %%
-- Last Changed By   : %%
-- Designer
--          Name     : Altuğ Somay, Buğra Tufan
--          E-mail   : asomay@ku.edu.tr, btufan21@ku.edu.tr
-- ===============================================================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rng is
	generic(
		--generic assignments
		output_size : integer range 1 to 64 := 64;
		init_z1	    : std_logic_vector(63 downto 0) := x"47254A8B5C3C2584";
		init_z2	    : std_logic_vector(63 downto 0) := x"6304A1B3DD89371A";
		init_z3	    : std_logic_vector(63 downto 0) := x"86946AA1B5F542B1"
	);
	port(
		--port assignments
		i_clk					  : in std_logic;
		i_rst				  	: in std_logic;
		i_enable				: in std_logic;
		o_valid					: out std_logic;
		o_data					: out std_logic_vector(output_size-1 downto 0)
	);
end entity;

architecture arch of rng is
	signal z1 			: std_logic_vector(63 downto 0);
	signal z2 			: std_logic_vector(63 downto 0);
	signal z3 			: std_logic_vector(63 downto 0);
	signal z1_next 	: std_logic_vector(63 downto 0);
	signal z2_next 	: std_logic_vector(63 downto 0);
	signal z3_next 	: std_logic_vector(63 downto 0);
	signal data 	  : std_logic_vector(63 downto 0);

begin
	z1_next <= z1(39 downto 1) & (z1(58 downto 34) xor z1(63 downto 39));
	z2_next <= z2(50 downto 6) & (z2(44 downto 26) xor z2(63 downto 45));
	z3_next <= z3(56 downto 9) & (z3(39 downto 24) xor z3(63 downto 48));
	o_data <= data(output_size-1 downto 0);

	process (i_clk, i_rst)
	begin
		if(i_rst='1') then
			--reset statements
			o_valid <='0';
			data <= (others=>'0');
			z1 <= init_z1;
			z2 <= init_z2;
			z3 <= init_z3;
		elsif (i_clk'event and i_clk = '1') then
			--main function statements
			o_valid <=i_enable;
			if(i_enable='1') then
				data <= z1_next xor z2_next xor z3_next;
				z1 <= z1_next;
				z2 <= z2_next;
				z3 <= z3_next;
			end if;
		end if;
	end process;
end architecture;
