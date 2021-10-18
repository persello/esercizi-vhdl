#include <stdio.h>
#include <unistd.h>

/**
 *
 * Differential equation solver.
 * y'' + 3xy'+ 3y = 0
 *
 * x(0) = 0
 * y(0) = y
 * y'(0) = u
 * range [x, a]
 *
 */

int main(int argc, char **argv) {

  const char usage[] = "Usage: -x <x0> -y <y0> -u <u0>, -d <dx> -a <a>";

  char f;

  float x, y, u, dx, a;
  x = y = u = dx = a = 0;

  unsigned int xd, yd, ud, dxd, ad;
  xd = yd = ud = dxd = ad = 0;

  while ((f = getopt(argc, argv, "hx:y:u:d:a:")) != -1) {
    switch (f) {
    case 'x':
      if (xd == 0) {
        xd = 1;
        if (sscanf(optarg, "%f", &x) != 1) {
          fprintf(stderr, "Error: Invalid x0\n");
          fprintf(stderr, "%s\n", usage);
          return 1;
        }
      }
      break;
    case 'y':
      if (yd == 0) {
        yd = 1;
        if (sscanf(optarg, "%f", &y) != 1) {
          fprintf(stderr, "Error: Invalid y0\n");
          fprintf(stderr, "%s\n", usage);
          return 1;
        }
      }
      break;
    case 'u':
      if (ud == 0) {
        ud = 1;
        if (sscanf(optarg, "%f", &u) != 1) {
          fprintf(stderr, "Error: Invalid u0\n");
          fprintf(stderr, "%s\n", usage);
          return 1;
        }
      }
      break;
    case 'd':
      if (dxd == 0) {
        dxd = 1;
        if (sscanf(optarg, "%f", &dx) != 1) {
          fprintf(stderr, "Error: Invalid dx\n");
          fprintf(stderr, "%s\n", usage);
          return 1;
        }
      }
      break;
    case 'a':
      if (ad == 0) {
        ad = 1;
        if (sscanf(optarg, "%f", &a) != 1) {
          fprintf(stderr, "Error: Invalid a\n");
          fprintf(stderr, "%s\n", usage);
          return 1;
        }
      }
      break;
    case 'h':
      printf("%s\n", usage);
      return 0;
    }
  }

  unsigned int done = xd * yd * ud * dxd * ad;
  if (done != 1) {
    fprintf(stderr, "Error: Invalid arguments\n");
    fprintf(stderr, "%s\n", usage);
    return 1;
  }

  printf("x: %f, y: %f, u: %f, dx: %f, a: %f\n", x, y, u, dx, a);

  int c = 1;
  float xl, yl, ul;
  while (c) {
    xl = x + dx;
    ul = u - (3 * x * u * dx) - (3 * y * dx);
    yl = y + (u * dx);
    c = x < a;
    x = xl;
    y = yl;
    u = ul;
    printf("%f\t%f\n", x, y);
  }
}