
_buffer_overflow:     file format elf32-i386


Disassembly of section .text:

00000000 <foo>:
#include "types.h"
#include "user.h"
#include "fcntl.h"

void foo()
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 ec 04             	sub    $0x4,%esp
   7:	e8 b8 00 00 00       	call   c4 <__x86.get_pc_thunk.bx>
   c:	81 c3 1c 0c 00 00    	add    $0xc1c,%ebx
    printf(1, "SECRET_STRING");
  12:	83 ec 08             	sub    $0x8,%esp
  15:	8d 83 00 fd ff ff    	lea    -0x300(%ebx),%eax
  1b:	50                   	push   %eax
  1c:	6a 01                	push   $0x1
  1e:	e8 06 05 00 00       	call   529 <printf>
  23:	83 c4 10             	add    $0x10,%esp
    exit();
  26:	e8 62 03 00 00       	call   38d <exit>

0000002b <vulnerable_func>:
}


void vulnerable_func(char *payload)
{
  2b:	55                   	push   %ebp
  2c:	89 e5                	mov    %esp,%ebp
  2e:	53                   	push   %ebx
  2f:	83 ec 14             	sub    $0x14,%esp
  32:	e8 89 00 00 00       	call   c0 <__x86.get_pc_thunk.ax>
  37:	05 f1 0b 00 00       	add    $0xbf1,%eax
    char buffer[7];
    strcpy(buffer, payload);
  3c:	83 ec 08             	sub    $0x8,%esp
  3f:	ff 75 08             	push   0x8(%ebp)
  42:	8d 55 f1             	lea    -0xf(%ebp),%edx
  45:	52                   	push   %edx
  46:	89 c3                	mov    %eax,%ebx
  48:	e8 ab 00 00 00       	call   f8 <strcpy>
  4d:	83 c4 10             	add    $0x10,%esp
}
  50:	90                   	nop
  51:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  54:	c9                   	leave  
  55:	c3                   	ret    

00000056 <main>:

