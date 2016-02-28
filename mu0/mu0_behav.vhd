library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mu0 is
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
end entity mu0;

architecture behavioral of mu0 is 
  -- Type declarations
  type mem_type is array(0 to 2**MAXDEPTH-1) of 
    std_logic_vector(MAXWIDTH-1 downto 0);
  -- According to XST User Manual, v14.1, p. 239
  impure function InitRamFromFile (RamFileName : in string) 
    return mem_type is
    FILE RamFile : text is in RamFileName;
    variable RamFileLine : line;
    variable ram : mem_type;
  begin
    for i in mem_type'RANGE loop
      readline(RamFile, RamFileLine);
      read(RamFileLine, ram(i));
    end loop;
    return ram;
  end function;
  -- Constant declarations
  constant LDA : std_logic_vector(to_unsigned(0,MAXWIDTH-12)); 
  constant STO : std_logic_vector(to_unsigned(1,MAXWIDTH-12)); 
  constant ADD : std_logic_vector(to_unsigned(2,MAXWIDTH-12)); 
  constant SUB : std_logic_vector(to_unsigned(3,MAXWIDTH-12)); 
  constant JMP : std_logic_vector(to_unsigned(4,MAXWIDTH-12)); 
  constant JGE : std_logic_vector(to_unsigned(5,MAXWIDTH-12)); 
  constant JNE : std_logic_vector(to_unsigned(6,MAXWIDTH-12)); 
  constant STP : std_logic_vector(to_unsigned(7,MAXWIDTH-12)); 
  -- Signal declarations
  signal opcode  : std_logic_vector(MAXWIDTH-1 downto MAXWIDTH-4);
  signal address : std_logic_vector(MAXWIDTH-5 downto 0);
  -- Initialize memory using impure function.
  signal mem     : mem_type := InitRamFromFile("prog.lst");
  signal pc_reg  : std_logic_vector(MAXWIDTH-1 downto 0);
  signal ir_reg  : std_logic_vector(MAXWIDTH-1 downto 0);
  signal acc_reg : std_logic_vector(MAXWIDTH-1 downto 0);
begin

  -- Synchronous logic
  process (clk)
  begin
    if (rising_edge(clk)) then
      if (reset = '1') then
        pc_reg  <= (others => '0');
        ir_reg  <= (others => '0');
        acc_reg <= (others => '0');
      else
        ir_reg  <= mem(to_integer(unsigned(pc));
        if (ir_reg(MAXWIDTH-1 downto MAXWIDTH-4) /= STP) then
          pc_reg <= pc_reg + '1';
        end if;
      end if;
    end if;
  end process;
  
  -- ALU logic (combinational)
  process (opcode, address, ir_reg, pc_reg, acc_reg)
  begin
    opcode  <= ir_reg(MAXWIDTH-1 downto MAXWIDTH-4);
    address <= ir_reg(MAXWIDTH-5 downto 0);
    case (opcode) is
      when LDA => 
        acc_reg <= mem(to_integer(unsigned(address));
      when STO =>
        mem(to_integer(unsigned(address)) <= acc_reg;
      when ADD =>
        acc_reg <= acc_reg + mem(to_integer(unsigned(address));
      when SUB =>
        acc_reg <= acc_reg - mem(to_integer(unsigned(address));
      when JMP =>
        pc_reg  <= (MAXWIDTH-1 downto MAXWIDTH-5 => '0') & address;
      when JNE =>
        if (acc_reg = std_logic_vector(to_unsigned(0,MAXWIDTH-12))) then
          pc_reg <= (MAXWIDTH-1 downto MAXWIDTH-5 => '0') & address;
        end if;
      when JGE =>
        if (acc_reg /= std_logic_vector(to_unsigned(0,MAXWIDTH-12))) then
          pc_reg <= (MAXWIDTH-1 downto MAXWIDTH-5 => '0') & address;
        end if;
      when STP =>
        pc_reg <= pc_reg;
      when others =>
        pc_reg <= pc_reg;
    end case opcode;
    
  -- Assign outputs
  pc  <= pc_reg;
  ir  <= ir_reg;
  acc <= acc_reg;

end architecture behavioral;
