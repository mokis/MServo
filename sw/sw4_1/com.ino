#include <EEPROM.h>

int com_state = 0;

void serial_com() {
  int id = 0;
  int len = 0;
  int addr2 = 0;
  byte value[4];
  byte run_loop = 0;

  if (Serial.available()) {
    run_loop = 1;
  }

  while (run_loop) {
    if (com_state == 0 && Serial.available()) {
      id = Serial.read();
      com_state = 1;
    } 
    
    if (com_state == 1 && Serial.available()) {
      len = Serial.read();
      com_state = 2;
    } 
    
    if (com_state == 2 && Serial.available()) {
      addr2 = addr2 + (Serial.read());
      com_state = 3;
    } 
    
    if (com_state == 3 && Serial.available()) {
      addr2 = addr2 + (Serial.read() << 8);
      if (id < 64) {
        com_state = 4;     // read value
      } else {
        com_state = 5;     // write value
      } 
    } 
    
    if (com_state == 4) {
  
      Serial.write(id);
      Serial.write(len);
            
      if (id < 9) {
        
        // disable interrupts, should prevent data corruption
        noInterrupts();
      
        // read len bytes from memory
        for (int i = 0; i < len; i++) {
          value[i] = *(byte*)addr2;
          addr2++;
        }
        
        interrupts();
      
      } else {
       
        // read len bytes from eeprom
        for (int i = 0; i < len; i++) {
          value[i] = EEPROM.read(addr2);
          addr2++;
        }  
      }
      
      // write bytes to serial
      for (int i = 0; i < len; i++) {
        Serial.write( value[i] );
      }   
      com_state = 0; 
      break;  
    } 
    
    if (com_state == 5 && Serial.available()) {
      value[0] = Serial.read();
      
      if (len > 1) {
        com_state = 6;
      } else {
        com_state = 9;
      }
    }
      
    if (com_state == 6 && Serial.available()) {
      value[1] = Serial.read();
      if (len > 2) {
        com_state = 7;
      } else {
        com_state = 9;
      }
    }   
   
    if (com_state == 7 && Serial.available()) {
      value[2] = Serial.read(); 
      com_state = 8; 
    }
     
    if (com_state == 8 && Serial.available()) {
      value[3] = Serial.read(); 
      com_state = 9; 
    }    
    
    if (com_state == 9) {
      // disable interrupts, should prevent data corruption
      
      if (id < 72) {
      
        noInterrupts();
    
        // write len bytes to memory
        for (int i = 0; i < len; i++) {
          *(byte*)addr2 = value[i];
          addr2++;
        }    
        interrupts();
        
      } else {
        
        // write len bytes to eeprom
        for (int i = 0; i < len; i++) {
          EEPROM.write(addr2, value[i]);
          addr2++;
        }   
      }     
        
      
      Serial.write(id);
      Serial.write(len);
      
      com_state = 0;  
      break;
    }
  }
}
