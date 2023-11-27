
_rand:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "stat.h"
#include "user.h"
 
int 
main(void) {
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
   f:	83 ec 10             	sub    $0x10,%esp
  12:	e8 2a 00 00 00       	call   41 <__x86.get_pc_thunk.bx>
  17:	81 c3 3d 0b 00 00    	add    $0xb3d,%ebx
    int x=random();
  1d:	e8 8c 03 00 00       	call   3ae <random>
  22:	89 45 f4             	mov    %eax,-0xc(%ebp)
    printf(1,"%d\n", x);
  25:	83 ec 04             	sub    $0x4,%esp
  28:	ff 75 f4             	push   -0xc(%ebp)
  2b:	8d 83 55 fd ff ff    	lea    -0x2ab(%ebx),%eax
  31:	50                   	push   %eax
  32:	6a 01                	push   $0x1
  34:	e8 71 04 00 00       	call   4aa <printf>
  39:	83 c4 10             	add    $0x10,%esp
    // printf(1, “Congrats !! You have successfully added new system  call in xv6 OS :) \n”);
    exit();
  3c:	e8 cd 02 00 00       	call   30e <exit>

00000041 <__x86.get_pc_thunk.bx>:
  41:	8b 1c 24             	mov    (%esp),%ebx
  44:	c3                   	ret    

00000045 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  45:	55                   	push   %ebp
  46:	89 e5                	mov    %esp,%ebp
  48:	57                   	push   %edi
  49:	53                   	push   %ebx
  4a:	e8 b3 02 00 00       	call   302 <__x86.get_pc_thunk.ax>
  4f:	05 05 0b 00 00       	add    $0xb05,%eax
  asm volatile("cld; rep stosb" :
  54:	8b 4d 08             	mov    0x8(%ebp),%ecx
  57:	8b 55 10             	mov    0x10(%ebp),%edx
  5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  5d:	89 cb                	mov    %ecx,%ebx
  5f:	89 df                	mov    %ebx,%edi
  61:	89 d1                	mov    %edx,%ecx
  63:	fc                   	cld    
  64:	f3 aa                	rep stos %al,%es:(%edi)
  66:	89 ca                	mov    %ecx,%edx
  68:	89 fb                	mov    %edi,%ebx
  6a:	89 5d 08             	mov    %ebx,0x8(%ebp)
  6d:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  70:	90                   	nop
  71:	5b                   	pop    %ebx
  72:	5f                   	pop    %edi
  73:	5d                   	pop    %ebp
  74:	c3                   	ret    

00000075 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  75:	55                   	push   %ebp
  76:	89 e5                	mov    %esp,%ebp
  78:	83 ec 10             	sub    $0x10,%esp
  7b:	e8 82 02 00 00       	call   302 <__x86.get_pc_thunk.ax>
  80:	05 d4 0a 00 00       	add    $0xad4,%eax
  char *os;

  os = s;
  85:	8b 45 08             	mov    0x8(%ebp),%eax
  88:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  8b:	90                   	nop
  8c:	8b 55 0c             	mov    0xc(%ebp),%edx
  8f:	8d 42 01             	lea    0x1(%edx),%eax
  92:	89 45 0c             	mov    %eax,0xc(%ebp)
  95:	8b 45 08             	mov    0x8(%ebp),%eax
  98:	8d 48 01             	lea    0x1(%eax),%ecx
  9b:	89 4d 08             	mov    %ecx,0x8(%ebp)
  9e:	0f b6 12             	movzbl (%edx),%edx
  a1:	88 10                	mov    %dl,(%eax)
  a3:	0f b6 00             	movzbl (%eax),%eax
  a6:	84 c0                	test   %al,%al
  a8:	75 e2                	jne    8c <strcpy+0x17>
    ;
  return os;
  aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  ad:	c9                   	leave  
  ae:	c3                   	ret    

000000af <strcmp>:

int
strcmp(const char *p, const char *q)
{
  af:	55                   	push   %ebp
  b0:	89 e5                	mov    %esp,%ebp
  b2:	e8 4b 02 00 00       	call   302 <__x86.get_pc_thunk.ax>
  b7:	05 9d 0a 00 00       	add    $0xa9d,%eax
  while(*p && *p == *q)
  bc:	eb 08                	jmp    c6 <strcmp+0x17>
    p++, q++;
  be:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  c2:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
  c6:	8b 45 08             	mov    0x8(%ebp),%eax
  c9:	0f b6 00             	movzbl (%eax),%eax
  cc:	84 c0                	test   %al,%al
  ce:	74 10                	je     e0 <strcmp+0x31>
  d0:	8b 45 08             	mov    0x8(%ebp),%eax
  d3:	0f b6 10             	movzbl (%eax),%edx
  d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  d9:	0f b6 00             	movzbl (%eax),%eax
  dc:	38 c2                	cmp    %al,%dl
  de:	74 de                	je     be <strcmp+0xf>
  return (uchar)*p - (uchar)*q;
  e0:	8b 45 08             	mov    0x8(%ebp),%eax
  e3:	0f b6 00             	movzbl (%eax),%eax
  e6:	0f b6 d0             	movzbl %al,%edx
  e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  ec:	0f b6 00             	movzbl (%eax),%eax
  ef:	0f b6 c8             	movzbl %al,%ecx
  f2:	89 d0                	mov    %edx,%eax
  f4:	29 c8                	sub    %ecx,%eax
}
  f6:	5d                   	pop    %ebp
  f7:	c3                   	ret    

000000f8 <strlen>:

uint
strlen(const char *s)
{
  f8:	55                   	push   %ebp
  f9:	89 e5                	mov    %esp,%ebp
  fb:	83 ec 10             	sub    $0x10,%esp
  fe:	e8 ff 01 00 00       	call   302 <__x86.get_pc_thunk.ax>
 103:	05 51 0a 00 00       	add    $0xa51,%eax
  int n;

  for(n = 0; s[n]; n++)
 108:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 10f:	eb 04                	jmp    115 <strlen+0x1d>
 111:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 115:	8b 55 fc             	mov    -0x4(%ebp),%edx
 118:	8b 45 08             	mov    0x8(%ebp),%eax
 11b:	01 d0                	add    %edx,%eax
 11d:	0f b6 00             	movzbl (%eax),%eax
 120:	84 c0                	test   %al,%al
 122:	75 ed                	jne    111 <strlen+0x19>
    ;
  return n;
 124:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 127:	c9                   	leave  
 128:	c3                   	ret    

00000129 <memset>:

void*
memset(void *dst, int c, uint n)
{
 129:	55                   	push   %ebp
 12a:	89 e5                	mov    %esp,%ebp
 12c:	e8 d1 01 00 00       	call   302 <__x86.get_pc_thunk.ax>
 131:	05 23 0a 00 00       	add    $0xa23,%eax
  stosb(dst, c, n);
 136:	8b 45 10             	mov    0x10(%ebp),%eax
 139:	50                   	push   %eax
 13a:	ff 75 0c             	push   0xc(%ebp)
 13d:	ff 75 08             	push   0x8(%ebp)
 140:	e8 00 ff ff ff       	call   45 <stosb>
 145:	83 c4 0c             	add    $0xc,%esp
  return dst;
 148:	8b 45 08             	mov    0x8(%ebp),%eax
}
 14b:	c9                   	leave  
 14c:	c3                   	ret    

0000014d <strchr>:

char*
strchr(const char *s, char c)
{
 14d:	55                   	push   %ebp
 14e:	89 e5                	mov    %esp,%ebp
 150:	83 ec 04             	sub    $0x4,%esp
 153:	e8 aa 01 00 00       	call   302 <__x86.get_pc_thunk.ax>
 158:	05 fc 09 00 00       	add    $0x9fc,%eax
 15d:	8b 45 0c             	mov    0xc(%ebp),%eax
 160:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 163:	eb 14                	jmp    179 <strchr+0x2c>
    if(*s == c)
 165:	8b 45 08             	mov    0x8(%ebp),%eax
 168:	0f b6 00             	movzbl (%eax),%eax
 16b:	38 45 fc             	cmp    %al,-0x4(%ebp)
 16e:	75 05                	jne    175 <strchr+0x28>
      return (char*)s;
 170:	8b 45 08             	mov    0x8(%ebp),%eax
 173:	eb 13                	jmp    188 <strchr+0x3b>
  for(; *s; s++)
 175:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 179:	8b 45 08             	mov    0x8(%ebp),%eax
 17c:	0f b6 00             	movzbl (%eax),%eax
 17f:	84 c0                	test   %al,%al
 181:	75 e2                	jne    165 <strchr+0x18>
  return 0;
 183:	b8 00 00 00 00       	mov    $0x0,%eax
}
 188:	c9                   	leave  
 189:	c3                   	ret    

0000018a <gets>:

char*
gets(char *buf, int max)
{
 18a:	55                   	push   %ebp
 18b:	89 e5                	mov    %esp,%ebp
 18d:	53                   	push   %ebx
 18e:	83 ec 14             	sub    $0x14,%esp
 191:	e8 ab fe ff ff       	call   41 <__x86.get_pc_thunk.bx>
 196:	81 c3 be 09 00 00    	add    $0x9be,%ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 19c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1a3:	eb 42                	jmp    1e7 <gets+0x5d>
    cc = read(0, &c, 1);
 1a5:	83 ec 04             	sub    $0x4,%esp
 1a8:	6a 01                	push   $0x1
 1aa:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1ad:	50                   	push   %eax
 1ae:	6a 00                	push   $0x0
 1b0:	e8 71 01 00 00       	call   326 <read>
 1b5:	83 c4 10             	add    $0x10,%esp
 1b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1bb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1bf:	7e 33                	jle    1f4 <gets+0x6a>
      break;
    buf[i++] = c;
 1c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c4:	8d 50 01             	lea    0x1(%eax),%edx
 1c7:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1ca:	89 c2                	mov    %eax,%edx
 1cc:	8b 45 08             	mov    0x8(%ebp),%eax
 1cf:	01 c2                	add    %eax,%edx
 1d1:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1d5:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1d7:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1db:	3c 0a                	cmp    $0xa,%al
 1dd:	74 16                	je     1f5 <gets+0x6b>
 1df:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1e3:	3c 0d                	cmp    $0xd,%al
 1e5:	74 0e                	je     1f5 <gets+0x6b>
  for(i=0; i+1 < max; ){
 1e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ea:	83 c0 01             	add    $0x1,%eax
 1ed:	39 45 0c             	cmp    %eax,0xc(%ebp)
 1f0:	7f b3                	jg     1a5 <gets+0x1b>
 1f2:	eb 01                	jmp    1f5 <gets+0x6b>
      break;
 1f4:	90                   	nop
      break;
  }
  buf[i] = '\0';
 1f5:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1f8:	8b 45 08             	mov    0x8(%ebp),%eax
 1fb:	01 d0                	add    %edx,%eax
 1fd:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 200:	8b 45 08             	mov    0x8(%ebp),%eax
}
 203:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 206:	c9                   	leave  
 207:	c3                   	ret    

00000208 <stat>:

int
stat(const char *n, struct stat *st)
{
 208:	55                   	push   %ebp
 209:	89 e5                	mov    %esp,%ebp
 20b:	53                   	push   %ebx
 20c:	83 ec 14             	sub    $0x14,%esp
 20f:	e8 2d fe ff ff       	call   41 <__x86.get_pc_thunk.bx>
 214:	81 c3 40 09 00 00    	add    $0x940,%ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 21a:	83 ec 08             	sub    $0x8,%esp
 21d:	6a 00                	push   $0x0
 21f:	ff 75 08             	push   0x8(%ebp)
 222:	e8 27 01 00 00       	call   34e <open>
 227:	83 c4 10             	add    $0x10,%esp
 22a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 22d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 231:	79 07                	jns    23a <stat+0x32>
    return -1;
 233:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 238:	eb 25                	jmp    25f <stat+0x57>
  r = fstat(fd, st);
 23a:	83 ec 08             	sub    $0x8,%esp
 23d:	ff 75 0c             	push   0xc(%ebp)
 240:	ff 75 f4             	push   -0xc(%ebp)
 243:	e8 1e 01 00 00       	call   366 <fstat>
 248:	83 c4 10             	add    $0x10,%esp
 24b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 24e:	83 ec 0c             	sub    $0xc,%esp
 251:	ff 75 f4             	push   -0xc(%ebp)
 254:	e8 dd 00 00 00       	call   336 <close>
 259:	83 c4 10             	add    $0x10,%esp
  return r;
 25c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 25f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 262:	c9                   	leave  
 263:	c3                   	ret    

00000264 <atoi>:

int
atoi(const char *s)
{
 264:	55                   	push   %ebp
 265:	89 e5                	mov    %esp,%ebp
 267:	83 ec 10             	sub    $0x10,%esp
 26a:	e8 93 00 00 00       	call   302 <__x86.get_pc_thunk.ax>
 26f:	05 e5 08 00 00       	add    $0x8e5,%eax
  int n;

  n = 0;
 274:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 27b:	eb 25                	jmp    2a2 <atoi+0x3e>
    n = n*10 + *s++ - '0';
 27d:	8b 55 fc             	mov    -0x4(%ebp),%edx
 280:	89 d0                	mov    %edx,%eax
 282:	c1 e0 02             	shl    $0x2,%eax
 285:	01 d0                	add    %edx,%eax
 287:	01 c0                	add    %eax,%eax
 289:	89 c1                	mov    %eax,%ecx
 28b:	8b 45 08             	mov    0x8(%ebp),%eax
 28e:	8d 50 01             	lea    0x1(%eax),%edx
 291:	89 55 08             	mov    %edx,0x8(%ebp)
 294:	0f b6 00             	movzbl (%eax),%eax
 297:	0f be c0             	movsbl %al,%eax
 29a:	01 c8                	add    %ecx,%eax
 29c:	83 e8 30             	sub    $0x30,%eax
 29f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2a2:	8b 45 08             	mov    0x8(%ebp),%eax
 2a5:	0f b6 00             	movzbl (%eax),%eax
 2a8:	3c 2f                	cmp    $0x2f,%al
 2aa:	7e 0a                	jle    2b6 <atoi+0x52>
 2ac:	8b 45 08             	mov    0x8(%ebp),%eax
 2af:	0f b6 00             	movzbl (%eax),%eax
 2b2:	3c 39                	cmp    $0x39,%al
 2b4:	7e c7                	jle    27d <atoi+0x19>
  return n;
 2b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2b9:	c9                   	leave  
 2ba:	c3                   	ret    

000002bb <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2bb:	55                   	push   %ebp
 2bc:	89 e5                	mov    %esp,%ebp
 2be:	83 ec 10             	sub    $0x10,%esp
 2c1:	e8 3c 00 00 00       	call   302 <__x86.get_pc_thunk.ax>
 2c6:	05 8e 08 00 00       	add    $0x88e,%eax
  char *dst;
  const char *src;

  dst = vdst;
 2cb:	8b 45 08             	mov    0x8(%ebp),%eax
 2ce:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2d1:	8b 45 0c             	mov    0xc(%ebp),%eax
 2d4:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2d7:	eb 17                	jmp    2f0 <memmove+0x35>
    *dst++ = *src++;
 2d9:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2dc:	8d 42 01             	lea    0x1(%edx),%eax
 2df:	89 45 f8             	mov    %eax,-0x8(%ebp)
 2e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2e5:	8d 48 01             	lea    0x1(%eax),%ecx
 2e8:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 2eb:	0f b6 12             	movzbl (%edx),%edx
 2ee:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 2f0:	8b 45 10             	mov    0x10(%ebp),%eax
 2f3:	8d 50 ff             	lea    -0x1(%eax),%edx
 2f6:	89 55 10             	mov    %edx,0x10(%ebp)
 2f9:	85 c0                	test   %eax,%eax
 2fb:	7f dc                	jg     2d9 <memmove+0x1e>
  return vdst;
 2fd:	8b 45 08             	mov    0x8(%ebp),%eax
}
 300:	c9                   	leave  
 301:	c3                   	ret    

00000302 <__x86.get_pc_thunk.ax>:
 302:	8b 04 24             	mov    (%esp),%eax
 305:	c3                   	ret    

00000306 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 306:	b8 01 00 00 00       	mov    $0x1,%eax
 30b:	cd 40                	int    $0x40
 30d:	c3                   	ret    

0000030e <exit>:
SYSCALL(exit)
 30e:	b8 02 00 00 00       	mov    $0x2,%eax
 313:	cd 40                	int    $0x40
 315:	c3                   	ret    

00000316 <wait>:
SYSCALL(wait)
 316:	b8 03 00 00 00       	mov    $0x3,%eax
 31b:	cd 40                	int    $0x40
 31d:	c3                   	ret    

0000031e <pipe>:
SYSCALL(pipe)
 31e:	b8 04 00 00 00       	mov    $0x4,%eax
 323:	cd 40                	int    $0x40
 325:	c3                   	ret    

00000326 <read>:
SYSCALL(read)
 326:	b8 05 00 00 00       	mov    $0x5,%eax
 32b:	cd 40                	int    $0x40
 32d:	c3                   	ret    

0000032e <write>:
SYSCALL(write)
 32e:	b8 10 00 00 00       	mov    $0x10,%eax
 333:	cd 40                	int    $0x40
 335:	c3                   	ret    

00000336 <close>:
SYSCALL(close)
 336:	b8 15 00 00 00       	mov    $0x15,%eax
 33b:	cd 40                	int    $0x40
 33d:	c3                   	ret    

0000033e <kill>:
SYSCALL(kill)
 33e:	b8 06 00 00 00       	mov    $0x6,%eax
 343:	cd 40                	int    $0x40
 345:	c3                   	ret    

00000346 <exec>:
SYSCALL(exec)
 346:	b8 07 00 00 00       	mov    $0x7,%eax
 34b:	cd 40                	int    $0x40
 34d:	c3                   	ret    

0000034e <open>:
SYSCALL(open)
 34e:	b8 0f 00 00 00       	mov    $0xf,%eax
 353:	cd 40                	int    $0x40
 355:	c3                   	ret    

00000356 <mknod>:
SYSCALL(mknod)
 356:	b8 11 00 00 00       	mov    $0x11,%eax
 35b:	cd 40                	int    $0x40
 35d:	c3                   	ret    

0000035e <unlink>:
SYSCALL(unlink)
 35e:	b8 12 00 00 00       	mov    $0x12,%eax
 363:	cd 40                	int    $0x40
 365:	c3                   	ret    

00000366 <fstat>:
SYSCALL(fstat)
 366:	b8 08 00 00 00       	mov    $0x8,%eax
 36b:	cd 40                	int    $0x40
 36d:	c3                   	ret    

0000036e <link>:
SYSCALL(link)
 36e:	b8 13 00 00 00       	mov    $0x13,%eax
 373:	cd 40                	int    $0x40
 375:	c3                   	ret    

00000376 <mkdir>:
SYSCALL(mkdir)
 376:	b8 14 00 00 00       	mov    $0x14,%eax
 37b:	cd 40                	int    $0x40
 37d:	c3                   	ret    

0000037e <chdir>:
SYSCALL(chdir)
 37e:	b8 09 00 00 00       	mov    $0x9,%eax
 383:	cd 40                	int    $0x40
 385:	c3                   	ret    

00000386 <dup>:
SYSCALL(dup)
 386:	b8 0a 00 00 00       	mov    $0xa,%eax
 38b:	cd 40                	int    $0x40
 38d:	c3                   	ret    

0000038e <getpid>:
SYSCALL(getpid)
 38e:	b8 0b 00 00 00       	mov    $0xb,%eax
 393:	cd 40                	int    $0x40
 395:	c3                   	ret    

00000396 <sbrk>:
SYSCALL(sbrk)
 396:	b8 0c 00 00 00       	mov    $0xc,%eax
 39b:	cd 40                	int    $0x40
 39d:	c3                   	ret    

0000039e <sleep>:
SYSCALL(sleep)
 39e:	b8 0d 00 00 00       	mov    $0xd,%eax
 3a3:	cd 40                	int    $0x40
 3a5:	c3                   	ret    

000003a6 <uptime>:
SYSCALL(uptime)
 3a6:	b8 0e 00 00 00       	mov    $0xe,%eax
 3ab:	cd 40                	int    $0x40
 3ad:	c3                   	ret    

000003ae <random>:
SYSCALL(random)
 3ae:	b8 16 00 00 00       	mov    $0x16,%eax
 3b3:	cd 40                	int    $0x40
 3b5:	c3                   	ret    

000003b6 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3b6:	55                   	push   %ebp
 3b7:	89 e5                	mov    %esp,%ebp
 3b9:	53                   	push   %ebx
 3ba:	83 ec 14             	sub    $0x14,%esp
 3bd:	e8 40 ff ff ff       	call   302 <__x86.get_pc_thunk.ax>
 3c2:	05 92 07 00 00       	add    $0x792,%eax
 3c7:	8b 55 0c             	mov    0xc(%ebp),%edx
 3ca:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 3cd:	83 ec 04             	sub    $0x4,%esp
 3d0:	6a 01                	push   $0x1
 3d2:	8d 55 f4             	lea    -0xc(%ebp),%edx
 3d5:	52                   	push   %edx
 3d6:	ff 75 08             	push   0x8(%ebp)
 3d9:	89 c3                	mov    %eax,%ebx
 3db:	e8 4e ff ff ff       	call   32e <write>
 3e0:	83 c4 10             	add    $0x10,%esp
}
 3e3:	90                   	nop
 3e4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3e7:	c9                   	leave  
 3e8:	c3                   	ret    

000003e9 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3e9:	55                   	push   %ebp
 3ea:	89 e5                	mov    %esp,%ebp
 3ec:	53                   	push   %ebx
 3ed:	83 ec 24             	sub    $0x24,%esp
 3f0:	e8 58 02 00 00       	call   64d <__x86.get_pc_thunk.cx>
 3f5:	81 c1 5f 07 00 00    	add    $0x75f,%ecx
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3fb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 402:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 406:	74 17                	je     41f <printint+0x36>
 408:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 40c:	79 11                	jns    41f <printint+0x36>
    neg = 1;
 40e:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 415:	8b 45 0c             	mov    0xc(%ebp),%eax
 418:	f7 d8                	neg    %eax
 41a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 41d:	eb 06                	jmp    425 <printint+0x3c>
  } else {
    x = xx;
 41f:	8b 45 0c             	mov    0xc(%ebp),%eax
 422:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 425:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 42c:	8b 5d 10             	mov    0x10(%ebp),%ebx
 42f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 432:	ba 00 00 00 00       	mov    $0x0,%edx
 437:	f7 f3                	div    %ebx
 439:	89 d3                	mov    %edx,%ebx
 43b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 43e:	8d 50 01             	lea    0x1(%eax),%edx
 441:	89 55 f4             	mov    %edx,-0xc(%ebp)
 444:	0f b6 94 19 0c 00 00 	movzbl 0xc(%ecx,%ebx,1),%edx
 44b:	00 
 44c:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 450:	8b 5d 10             	mov    0x10(%ebp),%ebx
 453:	8b 45 ec             	mov    -0x14(%ebp),%eax
 456:	ba 00 00 00 00       	mov    $0x0,%edx
 45b:	f7 f3                	div    %ebx
 45d:	89 45 ec             	mov    %eax,-0x14(%ebp)
 460:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 464:	75 c6                	jne    42c <printint+0x43>
  if(neg)
 466:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 46a:	74 2d                	je     499 <printint+0xb0>
    buf[i++] = '-';
 46c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 46f:	8d 50 01             	lea    0x1(%eax),%edx
 472:	89 55 f4             	mov    %edx,-0xc(%ebp)
 475:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 47a:	eb 1d                	jmp    499 <printint+0xb0>
    putc(fd, buf[i]);
 47c:	8d 55 dc             	lea    -0x24(%ebp),%edx
 47f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 482:	01 d0                	add    %edx,%eax
 484:	0f b6 00             	movzbl (%eax),%eax
 487:	0f be c0             	movsbl %al,%eax
 48a:	83 ec 08             	sub    $0x8,%esp
 48d:	50                   	push   %eax
 48e:	ff 75 08             	push   0x8(%ebp)
 491:	e8 20 ff ff ff       	call   3b6 <putc>
 496:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 499:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 49d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4a1:	79 d9                	jns    47c <printint+0x93>
}
 4a3:	90                   	nop
 4a4:	90                   	nop
 4a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4a8:	c9                   	leave  
 4a9:	c3                   	ret    

000004aa <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4aa:	55                   	push   %ebp
 4ab:	89 e5                	mov    %esp,%ebp
 4ad:	53                   	push   %ebx
 4ae:	83 ec 24             	sub    $0x24,%esp
 4b1:	e8 8b fb ff ff       	call   41 <__x86.get_pc_thunk.bx>
 4b6:	81 c3 9e 06 00 00    	add    $0x69e,%ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4bc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4c3:	8d 45 0c             	lea    0xc(%ebp),%eax
 4c6:	83 c0 04             	add    $0x4,%eax
 4c9:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4cc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4d3:	e9 5b 01 00 00       	jmp    633 <printf+0x189>
    c = fmt[i] & 0xff;
 4d8:	8b 55 0c             	mov    0xc(%ebp),%edx
 4db:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4de:	01 d0                	add    %edx,%eax
 4e0:	0f b6 00             	movzbl (%eax),%eax
 4e3:	0f be c0             	movsbl %al,%eax
 4e6:	25 ff 00 00 00       	and    $0xff,%eax
 4eb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4ee:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4f2:	75 2c                	jne    520 <printf+0x76>
      if(c == '%'){
 4f4:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4f8:	75 0c                	jne    506 <printf+0x5c>
        state = '%';
 4fa:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 501:	e9 29 01 00 00       	jmp    62f <printf+0x185>
      } else {
        putc(fd, c);
 506:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 509:	0f be c0             	movsbl %al,%eax
 50c:	83 ec 08             	sub    $0x8,%esp
 50f:	50                   	push   %eax
 510:	ff 75 08             	push   0x8(%ebp)
 513:	e8 9e fe ff ff       	call   3b6 <putc>
 518:	83 c4 10             	add    $0x10,%esp
 51b:	e9 0f 01 00 00       	jmp    62f <printf+0x185>
      }
    } else if(state == '%'){
 520:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 524:	0f 85 05 01 00 00    	jne    62f <printf+0x185>
      if(c == 'd'){
 52a:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 52e:	75 1e                	jne    54e <printf+0xa4>
        printint(fd, *ap, 10, 1);
 530:	8b 45 e8             	mov    -0x18(%ebp),%eax
 533:	8b 00                	mov    (%eax),%eax
 535:	6a 01                	push   $0x1
 537:	6a 0a                	push   $0xa
 539:	50                   	push   %eax
 53a:	ff 75 08             	push   0x8(%ebp)
 53d:	e8 a7 fe ff ff       	call   3e9 <printint>
 542:	83 c4 10             	add    $0x10,%esp
        ap++;
 545:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 549:	e9 da 00 00 00       	jmp    628 <printf+0x17e>
      } else if(c == 'x' || c == 'p'){
 54e:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 552:	74 06                	je     55a <printf+0xb0>
 554:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 558:	75 1e                	jne    578 <printf+0xce>
        printint(fd, *ap, 16, 0);
 55a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 55d:	8b 00                	mov    (%eax),%eax
 55f:	6a 00                	push   $0x0
 561:	6a 10                	push   $0x10
 563:	50                   	push   %eax
 564:	ff 75 08             	push   0x8(%ebp)
 567:	e8 7d fe ff ff       	call   3e9 <printint>
 56c:	83 c4 10             	add    $0x10,%esp
        ap++;
 56f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 573:	e9 b0 00 00 00       	jmp    628 <printf+0x17e>
      } else if(c == 's'){
 578:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 57c:	75 45                	jne    5c3 <printf+0x119>
        s = (char*)*ap;
 57e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 581:	8b 00                	mov    (%eax),%eax
 583:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 586:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 58a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 58e:	75 27                	jne    5b7 <printf+0x10d>
          s = "(null)";
 590:	8d 83 59 fd ff ff    	lea    -0x2a7(%ebx),%eax
 596:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while(*s != 0){
 599:	eb 1c                	jmp    5b7 <printf+0x10d>
          putc(fd, *s);
 59b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 59e:	0f b6 00             	movzbl (%eax),%eax
 5a1:	0f be c0             	movsbl %al,%eax
 5a4:	83 ec 08             	sub    $0x8,%esp
 5a7:	50                   	push   %eax
 5a8:	ff 75 08             	push   0x8(%ebp)
 5ab:	e8 06 fe ff ff       	call   3b6 <putc>
 5b0:	83 c4 10             	add    $0x10,%esp
          s++;
 5b3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 5b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5ba:	0f b6 00             	movzbl (%eax),%eax
 5bd:	84 c0                	test   %al,%al
 5bf:	75 da                	jne    59b <printf+0xf1>
 5c1:	eb 65                	jmp    628 <printf+0x17e>
        }
      } else if(c == 'c'){
 5c3:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5c7:	75 1d                	jne    5e6 <printf+0x13c>
        putc(fd, *ap);
 5c9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5cc:	8b 00                	mov    (%eax),%eax
 5ce:	0f be c0             	movsbl %al,%eax
 5d1:	83 ec 08             	sub    $0x8,%esp
 5d4:	50                   	push   %eax
 5d5:	ff 75 08             	push   0x8(%ebp)
 5d8:	e8 d9 fd ff ff       	call   3b6 <putc>
 5dd:	83 c4 10             	add    $0x10,%esp
        ap++;
 5e0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5e4:	eb 42                	jmp    628 <printf+0x17e>
      } else if(c == '%'){
 5e6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5ea:	75 17                	jne    603 <printf+0x159>
        putc(fd, c);
 5ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5ef:	0f be c0             	movsbl %al,%eax
 5f2:	83 ec 08             	sub    $0x8,%esp
 5f5:	50                   	push   %eax
 5f6:	ff 75 08             	push   0x8(%ebp)
 5f9:	e8 b8 fd ff ff       	call   3b6 <putc>
 5fe:	83 c4 10             	add    $0x10,%esp
 601:	eb 25                	jmp    628 <printf+0x17e>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 603:	83 ec 08             	sub    $0x8,%esp
 606:	6a 25                	push   $0x25
 608:	ff 75 08             	push   0x8(%ebp)
 60b:	e8 a6 fd ff ff       	call   3b6 <putc>
 610:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 613:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 616:	0f be c0             	movsbl %al,%eax
 619:	83 ec 08             	sub    $0x8,%esp
 61c:	50                   	push   %eax
 61d:	ff 75 08             	push   0x8(%ebp)
 620:	e8 91 fd ff ff       	call   3b6 <putc>
 625:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 628:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 62f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 633:	8b 55 0c             	mov    0xc(%ebp),%edx
 636:	8b 45 f0             	mov    -0x10(%ebp),%eax
 639:	01 d0                	add    %edx,%eax
 63b:	0f b6 00             	movzbl (%eax),%eax
 63e:	84 c0                	test   %al,%al
 640:	0f 85 92 fe ff ff    	jne    4d8 <printf+0x2e>
    }
  }
}
 646:	90                   	nop
 647:	90                   	nop
 648:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 64b:	c9                   	leave  
 64c:	c3                   	ret    

