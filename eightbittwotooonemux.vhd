LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY eightbittwotoonemux IS
PORT(
	w0 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	w1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	s : IN STD_LOGIC;
	f : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END eightbittwotoonemux;

architecture rtl of eightbittwotoonemux is
SIGNAL int_t1, int_t2 : STD_LOGIC_VECTOR(7 DOWNTO 0); 
begin
	
	int_t1(0) <= w0(0) and not s;
	int_t2(0) <= w1(0) and s;
	
	int_t1(1) <= w0(1) and not s;
	int_t2(1) <= w1(1) and s;
	
	int_t1(2) <= w0(2) and not s;
	int_t2(2) <= w1(2) and s;
	
	int_t1(3) <= w0(3) and not s;
	int_t2(3) <= w1(3) and s;
	
	int_t1(4) <= w0(4) and not s;
	int_t2(4) <= w1(4) and s;
	
	int_t1(5) <= w0(5) and not s;
	int_t2(5) <= w1(5) and s;
	
	int_t1(6) <= w0(6) and not s;
	int_t2(6) <= w1(6) and s;
	
	int_t1(7) <= w0(7) and not s;
	int_t2(7) <= w1(7) and s;

	f <= int_t1 or int_t2;
end rtl;