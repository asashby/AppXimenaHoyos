class MPResponse {
   final String sandboxInitPoint; 
   final String clientId;
   
   MPResponse(this.sandboxInitPoint, this.clientId); 
   factory MPResponse.fromMap(Map<String, dynamic> json) { 
      return MPResponse( 
         json['sandbox_init_point'], 
         json['client_id']
      );
   }
}