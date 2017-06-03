/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sys.classes;

/**
 *
 * @author Michael Mukolwe
 */
import java.net.InetAddress;

public class GetLocation {

    public InetAddress run() throws Exception {
        /* public static InetAddress getLocalHost()
       * throws UnknownHostException: Returns the address 
       * of the local host. This is achieved by retrieving 
       * the name of the host from the system, then resolving 
       * that name into an InetAddress. Note: The resolved 
       * address may be cached for a short period of time.
         */
        InetAddress myIP = InetAddress.getLocalHost();

        /* public String getHostAddress(): Returns the IP 
       * address string in textual presentation.
         */
        return myIP;
    }

}
