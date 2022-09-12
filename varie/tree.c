/* https://stackoverflow.com/questions/36511651/recursive-listing-of-directories-and-files-c */
/* https://github.com/csunibo/sistemi-operativi/blob/main/prove/pratica/scritto-2022-07-22-testo.pdf */
#include <dirent.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>

void list_dir(int dirfd, int indent) {
/* void list_dir(char *path, int indent) { */
  struct dirent *entry;
  DIR *dir = fdopendir(dirfd);
  /* DIR *dir = opendir(path); */

  if (dir == NULL) {
    printf("Failed to open directory.\n");
    return;
  }
  while ((entry = readdir(dir)) != NULL) {
    if(entry->d_type == DT_DIR) {
      if (strcmp(entry->d_name, ".") != 0 && strcmp(entry->d_name, "..") != 0) {

	for(int i=0; i < indent; i++) printf("\t");
        printf("%s\n", entry->d_name);

        /* char *new_path = (char *)malloc(strlen(path) + strlen(entry->d_name) + 1); */

        /* sprintf(new_path, "%s/%s", path, entry->d_name); */
        int newDirfd = openat(dirfd, entry->d_name, O_RDONLY);
        list_dir(newDirfd, indent + 1);

        /* free(new_path); */
      }
    }else {
		for(int i=0; i < indent; i++) printf("\t");
		    printf("%s\n", entry->d_name);
	}
  }
    closedir(dir);
}

int main(int argc, char **argv) {
  if(argc < 2){
  	printf("Bad usage\n");
  }
  else{
	printf("Current directory structure:\n");
    int fd = openat(AT_FDCWD, argv[1], O_RDONLY);
    printf("%d\n", fd);

    list_dir(fd, 0);
  	/* list_dir(argv[1], 0); */
  }
  return 0;
}
