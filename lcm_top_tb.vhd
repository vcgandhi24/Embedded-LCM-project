
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity lcm_top_tb is
end lcm_top_tb ;

architecture behav of lcm_top_tb is
  constant clockperiod: time:=100 ns;
  signal clk: std_logic:='0';
  signal rst,go_i: std_logic;
  signal d_out: integer;
  signal x_i,y_i: std_logic_vector (3 downto 0);
  component lcm_top
    port(clk,rst,go_i: in std_logic;
         x_i,y_i: in std_logic_vector (3 downto 0);
         d_out: out integer);
  end component ;
  begin
    clk <= not clk after clockperiod /2;
    rst <= '1' , '0' after 70 ns;
    go_i <= '0' ,'1' after 220 ns, '0' after 520 ns;
    x_i <= "0011";
    y_i <= "0101";
    dut: lcm_top port map(clk,rst,go_i,x_i,y_i,d_out);
  end behav;