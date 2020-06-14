LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY test IS
END test;
 
ARCHITECTURE behavior OF test IS 
    COMPONENT Transceiver
    PORT(
         RXD : IN  std_logic;
         DSR : IN  std_logic;
         CTS : IN  std_logic;
         DCD : IN  std_logic;
         clk : IN  std_logic;
         enable : IN  std_logic;
         Data : IN  std_logic_vector(7 downto 0);
         TXD : OUT  std_logic;
         DTR : OUT  std_logic;
         RTS : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal RXD : std_logic := '0';
   signal DSR : std_logic := '0';
   signal CTS : std_logic := '0';
   signal DCD : std_logic := '0';
   signal clk : std_logic := '0';
   signal enable : std_logic := '0';
   signal Data : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal TXD : std_logic;
   signal DTR : std_logic;
   signal RTS : std_logic;
	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Transceiver PORT MAP (
          RXD => RXD,
          DSR => DSR,
          CTS => CTS,
          DCD => DCD,
          clk => clk,
          enable => enable,
          Data => Data,
          TXD => TXD,
          DTR => DTR,
          RTS => RTS);
process begin
clk<='0';
wait for 1 ns;
clk<='1';
wait for 1 ns;
end process;

process begin
enable<='1';
data<= x"4A";
wait for 1 ns;
Dsr<='1';
wait for 2 ns;
Cts<='1';
wait;
end process;
END;