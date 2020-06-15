library ieee;
use ieee.std_logic_1164.ALL;
 
entity simulacion is
end simulacion;
 
architecture behavior of simulacion is

    --Añadimos componente del Transceiver
    component Transceiver is
        port ( RXD,DSR,CTS,DCD,clk,enable: in std_logic;
            Data: in std_logic_vector(7 downto 0);
            TXD: out std_logic:='1';
            DTR,RTS: out std_logic);
    end component;

    --Añadimos componente del Receiver
    component Receiver is
        port ( RXD,DSR,CTS,DCD,clk,enable: in std_logic;
            Data: in std_logic_vector(7 downto 0);
            TXD: out std_logic:='1';
            DTR,RTS: out std_logic);
    end component; 

    --Ponemos las señales que se van a usar
    signal tRXD,tDSR,tCTS,tDCD,tTXD,tDTR,tRTS: std_logic;
    signal tData : std_logic_vector(7 downto 0) := (others => '0');
    signal tEnable:std_logic := '1';
    signal clk:std_logic := '0';

    --Estructuramos el mensaje que queremos mandar
    type code_type is array (natural range <>) of std_logic_vector(7 downto 0);
    constant codes : code_type := ( x"48", x"4F",x"4C",x"41"); --envia mensaje de hola

    begin
        -- Porteamos los dos componentes
        t: Transceiver port map(tRXD,tDSR,tCTS,tDCD,clk,tEnable,tData,tTXD,tDTR,tRTS);
        r: Receiver port map(tTXD,tDTR,tRTS,tDCD,clk,tEnable,tData,tRXD,tDSR,tCTS);

        clk <= not clk after 1 ns;

        process
            --cada que se mande a llamar e procedure es cuando el Transceiver va a mandar información
            procedure send_code(data: std_logic_vector(7 downto 0)) is
                begin

                    tData <= Data;
                    wait for 26 ns;

            end procedure send_code;

            begin

                wait for 4 ns;
                
                for i in codes'range loop
                    send_code(codes(i));
                end loop;

        end process;

end behavior;