int main(int argc, char *argv[])
{
  56:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  5a:	83 e4 f0             	and    $0xfffffff0,%esp
  5d:	ff 71 fc             	push   -0x4(%ecx)
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	53                   	push   %ebx
  64:	51                   	push   %ecx
  65:	83 ec 70             	sub    $0x70,%esp
  68:	e8 57 00 00 00       	call   c4 <__x86.get_pc_thunk.bx>
  6d:	81 c3 bb 0b 00 00    	add    $0xbbb,%ebx
    int fd;

    fd = open("payload", O_RDONLY);
  73:	83 ec 08             	sub    $0x8,%esp
  76:	6a 00                	push   $0x0
  78:	8d 83 0e fd ff ff    	lea    -0x2f2(%ebx),%eax
  7e:	50                   	push   %eax
  7f:	e8 49 03 00 00       	call   3cd <open>
  84:	83 c4 10             	add    $0x10,%esp
  87:	89 45 f4             	mov    %eax,-0xc(%ebp)
    char payload[100];

    read(fd, payload, 100);
  8a:	83 ec 04             	sub    $0x4,%esp
  8d:	6a 64                	push   $0x64
  8f:	8d 45 90             	lea    -0x70(%ebp),%eax
  92:	50                   	push   %eax
  93:	ff 75 f4             	push   -0xc(%ebp)
  96:	e8 0a 03 00 00       	call   3a5 <read>
  9b:	83 c4 10             	add    $0x10,%esp

    vulnerable_func(payload);
  9e:	83 ec 0c             	sub    $0xc,%esp
  a1:	8d 45 90             	lea    -0x70(%ebp),%eax
  a4:	50                   	push   %eax
  a5:	e8 81 ff ff ff       	call   2b <vulnerable_func>
  aa:	83 c4 10             	add    $0x10,%esp

    close(fd);
  ad:	83 ec 0c             	sub    $0xc,%esp
  b0:	ff 75 f4             	push   -0xc(%ebp)
  b3:	e8 fd 02 00 00       	call   3b5 <close>
  b8:	83 c4 10             	add    $0x10,%esp
    exit();
  bb:	e8 cd 02 00 00       	call   38d <exit>

000000c0 <__x86.get_pc_thunk.ax>:
  c0:	8b 04 24             	mov    (%esp),%eax
  c3:	c3                   	ret    

000000c4 <__x86.get_pc_thunk.bx>:
  c4:	8b 1c 24             	mov    (%esp),%ebx
  c7:	c3                   	ret    

000000c8 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  c8:	55                   	push   %ebp
  c9:	89 e5                	mov    %esp,%ebp
  cb:	57                   	push   %edi
  cc:	53                   	push   %ebx
  cd:	e8 ee ff ff ff       	call   c0 <__x86.get_pc_thunk.ax>
  d2:	05 56 0b 00 00       	add    $0xb56,%eax
  asm volatile("cld; rep stosb" :
  d7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  da:	8b 55 10             	mov    0x10(%ebp),%edx
  dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  e0:	89 cb                	mov    %ecx,%ebx
  e2:	89 df                	mov    %ebx,%edi
  e4:	89 d1                	mov    %edx,%ecx
  e6:	fc                   	cld    
  e7:	f3 aa                	rep stos %al,%es:(%edi)
  e9:	89 ca                	mov    %ecx,%edx
  eb:	89 fb                	mov    %edi,%ebx
  ed:	89 5d 08             	mov    %ebx,0x8(%ebp)
  f0:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  f3:	90                   	nop
  f4:	5b                   	pop    %ebx
  f5:	5f                   	pop    %edi
  f6:	5d                   	pop    %ebp
  f7:	c3                   	ret    

000000f8 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  f8:	55                   	push   %ebp
  f9:	89 e5                	mov    %esp,%ebp
  fb:	83 ec 10             	sub    $0x10,%esp
  fe:	e8 bd ff ff ff       	call   c0 <__x86.get_pc_thunk.ax>
 103:	05 25 0b 00 00       	add    $0xb25,%eax
  char *os;

  os = s;
 108:	8b 45 08             	mov    0x8(%ebp),%eax
 10b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 10e:	90                   	nop
 10f:	8b 55 0c             	mov    0xc(%ebp),%edx
 112:	8d 42 01             	lea    0x1(%edx),%eax
 115:	89 45 0c             	mov    %eax,0xc(%ebp)
 118:	8b 45 08             	mov    0x8(%ebp),%eax
 11b:	8d 48 01             	lea    0x1(%eax),%ecx
 11e:	89 4d 08             	mov    %ecx,0x8(%ebp)
 121:	0f b6 12             	movzbl (%edx),%edx
 124:	88 10                	mov    %dl,(%eax)
 126:	0f b6 00             	movzbl (%eax),%eax
 129:	84 c0                	test   %al,%al
 12b:	75 e2                	jne    10f <strcpy+0x17>
    ;
  return os;
 12d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 130:	c9                   	leave  
 131:	c3                   	ret    

00000132 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 132:	55                   	push   %ebp
 133:	89 e5                	mov    %esp,%ebp
 135:	e8 86 ff ff ff       	call   c0 <__x86.get_pc_thunk.ax>
 13a:	05 ee 0a 00 00       	add    $0xaee,%eax
  while(*p && *p == *q)
 13f:	eb 08                	jmp    149 <strcmp+0x17>
    p++, q++;
 141:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 145:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 149:	8b 45 08             	mov    0x8(%ebp),%eax
 14c:	0f b6 00             	movzbl (%eax),%eax
 14f:	84 c0                	test   %al,%al
 151:	74 10                	je     163 <strcmp+0x31>
 153:	8b 45 08             	mov    0x8(%ebp),%eax
 156:	0f b6 10             	movzbl (%eax),%edx
 159:	8b 45 0c             	mov    0xc(%ebp),%eax
 15c:	0f b6 00             	movzbl (%eax),%eax
 15f:	38 c2                	cmp    %al,%dl
 161:	74 de                	je     141 <strcmp+0xf>
  return (uchar)*p - (uchar)*q;
 163:	8b 45 08             	mov    0x8(%ebp),%eax
 166:	0f b6 00             	movzbl (%eax),%eax
 169:	0f b6 d0             	movzbl %al,%edx
 16c:	8b 45 0c             	mov    0xc(%ebp),%eax
 16f:	0f b6 00             	movzbl (%eax),%eax
 172:	0f b6 c8             	movzbl %al,%ecx
 175:	89 d0                	mov    %edx,%eax
 177:	29 c8                	sub    %ecx,%eax
}
 179:	5d                   	pop    %ebp
 17a:	c3                   	ret    

0000017b <strlen>:

uint
strlen(const char *s)
{
 17b:	55                   	push   %ebp
 17c:	89 e5                	mov    %esp,%ebp
 17e:	83 ec 10             	sub    $0x10,%esp
 181:	e8 3a ff ff ff       	call   c0 <__x86.get_pc_thunk.ax>
 186:	05 a2 0a 00 00       	add    $0xaa2,%eax
  int n;

  for(n = 0; s[n]; n++)
 18b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 192:	eb 04                	jmp    198 <strlen+0x1d>
 194:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 198:	8b 55 fc             	mov    -0x4(%ebp),%edx
 19b:	8b 45 08             	mov    0x8(%ebp),%eax
 19e:	01 d0                	add    %edx,%eax
 1a0:	0f b6 00             	movzbl (%eax),%eax
 1a3:	84 c0                	test   %al,%al
 1a5:	75 ed                	jne    194 <strlen+0x19>
    ;
  return n;
 1a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1aa:	c9                   	leave  
 1ab:	c3                   	ret    

000001ac <memset>:

void*
memset(void *dst, int c, uint n)
{
 1ac:	55                   	push   %ebp
 1ad:	89 e5                	mov    %esp,%ebp
 1af:	e8 0c ff ff ff       	call   c0 <__x86.get_pc_thunk.ax>
 1b4:	05 74 0a 00 00       	add    $0xa74,%eax
  stosb(dst, c, n);
 1b9:	8b 45 10             	mov    0x10(%ebp),%eax
 1bc:	50                   	push   %eax
 1bd:	ff 75 0c             	push   0xc(%ebp)
 1c0:	ff 75 08             	push   0x8(%ebp)
 1c3:	e8 00 ff ff ff       	call   c8 <stosb>
 1c8:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1cb:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1ce:	c9                   	leave  
 1cf:	c3                   	ret    

000001d0 <strchr>:

char*
strchr(const char *s, char c)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	83 ec 04             	sub    $0x4,%esp
 1d6:	e8 e5 fe ff ff       	call   c0 <__x86.get_pc_thunk.ax>
 1db:	05 4d 0a 00 00       	add    $0xa4d,%eax
 1e0:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e3:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1e6:	eb 14                	jmp    1fc <strchr+0x2c>
    if(*s == c)
 1e8:	8b 45 08             	mov    0x8(%ebp),%eax
 1eb:	0f b6 00             	movzbl (%eax),%eax
 1ee:	38 45 fc             	cmp    %al,-0x4(%ebp)
 1f1:	75 05                	jne    1f8 <strchr+0x28>
      return (char*)s;
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	eb 13                	jmp    20b <strchr+0x3b>
  for(; *s; s++)
 1f8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1fc:	8b 45 08             	mov    0x8(%ebp),%eax
 1ff:	0f b6 00             	movzbl (%eax),%eax
 202:	84 c0                	test   %al,%al
 204:	75 e2                	jne    1e8 <strchr+0x18>
  return 0;
 206:	b8 00 00 00 00       	mov    $0x0,%eax
}
 20b:	c9                   	leave  
 20c:	c3                   	ret    

0000020d <gets>:

char*
gets(char *buf, int max)
{
 20d:	55                   	push   %ebp
 20e:	89 e5                	mov    %esp,%ebp
 210:	53                   	push   %ebx
 211:	83 ec 14             	sub    $0x14,%esp
 214:	e8 ab fe ff ff       	call   c4 <__x86.get_pc_thunk.bx>
 219:	81 c3 0f 0a 00 00    	add    $0xa0f,%ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 21f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 226:	eb 42                	jmp    26a <gets+0x5d>
    cc = read(0, &c, 1);
 228:	83 ec 04             	sub    $0x4,%esp
 22b:	6a 01                	push   $0x1
 22d:	8d 45 ef             	lea    -0x11(%ebp),%eax
 230:	50                   	push   %eax
 231:	6a 00                	push   $0x0
 233:	e8 6d 01 00 00       	call   3a5 <read>
 238:	83 c4 10             	add    $0x10,%esp
 23b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 23e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 242:	7e 33                	jle    277 <gets+0x6a>
      break;
    buf[i++] = c;
 244:	8b 45 f4             	mov    -0xc(%ebp),%eax
 247:	8d 50 01             	lea    0x1(%eax),%edx
 24a:	89 55 f4             	mov    %edx,-0xc(%ebp)
 24d:	89 c2                	mov    %eax,%edx
 24f:	8b 45 08             	mov    0x8(%ebp),%eax
 252:	01 c2                	add    %eax,%edx
 254:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 258:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 25a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 25e:	3c 0a                	cmp    $0xa,%al
 260:	74 16                	je     278 <gets+0x6b>
 262:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 266:	3c 0d                	cmp    $0xd,%al
 268:	74 0e                	je     278 <gets+0x6b>
  for(i=0; i+1 < max; ){
 26a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 26d:	83 c0 01             	add    $0x1,%eax
 270:	39 45 0c             	cmp    %eax,0xc(%ebp)
 273:	7f b3                	jg     228 <gets+0x1b>
 275:	eb 01                	jmp    278 <gets+0x6b>
      break;
 277:	90                   	nop
      break;
  }
  buf[i] = '\0';
 278:	8b 55 f4             	mov    -0xc(%ebp),%edx
 27b:	8b 45 08             	mov    0x8(%ebp),%eax
 27e:	01 d0                	add    %edx,%eax
 280:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 283:	8b 45 08             	mov    0x8(%ebp),%eax
}
 286:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 289:	c9                   	leave  
 28a:	c3                   	ret    

0000028b <stat>:

int
stat(const char *n, struct stat *st)
{
 28b:	55                   	push   %ebp
 28c:	89 e5                	mov    %esp,%ebp
 28e:	53                   	push   %ebx
 28f:	83 ec 14             	sub    $0x14,%esp
 292:	e8 2d fe ff ff       	call   c4 <__x86.get_pc_thunk.bx>
 297:	81 c3 91 09 00 00    	add    $0x991,%ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 29d:	83 ec 08             	sub    $0x8,%esp
 2a0:	6a 00                	push   $0x0
 2a2:	ff 75 08             	push   0x8(%ebp)
 2a5:	e8 23 01 00 00       	call   3cd <open>
 2aa:	83 c4 10             	add    $0x10,%esp
 2ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2b0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2b4:	79 07                	jns    2bd <stat+0x32>
    return -1;
 2b6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2bb:	eb 25                	jmp    2e2 <stat+0x57>
  r = fstat(fd, st);
 2bd:	83 ec 08             	sub    $0x8,%esp
 2c0:	ff 75 0c             	push   0xc(%ebp)
 2c3:	ff 75 f4             	push   -0xc(%ebp)
 2c6:	e8 1a 01 00 00       	call   3e5 <fstat>
 2cb:	83 c4 10             	add    $0x10,%esp
 2ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2d1:	83 ec 0c             	sub    $0xc,%esp
 2d4:	ff 75 f4             	push   -0xc(%ebp)
 2d7:	e8 d9 00 00 00       	call   3b5 <close>
 2dc:	83 c4 10             	add    $0x10,%esp
  return r;
 2df:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2e5:	c9                   	leave  
 2e6:	c3                   	ret    

000002e7 <atoi>:

int
atoi(const char *s)
{
 2e7:	55                   	push   %ebp
 2e8:	89 e5                	mov    %esp,%ebp
 2ea:	83 ec 10             	sub    $0x10,%esp
 2ed:	e8 ce fd ff ff       	call   c0 <__x86.get_pc_thunk.ax>
 2f2:	05 36 09 00 00       	add    $0x936,%eax
  int n;

  n = 0;
 2f7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2fe:	eb 25                	jmp    325 <atoi+0x3e>
    n = n*10 + *s++ - '0';
 300:	8b 55 fc             	mov    -0x4(%ebp),%edx
 303:	89 d0                	mov    %edx,%eax
 305:	c1 e0 02             	shl    $0x2,%eax
 308:	01 d0                	add    %edx,%eax
 30a:	01 c0                	add    %eax,%eax
 30c:	89 c1                	mov    %eax,%ecx
 30e:	8b 45 08             	mov    0x8(%ebp),%eax
 311:	8d 50 01             	lea    0x1(%eax),%edx
 314:	89 55 08             	mov    %edx,0x8(%ebp)
 317:	0f b6 00             	movzbl (%eax),%eax
 31a:	0f be c0             	movsbl %al,%eax
 31d:	01 c8                	add    %ecx,%eax
 31f:	83 e8 30             	sub    $0x30,%eax
 322:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 325:	8b 45 08             	mov    0x8(%ebp),%eax
 328:	0f b6 00             	movzbl (%eax),%eax
 32b:	3c 2f                	cmp    $0x2f,%al
 32d:	7e 0a                	jle    339 <atoi+0x52>
 32f:	8b 45 08             	mov    0x8(%ebp),%eax
 332:	0f b6 00             	movzbl (%eax),%eax
 335:	3c 39                	cmp    $0x39,%al
 337:	7e c7                	jle    300 <atoi+0x19>
  return n;
 339:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 33c:	c9                   	leave  
 33d:	c3                   	ret    

0000033e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 33e:	55                   	push   %ebp
 33f:	89 e5                	mov    %esp,%ebp
 341:	83 ec 10             	sub    $0x10,%esp
 344:	e8 77 fd ff ff       	call   c0 <__x86.get_pc_thunk.ax>
 349:	05 df 08 00 00       	add    $0x8df,%eax
  char *dst;
  const char *src;

  dst = vdst;
 34e:	8b 45 08             	mov    0x8(%ebp),%eax
 351:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 354:	8b 45 0c             	mov    0xc(%ebp),%eax
 357:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 35a:	eb 17                	jmp    373 <memmove+0x35>
    *dst++ = *src++;
 35c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 35f:	8d 42 01             	lea    0x1(%edx),%eax
 362:	89 45 f8             	mov    %eax,-0x8(%ebp)
 365:	8b 45 fc             	mov    -0x4(%ebp),%eax
 368:	8d 48 01             	lea    0x1(%eax),%ecx
 36b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 36e:	0f b6 12             	movzbl (%edx),%edx
 371:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 373:	8b 45 10             	mov    0x10(%ebp),%eax
 376:	8d 50 ff             	lea    -0x1(%eax),%edx
 379:	89 55 10             	mov    %edx,0x10(%ebp)
 37c:	85 c0                	test   %eax,%eax
 37e:	7f dc                	jg     35c <memmove+0x1e>
  return vdst;
 380:	8b 45 08             	mov    0x8(%ebp),%eax
}
 383:	c9                   	leave  
 384:	c3                   	ret    

00000385 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 385:	b8 01 00 00 00       	mov    $0x1,%eax
 38a:	cd 40                	int    $0x40
 38c:	c3                   	ret    

0000038d <exit>:
SYSCALL(exit)
 38d:	b8 02 00 00 00       	mov    $0x2,%eax
 392:	cd 40                	int    $0x40
 394:	c3                   	ret    

00000395 <wait>:
SYSCALL(wait)
 395:	b8 03 00 00 00       	mov    $0x3,%eax
 39a:	cd 40                	int    $0x40
 39c:	c3                   	ret    

0000039d <pipe>:
SYSCALL(pipe)
 39d:	b8 04 00 00 00       	mov    $0x4,%eax
 3a2:	cd 40                	int    $0x40
 3a4:	c3                   	ret    

000003a5 <read>:
SYSCALL(read)
 3a5:	b8 05 00 00 00       	mov    $0x5,%eax
 3aa:	cd 40                	int    $0x40
 3ac:	c3                   	ret    

000003ad <write>:
SYSCALL(write)
 3ad:	b8 10 00 00 00       	mov    $0x10,%eax
 3b2:	cd 40                	int    $0x40
 3b4:	c3                   	ret    

000003b5 <close>:
SYSCALL(close)
 3b5:	b8 15 00 00 00       	mov    $0x15,%eax
 3ba:	cd 40                	int    $0x40
 3bc:	c3                   	ret    

000003bd <kill>:
SYSCALL(kill)
 3bd:	b8 06 00 00 00       	mov    $0x6,%eax
 3c2:	cd 40                	int    $0x40
 3c4:	c3                   	ret    

000003c5 <exec>:
SYSCALL(exec)
 3c5:	b8 07 00 00 00       	mov    $0x7,%eax
 3ca:	cd 40                	int    $0x40
 3cc:	c3                   	ret    

000003cd <open>:
SYSCALL(open)
 3cd:	b8 0f 00 00 00       	mov    $0xf,%eax
 3d2:	cd 40                	int    $0x40
 3d4:	c3                   	ret    

000003d5 <mknod>:
SYSCALL(mknod)
 3d5:	b8 11 00 00 00       	mov    $0x11,%eax
 3da:	cd 40                	int    $0x40
 3dc:	c3                   	ret    

000003dd <unlink>:
SYSCALL(unlink)
 3dd:	b8 12 00 00 00       	mov    $0x12,%eax
 3e2:	cd 40                	int    $0x40
 3e4:	c3                   	ret    

000003e5 <fstat>:
SYSCALL(fstat)
 3e5:	b8 08 00 00 00       	mov    $0x8,%eax
 3ea:	cd 40                	int    $0x40
 3ec:	c3                   	ret    

000003ed <link>:
SYSCALL(link)
 3ed:	b8 13 00 00 00       	mov    $0x13,%eax
 3f2:	cd 40                	int    $0x40
 3f4:	c3                   	ret    

000003f5 <mkdir>:
SYSCALL(mkdir)
 3f5:	b8 14 00 00 00       	mov    $0x14,%eax
 3fa:	cd 40                	int    $0x40
 3fc:	c3                   	ret    

000003fd <chdir>:
SYSCALL(chdir)
 3fd:	b8 09 00 00 00       	mov    $0x9,%eax
 402:	cd 40                	int    $0x40
 404:	c3                   	ret    

00000405 <dup>:
SYSCALL(dup)
 405:	b8 0a 00 00 00       	mov    $0xa,%eax
 40a:	cd 40                	int    $0x40
 40c:	c3                   	ret    

0000040d <getpid>:
SYSCALL(getpid)
 40d:	b8 0b 00 00 00       	mov    $0xb,%eax
 412:	cd 40                	int    $0x40
 414:	c3                   	ret    

00000415 <sbrk>:
SYSCALL(sbrk)
 415:	b8 0c 00 00 00       	mov    $0xc,%eax
 41a:	cd 40                	int    $0x40
 41c:	c3                   	ret    

0000041d <sleep>:
SYSCALL(sleep)
 41d:	b8 0d 00 00 00       	mov    $0xd,%eax
 422:	cd 40                	int    $0x40
 424:	c3                   	ret    

00000425 <uptime>:
SYSCALL(uptime)
 425:	b8 0e 00 00 00       	mov    $0xe,%eax
 42a:	cd 40                	int    $0x40
 42c:	c3                   	ret    

0000042d <random>:
SYSCALL(random)
 42d:	b8 16 00 00 00       	mov    $0x16,%eax
 432:	cd 40                	int    $0x40
 434:	c3                   	ret    

00000435 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 435:	55                   	push   %ebp
 436:	89 e5                	mov    %esp,%ebp
 438:	53                   	push   %ebx
 439:	83 ec 14             	sub    $0x14,%esp
 43c:	e8 7f fc ff ff       	call   c0 <__x86.get_pc_thunk.ax>
 441:	05 e7 07 00 00       	add    $0x7e7,%eax
 446:	8b 55 0c             	mov    0xc(%ebp),%edx
 449:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 44c:	83 ec 04             	sub    $0x4,%esp
 44f:	6a 01                	push   $0x1
 451:	8d 55 f4             	lea    -0xc(%ebp),%edx
 454:	52                   	push   %edx
 455:	ff 75 08             	push   0x8(%ebp)
 458:	89 c3                	mov    %eax,%ebx
 45a:	e8 4e ff ff ff       	call   3ad <write>
 45f:	83 c4 10             	add    $0x10,%esp
}
 462:	90                   	nop
 463:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 466:	c9                   	leave  
 467:	c3                   	ret    

00000468 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 468:	55                   	push   %ebp
 469:	89 e5                	mov    %esp,%ebp
 46b:	53                   	push   %ebx
 46c:	83 ec 24             	sub    $0x24,%esp
 46f:	e8 58 02 00 00       	call   6cc <__x86.get_pc_thunk.cx>
 474:	81 c1 b4 07 00 00    	add    $0x7b4,%ecx
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 47a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 481:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 485:	74 17                	je     49e <printint+0x36>
 487:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 48b:	79 11                	jns    49e <printint+0x36>
    neg = 1;
 48d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 494:	8b 45 0c             	mov    0xc(%ebp),%eax
 497:	f7 d8                	neg    %eax
 499:	89 45 ec             	mov    %eax,-0x14(%ebp)
 49c:	eb 06                	jmp    4a4 <printint+0x3c>
  } else {
    x = xx;
 49e:	8b 45 0c             	mov    0xc(%ebp),%eax
 4a1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 4a4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 4ab:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4ae:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4b1:	ba 00 00 00 00       	mov    $0x0,%edx
 4b6:	f7 f3                	div    %ebx
 4b8:	89 d3                	mov    %edx,%ebx
 4ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4bd:	8d 50 01             	lea    0x1(%eax),%edx
 4c0:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4c3:	0f b6 94 19 0c 00 00 	movzbl 0xc(%ecx,%ebx,1),%edx
 4ca:	00 
 4cb:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 4cf:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4d2:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4d5:	ba 00 00 00 00       	mov    $0x0,%edx
 4da:	f7 f3                	div    %ebx
 4dc:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4df:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4e3:	75 c6                	jne    4ab <printint+0x43>
  if(neg)
 4e5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4e9:	74 2d                	je     518 <printint+0xb0>
    buf[i++] = '-';
 4eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4ee:	8d 50 01             	lea    0x1(%eax),%edx
 4f1:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4f4:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 4f9:	eb 1d                	jmp    518 <printint+0xb0>
    putc(fd, buf[i]);
 4fb:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
 501:	01 d0                	add    %edx,%eax
 503:	0f b6 00             	movzbl (%eax),%eax
 506:	0f be c0             	movsbl %al,%eax
 509:	83 ec 08             	sub    $0x8,%esp
 50c:	50                   	push   %eax
 50d:	ff 75 08             	push   0x8(%ebp)
 510:	e8 20 ff ff ff       	call   435 <putc>
 515:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 518:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 51c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 520:	79 d9                	jns    4fb <printint+0x93>
}
 522:	90                   	nop
 523:	90                   	nop
 524:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 527:	c9                   	leave  
 528:	c3                   	ret    

00000529 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 529:	55                   	push   %ebp
 52a:	89 e5                	mov    %esp,%ebp
 52c:	53                   	push   %ebx
 52d:	83 ec 24             	sub    $0x24,%esp
 530:	e8 8f fb ff ff       	call   c4 <__x86.get_pc_thunk.bx>
 535:	81 c3 f3 06 00 00    	add    $0x6f3,%ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 53b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 542:	8d 45 0c             	lea    0xc(%ebp),%eax
 545:	83 c0 04             	add    $0x4,%eax
 548:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 54b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 552:	e9 5b 01 00 00       	jmp    6b2 <printf+0x189>
    c = fmt[i] & 0xff;
 557:	8b 55 0c             	mov    0xc(%ebp),%edx
 55a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 55d:	01 d0                	add    %edx,%eax
 55f:	0f b6 00             	movzbl (%eax),%eax
 562:	0f be c0             	movsbl %al,%eax
 565:	25 ff 00 00 00       	and    $0xff,%eax
 56a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 56d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 571:	75 2c                	jne    59f <printf+0x76>
      if(c == '%'){
 573:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 577:	75 0c                	jne    585 <printf+0x5c>
        state = '%';
 579:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 580:	e9 29 01 00 00       	jmp    6ae <printf+0x185>
      } else {
        putc(fd, c);
 585:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 588:	0f be c0             	movsbl %al,%eax
 58b:	83 ec 08             	sub    $0x8,%esp
 58e:	50                   	push   %eax
 58f:	ff 75 08             	push   0x8(%ebp)
 592:	e8 9e fe ff ff       	call   435 <putc>
 597:	83 c4 10             	add    $0x10,%esp
 59a:	e9 0f 01 00 00       	jmp    6ae <printf+0x185>
      }
    } else if(state == '%'){
 59f:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 5a3:	0f 85 05 01 00 00    	jne    6ae <printf+0x185>
      if(c == 'd'){
 5a9:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 5ad:	75 1e                	jne    5cd <printf+0xa4>
        printint(fd, *ap, 10, 1);
 5af:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5b2:	8b 00                	mov    (%eax),%eax
 5b4:	6a 01                	push   $0x1
 5b6:	6a 0a                	push   $0xa
 5b8:	50                   	push   %eax
 5b9:	ff 75 08             	push   0x8(%ebp)
 5bc:	e8 a7 fe ff ff       	call   468 <printint>
 5c1:	83 c4 10             	add    $0x10,%esp
        ap++;
 5c4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5c8:	e9 da 00 00 00       	jmp    6a7 <printf+0x17e>
      } else if(c == 'x' || c == 'p'){
 5cd:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 5d1:	74 06                	je     5d9 <printf+0xb0>
 5d3:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 5d7:	75 1e                	jne    5f7 <printf+0xce>
        printint(fd, *ap, 16, 0);
 5d9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5dc:	8b 00                	mov    (%eax),%eax
 5de:	6a 00                	push   $0x0
 5e0:	6a 10                	push   $0x10
 5e2:	50                   	push   %eax
 5e3:	ff 75 08             	push   0x8(%ebp)
 5e6:	e8 7d fe ff ff       	call   468 <printint>
 5eb:	83 c4 10             	add    $0x10,%esp
        ap++;
 5ee:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5f2:	e9 b0 00 00 00       	jmp    6a7 <printf+0x17e>
      } else if(c == 's'){
 5f7:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5fb:	75 45                	jne    642 <printf+0x119>
        s = (char*)*ap;
 5fd:	8b 45 e8             	mov    -0x18(%ebp),%eax
 600:	8b 00                	mov    (%eax),%eax
 602:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 605:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 609:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 60d:	75 27                	jne    636 <printf+0x10d>
          s = "(null)";
 60f:	8d 83 16 fd ff ff    	lea    -0x2ea(%ebx),%eax
 615:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while(*s != 0){
 618:	eb 1c                	jmp    636 <printf+0x10d>
          putc(fd, *s);
 61a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 61d:	0f b6 00             	movzbl (%eax),%eax
 620:	0f be c0             	movsbl %al,%eax
 623:	83 ec 08             	sub    $0x8,%esp
 626:	50                   	push   %eax
 627:	ff 75 08             	push   0x8(%ebp)
 62a:	e8 06 fe ff ff       	call   435 <putc>
 62f:	83 c4 10             	add    $0x10,%esp
          s++;
 632:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 636:	8b 45 f4             	mov    -0xc(%ebp),%eax
 639:	0f b6 00             	movzbl (%eax),%eax
 63c:	84 c0                	test   %al,%al
 63e:	75 da                	jne    61a <printf+0xf1>
 640:	eb 65                	jmp    6a7 <printf+0x17e>
        }
      } else if(c == 'c'){
 642:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 646:	75 1d                	jne    665 <printf+0x13c>
        putc(fd, *ap);
 648:	8b 45 e8             	mov    -0x18(%ebp),%eax
 64b:	8b 00                	mov    (%eax),%eax
 64d:	0f be c0             	movsbl %al,%eax
 650:	83 ec 08             	sub    $0x8,%esp
 653:	50                   	push   %eax
 654:	ff 75 08             	push   0x8(%ebp)
 657:	e8 d9 fd ff ff       	call   435 <putc>
 65c:	83 c4 10             	add    $0x10,%esp
        ap++;
 65f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 663:	eb 42                	jmp    6a7 <printf+0x17e>
      } else if(c == '%'){
 665:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 669:	75 17                	jne    682 <printf+0x159>
        putc(fd, c);
 66b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 66e:	0f be c0             	movsbl %al,%eax
 671:	83 ec 08             	sub    $0x8,%esp
 674:	50                   	push   %eax
 675:	ff 75 08             	push   0x8(%ebp)
 678:	e8 b8 fd ff ff       	call   435 <putc>
 67d:	83 c4 10             	add    $0x10,%esp
 680:	eb 25                	jmp    6a7 <printf+0x17e>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 682:	83 ec 08             	sub    $0x8,%esp
 685:	6a 25                	push   $0x25
 687:	ff 75 08             	push   0x8(%ebp)
 68a:	e8 a6 fd ff ff       	call   435 <putc>
 68f:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 692:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 695:	0f be c0             	movsbl %al,%eax
 698:	83 ec 08             	sub    $0x8,%esp
 69b:	50                   	push   %eax
 69c:	ff 75 08             	push   0x8(%ebp)
 69f:	e8 91 fd ff ff       	call   435 <putc>
 6a4:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 6a7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 6ae:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 6b2:	8b 55 0c             	mov    0xc(%ebp),%edx
 6b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6b8:	01 d0                	add    %edx,%eax
 6ba:	0f b6 00             	movzbl (%eax),%eax
 6bd:	84 c0                	test   %al,%al
 6bf:	0f 85 92 fe ff ff    	jne    557 <printf+0x2e>
    }
  }
}
 6c5:	90                   	nop
 6c6:	90                   	nop
 6c7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 6ca:	c9                   	leave  
 6cb:	c3                   	ret    