0000064d <__x86.get_pc_thunk.cx>:
 64d:	8b 0c 24             	mov    (%esp),%ecx
 650:	c3                   	ret    

00000651 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 651:	55                   	push   %ebp
 652:	89 e5                	mov    %esp,%ebp
 654:	83 ec 10             	sub    $0x10,%esp
 657:	e8 a6 fc ff ff       	call   302 <__x86.get_pc_thunk.ax>
 65c:	05 f8 04 00 00       	add    $0x4f8,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
 661:	8b 55 08             	mov    0x8(%ebp),%edx
 664:	83 ea 08             	sub    $0x8,%edx
 667:	89 55 f8             	mov    %edx,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 66a:	8b 90 28 00 00 00    	mov    0x28(%eax),%edx
 670:	89 55 fc             	mov    %edx,-0x4(%ebp)
 673:	eb 24                	jmp    699 <free+0x48>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 675:	8b 55 fc             	mov    -0x4(%ebp),%edx
 678:	8b 12                	mov    (%edx),%edx
 67a:	39 55 fc             	cmp    %edx,-0x4(%ebp)
 67d:	72 12                	jb     691 <free+0x40>
 67f:	8b 55 f8             	mov    -0x8(%ebp),%edx
 682:	3b 55 fc             	cmp    -0x4(%ebp),%edx
 685:	77 24                	ja     6ab <free+0x5a>
 687:	8b 55 fc             	mov    -0x4(%ebp),%edx
 68a:	8b 12                	mov    (%edx),%edx
 68c:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 68f:	72 1a                	jb     6ab <free+0x5a>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 691:	8b 55 fc             	mov    -0x4(%ebp),%edx
 694:	8b 12                	mov    (%edx),%edx
 696:	89 55 fc             	mov    %edx,-0x4(%ebp)
 699:	8b 55 f8             	mov    -0x8(%ebp),%edx
 69c:	3b 55 fc             	cmp    -0x4(%ebp),%edx
 69f:	76 d4                	jbe    675 <free+0x24>
 6a1:	8b 55 fc             	mov    -0x4(%ebp),%edx
 6a4:	8b 12                	mov    (%edx),%edx
 6a6:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 6a9:	73 ca                	jae    675 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6ab:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6ae:	8b 52 04             	mov    0x4(%edx),%edx
 6b1:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
 6b8:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6bb:	01 d1                	add    %edx,%ecx
 6bd:	8b 55 fc             	mov    -0x4(%ebp),%edx
 6c0:	8b 12                	mov    (%edx),%edx
 6c2:	39 d1                	cmp    %edx,%ecx
 6c4:	75 24                	jne    6ea <free+0x99>
    bp->s.size += p->s.ptr->s.size;
 6c6:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6c9:	8b 4a 04             	mov    0x4(%edx),%ecx
 6cc:	8b 55 fc             	mov    -0x4(%ebp),%edx
 6cf:	8b 12                	mov    (%edx),%edx
 6d1:	8b 52 04             	mov    0x4(%edx),%edx
 6d4:	01 d1                	add    %edx,%ecx
 6d6:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6d9:	89 4a 04             	mov    %ecx,0x4(%edx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6dc:	8b 55 fc             	mov    -0x4(%ebp),%edx
 6df:	8b 12                	mov    (%edx),%edx
 6e1:	8b 0a                	mov    (%edx),%ecx
 6e3:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6e6:	89 0a                	mov    %ecx,(%edx)
 6e8:	eb 0a                	jmp    6f4 <free+0xa3>
  } else
    bp->s.ptr = p->s.ptr;
 6ea:	8b 55 fc             	mov    -0x4(%ebp),%edx
 6ed:	8b 0a                	mov    (%edx),%ecx
 6ef:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6f2:	89 0a                	mov    %ecx,(%edx)
  if(p + p->s.size == bp){
 6f4:	8b 55 fc             	mov    -0x4(%ebp),%edx
 6f7:	8b 52 04             	mov    0x4(%edx),%edx
 6fa:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
 701:	8b 55 fc             	mov    -0x4(%ebp),%edx
 704:	01 ca                	add    %ecx,%edx
 706:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 709:	75 20                	jne    72b <free+0xda>
    p->s.size += bp->s.size;
 70b:	8b 55 fc             	mov    -0x4(%ebp),%edx
 70e:	8b 4a 04             	mov    0x4(%edx),%ecx
 711:	8b 55 f8             	mov    -0x8(%ebp),%edx
 714:	8b 52 04             	mov    0x4(%edx),%edx
 717:	01 d1                	add    %edx,%ecx
 719:	8b 55 fc             	mov    -0x4(%ebp),%edx
 71c:	89 4a 04             	mov    %ecx,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 71f:	8b 55 f8             	mov    -0x8(%ebp),%edx
 722:	8b 0a                	mov    (%edx),%ecx
 724:	8b 55 fc             	mov    -0x4(%ebp),%edx
 727:	89 0a                	mov    %ecx,(%edx)
 729:	eb 08                	jmp    733 <free+0xe2>
  } else
    p->s.ptr = bp;
 72b:	8b 55 fc             	mov    -0x4(%ebp),%edx
 72e:	8b 4d f8             	mov    -0x8(%ebp),%ecx
 731:	89 0a                	mov    %ecx,(%edx)
  freep = p;
 733:	8b 55 fc             	mov    -0x4(%ebp),%edx
 736:	89 90 28 00 00 00    	mov    %edx,0x28(%eax)
}
 73c:	90                   	nop
 73d:	c9                   	leave  
 73e:	c3                   	ret    

