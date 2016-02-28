library IEEE, STD;
use STD.textio.all;
--use WORK.std_logic_textio.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;


entity mu0_tb is
  generic (
    MAXWIDTH : integer := 16;
    MAXDEPTH : integer := 12
  );
end mu0_tb;

architecture tb_arch of mu0_tb is
  component mu0
    generic (
      MAXWIDTH : integer := 16;
      MAXDEPTH : integer := 12
    );
    port (
      clk      : in  std_logic;
      reset    : in  std_logic;
      pc       : out std_logic_vector(MAXWIDTH-1 downto 0);
      ir       : out std_logic_vector(MAXWIDTH-1 downto 0);
      acc      : out std_logic_vector(MAXWIDTH-1 downto 0)
    );
  end component;
  signal clk   : std_logic;
  signal reset : std_logic;
  signal pc    : std_logic_vector(MAXWIDTH-1 downto 0);
  signal ir    : std_logic_vector(MAXWIDTH-1 downto 0);
  signal acc   : std_logic_vector(MAXWIDTH-1 downto 0);
  -- Profiling signals.
  signal ncycles : integer;
  -- Constant declarations.
  constant CLK_PERIOD : time := 10 ns;
  constant STP        : std_logic_vector(3 downto 0) := "0111"; 
  -- Declare results file.
  file ResultsFile: text open write_mode is "mu0_dump.txt";
begin

  uut : mu0
    generic map (
      MAXWIDTH => MAXWIDTH,
      MAXDEPTH => MAXDEPTH
    )
    port map (
      clk      => clk,
      reset    => reset,
      pc       => pc,
      ir       => ir,
      acc      => acc
    );

  CLK_GEN_PROC: process(clk)
  begin
    if (clk = 'U') then
      clk <= '1';
    else
      clk <= not clk after CLK_PERIOD/2;
    end if;
  end process CLK_GEN_PROC;

  RESET_STIM: process
  begin
    reset <= '1';
    wait for CLK_PERIOD;
    reset <= '0';
    wait for 536870911*CLK_PERIOD;
  end process RESET_STIM;

  PROFILING: process(clk, reset)
  begin
    if (reset = '1') then
      ncycles <= 0;
    elsif (rising_edge(clk)) then
      ncycles <= ncycles + 1;
    end if;
  end process PROFILING;

  MU0_BENCH: process(ir)
  begin
    -- Detect STOP/STP opcode.
    if (ir(MAXWIDTH-1 downto MAXWIDTH-4) = STP) then
      -- Automatic end of the current simulation.
      assert false
        report "NONE: End simulation time reached."
        severity failure;
    end if;
  end process MU0_BENCH;

end tb_arch;