000006cc <__x86.get_pc_thunk.cx>:
 6cc:	8b 0c 24             	mov    (%esp),%ecx
 6cf:	c3                   	ret    

000006d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6d0:	55                   	push   %ebp
 6d1:	89 e5                	mov    %esp,%ebp
 6d3:	83 ec 10             	sub    $0x10,%esp
 6d6:	e8 e5 f9 ff ff       	call   c0 <__x86.get_pc_thunk.ax>
 6db:	05 4d 05 00 00       	add    $0x54d,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6e0:	8b 55 08             	mov    0x8(%ebp),%edx
 6e3:	83 ea 08             	sub    $0x8,%edx
 6e6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6e9:	8b 90 28 00 00 00    	mov    0x28(%eax),%edx
 6ef:	89 55 fc             	mov    %edx,-0x4(%ebp)
 6f2:	eb 24                	jmp    718 <free+0x48>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f4:	8b 55 fc             	mov    -0x4(%ebp),%edx
 6f7:	8b 12                	mov    (%edx),%edx
 6f9:	39 55 fc             	cmp    %edx,-0x4(%ebp)
 6fc:	72 12                	jb     710 <free+0x40>
 6fe:	8b 55 f8             	mov    -0x8(%ebp),%edx
 701:	3b 55 fc             	cmp    -0x4(%ebp),%edx
 704:	77 24                	ja     72a <free+0x5a>
 706:	8b 55 fc             	mov    -0x4(%ebp),%edx
 709:	8b 12                	mov    (%edx),%edx
 70b:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 70e:	72 1a                	jb     72a <free+0x5a>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 710:	8b 55 fc             	mov    -0x4(%ebp),%edx
 713:	8b 12                	mov    (%edx),%edx
 715:	89 55 fc             	mov    %edx,-0x4(%ebp)
 718:	8b 55 f8             	mov    -0x8(%ebp),%edx
 71b:	3b 55 fc             	cmp    -0x4(%ebp),%edx
 71e:	76 d4                	jbe    6f4 <free+0x24>
 720:	8b 55 fc             	mov    -0x4(%ebp),%edx
 723:	8b 12                	mov    (%edx),%edx
 725:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 728:	73 ca                	jae    6f4 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 72a:	8b 55 f8             	mov    -0x8(%ebp),%edx
 72d:	8b 52 04             	mov    0x4(%edx),%edx
 730:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
 737:	8b 55 f8             	mov    -0x8(%ebp),%edx
 73a:	01 d1                	add    %edx,%ecx
 73c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 73f:	8b 12                	mov    (%edx),%edx
 741:	39 d1                	cmp    %edx,%ecx
 743:	75 24                	jne    769 <free+0x99>
    bp->s.size += p->s.ptr->s.size;
 745:	8b 55 f8             	mov    -0x8(%ebp),%edx
 748:	8b 4a 04             	mov    0x4(%edx),%ecx
 74b:	8b 55 fc             	mov    -0x4(%ebp),%edx
 74e:	8b 12                	mov    (%edx),%edx
 750:	8b 52 04             	mov    0x4(%edx),%edx
 753:	01 d1                	add    %edx,%ecx
 755:	8b 55 f8             	mov    -0x8(%ebp),%edx
 758:	89 4a 04             	mov    %ecx,0x4(%edx)
    bp->s.ptr = p->s.ptr->s.ptr;
 75b:	8b 55 fc             	mov    -0x4(%ebp),%edx
 75e:	8b 12                	mov    (%edx),%edx
 760:	8b 0a                	mov    (%edx),%ecx
 762:	8b 55 f8             	mov    -0x8(%ebp),%edx
 765:	89 0a                	mov    %ecx,(%edx)
 767:	eb 0a                	jmp    773 <free+0xa3>
  } else
    bp->s.ptr = p->s.ptr;
 769:	8b 55 fc             	mov    -0x4(%ebp),%edx
 76c:	8b 0a                	mov    (%edx),%ecx
 76e:	8b 55 f8             	mov    -0x8(%ebp),%edx
 771:	89 0a                	mov    %ecx,(%edx)
  if(p + p->s.size == bp){
 773:	8b 55 fc             	mov    -0x4(%ebp),%edx
 776:	8b 52 04             	mov    0x4(%edx),%edx
 779:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
 780:	8b 55 fc             	mov    -0x4(%ebp),%edx
 783:	01 ca                	add    %ecx,%edx
 785:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 788:	75 20                	jne    7aa <free+0xda>
    p->s.size += bp->s.size;
 78a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 78d:	8b 4a 04             	mov    0x4(%edx),%ecx
 790:	8b 55 f8             	mov    -0x8(%ebp),%edx
 793:	8b 52 04             	mov    0x4(%edx),%edx
 796:	01 d1                	add    %edx,%ecx
 798:	8b 55 fc             	mov    -0x4(%ebp),%edx
 79b:	89 4a 04             	mov    %ecx,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 79e:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7a1:	8b 0a                	mov    (%edx),%ecx
 7a3:	8b 55 fc             	mov    -0x4(%ebp),%edx
 7a6:	89 0a                	mov    %ecx,(%edx)
 7a8:	eb 08                	jmp    7b2 <free+0xe2>
  } else
    p->s.ptr = bp;
 7aa:	8b 55 fc             	mov    -0x4(%ebp),%edx
 7ad:	8b 4d f8             	mov    -0x8(%ebp),%ecx
 7b0:	89 0a                	mov    %ecx,(%edx)
  freep = p;
 7b2:	8b 55 fc             	mov    -0x4(%ebp),%edx
 7b5:	89 90 28 00 00 00    	mov    %edx,0x28(%eax)
}
 7bb:	90                   	nop
 7bc:	c9                   	leave  
 7bd:	c3                   	ret    

