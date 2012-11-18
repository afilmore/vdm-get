/***********************************************************************************************************************
 * 
 *      Application.vala
 * 
 *      Copyright 2012 Axel FILMORE <axel.filmore@gmail.com>
 * 
 *      This program is free software; you can redistribute it and/or modify
 *      it under the terms of the GNU General Public License Version 2.
 *      http://www.gnu.org/licenses/gpl-2.0.txt
 * 
 * 
 * 
 *      Purpose:
 * 
 * 
 * 
 **********************************************************************************************************************/
private static int main (string [] args) {
    
    const string HTML_OUTPUT = "/tmp/vdm.html";
    
    string cmd = "wget -q -O %s \"%s\"".printf (HTML_OUTPUT, "http://www.viedemerde.fr/aleatoire");
    try {
        
        Process.spawn_command_line_sync (cmd);
    
    } catch (Error error) {
    }
    
    string buffer = "";
    File file = File.new_for_path (HTML_OUTPUT);
    try {
        
        if (file.query_exists () == true){
            
            DataInputStream input_stream = new DataInputStream (file.read ());
            
            // Read lines until end of file (null) is reached...
            string line;
            while ((line = input_stream.read_line (null)) != null) {
                
                buffer += line;
            }
        }
        
    } catch (Error error) {
        
        print ("Error: %s\n", error.message);
        return 1;
    }
    
    //~ var doc = Html.Doc.parse_file (HTML_OUTPUT, "utf-8");
    var doc = Html.Doc.read_doc (buffer, "", "utf-8", Xml.ParserOption.RECOVER
                                                      | Xml.ParserOption.NOERROR
                                                      | Xml.ParserOption.NOWARNING);
    
    if (doc == null)
        return 1;
    
    if (doc->last == null) {
        
        print ("last = null\n");
        delete doc;
        return 1;
    }

    Xml.Node *article_node = find_article_div (doc->last);
    if (article_node == null) {
        
        print ("not found\n");
        delete doc;
        return 1;
    }
    
    string content = get_article_div_text (article_node);
    write_content (content);
    print ("%s\n", content);
    
    delete doc;
    
    return 0;
}


// Finds the <div> node which class is "post article"...
private Xml.Node* find_article_div (Xml.Node *node) {
    
    while (node != null) {
    
        if (get_div_attr (node, "class") == "post article") {
            
            return node;
        }
    
        if (node->children != null) {
            
            Xml.Node *nnode = find_article_div (node->children);
            if (nnode != null)
                return nnode;
        }
    
        node = node->next;
    }
    
    return null;
}

// Returns the value of a given node attribute attr_name...
private string get_div_attr (Xml.Node *div, string attr_name) {
    
    Xml.Attr* property = div->properties;
    
    while (property != null) {
    
        if (property->name == attr_name) {
        
            if (property->children != null)
                break;
        
        }
        
        property = property->next;
    }
    
    if (property == null)
        return "";
    
    else if (property->children == null)
        return "";
    
    else if (property->children->content == null)
        return "";
        
    return property->children->content;
}

// Gets the text from the "post article" node retrieved with find_article_div...
private string get_article_div_text (Xml.Node *article_div) {
    
    string ret = "";
    
    Xml.Node *p_child = article_div->children;
    
    if (p_child == null)
        return ret;
    
    Xml.Node *child = p_child->children;
    
    while (child != null) {
    
        if (child->name == "a") {
            
            Xml.Node *text = child->children;
            
            if (text != null) {
                
                if (text->content != null) {
                    
                    ret += text->content;
                }
            }
            
        }
    
        child = child->next;
    }
    
    return ret;
}

private void write_content (string content) {
    
    DataOutputStream output_stream = null;
    
    try {
        
        File file = File.new_for_path (Environment.get_home_dir () + "/vdm.txt");
        
        // Delete the file if there's already one...
        if (file.query_exists ()) {
            
                file.delete ();
        }
        
        output_stream = new DataOutputStream (
            file.create (FileCreateFlags.REPLACE_DESTINATION)
        );
            
            
    } catch (Error error) {
        
    }
    
    try {
        
        output_stream.put_string (content);
        
    } catch (IOError error) {
        
        return;
    }
}




