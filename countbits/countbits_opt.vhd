-- http://noasic.com/blog/move-those-conditions-out-of-those-loops/
library IEEE;
use IEEE.std_logic_1164.all;

entity countbits is
  generic (
    DATA_WIDTH : natural := 4
  );
  port (
    clk        : in  std_logic;
    data       : in  std_logic_vector(DATA_WIDTH-1 downto 0);
    ones       : out natural range 0 to DATA_WIDTH
  );
end entity countbits;

architecture rtl of countbits is
begin
  COUNT_BITS: process(clk) is
    variable v_count : natural range 0 to DATA_WIDTH;
  begin
    if rising_edge(clk) then
      v_count := 0;
      for i in 0 to DATA_WIDTH-1 loop
        v_count := v_count + to_integer(unsigned(data(i downto i)));
      end loop;
      ones <= v_count;
    end if;
  end process COUNT_BITS;

end architecture rtl;
