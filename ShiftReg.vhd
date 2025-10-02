library ieee;
use ieee.std_logic_1164.all;

entity eightBitShiftRegisterStructural is
  port(
    i_resetBar   : in  std_logic; -- active low synchronous reset
    i_load       : in  std_logic; -- synchronous load when '1'
    i_shiftLeft  : in  std_logic; -- synchronous shift-left when '1'
    i_shiftRight : in  std_logic; -- synchronous shift-right when '1'
    i_clock      : in  std_logic; -- clock
    i_Value      : in  std_logic_vector(7 downto 0); -- load value
    o_Value      : out std_logic_vector(7 downto 0)
  );
end entity;

architecture rtl of eightBitShiftRegisterStructural is
  signal q : std_logic_vector(7 downto 0) := (others => '0');
begin
  process(i_clock)
  begin
    if rising_edge(i_clock) then
      if i_resetBar = '0' then
        q <= (others => '0');
      elsif i_load = '1' then
        q <= i_Value;
      elsif i_shiftLeft = '1' then
        q <= q(6 downto 0) & '0';
      elsif i_shiftRight = '1' then
        q <= '0' & q(7 downto 1);
      else
        q <= q; -- hold
      end if;
    end if;
  end process;

  o_Value <= q;

end architecture;