0000073f <morecore>:

static Header*
morecore(uint nu)
{
 73f:	55                   	push   %ebp
 740:	89 e5                	mov    %esp,%ebp
 742:	53                   	push   %ebx
 743:	83 ec 14             	sub    $0x14,%esp
 746:	e8 f6 f8 ff ff       	call   41 <__x86.get_pc_thunk.bx>
 74b:	81 c3 09 04 00 00    	add    $0x409,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 751:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 758:	77 07                	ja     761 <morecore+0x22>
    nu = 4096;
 75a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 761:	8b 45 08             	mov    0x8(%ebp),%eax
 764:	c1 e0 03             	shl    $0x3,%eax
 767:	83 ec 0c             	sub    $0xc,%esp
 76a:	50                   	push   %eax
 76b:	e8 26 fc ff ff       	call   396 <sbrk>
 770:	83 c4 10             	add    $0x10,%esp
 773:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 776:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 77a:	75 07                	jne    783 <morecore+0x44>
    return 0;
 77c:	b8 00 00 00 00       	mov    $0x0,%eax
 781:	eb 27                	jmp    7aa <morecore+0x6b>
  hp = (Header*)p;
 783:	8b 45 f4             	mov    -0xc(%ebp),%eax
 786:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 789:	8b 45 f0             	mov    -0x10(%ebp),%eax
 78c:	8b 55 08             	mov    0x8(%ebp),%edx
 78f:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 792:	8b 45 f0             	mov    -0x10(%ebp),%eax
 795:	83 c0 08             	add    $0x8,%eax
 798:	83 ec 0c             	sub    $0xc,%esp
 79b:	50                   	push   %eax
 79c:	e8 b0 fe ff ff       	call   651 <free>
 7a1:	83 c4 10             	add    $0x10,%esp
  return freep;
 7a4:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
}
 7aa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 7ad:	c9                   	leave  
 7ae:	c3                   	ret    

