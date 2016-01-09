my @currentFolder = <*>;

$sevenZip="\"C:\\Program Files (x86)\\7-Zip\\7z.exe\"";

sub processFolder()
{
   my $folder = "@_";

   my @fileList = <"$folder/*">;

   print "Process folder: $folder\n";
   
   foreach my $file (@fileList)
   {
      if( -d "$file" )
      {
         print "Processing folder: $file\n";
         processFolder("$folder/$file");
      }
	  else
	  {
         print "Processing file: $file\n";
         unCompressFile("$folder/$file");	  
	  }
   }
}

sub unCompressFile()
{
   my $file = "@_";
   print "uncompress $file\n";
   print `$sevenZip x -y \"$file\"\n` . "\n";
}
   
	  