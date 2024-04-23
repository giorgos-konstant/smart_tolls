from smartcard.System import readers
from smartcard.util import toHexString
import py_acr122u as nfc

def connect_to_reader():
    r = readers()
    if not r:
        raise Exception("No Readers Found.")
    
    reader = r[0]
    print("Using reader: ",reader)
    connection = reader.CreateConnection()
    connection.connect()
    return connection

def read_card(connection):
    READ_COMMAND = [0xFF,0xB0,0x00,0x10]
    data,sw1,sw2 = connection.transmit(READ_COMMAND)
    if sw1 == 0x90 and sw2 == 0x00:
        print("Read succesfull: ",toHexString(data))
    else:
        print("Failed to read card.")


def write_card(connection):

    WRITE_COMMAND = [0xFF,0xD6,0x00,0x08,0x10] + [0x30]*16
    data,sw1,sw2 = connection.transmit(WRITE_COMMAND)
    if sw1 == 0x90 and sw2 == 0x00:
        print("Write successfull.")
    else:
        print("Failed to write to card")

def main():
    try:
        conn = connect_to_reader()
        read_card(conn)
        write_card(conn)
    except Exception as e:
        print("Error occured:", str(e))

if __name__ == "__main__":
    main()