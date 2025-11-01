----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.05.2025 18:58:59
-- Design Name: 
-- Module Name: MEM - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ID is
  Port (CLK: in STD_LOGIC;
        EN: in STD_LOGIC;
        RegWrite : in STD_LOGIC;
        Instr : in STD_LOGIC_VECTOR(25 downto 0);
        ExtOp : in STD_LOGIC;
        WD : in STD_LOGIC_VECTOR(31 downto 0);
        RD1 : out STD_LOGIC_VECTOR(31 downto 0);
        RD2 : out STD_LOGIC_VECTOR(31 downto 0);
        Ext_Imm : out STD_LOGIC_VECTOR(31 downto 0);
        func : out STD_LOGIC_VECTOR(5 downto 0);
        sa : out STD_LOGIC_VECTOR(4 downto 0);
        WA : in STD_LOGIC_VECTOR(4 downto 0);
        rt : out STD_LOGIC_VECTOR(4 downto 0);
        rd : out STD_LOGIC_VECTOR(4 downto 0));
end ID;

architecture Behavioral of ID is

signal RA1 : STD_LOGIC_VECTOR(4 downto 0);
signal RA2 : STD_LOGIC_VECTOR(4 downto 0);

type reg_array is array(0 to 31) of std_logic_vector(31 downto 0);
signal RF : reg_array :=(others =>X"00000000");

begin

    RA1 <= Instr(25 downto 21);
    RA2 <= Instr(20 downto 16);
    
    process(CLK)
    begin
    if falling_edge(CLK) then
        if EN='1' and RegWrite='1' then RF(conv_integer(WA)) <= WD;
        end if;
    end if;
    end process;
    
    RD1 <= RF(conv_integer(RA1));
    RD2 <= RF(conv_integer(RA2));
    
    Ext_Imm(15 downto 0) <= Instr(15 downto 0);
    Ext_Imm(31 downto 16) <=(others =>Instr(15)) when ExtOp='1' else (others =>'0');
    
    func <= Instr(5 downto 0);
    sa <= Instr(10 downto 6);
    rt <= Instr(20 downto 16);
    rd <= Instr(15 downto 11);
    
end Behavioral;