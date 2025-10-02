library ieee;
use ieee.std_logic_1164.all;

entity datapath is
  port(
    clock : in  std_logic;
    selDisplayA, selDisplayB, loadDisplay : in  std_logic;
    loadLMask, lMaskShiftLeft : in  std_logic;
    loadRMask, rMaskShiftRight : in  std_logic;
    o_display : out std_logic_vector(7 downto 0)
  );
end entity;

architecture rtl of datapath is

  -- 4-to-1 8-bit mux component (assumed to exist)
  component eightbitfourtoonemux
    port(
      w0 : in  std_logic_vector(7 downto 0);
      w1 : in  std_logic_vector(7 downto 0);
      w2 : in  std_logic_vector(7 downto 0);
      w3 : in  std_logic_vector(7 downto 0);
      s0 : in  std_logic;
      s1 : in  std_logic;
      f  : out std_logic_vector(7 downto 0)
    );
  end component;

  -- 8-bit shift-register (structural) component (assumed to exist)
  component eightBitShiftRegisterStructural
    port(
      i_resetBar  : in  std_logic;
      i_load      : in  std_logic;
      i_shiftLeft : in  std_logic;
      i_shiftRight: in  std_logic;
      i_clock     : in  std_logic;
      i_Value     : in  std_logic_vector(7 downto 0);
      o_Value     : out std_logic_vector(7 downto 0)
    );
  end component;

  signal int_lMaskOut         : std_logic_vector(7 downto 0);
  signal int_rMaskOut         : std_logic_vector(7 downto 0);
  signal int_xorLMaskRMask    : std_logic_vector(7 downto 0);
  signal int_displayMuxOutput : std_logic_vector(7 downto 0);
  constant ZERO_CONST         : std_logic_vector(7 downto 0) := (others => '0');
  constant LMASK_INIT         : std_logic_vector(7 downto 0) := "00000001";
  constant RMASK_INIT         : std_logic_vector(7 downto 0) := "10000000";

begin
  -- compute XOR of masks
  int_xorLMaskRMask <= int_lMaskOut xor int_rMaskOut;

  -- display source mux
  displayMux : eightbitfourtoonemux
    port map(
      w0 => ZERO_CONST,             -- 00 -> ZERO
      w1 => int_xorLMaskRMask,      -- 01 -> XOR (you used XOR in datapath)
      w2 => int_lMaskOut,           -- 10 -> LMASK
      w3 => int_rMaskOut,           -- 11 -> RMASK
      s0 => selDisplayA,
      s1 => selDisplayB,
      f  => int_displayMuxOutput
    );

  -- display register (loads selected source into DISPLAY)
  displayReg : eightBitShiftRegisterStructural
    port map(
      i_resetBar   => '0',          -- tied low in your original code; change as needed
      i_load       => loadDisplay,
      i_shiftLeft  => '0',
      i_shiftRight => '0',
      i_clock      => clock,
      i_Value      => int_displayMuxOutput,
      o_Value      => o_display
    );

  -- LMASK register: loads constant LMASK_INIT when loadLMask asserted, otherwise shifts left when lMaskShiftLeft asserted
  lMaskReg : eightBitShiftRegisterStructural
    port map(
      i_resetBar   => '0',          -- active-low reset pin tied per your original
      i_load       => loadLMask,
      i_shiftLeft  => lMaskShiftLeft,
      i_shiftRight => '0',
      i_clock      => clock,
      i_Value      => LMASK_INIT,
      o_Value      => int_lMaskOut
    );

  -- RMASK register
  rMaskReg : eightBitShiftRegisterStructural
    port map(
      i_resetBar   => '0',
      i_load       => loadRMask,
      i_shiftLeft  => '0',
      i_shiftRight => rMaskShiftRight,
      i_clock      => clock,
      i_Value      => RMASK_INIT,
      o_Value      => int_rMaskOut
    );

end architecture;