library ieee;
use ieee.std_logic_1164.ALL;
 
 
entity test is
end test;
 
architecture behavior of test is

  component Transceiver is 
      port ( RXD, DSR, CTS, DCD, clk, enable: in std_logic;
             Data: in std_logic_vector(7 downto 0);
             TXD: out std_logic := '1';
             DTR, RTS: out std_logic);
  end component;
    

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
	
  begin
 
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

    process 
        begin

        clk <= '0';
        wait for 1 ns;

        clk< = '1';
        wait for 1 ns;

    end process;

    process 
        begin

        enable <= '1';
        data <= x"4A";
        wait for 1 ns;

        Dsr<='1';
        wait for 2 ns;

        Cts<='1';
        wait;

    end process;
end behavior;