000007be <morecore>:

static Header*
morecore(uint nu)
{
 7be:	55                   	push   %ebp
 7bf:	89 e5                	mov    %esp,%ebp
 7c1:	53                   	push   %ebx
 7c2:	83 ec 14             	sub    $0x14,%esp
 7c5:	e8 fa f8 ff ff       	call   c4 <__x86.get_pc_thunk.bx>
 7ca:	81 c3 5e 04 00 00    	add    $0x45e,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 7d0:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7d7:	77 07                	ja     7e0 <morecore+0x22>
    nu = 4096;
 7d9:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7e0:	8b 45 08             	mov    0x8(%ebp),%eax
 7e3:	c1 e0 03             	shl    $0x3,%eax
 7e6:	83 ec 0c             	sub    $0xc,%esp
 7e9:	50                   	push   %eax
 7ea:	e8 26 fc ff ff       	call   415 <sbrk>
 7ef:	83 c4 10             	add    $0x10,%esp
 7f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 7f5:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 7f9:	75 07                	jne    802 <morecore+0x44>
    return 0;
 7fb:	b8 00 00 00 00       	mov    $0x0,%eax
 800:	eb 27                	jmp    829 <morecore+0x6b>
  hp = (Header*)p;
 802:	8b 45 f4             	mov    -0xc(%ebp),%eax
 805:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 808:	8b 45 f0             	mov    -0x10(%ebp),%eax
 80b:	8b 55 08             	mov    0x8(%ebp),%edx
 80e:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 811:	8b 45 f0             	mov    -0x10(%ebp),%eax
 814:	83 c0 08             	add    $0x8,%eax
 817:	83 ec 0c             	sub    $0xc,%esp
 81a:	50                   	push   %eax
 81b:	e8 b0 fe ff ff       	call   6d0 <free>
 820:	83 c4 10             	add    $0x10,%esp
  return freep;
 823:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
}
 829:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 82c:	c9                   	leave  
 82d:	c3                   	ret    