000007af <malloc>:

void*
malloc(uint nbytes)
{
 7af:	55                   	push   %ebp
 7b0:	89 e5                	mov    %esp,%ebp
 7b2:	53                   	push   %ebx
 7b3:	83 ec 14             	sub    $0x14,%esp
 7b6:	e8 86 f8 ff ff       	call   41 <__x86.get_pc_thunk.bx>
 7bb:	81 c3 99 03 00 00    	add    $0x399,%ebx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7c1:	8b 45 08             	mov    0x8(%ebp),%eax
 7c4:	83 c0 07             	add    $0x7,%eax
 7c7:	c1 e8 03             	shr    $0x3,%eax
 7ca:	83 c0 01             	add    $0x1,%eax
 7cd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7d0:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
 7d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7d9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7dd:	75 28                	jne    807 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
 7df:	8d 83 20 00 00 00    	lea    0x20(%ebx),%eax
 7e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7eb:	89 83 28 00 00 00    	mov    %eax,0x28(%ebx)
 7f1:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
 7f7:	89 83 20 00 00 00    	mov    %eax,0x20(%ebx)
    base.s.size = 0;
 7fd:	c7 83 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
 804:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 807:	8b 45 f0             	mov    -0x10(%ebp),%eax
 80a:	8b 00                	mov    (%eax),%eax
 80c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 80f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 812:	8b 40 04             	mov    0x4(%eax),%eax
 815:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 818:	77 4e                	ja     868 <malloc+0xb9>
      if(p->s.size == nunits)
 81a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81d:	8b 40 04             	mov    0x4(%eax),%eax
 820:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 823:	75 0c                	jne    831 <malloc+0x82>
        prevp->s.ptr = p->s.ptr;
 825:	8b 45 f4             	mov    -0xc(%ebp),%eax
 828:	8b 10                	mov    (%eax),%edx
 82a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 82d:	89 10                	mov    %edx,(%eax)
 82f:	eb 26                	jmp    857 <malloc+0xa8>
      else {
        p->s.size -= nunits;
 831:	8b 45 f4             	mov    -0xc(%ebp),%eax
 834:	8b 40 04             	mov    0x4(%eax),%eax
 837:	2b 45 ec             	sub    -0x14(%ebp),%eax
 83a:	89 c2                	mov    %eax,%edx
 83c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 83f:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 842:	8b 45 f4             	mov    -0xc(%ebp),%eax
 845:	8b 40 04             	mov    0x4(%eax),%eax
 848:	c1 e0 03             	shl    $0x3,%eax
 84b:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 84e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 851:	8b 55 ec             	mov    -0x14(%ebp),%edx
 854:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 857:	8b 45 f0             	mov    -0x10(%ebp),%eax
 85a:	89 83 28 00 00 00    	mov    %eax,0x28(%ebx)
      return (void*)(p + 1);
 860:	8b 45 f4             	mov    -0xc(%ebp),%eax
 863:	83 c0 08             	add    $0x8,%eax
 866:	eb 3c                	jmp    8a4 <malloc+0xf5>
    }
    if(p == freep)
 868:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
 86e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 871:	75 1e                	jne    891 <malloc+0xe2>
      if((p = morecore(nunits)) == 0)
 873:	83 ec 0c             	sub    $0xc,%esp
 876:	ff 75 ec             	push   -0x14(%ebp)
 879:	e8 c1 fe ff ff       	call   73f <morecore>
 87e:	83 c4 10             	add    $0x10,%esp
 881:	89 45 f4             	mov    %eax,-0xc(%ebp)
 884:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 888:	75 07                	jne    891 <malloc+0xe2>
        return 0;
 88a:	b8 00 00 00 00       	mov    $0x0,%eax
 88f:	eb 13                	jmp    8a4 <malloc+0xf5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 891:	8b 45 f4             	mov    -0xc(%ebp),%eax
 894:	89 45 f0             	mov    %eax,-0x10(%ebp)
 897:	8b 45 f4             	mov    -0xc(%ebp),%eax
 89a:	8b 00                	mov    (%eax),%eax
 89c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 89f:	e9 6b ff ff ff       	jmp    80f <malloc+0x60>
  }
}
 8a4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 8a7:	c9                   	leave  
 8a8:	c3                   	ret    
