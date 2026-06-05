#include "glib-object.h"
#include <gtk/gtk.h>

static void clicked(GtkWidget* widget, gpointer data) {
    g_print("Button clicked!\n");
}

static void activate(GtkApplication* app, gpointer data) {
    GtkWidget* window;
    GtkWidget* button;

    window = gtk_application_window_new(app);
    gtk_window_set_title(GTK_WINDOW(window), "Buttons");
    gtk_window_set_default_size(GTK_WINDOW(window), 400, 300);
    
    button = gtk_button_new_with_label("click me");
    g_signal_connect(button, "clicked", G_CALLBACK(clicked), NULL);
    gtk_window_set_child(GTK_WINDOW(window), button);

    gtk_widget_set_visible(window, 1);
}

int main(int argc, char** argv) {
    GtkApplication* app;

    app = gtk_application_new(
        "com.example.test",
        G_APPLICATION_DEFAULT_FLAGS
        );
    g_signal_connect(
        app,
        "activate",
        G_CALLBACK(activate),
        NULL
        );

    int status = g_application_run(
        G_APPLICATION(app),
        argc,
        argv
        );
    g_object_unref(app);

    return status; 
}