0000082e <malloc>:

void*
malloc(uint nbytes)
{
 82e:	55                   	push   %ebp
 82f:	89 e5                	mov    %esp,%ebp
 831:	53                   	push   %ebx
 832:	83 ec 14             	sub    $0x14,%esp
 835:	e8 8a f8 ff ff       	call   c4 <__x86.get_pc_thunk.bx>
 83a:	81 c3 ee 03 00 00    	add    $0x3ee,%ebx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 840:	8b 45 08             	mov    0x8(%ebp),%eax
 843:	83 c0 07             	add    $0x7,%eax
 846:	c1 e8 03             	shr    $0x3,%eax
 849:	83 c0 01             	add    $0x1,%eax
 84c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 84f:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
 855:	89 45 f0             	mov    %eax,-0x10(%ebp)
 858:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 85c:	75 28                	jne    886 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
 85e:	8d 83 20 00 00 00    	lea    0x20(%ebx),%eax
 864:	89 45 f0             	mov    %eax,-0x10(%ebp)
 867:	8b 45 f0             	mov    -0x10(%ebp),%eax
 86a:	89 83 28 00 00 00    	mov    %eax,0x28(%ebx)
 870:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
 876:	89 83 20 00 00 00    	mov    %eax,0x20(%ebx)
    base.s.size = 0;
 87c:	c7 83 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
 883:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 886:	8b 45 f0             	mov    -0x10(%ebp),%eax
 889:	8b 00                	mov    (%eax),%eax
 88b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 88e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 891:	8b 40 04             	mov    0x4(%eax),%eax
 894:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 897:	77 4e                	ja     8e7 <malloc+0xb9>
      if(p->s.size == nunits)
 899:	8b 45 f4             	mov    -0xc(%ebp),%eax
 89c:	8b 40 04             	mov    0x4(%eax),%eax
 89f:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 8a2:	75 0c                	jne    8b0 <malloc+0x82>
        prevp->s.ptr = p->s.ptr;
 8a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a7:	8b 10                	mov    (%eax),%edx
 8a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8ac:	89 10                	mov    %edx,(%eax)
 8ae:	eb 26                	jmp    8d6 <malloc+0xa8>
      else {
        p->s.size -= nunits;
 8b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b3:	8b 40 04             	mov    0x4(%eax),%eax
 8b6:	2b 45 ec             	sub    -0x14(%ebp),%eax
 8b9:	89 c2                	mov    %eax,%edx
 8bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8be:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 8c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c4:	8b 40 04             	mov    0x4(%eax),%eax
 8c7:	c1 e0 03             	shl    $0x3,%eax
 8ca:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 8cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8d0:	8b 55 ec             	mov    -0x14(%ebp),%edx
 8d3:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 8d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8d9:	89 83 28 00 00 00    	mov    %eax,0x28(%ebx)
      return (void*)(p + 1);
 8df:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8e2:	83 c0 08             	add    $0x8,%eax
 8e5:	eb 3c                	jmp    923 <malloc+0xf5>
    }
    if(p == freep)
 8e7:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
 8ed:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8f0:	75 1e                	jne    910 <malloc+0xe2>
      if((p = morecore(nunits)) == 0)
 8f2:	83 ec 0c             	sub    $0xc,%esp
 8f5:	ff 75 ec             	push   -0x14(%ebp)
 8f8:	e8 c1 fe ff ff       	call   7be <morecore>
 8fd:	83 c4 10             	add    $0x10,%esp
 900:	89 45 f4             	mov    %eax,-0xc(%ebp)
 903:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 907:	75 07                	jne    910 <malloc+0xe2>
        return 0;
 909:	b8 00 00 00 00       	mov    $0x0,%eax
 90e:	eb 13                	jmp    923 <malloc+0xf5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 910:	8b 45 f4             	mov    -0xc(%ebp),%eax
 913:	89 45 f0             	mov    %eax,-0x10(%ebp)
 916:	8b 45 f4             	mov    -0xc(%ebp),%eax
 919:	8b 00                	mov    (%eax),%eax
 91b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 91e:	e9 6b ff ff ff       	jmp    88e <malloc+0x60>
  }
}
 923:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 926:	c9                   	leave  
 927:	c3                   	ret    
