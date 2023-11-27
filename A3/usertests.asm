
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <iputtest>:
int stdout = 1;

// does chdir() call iput(p->cwd) in a transaction?
void
iputtest(void)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	53                   	push   %ebx
       4:	83 ec 04             	sub    $0x4,%esp
       7:	e8 c7 43 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
       c:	81 c3 64 6c 00 00    	add    $0x6c64,%ebx
  printf(stdout, "iput test\n");
      12:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
      18:	83 ec 08             	sub    $0x8,%esp
      1b:	8d 93 de df ff ff    	lea    -0x2022(%ebx),%edx
      21:	52                   	push   %edx
      22:	50                   	push   %eax
      23:	e8 10 48 00 00       	call   4838 <printf>
      28:	83 c4 10             	add    $0x10,%esp

  if(mkdir("iputdir") < 0){
      2b:	83 ec 0c             	sub    $0xc,%esp
      2e:	8d 83 e9 df ff ff    	lea    -0x2017(%ebx),%eax
      34:	50                   	push   %eax
      35:	e8 ca 46 00 00       	call   4704 <mkdir>
      3a:	83 c4 10             	add    $0x10,%esp
      3d:	85 c0                	test   %eax,%eax
      3f:	79 1e                	jns    5f <iputtest+0x5f>
    printf(stdout, "mkdir failed\n");
      41:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
      47:	83 ec 08             	sub    $0x8,%esp
      4a:	8d 93 f1 df ff ff    	lea    -0x200f(%ebx),%edx
      50:	52                   	push   %edx
      51:	50                   	push   %eax
      52:	e8 e1 47 00 00       	call   4838 <printf>
      57:	83 c4 10             	add    $0x10,%esp
    exit();
      5a:	e8 3d 46 00 00       	call   469c <exit>
  }
  if(chdir("iputdir") < 0){
      5f:	83 ec 0c             	sub    $0xc,%esp
      62:	8d 83 e9 df ff ff    	lea    -0x2017(%ebx),%eax
      68:	50                   	push   %eax
      69:	e8 9e 46 00 00       	call   470c <chdir>
      6e:	83 c4 10             	add    $0x10,%esp
      71:	85 c0                	test   %eax,%eax
      73:	79 1e                	jns    93 <iputtest+0x93>
    printf(stdout, "chdir iputdir failed\n");
      75:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
      7b:	83 ec 08             	sub    $0x8,%esp
      7e:	8d 93 ff df ff ff    	lea    -0x2001(%ebx),%edx
      84:	52                   	push   %edx
      85:	50                   	push   %eax
      86:	e8 ad 47 00 00       	call   4838 <printf>
      8b:	83 c4 10             	add    $0x10,%esp
    exit();
      8e:	e8 09 46 00 00       	call   469c <exit>
  }
  if(unlink("../iputdir") < 0){
      93:	83 ec 0c             	sub    $0xc,%esp
      96:	8d 83 15 e0 ff ff    	lea    -0x1feb(%ebx),%eax
      9c:	50                   	push   %eax
      9d:	e8 4a 46 00 00       	call   46ec <unlink>
      a2:	83 c4 10             	add    $0x10,%esp
      a5:	85 c0                	test   %eax,%eax
      a7:	79 1e                	jns    c7 <iputtest+0xc7>
    printf(stdout, "unlink ../iputdir failed\n");
      a9:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
      af:	83 ec 08             	sub    $0x8,%esp
      b2:	8d 93 20 e0 ff ff    	lea    -0x1fe0(%ebx),%edx
      b8:	52                   	push   %edx
      b9:	50                   	push   %eax
      ba:	e8 79 47 00 00       	call   4838 <printf>
      bf:	83 c4 10             	add    $0x10,%esp
    exit();
      c2:	e8 d5 45 00 00       	call   469c <exit>
  }
  if(chdir("/") < 0){
      c7:	83 ec 0c             	sub    $0xc,%esp
      ca:	8d 83 3a e0 ff ff    	lea    -0x1fc6(%ebx),%eax
      d0:	50                   	push   %eax
      d1:	e8 36 46 00 00       	call   470c <chdir>
      d6:	83 c4 10             	add    $0x10,%esp
      d9:	85 c0                	test   %eax,%eax
      db:	79 1e                	jns    fb <iputtest+0xfb>
    printf(stdout, "chdir / failed\n");
      dd:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
      e3:	83 ec 08             	sub    $0x8,%esp
      e6:	8d 93 3c e0 ff ff    	lea    -0x1fc4(%ebx),%edx
      ec:	52                   	push   %edx
      ed:	50                   	push   %eax
      ee:	e8 45 47 00 00       	call   4838 <printf>
      f3:	83 c4 10             	add    $0x10,%esp
    exit();
      f6:	e8 a1 45 00 00       	call   469c <exit>
  }
  printf(stdout, "iput test ok\n");
      fb:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     101:	83 ec 08             	sub    $0x8,%esp
     104:	8d 93 4c e0 ff ff    	lea    -0x1fb4(%ebx),%edx
     10a:	52                   	push   %edx
     10b:	50                   	push   %eax
     10c:	e8 27 47 00 00       	call   4838 <printf>
     111:	83 c4 10             	add    $0x10,%esp
}
     114:	90                   	nop
     115:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     118:	c9                   	leave  
     119:	c3                   	ret    

0000011a <exitiputtest>:

// does exit() call iput(p->cwd) in a transaction?
void
exitiputtest(void)
{
     11a:	55                   	push   %ebp
     11b:	89 e5                	mov    %esp,%ebp
     11d:	53                   	push   %ebx
     11e:	83 ec 14             	sub    $0x14,%esp
     121:	e8 ad 42 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
     126:	81 c3 4a 6b 00 00    	add    $0x6b4a,%ebx
  int pid;

  printf(stdout, "exitiput test\n");
     12c:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     132:	83 ec 08             	sub    $0x8,%esp
     135:	8d 93 5a e0 ff ff    	lea    -0x1fa6(%ebx),%edx
     13b:	52                   	push   %edx
     13c:	50                   	push   %eax
     13d:	e8 f6 46 00 00       	call   4838 <printf>
     142:	83 c4 10             	add    $0x10,%esp

  pid = fork();
     145:	e8 4a 45 00 00       	call   4694 <fork>
     14a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid < 0){
     14d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     151:	79 1e                	jns    171 <exitiputtest+0x57>
    printf(stdout, "fork failed\n");
     153:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     159:	83 ec 08             	sub    $0x8,%esp
     15c:	8d 93 69 e0 ff ff    	lea    -0x1f97(%ebx),%edx
     162:	52                   	push   %edx
     163:	50                   	push   %eax
     164:	e8 cf 46 00 00       	call   4838 <printf>
     169:	83 c4 10             	add    $0x10,%esp
    exit();
     16c:	e8 2b 45 00 00       	call   469c <exit>
  }
  if(pid == 0){
     171:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     175:	0f 85 a1 00 00 00    	jne    21c <exitiputtest+0x102>
    if(mkdir("iputdir") < 0){
     17b:	83 ec 0c             	sub    $0xc,%esp
     17e:	8d 83 e9 df ff ff    	lea    -0x2017(%ebx),%eax
     184:	50                   	push   %eax
     185:	e8 7a 45 00 00       	call   4704 <mkdir>
     18a:	83 c4 10             	add    $0x10,%esp
     18d:	85 c0                	test   %eax,%eax
     18f:	79 1e                	jns    1af <exitiputtest+0x95>
      printf(stdout, "mkdir failed\n");
     191:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     197:	83 ec 08             	sub    $0x8,%esp
     19a:	8d 93 f1 df ff ff    	lea    -0x200f(%ebx),%edx
     1a0:	52                   	push   %edx
     1a1:	50                   	push   %eax
     1a2:	e8 91 46 00 00       	call   4838 <printf>
     1a7:	83 c4 10             	add    $0x10,%esp
      exit();
     1aa:	e8 ed 44 00 00       	call   469c <exit>
    }
    if(chdir("iputdir") < 0){
     1af:	83 ec 0c             	sub    $0xc,%esp
     1b2:	8d 83 e9 df ff ff    	lea    -0x2017(%ebx),%eax
     1b8:	50                   	push   %eax
     1b9:	e8 4e 45 00 00       	call   470c <chdir>
     1be:	83 c4 10             	add    $0x10,%esp
     1c1:	85 c0                	test   %eax,%eax
     1c3:	79 1e                	jns    1e3 <exitiputtest+0xc9>
      printf(stdout, "child chdir failed\n");
     1c5:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     1cb:	83 ec 08             	sub    $0x8,%esp
     1ce:	8d 93 76 e0 ff ff    	lea    -0x1f8a(%ebx),%edx
     1d4:	52                   	push   %edx
     1d5:	50                   	push   %eax
     1d6:	e8 5d 46 00 00       	call   4838 <printf>
     1db:	83 c4 10             	add    $0x10,%esp
      exit();
     1de:	e8 b9 44 00 00       	call   469c <exit>
    }
    if(unlink("../iputdir") < 0){
     1e3:	83 ec 0c             	sub    $0xc,%esp
     1e6:	8d 83 15 e0 ff ff    	lea    -0x1feb(%ebx),%eax
     1ec:	50                   	push   %eax
     1ed:	e8 fa 44 00 00       	call   46ec <unlink>
     1f2:	83 c4 10             	add    $0x10,%esp
     1f5:	85 c0                	test   %eax,%eax
     1f7:	79 1e                	jns    217 <exitiputtest+0xfd>
      printf(stdout, "unlink ../iputdir failed\n");
     1f9:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     1ff:	83 ec 08             	sub    $0x8,%esp
     202:	8d 93 20 e0 ff ff    	lea    -0x1fe0(%ebx),%edx
     208:	52                   	push   %edx
     209:	50                   	push   %eax
     20a:	e8 29 46 00 00       	call   4838 <printf>
     20f:	83 c4 10             	add    $0x10,%esp
      exit();
     212:	e8 85 44 00 00       	call   469c <exit>
    }
    exit();
     217:	e8 80 44 00 00       	call   469c <exit>
  }
  wait();
     21c:	e8 83 44 00 00       	call   46a4 <wait>
  printf(stdout, "exitiput test ok\n");
     221:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     227:	83 ec 08             	sub    $0x8,%esp
     22a:	8d 93 8a e0 ff ff    	lea    -0x1f76(%ebx),%edx
     230:	52                   	push   %edx
     231:	50                   	push   %eax
     232:	e8 01 46 00 00       	call   4838 <printf>
     237:	83 c4 10             	add    $0x10,%esp
}
     23a:	90                   	nop
     23b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     23e:	c9                   	leave  
     23f:	c3                   	ret    

00000240 <openiputtest>:
//      for(i = 0; i < 10000; i++)
//        yield();
//    }
void
openiputtest(void)
{
     240:	55                   	push   %ebp
     241:	89 e5                	mov    %esp,%ebp
     243:	53                   	push   %ebx
     244:	83 ec 14             	sub    $0x14,%esp
     247:	e8 87 41 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
     24c:	81 c3 24 6a 00 00    	add    $0x6a24,%ebx
  int pid;

  printf(stdout, "openiput test\n");
     252:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     258:	83 ec 08             	sub    $0x8,%esp
     25b:	8d 93 9c e0 ff ff    	lea    -0x1f64(%ebx),%edx
     261:	52                   	push   %edx
     262:	50                   	push   %eax
     263:	e8 d0 45 00 00       	call   4838 <printf>
     268:	83 c4 10             	add    $0x10,%esp
  if(mkdir("oidir") < 0){
     26b:	83 ec 0c             	sub    $0xc,%esp
     26e:	8d 83 ab e0 ff ff    	lea    -0x1f55(%ebx),%eax
     274:	50                   	push   %eax
     275:	e8 8a 44 00 00       	call   4704 <mkdir>
     27a:	83 c4 10             	add    $0x10,%esp
     27d:	85 c0                	test   %eax,%eax
     27f:	79 1e                	jns    29f <openiputtest+0x5f>
    printf(stdout, "mkdir oidir failed\n");
     281:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     287:	83 ec 08             	sub    $0x8,%esp
     28a:	8d 93 b1 e0 ff ff    	lea    -0x1f4f(%ebx),%edx
     290:	52                   	push   %edx
     291:	50                   	push   %eax
     292:	e8 a1 45 00 00       	call   4838 <printf>
     297:	83 c4 10             	add    $0x10,%esp
    exit();
     29a:	e8 fd 43 00 00       	call   469c <exit>
  }
  pid = fork();
     29f:	e8 f0 43 00 00       	call   4694 <fork>
     2a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid < 0){
     2a7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     2ab:	79 1e                	jns    2cb <openiputtest+0x8b>
    printf(stdout, "fork failed\n");
     2ad:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     2b3:	83 ec 08             	sub    $0x8,%esp
     2b6:	8d 93 69 e0 ff ff    	lea    -0x1f97(%ebx),%edx
     2bc:	52                   	push   %edx
     2bd:	50                   	push   %eax
     2be:	e8 75 45 00 00       	call   4838 <printf>
     2c3:	83 c4 10             	add    $0x10,%esp
    exit();
     2c6:	e8 d1 43 00 00       	call   469c <exit>
  }
  if(pid == 0){
     2cb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     2cf:	75 40                	jne    311 <openiputtest+0xd1>
    int fd = open("oidir", O_RDWR);
     2d1:	83 ec 08             	sub    $0x8,%esp
     2d4:	6a 02                	push   $0x2
     2d6:	8d 83 ab e0 ff ff    	lea    -0x1f55(%ebx),%eax
     2dc:	50                   	push   %eax
     2dd:	e8 fa 43 00 00       	call   46dc <open>
     2e2:	83 c4 10             	add    $0x10,%esp
     2e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0){
     2e8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     2ec:	78 1e                	js     30c <openiputtest+0xcc>
      printf(stdout, "open directory for write succeeded\n");
     2ee:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     2f4:	83 ec 08             	sub    $0x8,%esp
     2f7:	8d 93 c8 e0 ff ff    	lea    -0x1f38(%ebx),%edx
     2fd:	52                   	push   %edx
     2fe:	50                   	push   %eax
     2ff:	e8 34 45 00 00       	call   4838 <printf>
     304:	83 c4 10             	add    $0x10,%esp
      exit();
     307:	e8 90 43 00 00       	call   469c <exit>
    }
    exit();
     30c:	e8 8b 43 00 00       	call   469c <exit>
  }
  sleep(1);
     311:	83 ec 0c             	sub    $0xc,%esp
     314:	6a 01                	push   $0x1
     316:	e8 11 44 00 00       	call   472c <sleep>
     31b:	83 c4 10             	add    $0x10,%esp
  if(unlink("oidir") != 0){
     31e:	83 ec 0c             	sub    $0xc,%esp
     321:	8d 83 ab e0 ff ff    	lea    -0x1f55(%ebx),%eax
     327:	50                   	push   %eax
     328:	e8 bf 43 00 00       	call   46ec <unlink>
     32d:	83 c4 10             	add    $0x10,%esp
     330:	85 c0                	test   %eax,%eax
     332:	74 1e                	je     352 <openiputtest+0x112>
    printf(stdout, "unlink failed\n");
     334:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     33a:	83 ec 08             	sub    $0x8,%esp
     33d:	8d 93 ec e0 ff ff    	lea    -0x1f14(%ebx),%edx
     343:	52                   	push   %edx
     344:	50                   	push   %eax
     345:	e8 ee 44 00 00       	call   4838 <printf>
     34a:	83 c4 10             	add    $0x10,%esp
    exit();
     34d:	e8 4a 43 00 00       	call   469c <exit>
  }
  wait();
     352:	e8 4d 43 00 00       	call   46a4 <wait>
  printf(stdout, "openiput test ok\n");
     357:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     35d:	83 ec 08             	sub    $0x8,%esp
     360:	8d 93 fb e0 ff ff    	lea    -0x1f05(%ebx),%edx
     366:	52                   	push   %edx
     367:	50                   	push   %eax
     368:	e8 cb 44 00 00       	call   4838 <printf>
     36d:	83 c4 10             	add    $0x10,%esp
}
     370:	90                   	nop
     371:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     374:	c9                   	leave  
     375:	c3                   	ret    

00000376 <opentest>:

// simple file system tests

void
opentest(void)
{
     376:	55                   	push   %ebp
     377:	89 e5                	mov    %esp,%ebp
     379:	53                   	push   %ebx
     37a:	83 ec 14             	sub    $0x14,%esp
     37d:	e8 51 40 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
     382:	81 c3 ee 68 00 00    	add    $0x68ee,%ebx
  int fd;

  printf(stdout, "open test\n");
     388:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     38e:	83 ec 08             	sub    $0x8,%esp
     391:	8d 93 0d e1 ff ff    	lea    -0x1ef3(%ebx),%edx
     397:	52                   	push   %edx
     398:	50                   	push   %eax
     399:	e8 9a 44 00 00       	call   4838 <printf>
     39e:	83 c4 10             	add    $0x10,%esp
  fd = open("echo", 0);
     3a1:	83 ec 08             	sub    $0x8,%esp
     3a4:	6a 00                	push   $0x0
     3a6:	8d 83 c8 df ff ff    	lea    -0x2038(%ebx),%eax
     3ac:	50                   	push   %eax
     3ad:	e8 2a 43 00 00       	call   46dc <open>
     3b2:	83 c4 10             	add    $0x10,%esp
     3b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
     3b8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     3bc:	79 1e                	jns    3dc <opentest+0x66>
    printf(stdout, "open echo failed!\n");
     3be:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     3c4:	83 ec 08             	sub    $0x8,%esp
     3c7:	8d 93 18 e1 ff ff    	lea    -0x1ee8(%ebx),%edx
     3cd:	52                   	push   %edx
     3ce:	50                   	push   %eax
     3cf:	e8 64 44 00 00       	call   4838 <printf>
     3d4:	83 c4 10             	add    $0x10,%esp
    exit();
     3d7:	e8 c0 42 00 00       	call   469c <exit>
  }
  close(fd);
     3dc:	83 ec 0c             	sub    $0xc,%esp
     3df:	ff 75 f4             	push   -0xc(%ebp)
     3e2:	e8 dd 42 00 00       	call   46c4 <close>
     3e7:	83 c4 10             	add    $0x10,%esp
  fd = open("doesnotexist", 0);
     3ea:	83 ec 08             	sub    $0x8,%esp
     3ed:	6a 00                	push   $0x0
     3ef:	8d 83 2b e1 ff ff    	lea    -0x1ed5(%ebx),%eax
     3f5:	50                   	push   %eax
     3f6:	e8 e1 42 00 00       	call   46dc <open>
     3fb:	83 c4 10             	add    $0x10,%esp
     3fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
     401:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     405:	78 1e                	js     425 <opentest+0xaf>
    printf(stdout, "open doesnotexist succeeded!\n");
     407:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     40d:	83 ec 08             	sub    $0x8,%esp
     410:	8d 93 38 e1 ff ff    	lea    -0x1ec8(%ebx),%edx
     416:	52                   	push   %edx
     417:	50                   	push   %eax
     418:	e8 1b 44 00 00       	call   4838 <printf>
     41d:	83 c4 10             	add    $0x10,%esp
    exit();
     420:	e8 77 42 00 00       	call   469c <exit>
  }
  printf(stdout, "open test ok\n");
     425:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     42b:	83 ec 08             	sub    $0x8,%esp
     42e:	8d 93 56 e1 ff ff    	lea    -0x1eaa(%ebx),%edx
     434:	52                   	push   %edx
     435:	50                   	push   %eax
     436:	e8 fd 43 00 00       	call   4838 <printf>
     43b:	83 c4 10             	add    $0x10,%esp
}
     43e:	90                   	nop
     43f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     442:	c9                   	leave  
     443:	c3                   	ret    

00000444 <writetest>:

void
writetest(void)
{
     444:	55                   	push   %ebp
     445:	89 e5                	mov    %esp,%ebp
     447:	53                   	push   %ebx
     448:	83 ec 14             	sub    $0x14,%esp
     44b:	e8 83 3f 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
     450:	81 c3 20 68 00 00    	add    $0x6820,%ebx
  int fd;
  int i;

  printf(stdout, "small file test\n");
     456:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     45c:	83 ec 08             	sub    $0x8,%esp
     45f:	8d 93 64 e1 ff ff    	lea    -0x1e9c(%ebx),%edx
     465:	52                   	push   %edx
     466:	50                   	push   %eax
     467:	e8 cc 43 00 00       	call   4838 <printf>
     46c:	83 c4 10             	add    $0x10,%esp
  fd = open("small", O_CREATE|O_RDWR);
     46f:	83 ec 08             	sub    $0x8,%esp
     472:	68 02 02 00 00       	push   $0x202
     477:	8d 83 75 e1 ff ff    	lea    -0x1e8b(%ebx),%eax
     47d:	50                   	push   %eax
     47e:	e8 59 42 00 00       	call   46dc <open>
     483:	83 c4 10             	add    $0x10,%esp
     486:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd >= 0){
     489:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     48d:	78 25                	js     4b4 <writetest+0x70>
    printf(stdout, "creat small succeeded; ok\n");
     48f:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     495:	83 ec 08             	sub    $0x8,%esp
     498:	8d 93 7b e1 ff ff    	lea    -0x1e85(%ebx),%edx
     49e:	52                   	push   %edx
     49f:	50                   	push   %eax
     4a0:	e8 93 43 00 00       	call   4838 <printf>
     4a5:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
     4a8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     4af:	e9 9c 00 00 00       	jmp    550 <writetest+0x10c>
    printf(stdout, "error: creat small failed!\n");
     4b4:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     4ba:	83 ec 08             	sub    $0x8,%esp
     4bd:	8d 93 96 e1 ff ff    	lea    -0x1e6a(%ebx),%edx
     4c3:	52                   	push   %edx
     4c4:	50                   	push   %eax
     4c5:	e8 6e 43 00 00       	call   4838 <printf>
     4ca:	83 c4 10             	add    $0x10,%esp
    exit();
     4cd:	e8 ca 41 00 00       	call   469c <exit>
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     4d2:	83 ec 04             	sub    $0x4,%esp
     4d5:	6a 0a                	push   $0xa
     4d7:	8d 83 b2 e1 ff ff    	lea    -0x1e4e(%ebx),%eax
     4dd:	50                   	push   %eax
     4de:	ff 75 f0             	push   -0x10(%ebp)
     4e1:	e8 d6 41 00 00       	call   46bc <write>
     4e6:	83 c4 10             	add    $0x10,%esp
     4e9:	83 f8 0a             	cmp    $0xa,%eax
     4ec:	74 21                	je     50f <writetest+0xcb>
      printf(stdout, "error: write aa %d new file failed\n", i);
     4ee:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     4f4:	83 ec 04             	sub    $0x4,%esp
     4f7:	ff 75 f4             	push   -0xc(%ebp)
     4fa:	8d 93 c0 e1 ff ff    	lea    -0x1e40(%ebx),%edx
     500:	52                   	push   %edx
     501:	50                   	push   %eax
     502:	e8 31 43 00 00       	call   4838 <printf>
     507:	83 c4 10             	add    $0x10,%esp
      exit();
     50a:	e8 8d 41 00 00       	call   469c <exit>
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     50f:	83 ec 04             	sub    $0x4,%esp
     512:	6a 0a                	push   $0xa
     514:	8d 83 e4 e1 ff ff    	lea    -0x1e1c(%ebx),%eax
     51a:	50                   	push   %eax
     51b:	ff 75 f0             	push   -0x10(%ebp)
     51e:	e8 99 41 00 00       	call   46bc <write>
     523:	83 c4 10             	add    $0x10,%esp
     526:	83 f8 0a             	cmp    $0xa,%eax
     529:	74 21                	je     54c <writetest+0x108>
      printf(stdout, "error: write bb %d new file failed\n", i);
     52b:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     531:	83 ec 04             	sub    $0x4,%esp
     534:	ff 75 f4             	push   -0xc(%ebp)
     537:	8d 93 f0 e1 ff ff    	lea    -0x1e10(%ebx),%edx
     53d:	52                   	push   %edx
     53e:	50                   	push   %eax
     53f:	e8 f4 42 00 00       	call   4838 <printf>
     544:	83 c4 10             	add    $0x10,%esp
      exit();
     547:	e8 50 41 00 00       	call   469c <exit>
  for(i = 0; i < 100; i++){
     54c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     550:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
     554:	0f 8e 78 ff ff ff    	jle    4d2 <writetest+0x8e>
    }
  }
  printf(stdout, "writes ok\n");
     55a:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     560:	83 ec 08             	sub    $0x8,%esp
     563:	8d 93 14 e2 ff ff    	lea    -0x1dec(%ebx),%edx
     569:	52                   	push   %edx
     56a:	50                   	push   %eax
     56b:	e8 c8 42 00 00       	call   4838 <printf>
     570:	83 c4 10             	add    $0x10,%esp
  close(fd);
     573:	83 ec 0c             	sub    $0xc,%esp
     576:	ff 75 f0             	push   -0x10(%ebp)
     579:	e8 46 41 00 00       	call   46c4 <close>
     57e:	83 c4 10             	add    $0x10,%esp
  fd = open("small", O_RDONLY);
     581:	83 ec 08             	sub    $0x8,%esp
     584:	6a 00                	push   $0x0
     586:	8d 83 75 e1 ff ff    	lea    -0x1e8b(%ebx),%eax
     58c:	50                   	push   %eax
     58d:	e8 4a 41 00 00       	call   46dc <open>
     592:	83 c4 10             	add    $0x10,%esp
     595:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd >= 0){
     598:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     59c:	78 41                	js     5df <writetest+0x19b>
    printf(stdout, "open small succeeded ok\n");
     59e:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     5a4:	83 ec 08             	sub    $0x8,%esp
     5a7:	8d 93 1f e2 ff ff    	lea    -0x1de1(%ebx),%edx
     5ad:	52                   	push   %edx
     5ae:	50                   	push   %eax
     5af:	e8 84 42 00 00       	call   4838 <printf>
     5b4:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "error: open small failed!\n");
    exit();
  }
  i = read(fd, buf, 2000);
     5b7:	83 ec 04             	sub    $0x4,%esp
     5ba:	68 d0 07 00 00       	push   $0x7d0
     5bf:	8d 83 50 00 00 00    	lea    0x50(%ebx),%eax
     5c5:	50                   	push   %eax
     5c6:	ff 75 f0             	push   -0x10(%ebp)
     5c9:	e8 e6 40 00 00       	call   46b4 <read>
     5ce:	83 c4 10             	add    $0x10,%esp
     5d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(i == 2000){
     5d4:	81 7d f4 d0 07 00 00 	cmpl   $0x7d0,-0xc(%ebp)
     5db:	75 5f                	jne    63c <writetest+0x1f8>
     5dd:	eb 1e                	jmp    5fd <writetest+0x1b9>
    printf(stdout, "error: open small failed!\n");
     5df:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     5e5:	83 ec 08             	sub    $0x8,%esp
     5e8:	8d 93 38 e2 ff ff    	lea    -0x1dc8(%ebx),%edx
     5ee:	52                   	push   %edx
     5ef:	50                   	push   %eax
     5f0:	e8 43 42 00 00       	call   4838 <printf>
     5f5:	83 c4 10             	add    $0x10,%esp
    exit();
     5f8:	e8 9f 40 00 00       	call   469c <exit>
    printf(stdout, "read succeeded ok\n");
     5fd:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     603:	83 ec 08             	sub    $0x8,%esp
     606:	8d 93 53 e2 ff ff    	lea    -0x1dad(%ebx),%edx
     60c:	52                   	push   %edx
     60d:	50                   	push   %eax
     60e:	e8 25 42 00 00       	call   4838 <printf>
     613:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  close(fd);
     616:	83 ec 0c             	sub    $0xc,%esp
     619:	ff 75 f0             	push   -0x10(%ebp)
     61c:	e8 a3 40 00 00       	call   46c4 <close>
     621:	83 c4 10             	add    $0x10,%esp

  if(unlink("small") < 0){
     624:	83 ec 0c             	sub    $0xc,%esp
     627:	8d 83 75 e1 ff ff    	lea    -0x1e8b(%ebx),%eax
     62d:	50                   	push   %eax
     62e:	e8 b9 40 00 00       	call   46ec <unlink>
     633:	83 c4 10             	add    $0x10,%esp
     636:	85 c0                	test   %eax,%eax
     638:	79 3e                	jns    678 <writetest+0x234>
     63a:	eb 1e                	jmp    65a <writetest+0x216>
    printf(stdout, "read failed\n");
     63c:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     642:	83 ec 08             	sub    $0x8,%esp
     645:	8d 93 66 e2 ff ff    	lea    -0x1d9a(%ebx),%edx
     64b:	52                   	push   %edx
     64c:	50                   	push   %eax
     64d:	e8 e6 41 00 00       	call   4838 <printf>
     652:	83 c4 10             	add    $0x10,%esp
    exit();
     655:	e8 42 40 00 00       	call   469c <exit>
    printf(stdout, "unlink small failed\n");
     65a:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     660:	83 ec 08             	sub    $0x8,%esp
     663:	8d 93 73 e2 ff ff    	lea    -0x1d8d(%ebx),%edx
     669:	52                   	push   %edx
     66a:	50                   	push   %eax
     66b:	e8 c8 41 00 00       	call   4838 <printf>
     670:	83 c4 10             	add    $0x10,%esp
    exit();
     673:	e8 24 40 00 00       	call   469c <exit>
  }
  printf(stdout, "small file test ok\n");
     678:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     67e:	83 ec 08             	sub    $0x8,%esp
     681:	8d 93 88 e2 ff ff    	lea    -0x1d78(%ebx),%edx
     687:	52                   	push   %edx
     688:	50                   	push   %eax
     689:	e8 aa 41 00 00       	call   4838 <printf>
     68e:	83 c4 10             	add    $0x10,%esp
}
     691:	90                   	nop
     692:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     695:	c9                   	leave  
     696:	c3                   	ret    

00000697 <writetest1>:

void
writetest1(void)
{
     697:	55                   	push   %ebp
     698:	89 e5                	mov    %esp,%ebp
     69a:	53                   	push   %ebx
     69b:	83 ec 14             	sub    $0x14,%esp
     69e:	e8 30 3d 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
     6a3:	81 c3 cd 65 00 00    	add    $0x65cd,%ebx
  int i, fd, n;

  printf(stdout, "big files test\n");
     6a9:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     6af:	83 ec 08             	sub    $0x8,%esp
     6b2:	8d 93 9c e2 ff ff    	lea    -0x1d64(%ebx),%edx
     6b8:	52                   	push   %edx
     6b9:	50                   	push   %eax
     6ba:	e8 79 41 00 00       	call   4838 <printf>
     6bf:	83 c4 10             	add    $0x10,%esp

  fd = open("big", O_CREATE|O_RDWR);
     6c2:	83 ec 08             	sub    $0x8,%esp
     6c5:	68 02 02 00 00       	push   $0x202
     6ca:	8d 83 ac e2 ff ff    	lea    -0x1d54(%ebx),%eax
     6d0:	50                   	push   %eax
     6d1:	e8 06 40 00 00       	call   46dc <open>
     6d6:	83 c4 10             	add    $0x10,%esp
     6d9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
     6dc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     6e0:	79 1e                	jns    700 <writetest1+0x69>
    printf(stdout, "error: creat big failed!\n");
     6e2:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     6e8:	83 ec 08             	sub    $0x8,%esp
     6eb:	8d 93 b0 e2 ff ff    	lea    -0x1d50(%ebx),%edx
     6f1:	52                   	push   %edx
     6f2:	50                   	push   %eax
     6f3:	e8 40 41 00 00       	call   4838 <printf>
     6f8:	83 c4 10             	add    $0x10,%esp
    exit();
     6fb:	e8 9c 3f 00 00       	call   469c <exit>
  }

  for(i = 0; i < MAXFILE; i++){
     700:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     707:	eb 51                	jmp    75a <writetest1+0xc3>
    ((int*)buf)[0] = i;
     709:	8d 83 50 00 00 00    	lea    0x50(%ebx),%eax
     70f:	8b 55 f4             	mov    -0xc(%ebp),%edx
     712:	89 10                	mov    %edx,(%eax)
    if(write(fd, buf, 512) != 512){
     714:	83 ec 04             	sub    $0x4,%esp
     717:	68 00 02 00 00       	push   $0x200
     71c:	8d 83 50 00 00 00    	lea    0x50(%ebx),%eax
     722:	50                   	push   %eax
     723:	ff 75 ec             	push   -0x14(%ebp)
     726:	e8 91 3f 00 00       	call   46bc <write>
     72b:	83 c4 10             	add    $0x10,%esp
     72e:	3d 00 02 00 00       	cmp    $0x200,%eax
     733:	74 21                	je     756 <writetest1+0xbf>
      printf(stdout, "error: write big file failed\n", i);
     735:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     73b:	83 ec 04             	sub    $0x4,%esp
     73e:	ff 75 f4             	push   -0xc(%ebp)
     741:	8d 93 ca e2 ff ff    	lea    -0x1d36(%ebx),%edx
     747:	52                   	push   %edx
     748:	50                   	push   %eax
     749:	e8 ea 40 00 00       	call   4838 <printf>
     74e:	83 c4 10             	add    $0x10,%esp
      exit();
     751:	e8 46 3f 00 00       	call   469c <exit>
  for(i = 0; i < MAXFILE; i++){
     756:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     75a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     75d:	3d 8b 00 00 00       	cmp    $0x8b,%eax
     762:	76 a5                	jbe    709 <writetest1+0x72>
    }
  }

  close(fd);
     764:	83 ec 0c             	sub    $0xc,%esp
     767:	ff 75 ec             	push   -0x14(%ebp)
     76a:	e8 55 3f 00 00       	call   46c4 <close>
     76f:	83 c4 10             	add    $0x10,%esp

  fd = open("big", O_RDONLY);
     772:	83 ec 08             	sub    $0x8,%esp
     775:	6a 00                	push   $0x0
     777:	8d 83 ac e2 ff ff    	lea    -0x1d54(%ebx),%eax
     77d:	50                   	push   %eax
     77e:	e8 59 3f 00 00       	call   46dc <open>
     783:	83 c4 10             	add    $0x10,%esp
     786:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
     789:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     78d:	79 1e                	jns    7ad <writetest1+0x116>
    printf(stdout, "error: open big failed!\n");
     78f:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     795:	83 ec 08             	sub    $0x8,%esp
     798:	8d 93 e8 e2 ff ff    	lea    -0x1d18(%ebx),%edx
     79e:	52                   	push   %edx
     79f:	50                   	push   %eax
     7a0:	e8 93 40 00 00       	call   4838 <printf>
     7a5:	83 c4 10             	add    $0x10,%esp
    exit();
     7a8:	e8 ef 3e 00 00       	call   469c <exit>
  }

  n = 0;
     7ad:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(;;){
    i = read(fd, buf, 512);
     7b4:	83 ec 04             	sub    $0x4,%esp
     7b7:	68 00 02 00 00       	push   $0x200
     7bc:	8d 83 50 00 00 00    	lea    0x50(%ebx),%eax
     7c2:	50                   	push   %eax
     7c3:	ff 75 ec             	push   -0x14(%ebp)
     7c6:	e8 e9 3e 00 00       	call   46b4 <read>
     7cb:	83 c4 10             	add    $0x10,%esp
     7ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(i == 0){
     7d1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     7d5:	75 2e                	jne    805 <writetest1+0x16e>
      if(n == MAXFILE - 1){
     7d7:	81 7d f0 8b 00 00 00 	cmpl   $0x8b,-0x10(%ebp)
     7de:	0f 85 88 00 00 00    	jne    86c <writetest1+0x1d5>
        printf(stdout, "read only %d blocks from big", n);
     7e4:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     7ea:	83 ec 04             	sub    $0x4,%esp
     7ed:	ff 75 f0             	push   -0x10(%ebp)
     7f0:	8d 93 01 e3 ff ff    	lea    -0x1cff(%ebx),%edx
     7f6:	52                   	push   %edx
     7f7:	50                   	push   %eax
     7f8:	e8 3b 40 00 00       	call   4838 <printf>
     7fd:	83 c4 10             	add    $0x10,%esp
        exit();
     800:	e8 97 3e 00 00       	call   469c <exit>
      }
      break;
    } else if(i != 512){
     805:	81 7d f4 00 02 00 00 	cmpl   $0x200,-0xc(%ebp)
     80c:	74 21                	je     82f <writetest1+0x198>
      printf(stdout, "read failed %d\n", i);
     80e:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     814:	83 ec 04             	sub    $0x4,%esp
     817:	ff 75 f4             	push   -0xc(%ebp)
     81a:	8d 93 1e e3 ff ff    	lea    -0x1ce2(%ebx),%edx
     820:	52                   	push   %edx
     821:	50                   	push   %eax
     822:	e8 11 40 00 00       	call   4838 <printf>
     827:	83 c4 10             	add    $0x10,%esp
      exit();
     82a:	e8 6d 3e 00 00       	call   469c <exit>
    }
    if(((int*)buf)[0] != n){
     82f:	8d 83 50 00 00 00    	lea    0x50(%ebx),%eax
     835:	8b 00                	mov    (%eax),%eax
     837:	39 45 f0             	cmp    %eax,-0x10(%ebp)
     83a:	74 27                	je     863 <writetest1+0x1cc>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
     83c:	8d 83 50 00 00 00    	lea    0x50(%ebx),%eax
      printf(stdout, "read content of block %d is %d\n",
     842:	8b 10                	mov    (%eax),%edx
     844:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     84a:	52                   	push   %edx
     84b:	ff 75 f0             	push   -0x10(%ebp)
     84e:	8d 93 30 e3 ff ff    	lea    -0x1cd0(%ebx),%edx
     854:	52                   	push   %edx
     855:	50                   	push   %eax
     856:	e8 dd 3f 00 00       	call   4838 <printf>
     85b:	83 c4 10             	add    $0x10,%esp
      exit();
     85e:	e8 39 3e 00 00       	call   469c <exit>
    }
    n++;
     863:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    i = read(fd, buf, 512);
     867:	e9 48 ff ff ff       	jmp    7b4 <writetest1+0x11d>
      break;
     86c:	90                   	nop
  }
  close(fd);
     86d:	83 ec 0c             	sub    $0xc,%esp
     870:	ff 75 ec             	push   -0x14(%ebp)
     873:	e8 4c 3e 00 00       	call   46c4 <close>
     878:	83 c4 10             	add    $0x10,%esp
  if(unlink("big") < 0){
     87b:	83 ec 0c             	sub    $0xc,%esp
     87e:	8d 83 ac e2 ff ff    	lea    -0x1d54(%ebx),%eax
     884:	50                   	push   %eax
     885:	e8 62 3e 00 00       	call   46ec <unlink>
     88a:	83 c4 10             	add    $0x10,%esp
     88d:	85 c0                	test   %eax,%eax
     88f:	79 1e                	jns    8af <writetest1+0x218>
    printf(stdout, "unlink big failed\n");
     891:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     897:	83 ec 08             	sub    $0x8,%esp
     89a:	8d 93 50 e3 ff ff    	lea    -0x1cb0(%ebx),%edx
     8a0:	52                   	push   %edx
     8a1:	50                   	push   %eax
     8a2:	e8 91 3f 00 00       	call   4838 <printf>
     8a7:	83 c4 10             	add    $0x10,%esp
    exit();
     8aa:	e8 ed 3d 00 00       	call   469c <exit>
  }
  printf(stdout, "big files ok\n");
     8af:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     8b5:	83 ec 08             	sub    $0x8,%esp
     8b8:	8d 93 63 e3 ff ff    	lea    -0x1c9d(%ebx),%edx
     8be:	52                   	push   %edx
     8bf:	50                   	push   %eax
     8c0:	e8 73 3f 00 00       	call   4838 <printf>
     8c5:	83 c4 10             	add    $0x10,%esp
}
     8c8:	90                   	nop
     8c9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8cc:	c9                   	leave  
     8cd:	c3                   	ret    

000008ce <createtest>:

void
createtest(void)
{
     8ce:	55                   	push   %ebp
     8cf:	89 e5                	mov    %esp,%ebp
     8d1:	53                   	push   %ebx
     8d2:	83 ec 14             	sub    $0x14,%esp
     8d5:	e8 f9 3a 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
     8da:	81 c3 96 63 00 00    	add    $0x6396,%ebx
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
     8e0:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     8e6:	83 ec 08             	sub    $0x8,%esp
     8e9:	8d 93 74 e3 ff ff    	lea    -0x1c8c(%ebx),%edx
     8ef:	52                   	push   %edx
     8f0:	50                   	push   %eax
     8f1:	e8 42 3f 00 00       	call   4838 <printf>
     8f6:	83 c4 10             	add    $0x10,%esp

  name[0] = 'a';
     8f9:	c6 83 50 20 00 00 61 	movb   $0x61,0x2050(%ebx)
  name[2] = '\0';
     900:	c6 83 52 20 00 00 00 	movb   $0x0,0x2052(%ebx)
  for(i = 0; i < 52; i++){
     907:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     90e:	eb 38                	jmp    948 <createtest+0x7a>
    name[1] = '0' + i;
     910:	8b 45 f4             	mov    -0xc(%ebp),%eax
     913:	83 c0 30             	add    $0x30,%eax
     916:	88 83 51 20 00 00    	mov    %al,0x2051(%ebx)
    fd = open(name, O_CREATE|O_RDWR);
     91c:	83 ec 08             	sub    $0x8,%esp
     91f:	68 02 02 00 00       	push   $0x202
     924:	8d 83 50 20 00 00    	lea    0x2050(%ebx),%eax
     92a:	50                   	push   %eax
     92b:	e8 ac 3d 00 00       	call   46dc <open>
     930:	83 c4 10             	add    $0x10,%esp
     933:	89 45 f0             	mov    %eax,-0x10(%ebp)
    close(fd);
     936:	83 ec 0c             	sub    $0xc,%esp
     939:	ff 75 f0             	push   -0x10(%ebp)
     93c:	e8 83 3d 00 00       	call   46c4 <close>
     941:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 52; i++){
     944:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     948:	83 7d f4 33          	cmpl   $0x33,-0xc(%ebp)
     94c:	7e c2                	jle    910 <createtest+0x42>
  }
  name[0] = 'a';
     94e:	c6 83 50 20 00 00 61 	movb   $0x61,0x2050(%ebx)
  name[2] = '\0';
     955:	c6 83 52 20 00 00 00 	movb   $0x0,0x2052(%ebx)
  for(i = 0; i < 52; i++){
     95c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     963:	eb 22                	jmp    987 <createtest+0xb9>
    name[1] = '0' + i;
     965:	8b 45 f4             	mov    -0xc(%ebp),%eax
     968:	83 c0 30             	add    $0x30,%eax
     96b:	88 83 51 20 00 00    	mov    %al,0x2051(%ebx)
    unlink(name);
     971:	83 ec 0c             	sub    $0xc,%esp
     974:	8d 83 50 20 00 00    	lea    0x2050(%ebx),%eax
     97a:	50                   	push   %eax
     97b:	e8 6c 3d 00 00       	call   46ec <unlink>
     980:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 52; i++){
     983:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     987:	83 7d f4 33          	cmpl   $0x33,-0xc(%ebp)
     98b:	7e d8                	jle    965 <createtest+0x97>
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
     98d:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     993:	83 ec 08             	sub    $0x8,%esp
     996:	8d 93 9c e3 ff ff    	lea    -0x1c64(%ebx),%edx
     99c:	52                   	push   %edx
     99d:	50                   	push   %eax
     99e:	e8 95 3e 00 00       	call   4838 <printf>
     9a3:	83 c4 10             	add    $0x10,%esp
}
     9a6:	90                   	nop
     9a7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     9aa:	c9                   	leave  
     9ab:	c3                   	ret    

000009ac <dirtest>:

void dirtest(void)
{
     9ac:	55                   	push   %ebp
     9ad:	89 e5                	mov    %esp,%ebp
     9af:	53                   	push   %ebx
     9b0:	83 ec 04             	sub    $0x4,%esp
     9b3:	e8 1b 3a 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
     9b8:	81 c3 b8 62 00 00    	add    $0x62b8,%ebx
  printf(stdout, "mkdir test\n");
     9be:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     9c4:	83 ec 08             	sub    $0x8,%esp
     9c7:	8d 93 c2 e3 ff ff    	lea    -0x1c3e(%ebx),%edx
     9cd:	52                   	push   %edx
     9ce:	50                   	push   %eax
     9cf:	e8 64 3e 00 00       	call   4838 <printf>
     9d4:	83 c4 10             	add    $0x10,%esp

  if(mkdir("dir0") < 0){
     9d7:	83 ec 0c             	sub    $0xc,%esp
     9da:	8d 83 ce e3 ff ff    	lea    -0x1c32(%ebx),%eax
     9e0:	50                   	push   %eax
     9e1:	e8 1e 3d 00 00       	call   4704 <mkdir>
     9e6:	83 c4 10             	add    $0x10,%esp
     9e9:	85 c0                	test   %eax,%eax
     9eb:	79 1e                	jns    a0b <dirtest+0x5f>
    printf(stdout, "mkdir failed\n");
     9ed:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     9f3:	83 ec 08             	sub    $0x8,%esp
     9f6:	8d 93 f1 df ff ff    	lea    -0x200f(%ebx),%edx
     9fc:	52                   	push   %edx
     9fd:	50                   	push   %eax
     9fe:	e8 35 3e 00 00       	call   4838 <printf>
     a03:	83 c4 10             	add    $0x10,%esp
    exit();
     a06:	e8 91 3c 00 00       	call   469c <exit>
  }

  if(chdir("dir0") < 0){
     a0b:	83 ec 0c             	sub    $0xc,%esp
     a0e:	8d 83 ce e3 ff ff    	lea    -0x1c32(%ebx),%eax
     a14:	50                   	push   %eax
     a15:	e8 f2 3c 00 00       	call   470c <chdir>
     a1a:	83 c4 10             	add    $0x10,%esp
     a1d:	85 c0                	test   %eax,%eax
     a1f:	79 1e                	jns    a3f <dirtest+0x93>
    printf(stdout, "chdir dir0 failed\n");
     a21:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     a27:	83 ec 08             	sub    $0x8,%esp
     a2a:	8d 93 d3 e3 ff ff    	lea    -0x1c2d(%ebx),%edx
     a30:	52                   	push   %edx
     a31:	50                   	push   %eax
     a32:	e8 01 3e 00 00       	call   4838 <printf>
     a37:	83 c4 10             	add    $0x10,%esp
    exit();
     a3a:	e8 5d 3c 00 00       	call   469c <exit>
  }

  if(chdir("..") < 0){
     a3f:	83 ec 0c             	sub    $0xc,%esp
     a42:	8d 83 e6 e3 ff ff    	lea    -0x1c1a(%ebx),%eax
     a48:	50                   	push   %eax
     a49:	e8 be 3c 00 00       	call   470c <chdir>
     a4e:	83 c4 10             	add    $0x10,%esp
     a51:	85 c0                	test   %eax,%eax
     a53:	79 1e                	jns    a73 <dirtest+0xc7>
    printf(stdout, "chdir .. failed\n");
     a55:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     a5b:	83 ec 08             	sub    $0x8,%esp
     a5e:	8d 93 e9 e3 ff ff    	lea    -0x1c17(%ebx),%edx
     a64:	52                   	push   %edx
     a65:	50                   	push   %eax
     a66:	e8 cd 3d 00 00       	call   4838 <printf>
     a6b:	83 c4 10             	add    $0x10,%esp
    exit();
     a6e:	e8 29 3c 00 00       	call   469c <exit>
  }

  if(unlink("dir0") < 0){
     a73:	83 ec 0c             	sub    $0xc,%esp
     a76:	8d 83 ce e3 ff ff    	lea    -0x1c32(%ebx),%eax
     a7c:	50                   	push   %eax
     a7d:	e8 6a 3c 00 00       	call   46ec <unlink>
     a82:	83 c4 10             	add    $0x10,%esp
     a85:	85 c0                	test   %eax,%eax
     a87:	79 1e                	jns    aa7 <dirtest+0xfb>
    printf(stdout, "unlink dir0 failed\n");
     a89:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     a8f:	83 ec 08             	sub    $0x8,%esp
     a92:	8d 93 fa e3 ff ff    	lea    -0x1c06(%ebx),%edx
     a98:	52                   	push   %edx
     a99:	50                   	push   %eax
     a9a:	e8 99 3d 00 00       	call   4838 <printf>
     a9f:	83 c4 10             	add    $0x10,%esp
    exit();
     aa2:	e8 f5 3b 00 00       	call   469c <exit>
  }
  printf(stdout, "mkdir test ok\n");
     aa7:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     aad:	83 ec 08             	sub    $0x8,%esp
     ab0:	8d 93 0e e4 ff ff    	lea    -0x1bf2(%ebx),%edx
     ab6:	52                   	push   %edx
     ab7:	50                   	push   %eax
     ab8:	e8 7b 3d 00 00       	call   4838 <printf>
     abd:	83 c4 10             	add    $0x10,%esp
}
     ac0:	90                   	nop
     ac1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ac4:	c9                   	leave  
     ac5:	c3                   	ret    

00000ac6 <exectest>:

void
exectest(void)
{
     ac6:	55                   	push   %ebp
     ac7:	89 e5                	mov    %esp,%ebp
     ac9:	53                   	push   %ebx
     aca:	83 ec 04             	sub    $0x4,%esp
     acd:	e8 01 39 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
     ad2:	81 c3 9e 61 00 00    	add    $0x619e,%ebx
  printf(stdout, "exec test\n");
     ad8:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     ade:	83 ec 08             	sub    $0x8,%esp
     ae1:	8d 93 1d e4 ff ff    	lea    -0x1be3(%ebx),%edx
     ae7:	52                   	push   %edx
     ae8:	50                   	push   %eax
     ae9:	e8 4a 3d 00 00       	call   4838 <printf>
     aee:	83 c4 10             	add    $0x10,%esp
  if(exec("echo", echoargv) < 0){
     af1:	83 ec 08             	sub    $0x8,%esp
     af4:	8d 83 14 00 00 00    	lea    0x14(%ebx),%eax
     afa:	50                   	push   %eax
     afb:	8d 83 c8 df ff ff    	lea    -0x2038(%ebx),%eax
     b01:	50                   	push   %eax
     b02:	e8 cd 3b 00 00       	call   46d4 <exec>
     b07:	83 c4 10             	add    $0x10,%esp
     b0a:	85 c0                	test   %eax,%eax
     b0c:	79 1e                	jns    b2c <exectest+0x66>
    printf(stdout, "exec echo failed\n");
     b0e:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
     b14:	83 ec 08             	sub    $0x8,%esp
     b17:	8d 93 28 e4 ff ff    	lea    -0x1bd8(%ebx),%edx
     b1d:	52                   	push   %edx
     b1e:	50                   	push   %eax
     b1f:	e8 14 3d 00 00       	call   4838 <printf>
     b24:	83 c4 10             	add    $0x10,%esp
    exit();
     b27:	e8 70 3b 00 00       	call   469c <exit>
  }
}
     b2c:	90                   	nop
     b2d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     b30:	c9                   	leave  
     b31:	c3                   	ret    

00000b32 <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
     b32:	55                   	push   %ebp
     b33:	89 e5                	mov    %esp,%ebp
     b35:	53                   	push   %ebx
     b36:	83 ec 24             	sub    $0x24,%esp
     b39:	e8 95 38 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
     b3e:	81 c3 32 61 00 00    	add    $0x6132,%ebx
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
     b44:	83 ec 0c             	sub    $0xc,%esp
     b47:	8d 45 d8             	lea    -0x28(%ebp),%eax
     b4a:	50                   	push   %eax
     b4b:	e8 5c 3b 00 00       	call   46ac <pipe>
     b50:	83 c4 10             	add    $0x10,%esp
     b53:	85 c0                	test   %eax,%eax
     b55:	74 19                	je     b70 <pipe1+0x3e>
    printf(1, "pipe() failed\n");
     b57:	83 ec 08             	sub    $0x8,%esp
     b5a:	8d 83 3a e4 ff ff    	lea    -0x1bc6(%ebx),%eax
     b60:	50                   	push   %eax
     b61:	6a 01                	push   $0x1
     b63:	e8 d0 3c 00 00       	call   4838 <printf>
     b68:	83 c4 10             	add    $0x10,%esp
    exit();
     b6b:	e8 2c 3b 00 00       	call   469c <exit>
  }
  pid = fork();
     b70:	e8 1f 3b 00 00       	call   4694 <fork>
     b75:	89 45 e0             	mov    %eax,-0x20(%ebp)
  seq = 0;
     b78:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  if(pid == 0){
     b7f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     b83:	0f 85 90 00 00 00    	jne    c19 <pipe1+0xe7>
    close(fds[0]);
     b89:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b8c:	83 ec 0c             	sub    $0xc,%esp
     b8f:	50                   	push   %eax
     b90:	e8 2f 3b 00 00       	call   46c4 <close>
     b95:	83 c4 10             	add    $0x10,%esp
    for(n = 0; n < 5; n++){
     b98:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     b9f:	eb 6d                	jmp    c0e <pipe1+0xdc>
      for(i = 0; i < 1033; i++)
     ba1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     ba8:	eb 1c                	jmp    bc6 <pipe1+0x94>
        buf[i] = seq++;
     baa:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bad:	8d 50 01             	lea    0x1(%eax),%edx
     bb0:	89 55 f4             	mov    %edx,-0xc(%ebp)
     bb3:	89 c2                	mov    %eax,%edx
     bb5:	8d 8b 50 00 00 00    	lea    0x50(%ebx),%ecx
     bbb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bbe:	01 c8                	add    %ecx,%eax
     bc0:	88 10                	mov    %dl,(%eax)
      for(i = 0; i < 1033; i++)
     bc2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     bc6:	81 7d f0 08 04 00 00 	cmpl   $0x408,-0x10(%ebp)
     bcd:	7e db                	jle    baa <pipe1+0x78>
      if(write(fds[1], buf, 1033) != 1033){
     bcf:	8b 45 dc             	mov    -0x24(%ebp),%eax
     bd2:	83 ec 04             	sub    $0x4,%esp
     bd5:	68 09 04 00 00       	push   $0x409
     bda:	8d 93 50 00 00 00    	lea    0x50(%ebx),%edx
     be0:	52                   	push   %edx
     be1:	50                   	push   %eax
     be2:	e8 d5 3a 00 00       	call   46bc <write>
     be7:	83 c4 10             	add    $0x10,%esp
     bea:	3d 09 04 00 00       	cmp    $0x409,%eax
     bef:	74 19                	je     c0a <pipe1+0xd8>
        printf(1, "pipe1 oops 1\n");
     bf1:	83 ec 08             	sub    $0x8,%esp
     bf4:	8d 83 49 e4 ff ff    	lea    -0x1bb7(%ebx),%eax
     bfa:	50                   	push   %eax
     bfb:	6a 01                	push   $0x1
     bfd:	e8 36 3c 00 00       	call   4838 <printf>
     c02:	83 c4 10             	add    $0x10,%esp
        exit();
     c05:	e8 92 3a 00 00       	call   469c <exit>
    for(n = 0; n < 5; n++){
     c0a:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     c0e:	83 7d ec 04          	cmpl   $0x4,-0x14(%ebp)
     c12:	7e 8d                	jle    ba1 <pipe1+0x6f>
      }
    }
    exit();
     c14:	e8 83 3a 00 00       	call   469c <exit>
  } else if(pid > 0){
     c19:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     c1d:	0f 8e ff 00 00 00    	jle    d22 <pipe1+0x1f0>
    close(fds[1]);
     c23:	8b 45 dc             	mov    -0x24(%ebp),%eax
     c26:	83 ec 0c             	sub    $0xc,%esp
     c29:	50                   	push   %eax
     c2a:	e8 95 3a 00 00       	call   46c4 <close>
     c2f:	83 c4 10             	add    $0x10,%esp
    total = 0;
     c32:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    cc = 1;
     c39:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
     c40:	eb 6b                	jmp    cad <pipe1+0x17b>
      for(i = 0; i < n; i++){
     c42:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     c49:	eb 40                	jmp    c8b <pipe1+0x159>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     c4b:	8d 93 50 00 00 00    	lea    0x50(%ebx),%edx
     c51:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c54:	01 d0                	add    %edx,%eax
     c56:	0f b6 00             	movzbl (%eax),%eax
     c59:	0f be c8             	movsbl %al,%ecx
     c5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c5f:	8d 50 01             	lea    0x1(%eax),%edx
     c62:	89 55 f4             	mov    %edx,-0xc(%ebp)
     c65:	31 c8                	xor    %ecx,%eax
     c67:	0f b6 c0             	movzbl %al,%eax
     c6a:	85 c0                	test   %eax,%eax
     c6c:	74 19                	je     c87 <pipe1+0x155>
          printf(1, "pipe1 oops 2\n");
     c6e:	83 ec 08             	sub    $0x8,%esp
     c71:	8d 83 57 e4 ff ff    	lea    -0x1ba9(%ebx),%eax
     c77:	50                   	push   %eax
     c78:	6a 01                	push   $0x1
     c7a:	e8 b9 3b 00 00       	call   4838 <printf>
     c7f:	83 c4 10             	add    $0x10,%esp
     c82:	e9 b4 00 00 00       	jmp    d3b <pipe1+0x209>
      for(i = 0; i < n; i++){
     c87:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     c8b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c8e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     c91:	7c b8                	jl     c4b <pipe1+0x119>
          return;
        }
      }
      total += n;
     c93:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c96:	01 45 e4             	add    %eax,-0x1c(%ebp)
      cc = cc * 2;
     c99:	d1 65 e8             	shll   -0x18(%ebp)
      if(cc > sizeof(buf))
     c9c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c9f:	3d 00 20 00 00       	cmp    $0x2000,%eax
     ca4:	76 07                	jbe    cad <pipe1+0x17b>
        cc = sizeof(buf);
     ca6:	c7 45 e8 00 20 00 00 	movl   $0x2000,-0x18(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
     cad:	8b 45 d8             	mov    -0x28(%ebp),%eax
     cb0:	83 ec 04             	sub    $0x4,%esp
     cb3:	ff 75 e8             	push   -0x18(%ebp)
     cb6:	8d 93 50 00 00 00    	lea    0x50(%ebx),%edx
     cbc:	52                   	push   %edx
     cbd:	50                   	push   %eax
     cbe:	e8 f1 39 00 00       	call   46b4 <read>
     cc3:	83 c4 10             	add    $0x10,%esp
     cc6:	89 45 ec             	mov    %eax,-0x14(%ebp)
     cc9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     ccd:	0f 8f 6f ff ff ff    	jg     c42 <pipe1+0x110>
    }
    if(total != 5 * 1033){
     cd3:	81 7d e4 2d 14 00 00 	cmpl   $0x142d,-0x1c(%ebp)
     cda:	74 1c                	je     cf8 <pipe1+0x1c6>
      printf(1, "pipe1 oops 3 total %d\n", total);
     cdc:	83 ec 04             	sub    $0x4,%esp
     cdf:	ff 75 e4             	push   -0x1c(%ebp)
     ce2:	8d 83 65 e4 ff ff    	lea    -0x1b9b(%ebx),%eax
     ce8:	50                   	push   %eax
     ce9:	6a 01                	push   $0x1
     ceb:	e8 48 3b 00 00       	call   4838 <printf>
     cf0:	83 c4 10             	add    $0x10,%esp
      exit();
     cf3:	e8 a4 39 00 00       	call   469c <exit>
    }
    close(fds[0]);
     cf8:	8b 45 d8             	mov    -0x28(%ebp),%eax
     cfb:	83 ec 0c             	sub    $0xc,%esp
     cfe:	50                   	push   %eax
     cff:	e8 c0 39 00 00       	call   46c4 <close>
     d04:	83 c4 10             	add    $0x10,%esp
    wait();
     d07:	e8 98 39 00 00       	call   46a4 <wait>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
     d0c:	83 ec 08             	sub    $0x8,%esp
     d0f:	8d 83 8b e4 ff ff    	lea    -0x1b75(%ebx),%eax
     d15:	50                   	push   %eax
     d16:	6a 01                	push   $0x1
     d18:	e8 1b 3b 00 00       	call   4838 <printf>
     d1d:	83 c4 10             	add    $0x10,%esp
     d20:	eb 19                	jmp    d3b <pipe1+0x209>
    printf(1, "fork() failed\n");
     d22:	83 ec 08             	sub    $0x8,%esp
     d25:	8d 83 7c e4 ff ff    	lea    -0x1b84(%ebx),%eax
     d2b:	50                   	push   %eax
     d2c:	6a 01                	push   $0x1
     d2e:	e8 05 3b 00 00       	call   4838 <printf>
     d33:	83 c4 10             	add    $0x10,%esp
    exit();
     d36:	e8 61 39 00 00       	call   469c <exit>
}
     d3b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     d3e:	c9                   	leave  
     d3f:	c3                   	ret    

00000d40 <preempt>:

// meant to be run w/ at most two CPUs
void
preempt(void)
{
     d40:	55                   	push   %ebp
     d41:	89 e5                	mov    %esp,%ebp
     d43:	53                   	push   %ebx
     d44:	83 ec 24             	sub    $0x24,%esp
     d47:	e8 87 36 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
     d4c:	81 c3 24 5f 00 00    	add    $0x5f24,%ebx
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
     d52:	83 ec 08             	sub    $0x8,%esp
     d55:	8d 83 95 e4 ff ff    	lea    -0x1b6b(%ebx),%eax
     d5b:	50                   	push   %eax
     d5c:	6a 01                	push   $0x1
     d5e:	e8 d5 3a 00 00       	call   4838 <printf>
     d63:	83 c4 10             	add    $0x10,%esp
  pid1 = fork();
     d66:	e8 29 39 00 00       	call   4694 <fork>
     d6b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid1 == 0)
     d6e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     d72:	75 02                	jne    d76 <preempt+0x36>
    for(;;)
     d74:	eb fe                	jmp    d74 <preempt+0x34>
      ;

  pid2 = fork();
     d76:	e8 19 39 00 00       	call   4694 <fork>
     d7b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid2 == 0)
     d7e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     d82:	75 02                	jne    d86 <preempt+0x46>
    for(;;)
     d84:	eb fe                	jmp    d84 <preempt+0x44>
      ;

  pipe(pfds);
     d86:	83 ec 0c             	sub    $0xc,%esp
     d89:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     d8c:	50                   	push   %eax
     d8d:	e8 1a 39 00 00       	call   46ac <pipe>
     d92:	83 c4 10             	add    $0x10,%esp
  pid3 = fork();
     d95:	e8 fa 38 00 00       	call   4694 <fork>
     d9a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(pid3 == 0){
     d9d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     da1:	75 51                	jne    df4 <preempt+0xb4>
    close(pfds[0]);
     da3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     da6:	83 ec 0c             	sub    $0xc,%esp
     da9:	50                   	push   %eax
     daa:	e8 15 39 00 00       	call   46c4 <close>
     daf:	83 c4 10             	add    $0x10,%esp
    if(write(pfds[1], "x", 1) != 1)
     db2:	8b 45 e8             	mov    -0x18(%ebp),%eax
     db5:	83 ec 04             	sub    $0x4,%esp
     db8:	6a 01                	push   $0x1
     dba:	8d 93 9f e4 ff ff    	lea    -0x1b61(%ebx),%edx
     dc0:	52                   	push   %edx
     dc1:	50                   	push   %eax
     dc2:	e8 f5 38 00 00       	call   46bc <write>
     dc7:	83 c4 10             	add    $0x10,%esp
     dca:	83 f8 01             	cmp    $0x1,%eax
     dcd:	74 14                	je     de3 <preempt+0xa3>
      printf(1, "preempt write error");
     dcf:	83 ec 08             	sub    $0x8,%esp
     dd2:	8d 83 a1 e4 ff ff    	lea    -0x1b5f(%ebx),%eax
     dd8:	50                   	push   %eax
     dd9:	6a 01                	push   $0x1
     ddb:	e8 58 3a 00 00       	call   4838 <printf>
     de0:	83 c4 10             	add    $0x10,%esp
    close(pfds[1]);
     de3:	8b 45 e8             	mov    -0x18(%ebp),%eax
     de6:	83 ec 0c             	sub    $0xc,%esp
     de9:	50                   	push   %eax
     dea:	e8 d5 38 00 00       	call   46c4 <close>
     def:	83 c4 10             	add    $0x10,%esp
    for(;;)
     df2:	eb fe                	jmp    df2 <preempt+0xb2>
      ;
  }

  close(pfds[1]);
     df4:	8b 45 e8             	mov    -0x18(%ebp),%eax
     df7:	83 ec 0c             	sub    $0xc,%esp
     dfa:	50                   	push   %eax
     dfb:	e8 c4 38 00 00       	call   46c4 <close>
     e00:	83 c4 10             	add    $0x10,%esp
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     e03:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     e06:	83 ec 04             	sub    $0x4,%esp
     e09:	68 00 20 00 00       	push   $0x2000
     e0e:	8d 93 50 00 00 00    	lea    0x50(%ebx),%edx
     e14:	52                   	push   %edx
     e15:	50                   	push   %eax
     e16:	e8 99 38 00 00       	call   46b4 <read>
     e1b:	83 c4 10             	add    $0x10,%esp
     e1e:	83 f8 01             	cmp    $0x1,%eax
     e21:	74 19                	je     e3c <preempt+0xfc>
    printf(1, "preempt read error");
     e23:	83 ec 08             	sub    $0x8,%esp
     e26:	8d 83 b5 e4 ff ff    	lea    -0x1b4b(%ebx),%eax
     e2c:	50                   	push   %eax
     e2d:	6a 01                	push   $0x1
     e2f:	e8 04 3a 00 00       	call   4838 <printf>
     e34:	83 c4 10             	add    $0x10,%esp
     e37:	e9 84 00 00 00       	jmp    ec0 <preempt+0x180>
    return;
  }
  close(pfds[0]);
     e3c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     e3f:	83 ec 0c             	sub    $0xc,%esp
     e42:	50                   	push   %eax
     e43:	e8 7c 38 00 00       	call   46c4 <close>
     e48:	83 c4 10             	add    $0x10,%esp
  printf(1, "kill... ");
     e4b:	83 ec 08             	sub    $0x8,%esp
     e4e:	8d 83 c8 e4 ff ff    	lea    -0x1b38(%ebx),%eax
     e54:	50                   	push   %eax
     e55:	6a 01                	push   $0x1
     e57:	e8 dc 39 00 00       	call   4838 <printf>
     e5c:	83 c4 10             	add    $0x10,%esp
  kill(pid1);
     e5f:	83 ec 0c             	sub    $0xc,%esp
     e62:	ff 75 f4             	push   -0xc(%ebp)
     e65:	e8 62 38 00 00       	call   46cc <kill>
     e6a:	83 c4 10             	add    $0x10,%esp
  kill(pid2);
     e6d:	83 ec 0c             	sub    $0xc,%esp
     e70:	ff 75 f0             	push   -0x10(%ebp)
     e73:	e8 54 38 00 00       	call   46cc <kill>
     e78:	83 c4 10             	add    $0x10,%esp
  kill(pid3);
     e7b:	83 ec 0c             	sub    $0xc,%esp
     e7e:	ff 75 ec             	push   -0x14(%ebp)
     e81:	e8 46 38 00 00       	call   46cc <kill>
     e86:	83 c4 10             	add    $0x10,%esp
  printf(1, "wait... ");
     e89:	83 ec 08             	sub    $0x8,%esp
     e8c:	8d 83 d1 e4 ff ff    	lea    -0x1b2f(%ebx),%eax
     e92:	50                   	push   %eax
     e93:	6a 01                	push   $0x1
     e95:	e8 9e 39 00 00       	call   4838 <printf>
     e9a:	83 c4 10             	add    $0x10,%esp
  wait();
     e9d:	e8 02 38 00 00       	call   46a4 <wait>
  wait();
     ea2:	e8 fd 37 00 00       	call   46a4 <wait>
  wait();
     ea7:	e8 f8 37 00 00       	call   46a4 <wait>
  printf(1, "preempt ok\n");
     eac:	83 ec 08             	sub    $0x8,%esp
     eaf:	8d 83 da e4 ff ff    	lea    -0x1b26(%ebx),%eax
     eb5:	50                   	push   %eax
     eb6:	6a 01                	push   $0x1
     eb8:	e8 7b 39 00 00       	call   4838 <printf>
     ebd:	83 c4 10             	add    $0x10,%esp
}
     ec0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ec3:	c9                   	leave  
     ec4:	c3                   	ret    

00000ec5 <exitwait>:

// try to find any races between exit and wait
void
exitwait(void)
{
     ec5:	55                   	push   %ebp
     ec6:	89 e5                	mov    %esp,%ebp
     ec8:	53                   	push   %ebx
     ec9:	83 ec 14             	sub    $0x14,%esp
     ecc:	e8 02 35 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
     ed1:	81 c3 9f 5d 00 00    	add    $0x5d9f,%ebx
  int i, pid;

  for(i = 0; i < 100; i++){
     ed7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     ede:	eb 53                	jmp    f33 <exitwait+0x6e>
    pid = fork();
     ee0:	e8 af 37 00 00       	call   4694 <fork>
     ee5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0){
     ee8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     eec:	79 16                	jns    f04 <exitwait+0x3f>
      printf(1, "fork failed\n");
     eee:	83 ec 08             	sub    $0x8,%esp
     ef1:	8d 83 69 e0 ff ff    	lea    -0x1f97(%ebx),%eax
     ef7:	50                   	push   %eax
     ef8:	6a 01                	push   $0x1
     efa:	e8 39 39 00 00       	call   4838 <printf>
     eff:	83 c4 10             	add    $0x10,%esp
      return;
     f02:	eb 49                	jmp    f4d <exitwait+0x88>
    }
    if(pid){
     f04:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     f08:	74 20                	je     f2a <exitwait+0x65>
      if(wait() != pid){
     f0a:	e8 95 37 00 00       	call   46a4 <wait>
     f0f:	39 45 f0             	cmp    %eax,-0x10(%ebp)
     f12:	74 1b                	je     f2f <exitwait+0x6a>
        printf(1, "wait wrong pid\n");
     f14:	83 ec 08             	sub    $0x8,%esp
     f17:	8d 83 e6 e4 ff ff    	lea    -0x1b1a(%ebx),%eax
     f1d:	50                   	push   %eax
     f1e:	6a 01                	push   $0x1
     f20:	e8 13 39 00 00       	call   4838 <printf>
     f25:	83 c4 10             	add    $0x10,%esp
        return;
     f28:	eb 23                	jmp    f4d <exitwait+0x88>
      }
    } else {
      exit();
     f2a:	e8 6d 37 00 00       	call   469c <exit>
  for(i = 0; i < 100; i++){
     f2f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     f33:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
     f37:	7e a7                	jle    ee0 <exitwait+0x1b>
    }
  }
  printf(1, "exitwait ok\n");
     f39:	83 ec 08             	sub    $0x8,%esp
     f3c:	8d 83 f6 e4 ff ff    	lea    -0x1b0a(%ebx),%eax
     f42:	50                   	push   %eax
     f43:	6a 01                	push   $0x1
     f45:	e8 ee 38 00 00       	call   4838 <printf>
     f4a:	83 c4 10             	add    $0x10,%esp
}
     f4d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     f50:	c9                   	leave  
     f51:	c3                   	ret    

00000f52 <mem>:

void
mem(void)
{
     f52:	55                   	push   %ebp
     f53:	89 e5                	mov    %esp,%ebp
     f55:	53                   	push   %ebx
     f56:	83 ec 14             	sub    $0x14,%esp
     f59:	e8 75 34 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
     f5e:	81 c3 12 5d 00 00    	add    $0x5d12,%ebx
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
     f64:	83 ec 08             	sub    $0x8,%esp
     f67:	8d 83 03 e5 ff ff    	lea    -0x1afd(%ebx),%eax
     f6d:	50                   	push   %eax
     f6e:	6a 01                	push   $0x1
     f70:	e8 c3 38 00 00       	call   4838 <printf>
     f75:	83 c4 10             	add    $0x10,%esp
  ppid = getpid();
     f78:	e8 9f 37 00 00       	call   471c <getpid>
     f7d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if((pid = fork()) == 0){
     f80:	e8 0f 37 00 00       	call   4694 <fork>
     f85:	89 45 ec             	mov    %eax,-0x14(%ebp)
     f88:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f8c:	0f 85 bb 00 00 00    	jne    104d <mem+0xfb>
    m1 = 0;
     f92:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while((m2 = malloc(10001)) != 0){
     f99:	eb 0e                	jmp    fa9 <mem+0x57>
      *(char**)m2 = m1;
     f9b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     f9e:	8b 55 f4             	mov    -0xc(%ebp),%edx
     fa1:	89 10                	mov    %edx,(%eax)
      m1 = m2;
     fa3:	8b 45 e8             	mov    -0x18(%ebp),%eax
     fa6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while((m2 = malloc(10001)) != 0){
     fa9:	83 ec 0c             	sub    $0xc,%esp
     fac:	68 11 27 00 00       	push   $0x2711
     fb1:	e8 87 3b 00 00       	call   4b3d <malloc>
     fb6:	83 c4 10             	add    $0x10,%esp
     fb9:	89 45 e8             	mov    %eax,-0x18(%ebp)
     fbc:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     fc0:	75 d9                	jne    f9b <mem+0x49>
    }
    while(m1){
     fc2:	eb 1c                	jmp    fe0 <mem+0x8e>
      m2 = *(char**)m1;
     fc4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fc7:	8b 00                	mov    (%eax),%eax
     fc9:	89 45 e8             	mov    %eax,-0x18(%ebp)
      free(m1);
     fcc:	83 ec 0c             	sub    $0xc,%esp
     fcf:	ff 75 f4             	push   -0xc(%ebp)
     fd2:	e8 08 3a 00 00       	call   49df <free>
     fd7:	83 c4 10             	add    $0x10,%esp
      m1 = m2;
     fda:	8b 45 e8             	mov    -0x18(%ebp),%eax
     fdd:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while(m1){
     fe0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     fe4:	75 de                	jne    fc4 <mem+0x72>
    }
    m1 = malloc(1024*20);
     fe6:	83 ec 0c             	sub    $0xc,%esp
     fe9:	68 00 50 00 00       	push   $0x5000
     fee:	e8 4a 3b 00 00       	call   4b3d <malloc>
     ff3:	83 c4 10             	add    $0x10,%esp
     ff6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(m1 == 0){
     ff9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     ffd:	75 27                	jne    1026 <mem+0xd4>
      printf(1, "couldn't allocate mem?!!\n");
     fff:	83 ec 08             	sub    $0x8,%esp
    1002:	8d 83 0d e5 ff ff    	lea    -0x1af3(%ebx),%eax
    1008:	50                   	push   %eax
    1009:	6a 01                	push   $0x1
    100b:	e8 28 38 00 00       	call   4838 <printf>
    1010:	83 c4 10             	add    $0x10,%esp
      kill(ppid);
    1013:	83 ec 0c             	sub    $0xc,%esp
    1016:	ff 75 f0             	push   -0x10(%ebp)
    1019:	e8 ae 36 00 00       	call   46cc <kill>
    101e:	83 c4 10             	add    $0x10,%esp
      exit();
    1021:	e8 76 36 00 00       	call   469c <exit>
    }
    free(m1);
    1026:	83 ec 0c             	sub    $0xc,%esp
    1029:	ff 75 f4             	push   -0xc(%ebp)
    102c:	e8 ae 39 00 00       	call   49df <free>
    1031:	83 c4 10             	add    $0x10,%esp
    printf(1, "mem ok\n");
    1034:	83 ec 08             	sub    $0x8,%esp
    1037:	8d 83 27 e5 ff ff    	lea    -0x1ad9(%ebx),%eax
    103d:	50                   	push   %eax
    103e:	6a 01                	push   $0x1
    1040:	e8 f3 37 00 00       	call   4838 <printf>
    1045:	83 c4 10             	add    $0x10,%esp
    exit();
    1048:	e8 4f 36 00 00       	call   469c <exit>
  } else {
    wait();
    104d:	e8 52 36 00 00       	call   46a4 <wait>
  }
}
    1052:	90                   	nop
    1053:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1056:	c9                   	leave  
    1057:	c3                   	ret    

00001058 <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
    1058:	55                   	push   %ebp
    1059:	89 e5                	mov    %esp,%ebp
    105b:	53                   	push   %ebx
    105c:	83 ec 34             	sub    $0x34,%esp
    105f:	e8 6f 33 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
    1064:	81 c3 0c 5c 00 00    	add    $0x5c0c,%ebx
  int fd, pid, i, n, nc, np;
  char buf[10];

  printf(1, "sharedfd test\n");
    106a:	83 ec 08             	sub    $0x8,%esp
    106d:	8d 83 2f e5 ff ff    	lea    -0x1ad1(%ebx),%eax
    1073:	50                   	push   %eax
    1074:	6a 01                	push   $0x1
    1076:	e8 bd 37 00 00       	call   4838 <printf>
    107b:	83 c4 10             	add    $0x10,%esp

  unlink("sharedfd");
    107e:	83 ec 0c             	sub    $0xc,%esp
    1081:	8d 83 3e e5 ff ff    	lea    -0x1ac2(%ebx),%eax
    1087:	50                   	push   %eax
    1088:	e8 5f 36 00 00       	call   46ec <unlink>
    108d:	83 c4 10             	add    $0x10,%esp
  fd = open("sharedfd", O_CREATE|O_RDWR);
    1090:	83 ec 08             	sub    $0x8,%esp
    1093:	68 02 02 00 00       	push   $0x202
    1098:	8d 83 3e e5 ff ff    	lea    -0x1ac2(%ebx),%eax
    109e:	50                   	push   %eax
    109f:	e8 38 36 00 00       	call   46dc <open>
    10a4:	83 c4 10             	add    $0x10,%esp
    10a7:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(fd < 0){
    10aa:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    10ae:	79 19                	jns    10c9 <sharedfd+0x71>
    printf(1, "fstests: cannot open sharedfd for writing");
    10b0:	83 ec 08             	sub    $0x8,%esp
    10b3:	8d 83 48 e5 ff ff    	lea    -0x1ab8(%ebx),%eax
    10b9:	50                   	push   %eax
    10ba:	6a 01                	push   $0x1
    10bc:	e8 77 37 00 00       	call   4838 <printf>
    10c1:	83 c4 10             	add    $0x10,%esp
    return;
    10c4:	e9 90 01 00 00       	jmp    1259 <sharedfd+0x201>
  }
  pid = fork();
    10c9:	e8 c6 35 00 00       	call   4694 <fork>
    10ce:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
    10d1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    10d5:	75 07                	jne    10de <sharedfd+0x86>
    10d7:	b8 63 00 00 00       	mov    $0x63,%eax
    10dc:	eb 05                	jmp    10e3 <sharedfd+0x8b>
    10de:	b8 70 00 00 00       	mov    $0x70,%eax
    10e3:	83 ec 04             	sub    $0x4,%esp
    10e6:	6a 0a                	push   $0xa
    10e8:	50                   	push   %eax
    10e9:	8d 45 d6             	lea    -0x2a(%ebp),%eax
    10ec:	50                   	push   %eax
    10ed:	e8 c9 33 00 00       	call   44bb <memset>
    10f2:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 1000; i++){
    10f5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    10fc:	eb 33                	jmp    1131 <sharedfd+0xd9>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    10fe:	83 ec 04             	sub    $0x4,%esp
    1101:	6a 0a                	push   $0xa
    1103:	8d 45 d6             	lea    -0x2a(%ebp),%eax
    1106:	50                   	push   %eax
    1107:	ff 75 e8             	push   -0x18(%ebp)
    110a:	e8 ad 35 00 00       	call   46bc <write>
    110f:	83 c4 10             	add    $0x10,%esp
    1112:	83 f8 0a             	cmp    $0xa,%eax
    1115:	74 16                	je     112d <sharedfd+0xd5>
      printf(1, "fstests: write sharedfd failed\n");
    1117:	83 ec 08             	sub    $0x8,%esp
    111a:	8d 83 74 e5 ff ff    	lea    -0x1a8c(%ebx),%eax
    1120:	50                   	push   %eax
    1121:	6a 01                	push   $0x1
    1123:	e8 10 37 00 00       	call   4838 <printf>
    1128:	83 c4 10             	add    $0x10,%esp
      break;
    112b:	eb 0d                	jmp    113a <sharedfd+0xe2>
  for(i = 0; i < 1000; i++){
    112d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1131:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
    1138:	7e c4                	jle    10fe <sharedfd+0xa6>
    }
  }
  if(pid == 0)
    113a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    113e:	75 05                	jne    1145 <sharedfd+0xed>
    exit();
    1140:	e8 57 35 00 00       	call   469c <exit>
  else
    wait();
    1145:	e8 5a 35 00 00       	call   46a4 <wait>
  close(fd);
    114a:	83 ec 0c             	sub    $0xc,%esp
    114d:	ff 75 e8             	push   -0x18(%ebp)
    1150:	e8 6f 35 00 00       	call   46c4 <close>
    1155:	83 c4 10             	add    $0x10,%esp
  fd = open("sharedfd", 0);
    1158:	83 ec 08             	sub    $0x8,%esp
    115b:	6a 00                	push   $0x0
    115d:	8d 83 3e e5 ff ff    	lea    -0x1ac2(%ebx),%eax
    1163:	50                   	push   %eax
    1164:	e8 73 35 00 00       	call   46dc <open>
    1169:	83 c4 10             	add    $0x10,%esp
    116c:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(fd < 0){
    116f:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1173:	79 19                	jns    118e <sharedfd+0x136>
    printf(1, "fstests: cannot open sharedfd for reading\n");
    1175:	83 ec 08             	sub    $0x8,%esp
    1178:	8d 83 94 e5 ff ff    	lea    -0x1a6c(%ebx),%eax
    117e:	50                   	push   %eax
    117f:	6a 01                	push   $0x1
    1181:	e8 b2 36 00 00       	call   4838 <printf>
    1186:	83 c4 10             	add    $0x10,%esp
    return;
    1189:	e9 cb 00 00 00       	jmp    1259 <sharedfd+0x201>
  }
  nc = np = 0;
    118e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1195:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1198:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
    119b:	eb 3b                	jmp    11d8 <sharedfd+0x180>
    for(i = 0; i < sizeof(buf); i++){
    119d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    11a4:	eb 2a                	jmp    11d0 <sharedfd+0x178>
      if(buf[i] == 'c')
    11a6:	8d 55 d6             	lea    -0x2a(%ebp),%edx
    11a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11ac:	01 d0                	add    %edx,%eax
    11ae:	0f b6 00             	movzbl (%eax),%eax
    11b1:	3c 63                	cmp    $0x63,%al
    11b3:	75 04                	jne    11b9 <sharedfd+0x161>
        nc++;
    11b5:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(buf[i] == 'p')
    11b9:	8d 55 d6             	lea    -0x2a(%ebp),%edx
    11bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11bf:	01 d0                	add    %edx,%eax
    11c1:	0f b6 00             	movzbl (%eax),%eax
    11c4:	3c 70                	cmp    $0x70,%al
    11c6:	75 04                	jne    11cc <sharedfd+0x174>
        np++;
    11c8:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    for(i = 0; i < sizeof(buf); i++){
    11cc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    11d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11d3:	83 f8 09             	cmp    $0x9,%eax
    11d6:	76 ce                	jbe    11a6 <sharedfd+0x14e>
  while((n = read(fd, buf, sizeof(buf))) > 0){
    11d8:	83 ec 04             	sub    $0x4,%esp
    11db:	6a 0a                	push   $0xa
    11dd:	8d 45 d6             	lea    -0x2a(%ebp),%eax
    11e0:	50                   	push   %eax
    11e1:	ff 75 e8             	push   -0x18(%ebp)
    11e4:	e8 cb 34 00 00       	call   46b4 <read>
    11e9:	83 c4 10             	add    $0x10,%esp
    11ec:	89 45 e0             	mov    %eax,-0x20(%ebp)
    11ef:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    11f3:	7f a8                	jg     119d <sharedfd+0x145>
    }
  }
  close(fd);
    11f5:	83 ec 0c             	sub    $0xc,%esp
    11f8:	ff 75 e8             	push   -0x18(%ebp)
    11fb:	e8 c4 34 00 00       	call   46c4 <close>
    1200:	83 c4 10             	add    $0x10,%esp
  unlink("sharedfd");
    1203:	83 ec 0c             	sub    $0xc,%esp
    1206:	8d 83 3e e5 ff ff    	lea    -0x1ac2(%ebx),%eax
    120c:	50                   	push   %eax
    120d:	e8 da 34 00 00       	call   46ec <unlink>
    1212:	83 c4 10             	add    $0x10,%esp
  if(nc == 10000 && np == 10000){
    1215:	81 7d f0 10 27 00 00 	cmpl   $0x2710,-0x10(%ebp)
    121c:	75 1f                	jne    123d <sharedfd+0x1e5>
    121e:	81 7d ec 10 27 00 00 	cmpl   $0x2710,-0x14(%ebp)
    1225:	75 16                	jne    123d <sharedfd+0x1e5>
    printf(1, "sharedfd ok\n");
    1227:	83 ec 08             	sub    $0x8,%esp
    122a:	8d 83 bf e5 ff ff    	lea    -0x1a41(%ebx),%eax
    1230:	50                   	push   %eax
    1231:	6a 01                	push   $0x1
    1233:	e8 00 36 00 00       	call   4838 <printf>
    1238:	83 c4 10             	add    $0x10,%esp
    123b:	eb 1c                	jmp    1259 <sharedfd+0x201>
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    123d:	ff 75 ec             	push   -0x14(%ebp)
    1240:	ff 75 f0             	push   -0x10(%ebp)
    1243:	8d 83 cc e5 ff ff    	lea    -0x1a34(%ebx),%eax
    1249:	50                   	push   %eax
    124a:	6a 01                	push   $0x1
    124c:	e8 e7 35 00 00       	call   4838 <printf>
    1251:	83 c4 10             	add    $0x10,%esp
    exit();
    1254:	e8 43 34 00 00       	call   469c <exit>
  }
}
    1259:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    125c:	c9                   	leave  
    125d:	c3                   	ret    

0000125e <fourfiles>:

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
    125e:	55                   	push   %ebp
    125f:	89 e5                	mov    %esp,%ebp
    1261:	53                   	push   %ebx
    1262:	83 ec 34             	sub    $0x34,%esp
    1265:	e8 69 31 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
    126a:	81 c3 06 5a 00 00    	add    $0x5a06,%ebx
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
    1270:	8d 83 e1 e5 ff ff    	lea    -0x1a1f(%ebx),%eax
    1276:	89 45 c8             	mov    %eax,-0x38(%ebp)
    1279:	8d 83 e4 e5 ff ff    	lea    -0x1a1c(%ebx),%eax
    127f:	89 45 cc             	mov    %eax,-0x34(%ebp)
    1282:	8d 83 e7 e5 ff ff    	lea    -0x1a19(%ebx),%eax
    1288:	89 45 d0             	mov    %eax,-0x30(%ebp)
    128b:	8d 83 ea e5 ff ff    	lea    -0x1a16(%ebx),%eax
    1291:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  char *fname;

  printf(1, "fourfiles test\n");
    1294:	83 ec 08             	sub    $0x8,%esp
    1297:	8d 83 ed e5 ff ff    	lea    -0x1a13(%ebx),%eax
    129d:	50                   	push   %eax
    129e:	6a 01                	push   $0x1
    12a0:	e8 93 35 00 00       	call   4838 <printf>
    12a5:	83 c4 10             	add    $0x10,%esp

  for(pi = 0; pi < 4; pi++){
    12a8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    12af:	e9 fa 00 00 00       	jmp    13ae <fourfiles+0x150>
    fname = names[pi];
    12b4:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12b7:	8b 44 85 c8          	mov    -0x38(%ebp,%eax,4),%eax
    12bb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    unlink(fname);
    12be:	83 ec 0c             	sub    $0xc,%esp
    12c1:	ff 75 e4             	push   -0x1c(%ebp)
    12c4:	e8 23 34 00 00       	call   46ec <unlink>
    12c9:	83 c4 10             	add    $0x10,%esp

    pid = fork();
    12cc:	e8 c3 33 00 00       	call   4694 <fork>
    12d1:	89 45 d8             	mov    %eax,-0x28(%ebp)
    if(pid < 0){
    12d4:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
    12d8:	79 19                	jns    12f3 <fourfiles+0x95>
      printf(1, "fork failed\n");
    12da:	83 ec 08             	sub    $0x8,%esp
    12dd:	8d 83 69 e0 ff ff    	lea    -0x1f97(%ebx),%eax
    12e3:	50                   	push   %eax
    12e4:	6a 01                	push   $0x1
    12e6:	e8 4d 35 00 00       	call   4838 <printf>
    12eb:	83 c4 10             	add    $0x10,%esp
      exit();
    12ee:	e8 a9 33 00 00       	call   469c <exit>
    }

    if(pid == 0){
    12f3:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
    12f7:	0f 85 ad 00 00 00    	jne    13aa <fourfiles+0x14c>
      fd = open(fname, O_CREATE | O_RDWR);
    12fd:	83 ec 08             	sub    $0x8,%esp
    1300:	68 02 02 00 00       	push   $0x202
    1305:	ff 75 e4             	push   -0x1c(%ebp)
    1308:	e8 cf 33 00 00       	call   46dc <open>
    130d:	83 c4 10             	add    $0x10,%esp
    1310:	89 45 e0             	mov    %eax,-0x20(%ebp)
      if(fd < 0){
    1313:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    1317:	79 19                	jns    1332 <fourfiles+0xd4>
        printf(1, "create failed\n");
    1319:	83 ec 08             	sub    $0x8,%esp
    131c:	8d 83 fd e5 ff ff    	lea    -0x1a03(%ebx),%eax
    1322:	50                   	push   %eax
    1323:	6a 01                	push   $0x1
    1325:	e8 0e 35 00 00       	call   4838 <printf>
    132a:	83 c4 10             	add    $0x10,%esp
        exit();
    132d:	e8 6a 33 00 00       	call   469c <exit>
      }

      memset(buf, '0'+pi, 512);
    1332:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1335:	83 c0 30             	add    $0x30,%eax
    1338:	83 ec 04             	sub    $0x4,%esp
    133b:	68 00 02 00 00       	push   $0x200
    1340:	50                   	push   %eax
    1341:	8d 83 50 00 00 00    	lea    0x50(%ebx),%eax
    1347:	50                   	push   %eax
    1348:	e8 6e 31 00 00       	call   44bb <memset>
    134d:	83 c4 10             	add    $0x10,%esp
      for(i = 0; i < 12; i++){
    1350:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1357:	eb 46                	jmp    139f <fourfiles+0x141>
        if((n = write(fd, buf, 500)) != 500){
    1359:	83 ec 04             	sub    $0x4,%esp
    135c:	68 f4 01 00 00       	push   $0x1f4
    1361:	8d 83 50 00 00 00    	lea    0x50(%ebx),%eax
    1367:	50                   	push   %eax
    1368:	ff 75 e0             	push   -0x20(%ebp)
    136b:	e8 4c 33 00 00       	call   46bc <write>
    1370:	83 c4 10             	add    $0x10,%esp
    1373:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1376:	81 7d dc f4 01 00 00 	cmpl   $0x1f4,-0x24(%ebp)
    137d:	74 1c                	je     139b <fourfiles+0x13d>
          printf(1, "write failed %d\n", n);
    137f:	83 ec 04             	sub    $0x4,%esp
    1382:	ff 75 dc             	push   -0x24(%ebp)
    1385:	8d 83 0c e6 ff ff    	lea    -0x19f4(%ebx),%eax
    138b:	50                   	push   %eax
    138c:	6a 01                	push   $0x1
    138e:	e8 a5 34 00 00       	call   4838 <printf>
    1393:	83 c4 10             	add    $0x10,%esp
          exit();
    1396:	e8 01 33 00 00       	call   469c <exit>
      for(i = 0; i < 12; i++){
    139b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    139f:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    13a3:	7e b4                	jle    1359 <fourfiles+0xfb>
        }
      }
      exit();
    13a5:	e8 f2 32 00 00       	call   469c <exit>
  for(pi = 0; pi < 4; pi++){
    13aa:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    13ae:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
    13b2:	0f 8e fc fe ff ff    	jle    12b4 <fourfiles+0x56>
    }
  }

  for(pi = 0; pi < 4; pi++){
    13b8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    13bf:	eb 09                	jmp    13ca <fourfiles+0x16c>
    wait();
    13c1:	e8 de 32 00 00       	call   46a4 <wait>
  for(pi = 0; pi < 4; pi++){
    13c6:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    13ca:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
    13ce:	7e f1                	jle    13c1 <fourfiles+0x163>
  }

  for(i = 0; i < 2; i++){
    13d0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    13d7:	e9 dd 00 00 00       	jmp    14b9 <fourfiles+0x25b>
    fname = names[i];
    13dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13df:	8b 44 85 c8          	mov    -0x38(%ebp,%eax,4),%eax
    13e3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    fd = open(fname, 0);
    13e6:	83 ec 08             	sub    $0x8,%esp
    13e9:	6a 00                	push   $0x0
    13eb:	ff 75 e4             	push   -0x1c(%ebp)
    13ee:	e8 e9 32 00 00       	call   46dc <open>
    13f3:	83 c4 10             	add    $0x10,%esp
    13f6:	89 45 e0             	mov    %eax,-0x20(%ebp)
    total = 0;
    13f9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    1400:	eb 4f                	jmp    1451 <fourfiles+0x1f3>
      for(j = 0; j < n; j++){
    1402:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1409:	eb 38                	jmp    1443 <fourfiles+0x1e5>
        if(buf[j] != '0'+i){
    140b:	8d 93 50 00 00 00    	lea    0x50(%ebx),%edx
    1411:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1414:	01 d0                	add    %edx,%eax
    1416:	0f b6 00             	movzbl (%eax),%eax
    1419:	0f be c0             	movsbl %al,%eax
    141c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    141f:	83 c2 30             	add    $0x30,%edx
    1422:	39 d0                	cmp    %edx,%eax
    1424:	74 19                	je     143f <fourfiles+0x1e1>
          printf(1, "wrong char\n");
    1426:	83 ec 08             	sub    $0x8,%esp
    1429:	8d 83 1d e6 ff ff    	lea    -0x19e3(%ebx),%eax
    142f:	50                   	push   %eax
    1430:	6a 01                	push   $0x1
    1432:	e8 01 34 00 00       	call   4838 <printf>
    1437:	83 c4 10             	add    $0x10,%esp
          exit();
    143a:	e8 5d 32 00 00       	call   469c <exit>
      for(j = 0; j < n; j++){
    143f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1443:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1446:	3b 45 dc             	cmp    -0x24(%ebp),%eax
    1449:	7c c0                	jl     140b <fourfiles+0x1ad>
        }
      }
      total += n;
    144b:	8b 45 dc             	mov    -0x24(%ebp),%eax
    144e:	01 45 ec             	add    %eax,-0x14(%ebp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    1451:	83 ec 04             	sub    $0x4,%esp
    1454:	68 00 20 00 00       	push   $0x2000
    1459:	8d 83 50 00 00 00    	lea    0x50(%ebx),%eax
    145f:	50                   	push   %eax
    1460:	ff 75 e0             	push   -0x20(%ebp)
    1463:	e8 4c 32 00 00       	call   46b4 <read>
    1468:	83 c4 10             	add    $0x10,%esp
    146b:	89 45 dc             	mov    %eax,-0x24(%ebp)
    146e:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
    1472:	7f 8e                	jg     1402 <fourfiles+0x1a4>
    }
    close(fd);
    1474:	83 ec 0c             	sub    $0xc,%esp
    1477:	ff 75 e0             	push   -0x20(%ebp)
    147a:	e8 45 32 00 00       	call   46c4 <close>
    147f:	83 c4 10             	add    $0x10,%esp
    if(total != 12*500){
    1482:	81 7d ec 70 17 00 00 	cmpl   $0x1770,-0x14(%ebp)
    1489:	74 1c                	je     14a7 <fourfiles+0x249>
      printf(1, "wrong length %d\n", total);
    148b:	83 ec 04             	sub    $0x4,%esp
    148e:	ff 75 ec             	push   -0x14(%ebp)
    1491:	8d 83 29 e6 ff ff    	lea    -0x19d7(%ebx),%eax
    1497:	50                   	push   %eax
    1498:	6a 01                	push   $0x1
    149a:	e8 99 33 00 00       	call   4838 <printf>
    149f:	83 c4 10             	add    $0x10,%esp
      exit();
    14a2:	e8 f5 31 00 00       	call   469c <exit>
    }
    unlink(fname);
    14a7:	83 ec 0c             	sub    $0xc,%esp
    14aa:	ff 75 e4             	push   -0x1c(%ebp)
    14ad:	e8 3a 32 00 00       	call   46ec <unlink>
    14b2:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 2; i++){
    14b5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    14b9:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
    14bd:	0f 8e 19 ff ff ff    	jle    13dc <fourfiles+0x17e>
  }

  printf(1, "fourfiles ok\n");
    14c3:	83 ec 08             	sub    $0x8,%esp
    14c6:	8d 83 3a e6 ff ff    	lea    -0x19c6(%ebx),%eax
    14cc:	50                   	push   %eax
    14cd:	6a 01                	push   $0x1
    14cf:	e8 64 33 00 00       	call   4838 <printf>
    14d4:	83 c4 10             	add    $0x10,%esp
}
    14d7:	90                   	nop
    14d8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    14db:	c9                   	leave  
    14dc:	c3                   	ret    

000014dd <createdelete>:

// four processes create and delete different files in same directory
void
createdelete(void)
{
    14dd:	55                   	push   %ebp
    14de:	89 e5                	mov    %esp,%ebp
    14e0:	53                   	push   %ebx
    14e1:	83 ec 34             	sub    $0x34,%esp
    14e4:	e8 ea 2e 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
    14e9:	81 c3 87 57 00 00    	add    $0x5787,%ebx
  enum { N = 20 };
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");
    14ef:	83 ec 08             	sub    $0x8,%esp
    14f2:	8d 83 48 e6 ff ff    	lea    -0x19b8(%ebx),%eax
    14f8:	50                   	push   %eax
    14f9:	6a 01                	push   $0x1
    14fb:	e8 38 33 00 00       	call   4838 <printf>
    1500:	83 c4 10             	add    $0x10,%esp

  for(pi = 0; pi < 4; pi++){
    1503:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    150a:	e9 fc 00 00 00       	jmp    160b <createdelete+0x12e>
    pid = fork();
    150f:	e8 80 31 00 00       	call   4694 <fork>
    1514:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pid < 0){
    1517:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    151b:	79 19                	jns    1536 <createdelete+0x59>
      printf(1, "fork failed\n");
    151d:	83 ec 08             	sub    $0x8,%esp
    1520:	8d 83 69 e0 ff ff    	lea    -0x1f97(%ebx),%eax
    1526:	50                   	push   %eax
    1527:	6a 01                	push   $0x1
    1529:	e8 0a 33 00 00       	call   4838 <printf>
    152e:	83 c4 10             	add    $0x10,%esp
      exit();
    1531:	e8 66 31 00 00       	call   469c <exit>
    }

    if(pid == 0){
    1536:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    153a:	0f 85 c7 00 00 00    	jne    1607 <createdelete+0x12a>
      name[0] = 'p' + pi;
    1540:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1543:	83 c0 70             	add    $0x70,%eax
    1546:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[2] = '\0';
    1549:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
      for(i = 0; i < N; i++){
    154d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1554:	e9 9f 00 00 00       	jmp    15f8 <createdelete+0x11b>
        name[1] = '0' + i;
    1559:	8b 45 f4             	mov    -0xc(%ebp),%eax
    155c:	83 c0 30             	add    $0x30,%eax
    155f:	88 45 c9             	mov    %al,-0x37(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
    1562:	83 ec 08             	sub    $0x8,%esp
    1565:	68 02 02 00 00       	push   $0x202
    156a:	8d 45 c8             	lea    -0x38(%ebp),%eax
    156d:	50                   	push   %eax
    156e:	e8 69 31 00 00       	call   46dc <open>
    1573:	83 c4 10             	add    $0x10,%esp
    1576:	89 45 ec             	mov    %eax,-0x14(%ebp)
        if(fd < 0){
    1579:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    157d:	79 19                	jns    1598 <createdelete+0xbb>
          printf(1, "create failed\n");
    157f:	83 ec 08             	sub    $0x8,%esp
    1582:	8d 83 fd e5 ff ff    	lea    -0x1a03(%ebx),%eax
    1588:	50                   	push   %eax
    1589:	6a 01                	push   $0x1
    158b:	e8 a8 32 00 00       	call   4838 <printf>
    1590:	83 c4 10             	add    $0x10,%esp
          exit();
    1593:	e8 04 31 00 00       	call   469c <exit>
        }
        close(fd);
    1598:	83 ec 0c             	sub    $0xc,%esp
    159b:	ff 75 ec             	push   -0x14(%ebp)
    159e:	e8 21 31 00 00       	call   46c4 <close>
    15a3:	83 c4 10             	add    $0x10,%esp
        if(i > 0 && (i % 2 ) == 0){
    15a6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    15aa:	7e 48                	jle    15f4 <createdelete+0x117>
    15ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15af:	83 e0 01             	and    $0x1,%eax
    15b2:	85 c0                	test   %eax,%eax
    15b4:	75 3e                	jne    15f4 <createdelete+0x117>
          name[1] = '0' + (i / 2);
    15b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b9:	89 c2                	mov    %eax,%edx
    15bb:	c1 ea 1f             	shr    $0x1f,%edx
    15be:	01 d0                	add    %edx,%eax
    15c0:	d1 f8                	sar    %eax
    15c2:	83 c0 30             	add    $0x30,%eax
    15c5:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
    15c8:	83 ec 0c             	sub    $0xc,%esp
    15cb:	8d 45 c8             	lea    -0x38(%ebp),%eax
    15ce:	50                   	push   %eax
    15cf:	e8 18 31 00 00       	call   46ec <unlink>
    15d4:	83 c4 10             	add    $0x10,%esp
    15d7:	85 c0                	test   %eax,%eax
    15d9:	79 19                	jns    15f4 <createdelete+0x117>
            printf(1, "unlink failed\n");
    15db:	83 ec 08             	sub    $0x8,%esp
    15de:	8d 83 ec e0 ff ff    	lea    -0x1f14(%ebx),%eax
    15e4:	50                   	push   %eax
    15e5:	6a 01                	push   $0x1
    15e7:	e8 4c 32 00 00       	call   4838 <printf>
    15ec:	83 c4 10             	add    $0x10,%esp
            exit();
    15ef:	e8 a8 30 00 00       	call   469c <exit>
      for(i = 0; i < N; i++){
    15f4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    15f8:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    15fc:	0f 8e 57 ff ff ff    	jle    1559 <createdelete+0x7c>
          }
        }
      }
      exit();
    1602:	e8 95 30 00 00       	call   469c <exit>
  for(pi = 0; pi < 4; pi++){
    1607:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    160b:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    160f:	0f 8e fa fe ff ff    	jle    150f <createdelete+0x32>
    }
  }

  for(pi = 0; pi < 4; pi++){
    1615:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    161c:	eb 09                	jmp    1627 <createdelete+0x14a>
    wait();
    161e:	e8 81 30 00 00       	call   46a4 <wait>
  for(pi = 0; pi < 4; pi++){
    1623:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1627:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    162b:	7e f1                	jle    161e <createdelete+0x141>
  }

  name[0] = name[1] = name[2] = 0;
    162d:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    1631:	0f b6 45 ca          	movzbl -0x36(%ebp),%eax
    1635:	88 45 c9             	mov    %al,-0x37(%ebp)
    1638:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
    163c:	88 45 c8             	mov    %al,-0x38(%ebp)
  for(i = 0; i < N; i++){
    163f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1646:	e9 b6 00 00 00       	jmp    1701 <createdelete+0x224>
    for(pi = 0; pi < 4; pi++){
    164b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1652:	e9 9c 00 00 00       	jmp    16f3 <createdelete+0x216>
      name[0] = 'p' + pi;
    1657:	8b 45 f0             	mov    -0x10(%ebp),%eax
    165a:	83 c0 70             	add    $0x70,%eax
    165d:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[1] = '0' + i;
    1660:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1663:	83 c0 30             	add    $0x30,%eax
    1666:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
    1669:	83 ec 08             	sub    $0x8,%esp
    166c:	6a 00                	push   $0x0
    166e:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1671:	50                   	push   %eax
    1672:	e8 65 30 00 00       	call   46dc <open>
    1677:	83 c4 10             	add    $0x10,%esp
    167a:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if((i == 0 || i >= N/2) && fd < 0){
    167d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1681:	74 06                	je     1689 <createdelete+0x1ac>
    1683:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    1687:	7e 23                	jle    16ac <createdelete+0x1cf>
    1689:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    168d:	79 1d                	jns    16ac <createdelete+0x1cf>
        printf(1, "oops createdelete %s didn't exist\n", name);
    168f:	83 ec 04             	sub    $0x4,%esp
    1692:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1695:	50                   	push   %eax
    1696:	8d 83 5c e6 ff ff    	lea    -0x19a4(%ebx),%eax
    169c:	50                   	push   %eax
    169d:	6a 01                	push   $0x1
    169f:	e8 94 31 00 00       	call   4838 <printf>
    16a4:	83 c4 10             	add    $0x10,%esp
        exit();
    16a7:	e8 f0 2f 00 00       	call   469c <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    16ac:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16b0:	7e 29                	jle    16db <createdelete+0x1fe>
    16b2:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    16b6:	7f 23                	jg     16db <createdelete+0x1fe>
    16b8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    16bc:	78 1d                	js     16db <createdelete+0x1fe>
        printf(1, "oops createdelete %s did exist\n", name);
    16be:	83 ec 04             	sub    $0x4,%esp
    16c1:	8d 45 c8             	lea    -0x38(%ebp),%eax
    16c4:	50                   	push   %eax
    16c5:	8d 83 80 e6 ff ff    	lea    -0x1980(%ebx),%eax
    16cb:	50                   	push   %eax
    16cc:	6a 01                	push   $0x1
    16ce:	e8 65 31 00 00       	call   4838 <printf>
    16d3:	83 c4 10             	add    $0x10,%esp
        exit();
    16d6:	e8 c1 2f 00 00       	call   469c <exit>
      }
      if(fd >= 0)
    16db:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    16df:	78 0e                	js     16ef <createdelete+0x212>
        close(fd);
    16e1:	83 ec 0c             	sub    $0xc,%esp
    16e4:	ff 75 ec             	push   -0x14(%ebp)
    16e7:	e8 d8 2f 00 00       	call   46c4 <close>
    16ec:	83 c4 10             	add    $0x10,%esp
    for(pi = 0; pi < 4; pi++){
    16ef:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    16f3:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    16f7:	0f 8e 5a ff ff ff    	jle    1657 <createdelete+0x17a>
  for(i = 0; i < N; i++){
    16fd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1701:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    1705:	0f 8e 40 ff ff ff    	jle    164b <createdelete+0x16e>
    }
  }

  for(i = 0; i < N; i++){
    170b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1712:	eb 38                	jmp    174c <createdelete+0x26f>
    for(pi = 0; pi < 4; pi++){
    1714:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    171b:	eb 25                	jmp    1742 <createdelete+0x265>
      name[0] = 'p' + i;
    171d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1720:	83 c0 70             	add    $0x70,%eax
    1723:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[1] = '0' + i;
    1726:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1729:	83 c0 30             	add    $0x30,%eax
    172c:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
    172f:	83 ec 0c             	sub    $0xc,%esp
    1732:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1735:	50                   	push   %eax
    1736:	e8 b1 2f 00 00       	call   46ec <unlink>
    173b:	83 c4 10             	add    $0x10,%esp
    for(pi = 0; pi < 4; pi++){
    173e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1742:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    1746:	7e d5                	jle    171d <createdelete+0x240>
  for(i = 0; i < N; i++){
    1748:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    174c:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    1750:	7e c2                	jle    1714 <createdelete+0x237>
    }
  }

  printf(1, "createdelete ok\n");
    1752:	83 ec 08             	sub    $0x8,%esp
    1755:	8d 83 a0 e6 ff ff    	lea    -0x1960(%ebx),%eax
    175b:	50                   	push   %eax
    175c:	6a 01                	push   $0x1
    175e:	e8 d5 30 00 00       	call   4838 <printf>
    1763:	83 c4 10             	add    $0x10,%esp
}
    1766:	90                   	nop
    1767:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    176a:	c9                   	leave  
    176b:	c3                   	ret    

0000176c <unlinkread>:

// can I unlink a file and still read it?
void
unlinkread(void)
{
    176c:	55                   	push   %ebp
    176d:	89 e5                	mov    %esp,%ebp
    176f:	53                   	push   %ebx
    1770:	83 ec 14             	sub    $0x14,%esp
    1773:	e8 5b 2c 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
    1778:	81 c3 f8 54 00 00    	add    $0x54f8,%ebx
  int fd, fd1;

  printf(1, "unlinkread test\n");
    177e:	83 ec 08             	sub    $0x8,%esp
    1781:	8d 83 b1 e6 ff ff    	lea    -0x194f(%ebx),%eax
    1787:	50                   	push   %eax
    1788:	6a 01                	push   $0x1
    178a:	e8 a9 30 00 00       	call   4838 <printf>
    178f:	83 c4 10             	add    $0x10,%esp
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1792:	83 ec 08             	sub    $0x8,%esp
    1795:	68 02 02 00 00       	push   $0x202
    179a:	8d 83 c2 e6 ff ff    	lea    -0x193e(%ebx),%eax
    17a0:	50                   	push   %eax
    17a1:	e8 36 2f 00 00       	call   46dc <open>
    17a6:	83 c4 10             	add    $0x10,%esp
    17a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    17ac:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    17b0:	79 19                	jns    17cb <unlinkread+0x5f>
    printf(1, "create unlinkread failed\n");
    17b2:	83 ec 08             	sub    $0x8,%esp
    17b5:	8d 83 cd e6 ff ff    	lea    -0x1933(%ebx),%eax
    17bb:	50                   	push   %eax
    17bc:	6a 01                	push   $0x1
    17be:	e8 75 30 00 00       	call   4838 <printf>
    17c3:	83 c4 10             	add    $0x10,%esp
    exit();
    17c6:	e8 d1 2e 00 00       	call   469c <exit>
  }
  write(fd, "hello", 5);
    17cb:	83 ec 04             	sub    $0x4,%esp
    17ce:	6a 05                	push   $0x5
    17d0:	8d 83 e7 e6 ff ff    	lea    -0x1919(%ebx),%eax
    17d6:	50                   	push   %eax
    17d7:	ff 75 f4             	push   -0xc(%ebp)
    17da:	e8 dd 2e 00 00       	call   46bc <write>
    17df:	83 c4 10             	add    $0x10,%esp
  close(fd);
    17e2:	83 ec 0c             	sub    $0xc,%esp
    17e5:	ff 75 f4             	push   -0xc(%ebp)
    17e8:	e8 d7 2e 00 00       	call   46c4 <close>
    17ed:	83 c4 10             	add    $0x10,%esp

  fd = open("unlinkread", O_RDWR);
    17f0:	83 ec 08             	sub    $0x8,%esp
    17f3:	6a 02                	push   $0x2
    17f5:	8d 83 c2 e6 ff ff    	lea    -0x193e(%ebx),%eax
    17fb:	50                   	push   %eax
    17fc:	e8 db 2e 00 00       	call   46dc <open>
    1801:	83 c4 10             	add    $0x10,%esp
    1804:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1807:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    180b:	79 19                	jns    1826 <unlinkread+0xba>
    printf(1, "open unlinkread failed\n");
    180d:	83 ec 08             	sub    $0x8,%esp
    1810:	8d 83 ed e6 ff ff    	lea    -0x1913(%ebx),%eax
    1816:	50                   	push   %eax
    1817:	6a 01                	push   $0x1
    1819:	e8 1a 30 00 00       	call   4838 <printf>
    181e:	83 c4 10             	add    $0x10,%esp
    exit();
    1821:	e8 76 2e 00 00       	call   469c <exit>
  }
  if(unlink("unlinkread") != 0){
    1826:	83 ec 0c             	sub    $0xc,%esp
    1829:	8d 83 c2 e6 ff ff    	lea    -0x193e(%ebx),%eax
    182f:	50                   	push   %eax
    1830:	e8 b7 2e 00 00       	call   46ec <unlink>
    1835:	83 c4 10             	add    $0x10,%esp
    1838:	85 c0                	test   %eax,%eax
    183a:	74 19                	je     1855 <unlinkread+0xe9>
    printf(1, "unlink unlinkread failed\n");
    183c:	83 ec 08             	sub    $0x8,%esp
    183f:	8d 83 05 e7 ff ff    	lea    -0x18fb(%ebx),%eax
    1845:	50                   	push   %eax
    1846:	6a 01                	push   $0x1
    1848:	e8 eb 2f 00 00       	call   4838 <printf>
    184d:	83 c4 10             	add    $0x10,%esp
    exit();
    1850:	e8 47 2e 00 00       	call   469c <exit>
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    1855:	83 ec 08             	sub    $0x8,%esp
    1858:	68 02 02 00 00       	push   $0x202
    185d:	8d 83 c2 e6 ff ff    	lea    -0x193e(%ebx),%eax
    1863:	50                   	push   %eax
    1864:	e8 73 2e 00 00       	call   46dc <open>
    1869:	83 c4 10             	add    $0x10,%esp
    186c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  write(fd1, "yyy", 3);
    186f:	83 ec 04             	sub    $0x4,%esp
    1872:	6a 03                	push   $0x3
    1874:	8d 83 1f e7 ff ff    	lea    -0x18e1(%ebx),%eax
    187a:	50                   	push   %eax
    187b:	ff 75 f0             	push   -0x10(%ebp)
    187e:	e8 39 2e 00 00       	call   46bc <write>
    1883:	83 c4 10             	add    $0x10,%esp
  close(fd1);
    1886:	83 ec 0c             	sub    $0xc,%esp
    1889:	ff 75 f0             	push   -0x10(%ebp)
    188c:	e8 33 2e 00 00       	call   46c4 <close>
    1891:	83 c4 10             	add    $0x10,%esp

  if(read(fd, buf, sizeof(buf)) != 5){
    1894:	83 ec 04             	sub    $0x4,%esp
    1897:	68 00 20 00 00       	push   $0x2000
    189c:	8d 83 50 00 00 00    	lea    0x50(%ebx),%eax
    18a2:	50                   	push   %eax
    18a3:	ff 75 f4             	push   -0xc(%ebp)
    18a6:	e8 09 2e 00 00       	call   46b4 <read>
    18ab:	83 c4 10             	add    $0x10,%esp
    18ae:	83 f8 05             	cmp    $0x5,%eax
    18b1:	74 19                	je     18cc <unlinkread+0x160>
    printf(1, "unlinkread read failed");
    18b3:	83 ec 08             	sub    $0x8,%esp
    18b6:	8d 83 23 e7 ff ff    	lea    -0x18dd(%ebx),%eax
    18bc:	50                   	push   %eax
    18bd:	6a 01                	push   $0x1
    18bf:	e8 74 2f 00 00       	call   4838 <printf>
    18c4:	83 c4 10             	add    $0x10,%esp
    exit();
    18c7:	e8 d0 2d 00 00       	call   469c <exit>
  }
  if(buf[0] != 'h'){
    18cc:	0f b6 83 50 00 00 00 	movzbl 0x50(%ebx),%eax
    18d3:	3c 68                	cmp    $0x68,%al
    18d5:	74 19                	je     18f0 <unlinkread+0x184>
    printf(1, "unlinkread wrong data\n");
    18d7:	83 ec 08             	sub    $0x8,%esp
    18da:	8d 83 3a e7 ff ff    	lea    -0x18c6(%ebx),%eax
    18e0:	50                   	push   %eax
    18e1:	6a 01                	push   $0x1
    18e3:	e8 50 2f 00 00       	call   4838 <printf>
    18e8:	83 c4 10             	add    $0x10,%esp
    exit();
    18eb:	e8 ac 2d 00 00       	call   469c <exit>
  }
  if(write(fd, buf, 10) != 10){
    18f0:	83 ec 04             	sub    $0x4,%esp
    18f3:	6a 0a                	push   $0xa
    18f5:	8d 83 50 00 00 00    	lea    0x50(%ebx),%eax
    18fb:	50                   	push   %eax
    18fc:	ff 75 f4             	push   -0xc(%ebp)
    18ff:	e8 b8 2d 00 00       	call   46bc <write>
    1904:	83 c4 10             	add    $0x10,%esp
    1907:	83 f8 0a             	cmp    $0xa,%eax
    190a:	74 19                	je     1925 <unlinkread+0x1b9>
    printf(1, "unlinkread write failed\n");
    190c:	83 ec 08             	sub    $0x8,%esp
    190f:	8d 83 51 e7 ff ff    	lea    -0x18af(%ebx),%eax
    1915:	50                   	push   %eax
    1916:	6a 01                	push   $0x1
    1918:	e8 1b 2f 00 00       	call   4838 <printf>
    191d:	83 c4 10             	add    $0x10,%esp
    exit();
    1920:	e8 77 2d 00 00       	call   469c <exit>
  }
  close(fd);
    1925:	83 ec 0c             	sub    $0xc,%esp
    1928:	ff 75 f4             	push   -0xc(%ebp)
    192b:	e8 94 2d 00 00       	call   46c4 <close>
    1930:	83 c4 10             	add    $0x10,%esp
  unlink("unlinkread");
    1933:	83 ec 0c             	sub    $0xc,%esp
    1936:	8d 83 c2 e6 ff ff    	lea    -0x193e(%ebx),%eax
    193c:	50                   	push   %eax
    193d:	e8 aa 2d 00 00       	call   46ec <unlink>
    1942:	83 c4 10             	add    $0x10,%esp
  printf(1, "unlinkread ok\n");
    1945:	83 ec 08             	sub    $0x8,%esp
    1948:	8d 83 6a e7 ff ff    	lea    -0x1896(%ebx),%eax
    194e:	50                   	push   %eax
    194f:	6a 01                	push   $0x1
    1951:	e8 e2 2e 00 00       	call   4838 <printf>
    1956:	83 c4 10             	add    $0x10,%esp
}
    1959:	90                   	nop
    195a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    195d:	c9                   	leave  
    195e:	c3                   	ret    

0000195f <linktest>:

void
linktest(void)
{
    195f:	55                   	push   %ebp
    1960:	89 e5                	mov    %esp,%ebp
    1962:	53                   	push   %ebx
    1963:	83 ec 14             	sub    $0x14,%esp
    1966:	e8 68 2a 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
    196b:	81 c3 05 53 00 00    	add    $0x5305,%ebx
  int fd;

  printf(1, "linktest\n");
    1971:	83 ec 08             	sub    $0x8,%esp
    1974:	8d 83 79 e7 ff ff    	lea    -0x1887(%ebx),%eax
    197a:	50                   	push   %eax
    197b:	6a 01                	push   $0x1
    197d:	e8 b6 2e 00 00       	call   4838 <printf>
    1982:	83 c4 10             	add    $0x10,%esp

  unlink("lf1");
    1985:	83 ec 0c             	sub    $0xc,%esp
    1988:	8d 83 83 e7 ff ff    	lea    -0x187d(%ebx),%eax
    198e:	50                   	push   %eax
    198f:	e8 58 2d 00 00       	call   46ec <unlink>
    1994:	83 c4 10             	add    $0x10,%esp
  unlink("lf2");
    1997:	83 ec 0c             	sub    $0xc,%esp
    199a:	8d 83 87 e7 ff ff    	lea    -0x1879(%ebx),%eax
    19a0:	50                   	push   %eax
    19a1:	e8 46 2d 00 00       	call   46ec <unlink>
    19a6:	83 c4 10             	add    $0x10,%esp

  fd = open("lf1", O_CREATE|O_RDWR);
    19a9:	83 ec 08             	sub    $0x8,%esp
    19ac:	68 02 02 00 00       	push   $0x202
    19b1:	8d 83 83 e7 ff ff    	lea    -0x187d(%ebx),%eax
    19b7:	50                   	push   %eax
    19b8:	e8 1f 2d 00 00       	call   46dc <open>
    19bd:	83 c4 10             	add    $0x10,%esp
    19c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    19c3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    19c7:	79 19                	jns    19e2 <linktest+0x83>
    printf(1, "create lf1 failed\n");
    19c9:	83 ec 08             	sub    $0x8,%esp
    19cc:	8d 83 8b e7 ff ff    	lea    -0x1875(%ebx),%eax
    19d2:	50                   	push   %eax
    19d3:	6a 01                	push   $0x1
    19d5:	e8 5e 2e 00 00       	call   4838 <printf>
    19da:	83 c4 10             	add    $0x10,%esp
    exit();
    19dd:	e8 ba 2c 00 00       	call   469c <exit>
  }
  if(write(fd, "hello", 5) != 5){
    19e2:	83 ec 04             	sub    $0x4,%esp
    19e5:	6a 05                	push   $0x5
    19e7:	8d 83 e7 e6 ff ff    	lea    -0x1919(%ebx),%eax
    19ed:	50                   	push   %eax
    19ee:	ff 75 f4             	push   -0xc(%ebp)
    19f1:	e8 c6 2c 00 00       	call   46bc <write>
    19f6:	83 c4 10             	add    $0x10,%esp
    19f9:	83 f8 05             	cmp    $0x5,%eax
    19fc:	74 19                	je     1a17 <linktest+0xb8>
    printf(1, "write lf1 failed\n");
    19fe:	83 ec 08             	sub    $0x8,%esp
    1a01:	8d 83 9e e7 ff ff    	lea    -0x1862(%ebx),%eax
    1a07:	50                   	push   %eax
    1a08:	6a 01                	push   $0x1
    1a0a:	e8 29 2e 00 00       	call   4838 <printf>
    1a0f:	83 c4 10             	add    $0x10,%esp
    exit();
    1a12:	e8 85 2c 00 00       	call   469c <exit>
  }
  close(fd);
    1a17:	83 ec 0c             	sub    $0xc,%esp
    1a1a:	ff 75 f4             	push   -0xc(%ebp)
    1a1d:	e8 a2 2c 00 00       	call   46c4 <close>
    1a22:	83 c4 10             	add    $0x10,%esp

  if(link("lf1", "lf2") < 0){
    1a25:	83 ec 08             	sub    $0x8,%esp
    1a28:	8d 83 87 e7 ff ff    	lea    -0x1879(%ebx),%eax
    1a2e:	50                   	push   %eax
    1a2f:	8d 83 83 e7 ff ff    	lea    -0x187d(%ebx),%eax
    1a35:	50                   	push   %eax
    1a36:	e8 c1 2c 00 00       	call   46fc <link>
    1a3b:	83 c4 10             	add    $0x10,%esp
    1a3e:	85 c0                	test   %eax,%eax
    1a40:	79 19                	jns    1a5b <linktest+0xfc>
    printf(1, "link lf1 lf2 failed\n");
    1a42:	83 ec 08             	sub    $0x8,%esp
    1a45:	8d 83 b0 e7 ff ff    	lea    -0x1850(%ebx),%eax
    1a4b:	50                   	push   %eax
    1a4c:	6a 01                	push   $0x1
    1a4e:	e8 e5 2d 00 00       	call   4838 <printf>
    1a53:	83 c4 10             	add    $0x10,%esp
    exit();
    1a56:	e8 41 2c 00 00       	call   469c <exit>
  }
  unlink("lf1");
    1a5b:	83 ec 0c             	sub    $0xc,%esp
    1a5e:	8d 83 83 e7 ff ff    	lea    -0x187d(%ebx),%eax
    1a64:	50                   	push   %eax
    1a65:	e8 82 2c 00 00       	call   46ec <unlink>
    1a6a:	83 c4 10             	add    $0x10,%esp

  if(open("lf1", 0) >= 0){
    1a6d:	83 ec 08             	sub    $0x8,%esp
    1a70:	6a 00                	push   $0x0
    1a72:	8d 83 83 e7 ff ff    	lea    -0x187d(%ebx),%eax
    1a78:	50                   	push   %eax
    1a79:	e8 5e 2c 00 00       	call   46dc <open>
    1a7e:	83 c4 10             	add    $0x10,%esp
    1a81:	85 c0                	test   %eax,%eax
    1a83:	78 19                	js     1a9e <linktest+0x13f>
    printf(1, "unlinked lf1 but it is still there!\n");
    1a85:	83 ec 08             	sub    $0x8,%esp
    1a88:	8d 83 c8 e7 ff ff    	lea    -0x1838(%ebx),%eax
    1a8e:	50                   	push   %eax
    1a8f:	6a 01                	push   $0x1
    1a91:	e8 a2 2d 00 00       	call   4838 <printf>
    1a96:	83 c4 10             	add    $0x10,%esp
    exit();
    1a99:	e8 fe 2b 00 00       	call   469c <exit>
  }

  fd = open("lf2", 0);
    1a9e:	83 ec 08             	sub    $0x8,%esp
    1aa1:	6a 00                	push   $0x0
    1aa3:	8d 83 87 e7 ff ff    	lea    -0x1879(%ebx),%eax
    1aa9:	50                   	push   %eax
    1aaa:	e8 2d 2c 00 00       	call   46dc <open>
    1aaf:	83 c4 10             	add    $0x10,%esp
    1ab2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1ab5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1ab9:	79 19                	jns    1ad4 <linktest+0x175>
    printf(1, "open lf2 failed\n");
    1abb:	83 ec 08             	sub    $0x8,%esp
    1abe:	8d 83 ed e7 ff ff    	lea    -0x1813(%ebx),%eax
    1ac4:	50                   	push   %eax
    1ac5:	6a 01                	push   $0x1
    1ac7:	e8 6c 2d 00 00       	call   4838 <printf>
    1acc:	83 c4 10             	add    $0x10,%esp
    exit();
    1acf:	e8 c8 2b 00 00       	call   469c <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    1ad4:	83 ec 04             	sub    $0x4,%esp
    1ad7:	68 00 20 00 00       	push   $0x2000
    1adc:	8d 83 50 00 00 00    	lea    0x50(%ebx),%eax
    1ae2:	50                   	push   %eax
    1ae3:	ff 75 f4             	push   -0xc(%ebp)
    1ae6:	e8 c9 2b 00 00       	call   46b4 <read>
    1aeb:	83 c4 10             	add    $0x10,%esp
    1aee:	83 f8 05             	cmp    $0x5,%eax
    1af1:	74 19                	je     1b0c <linktest+0x1ad>
    printf(1, "read lf2 failed\n");
    1af3:	83 ec 08             	sub    $0x8,%esp
    1af6:	8d 83 fe e7 ff ff    	lea    -0x1802(%ebx),%eax
    1afc:	50                   	push   %eax
    1afd:	6a 01                	push   $0x1
    1aff:	e8 34 2d 00 00       	call   4838 <printf>
    1b04:	83 c4 10             	add    $0x10,%esp
    exit();
    1b07:	e8 90 2b 00 00       	call   469c <exit>
  }
  close(fd);
    1b0c:	83 ec 0c             	sub    $0xc,%esp
    1b0f:	ff 75 f4             	push   -0xc(%ebp)
    1b12:	e8 ad 2b 00 00       	call   46c4 <close>
    1b17:	83 c4 10             	add    $0x10,%esp

  if(link("lf2", "lf2") >= 0){
    1b1a:	83 ec 08             	sub    $0x8,%esp
    1b1d:	8d 83 87 e7 ff ff    	lea    -0x1879(%ebx),%eax
    1b23:	50                   	push   %eax
    1b24:	8d 83 87 e7 ff ff    	lea    -0x1879(%ebx),%eax
    1b2a:	50                   	push   %eax
    1b2b:	e8 cc 2b 00 00       	call   46fc <link>
    1b30:	83 c4 10             	add    $0x10,%esp
    1b33:	85 c0                	test   %eax,%eax
    1b35:	78 19                	js     1b50 <linktest+0x1f1>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    1b37:	83 ec 08             	sub    $0x8,%esp
    1b3a:	8d 83 0f e8 ff ff    	lea    -0x17f1(%ebx),%eax
    1b40:	50                   	push   %eax
    1b41:	6a 01                	push   $0x1
    1b43:	e8 f0 2c 00 00       	call   4838 <printf>
    1b48:	83 c4 10             	add    $0x10,%esp
    exit();
    1b4b:	e8 4c 2b 00 00       	call   469c <exit>
  }

  unlink("lf2");
    1b50:	83 ec 0c             	sub    $0xc,%esp
    1b53:	8d 83 87 e7 ff ff    	lea    -0x1879(%ebx),%eax
    1b59:	50                   	push   %eax
    1b5a:	e8 8d 2b 00 00       	call   46ec <unlink>
    1b5f:	83 c4 10             	add    $0x10,%esp
  if(link("lf2", "lf1") >= 0){
    1b62:	83 ec 08             	sub    $0x8,%esp
    1b65:	8d 83 83 e7 ff ff    	lea    -0x187d(%ebx),%eax
    1b6b:	50                   	push   %eax
    1b6c:	8d 83 87 e7 ff ff    	lea    -0x1879(%ebx),%eax
    1b72:	50                   	push   %eax
    1b73:	e8 84 2b 00 00       	call   46fc <link>
    1b78:	83 c4 10             	add    $0x10,%esp
    1b7b:	85 c0                	test   %eax,%eax
    1b7d:	78 19                	js     1b98 <linktest+0x239>
    printf(1, "link non-existant succeeded! oops\n");
    1b7f:	83 ec 08             	sub    $0x8,%esp
    1b82:	8d 83 30 e8 ff ff    	lea    -0x17d0(%ebx),%eax
    1b88:	50                   	push   %eax
    1b89:	6a 01                	push   $0x1
    1b8b:	e8 a8 2c 00 00       	call   4838 <printf>
    1b90:	83 c4 10             	add    $0x10,%esp
    exit();
    1b93:	e8 04 2b 00 00       	call   469c <exit>
  }

  if(link(".", "lf1") >= 0){
    1b98:	83 ec 08             	sub    $0x8,%esp
    1b9b:	8d 83 83 e7 ff ff    	lea    -0x187d(%ebx),%eax
    1ba1:	50                   	push   %eax
    1ba2:	8d 83 53 e8 ff ff    	lea    -0x17ad(%ebx),%eax
    1ba8:	50                   	push   %eax
    1ba9:	e8 4e 2b 00 00       	call   46fc <link>
    1bae:	83 c4 10             	add    $0x10,%esp
    1bb1:	85 c0                	test   %eax,%eax
    1bb3:	78 19                	js     1bce <linktest+0x26f>
    printf(1, "link . lf1 succeeded! oops\n");
    1bb5:	83 ec 08             	sub    $0x8,%esp
    1bb8:	8d 83 55 e8 ff ff    	lea    -0x17ab(%ebx),%eax
    1bbe:	50                   	push   %eax
    1bbf:	6a 01                	push   $0x1
    1bc1:	e8 72 2c 00 00       	call   4838 <printf>
    1bc6:	83 c4 10             	add    $0x10,%esp
    exit();
    1bc9:	e8 ce 2a 00 00       	call   469c <exit>
  }

  printf(1, "linktest ok\n");
    1bce:	83 ec 08             	sub    $0x8,%esp
    1bd1:	8d 83 71 e8 ff ff    	lea    -0x178f(%ebx),%eax
    1bd7:	50                   	push   %eax
    1bd8:	6a 01                	push   $0x1
    1bda:	e8 59 2c 00 00       	call   4838 <printf>
    1bdf:	83 c4 10             	add    $0x10,%esp
}
    1be2:	90                   	nop
    1be3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1be6:	c9                   	leave  
    1be7:	c3                   	ret    

00001be8 <concreate>:

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    1be8:	55                   	push   %ebp
    1be9:	89 e5                	mov    %esp,%ebp
    1beb:	56                   	push   %esi
    1bec:	53                   	push   %ebx
    1bed:	83 ec 50             	sub    $0x50,%esp
    1bf0:	e8 de 27 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
    1bf5:	81 c3 7b 50 00 00    	add    $0x507b,%ebx
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    1bfb:	83 ec 08             	sub    $0x8,%esp
    1bfe:	8d 83 7e e8 ff ff    	lea    -0x1782(%ebx),%eax
    1c04:	50                   	push   %eax
    1c05:	6a 01                	push   $0x1
    1c07:	e8 2c 2c 00 00       	call   4838 <printf>
    1c0c:	83 c4 10             	add    $0x10,%esp
  file[0] = 'C';
    1c0f:	c6 45 e5 43          	movb   $0x43,-0x1b(%ebp)
  file[2] = '\0';
    1c13:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
  for(i = 0; i < 40; i++){
    1c17:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1c1e:	e9 06 01 00 00       	jmp    1d29 <concreate+0x141>
    file[1] = '0' + i;
    1c23:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c26:	83 c0 30             	add    $0x30,%eax
    1c29:	88 45 e6             	mov    %al,-0x1a(%ebp)
    unlink(file);
    1c2c:	83 ec 0c             	sub    $0xc,%esp
    1c2f:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c32:	50                   	push   %eax
    1c33:	e8 b4 2a 00 00       	call   46ec <unlink>
    1c38:	83 c4 10             	add    $0x10,%esp
    pid = fork();
    1c3b:	e8 54 2a 00 00       	call   4694 <fork>
    1c40:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pid && (i % 3) == 1){
    1c43:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1c47:	74 3f                	je     1c88 <concreate+0xa0>
    1c49:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1c4c:	ba 56 55 55 55       	mov    $0x55555556,%edx
    1c51:	89 c8                	mov    %ecx,%eax
    1c53:	f7 ea                	imul   %edx
    1c55:	89 ce                	mov    %ecx,%esi
    1c57:	c1 fe 1f             	sar    $0x1f,%esi
    1c5a:	89 d0                	mov    %edx,%eax
    1c5c:	29 f0                	sub    %esi,%eax
    1c5e:	89 c2                	mov    %eax,%edx
    1c60:	01 d2                	add    %edx,%edx
    1c62:	01 c2                	add    %eax,%edx
    1c64:	89 c8                	mov    %ecx,%eax
    1c66:	29 d0                	sub    %edx,%eax
    1c68:	83 f8 01             	cmp    $0x1,%eax
    1c6b:	75 1b                	jne    1c88 <concreate+0xa0>
      link("C0", file);
    1c6d:	83 ec 08             	sub    $0x8,%esp
    1c70:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c73:	50                   	push   %eax
    1c74:	8d 83 8e e8 ff ff    	lea    -0x1772(%ebx),%eax
    1c7a:	50                   	push   %eax
    1c7b:	e8 7c 2a 00 00       	call   46fc <link>
    1c80:	83 c4 10             	add    $0x10,%esp
    1c83:	e9 8d 00 00 00       	jmp    1d15 <concreate+0x12d>
    } else if(pid == 0 && (i % 5) == 1){
    1c88:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1c8c:	75 3f                	jne    1ccd <concreate+0xe5>
    1c8e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1c91:	ba 67 66 66 66       	mov    $0x66666667,%edx
    1c96:	89 c8                	mov    %ecx,%eax
    1c98:	f7 ea                	imul   %edx
    1c9a:	89 d0                	mov    %edx,%eax
    1c9c:	d1 f8                	sar    %eax
    1c9e:	89 ca                	mov    %ecx,%edx
    1ca0:	c1 fa 1f             	sar    $0x1f,%edx
    1ca3:	29 d0                	sub    %edx,%eax
    1ca5:	89 c2                	mov    %eax,%edx
    1ca7:	c1 e2 02             	shl    $0x2,%edx
    1caa:	01 c2                	add    %eax,%edx
    1cac:	89 c8                	mov    %ecx,%eax
    1cae:	29 d0                	sub    %edx,%eax
    1cb0:	83 f8 01             	cmp    $0x1,%eax
    1cb3:	75 18                	jne    1ccd <concreate+0xe5>
      link("C0", file);
    1cb5:	83 ec 08             	sub    $0x8,%esp
    1cb8:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1cbb:	50                   	push   %eax
    1cbc:	8d 83 8e e8 ff ff    	lea    -0x1772(%ebx),%eax
    1cc2:	50                   	push   %eax
    1cc3:	e8 34 2a 00 00       	call   46fc <link>
    1cc8:	83 c4 10             	add    $0x10,%esp
    1ccb:	eb 48                	jmp    1d15 <concreate+0x12d>
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    1ccd:	83 ec 08             	sub    $0x8,%esp
    1cd0:	68 02 02 00 00       	push   $0x202
    1cd5:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1cd8:	50                   	push   %eax
    1cd9:	e8 fe 29 00 00       	call   46dc <open>
    1cde:	83 c4 10             	add    $0x10,%esp
    1ce1:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(fd < 0){
    1ce4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1ce8:	79 1d                	jns    1d07 <concreate+0x11f>
        printf(1, "concreate create %s failed\n", file);
    1cea:	83 ec 04             	sub    $0x4,%esp
    1ced:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1cf0:	50                   	push   %eax
    1cf1:	8d 83 91 e8 ff ff    	lea    -0x176f(%ebx),%eax
    1cf7:	50                   	push   %eax
    1cf8:	6a 01                	push   $0x1
    1cfa:	e8 39 2b 00 00       	call   4838 <printf>
    1cff:	83 c4 10             	add    $0x10,%esp
        exit();
    1d02:	e8 95 29 00 00       	call   469c <exit>
      }
      close(fd);
    1d07:	83 ec 0c             	sub    $0xc,%esp
    1d0a:	ff 75 ec             	push   -0x14(%ebp)
    1d0d:	e8 b2 29 00 00       	call   46c4 <close>
    1d12:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
    1d15:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1d19:	75 05                	jne    1d20 <concreate+0x138>
      exit();
    1d1b:	e8 7c 29 00 00       	call   469c <exit>
    else
      wait();
    1d20:	e8 7f 29 00 00       	call   46a4 <wait>
  for(i = 0; i < 40; i++){
    1d25:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1d29:	83 7d f4 27          	cmpl   $0x27,-0xc(%ebp)
    1d2d:	0f 8e f0 fe ff ff    	jle    1c23 <concreate+0x3b>
  }

  memset(fa, 0, sizeof(fa));
    1d33:	83 ec 04             	sub    $0x4,%esp
    1d36:	6a 28                	push   $0x28
    1d38:	6a 00                	push   $0x0
    1d3a:	8d 45 bd             	lea    -0x43(%ebp),%eax
    1d3d:	50                   	push   %eax
    1d3e:	e8 78 27 00 00       	call   44bb <memset>
    1d43:	83 c4 10             	add    $0x10,%esp
  fd = open(".", 0);
    1d46:	83 ec 08             	sub    $0x8,%esp
    1d49:	6a 00                	push   $0x0
    1d4b:	8d 83 53 e8 ff ff    	lea    -0x17ad(%ebx),%eax
    1d51:	50                   	push   %eax
    1d52:	e8 85 29 00 00       	call   46dc <open>
    1d57:	83 c4 10             	add    $0x10,%esp
    1d5a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  n = 0;
    1d5d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  while(read(fd, &de, sizeof(de)) > 0){
    1d64:	e9 9b 00 00 00       	jmp    1e04 <concreate+0x21c>
    if(de.inum == 0)
    1d69:	0f b7 45 ac          	movzwl -0x54(%ebp),%eax
    1d6d:	66 85 c0             	test   %ax,%ax
    1d70:	75 05                	jne    1d77 <concreate+0x18f>
      continue;
    1d72:	e9 8d 00 00 00       	jmp    1e04 <concreate+0x21c>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    1d77:	0f b6 45 ae          	movzbl -0x52(%ebp),%eax
    1d7b:	3c 43                	cmp    $0x43,%al
    1d7d:	0f 85 81 00 00 00    	jne    1e04 <concreate+0x21c>
    1d83:	0f b6 45 b0          	movzbl -0x50(%ebp),%eax
    1d87:	84 c0                	test   %al,%al
    1d89:	75 79                	jne    1e04 <concreate+0x21c>
      i = de.name[1] - '0';
    1d8b:	0f b6 45 af          	movzbl -0x51(%ebp),%eax
    1d8f:	0f be c0             	movsbl %al,%eax
    1d92:	83 e8 30             	sub    $0x30,%eax
    1d95:	89 45 f4             	mov    %eax,-0xc(%ebp)
      if(i < 0 || i >= sizeof(fa)){
    1d98:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1d9c:	78 08                	js     1da6 <concreate+0x1be>
    1d9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1da1:	83 f8 27             	cmp    $0x27,%eax
    1da4:	76 20                	jbe    1dc6 <concreate+0x1de>
        printf(1, "concreate weird file %s\n", de.name);
    1da6:	83 ec 04             	sub    $0x4,%esp
    1da9:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1dac:	83 c0 02             	add    $0x2,%eax
    1daf:	50                   	push   %eax
    1db0:	8d 83 ad e8 ff ff    	lea    -0x1753(%ebx),%eax
    1db6:	50                   	push   %eax
    1db7:	6a 01                	push   $0x1
    1db9:	e8 7a 2a 00 00       	call   4838 <printf>
    1dbe:	83 c4 10             	add    $0x10,%esp
        exit();
    1dc1:	e8 d6 28 00 00       	call   469c <exit>
      }
      if(fa[i]){
    1dc6:	8d 55 bd             	lea    -0x43(%ebp),%edx
    1dc9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dcc:	01 d0                	add    %edx,%eax
    1dce:	0f b6 00             	movzbl (%eax),%eax
    1dd1:	84 c0                	test   %al,%al
    1dd3:	74 20                	je     1df5 <concreate+0x20d>
        printf(1, "concreate duplicate file %s\n", de.name);
    1dd5:	83 ec 04             	sub    $0x4,%esp
    1dd8:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1ddb:	83 c0 02             	add    $0x2,%eax
    1dde:	50                   	push   %eax
    1ddf:	8d 83 c6 e8 ff ff    	lea    -0x173a(%ebx),%eax
    1de5:	50                   	push   %eax
    1de6:	6a 01                	push   $0x1
    1de8:	e8 4b 2a 00 00       	call   4838 <printf>
    1ded:	83 c4 10             	add    $0x10,%esp
        exit();
    1df0:	e8 a7 28 00 00       	call   469c <exit>
      }
      fa[i] = 1;
    1df5:	8d 55 bd             	lea    -0x43(%ebp),%edx
    1df8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dfb:	01 d0                	add    %edx,%eax
    1dfd:	c6 00 01             	movb   $0x1,(%eax)
      n++;
    1e00:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  while(read(fd, &de, sizeof(de)) > 0){
    1e04:	83 ec 04             	sub    $0x4,%esp
    1e07:	6a 10                	push   $0x10
    1e09:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1e0c:	50                   	push   %eax
    1e0d:	ff 75 ec             	push   -0x14(%ebp)
    1e10:	e8 9f 28 00 00       	call   46b4 <read>
    1e15:	83 c4 10             	add    $0x10,%esp
    1e18:	85 c0                	test   %eax,%eax
    1e1a:	0f 8f 49 ff ff ff    	jg     1d69 <concreate+0x181>
    }
  }
  close(fd);
    1e20:	83 ec 0c             	sub    $0xc,%esp
    1e23:	ff 75 ec             	push   -0x14(%ebp)
    1e26:	e8 99 28 00 00       	call   46c4 <close>
    1e2b:	83 c4 10             	add    $0x10,%esp

  if(n != 40){
    1e2e:	83 7d f0 28          	cmpl   $0x28,-0x10(%ebp)
    1e32:	74 19                	je     1e4d <concreate+0x265>
    printf(1, "concreate not enough files in directory listing\n");
    1e34:	83 ec 08             	sub    $0x8,%esp
    1e37:	8d 83 e4 e8 ff ff    	lea    -0x171c(%ebx),%eax
    1e3d:	50                   	push   %eax
    1e3e:	6a 01                	push   $0x1
    1e40:	e8 f3 29 00 00       	call   4838 <printf>
    1e45:	83 c4 10             	add    $0x10,%esp
    exit();
    1e48:	e8 4f 28 00 00       	call   469c <exit>
  }

  for(i = 0; i < 40; i++){
    1e4d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1e54:	e9 49 01 00 00       	jmp    1fa2 <concreate+0x3ba>
    file[1] = '0' + i;
    1e59:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e5c:	83 c0 30             	add    $0x30,%eax
    1e5f:	88 45 e6             	mov    %al,-0x1a(%ebp)
    pid = fork();
    1e62:	e8 2d 28 00 00       	call   4694 <fork>
    1e67:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pid < 0){
    1e6a:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1e6e:	79 19                	jns    1e89 <concreate+0x2a1>
      printf(1, "fork failed\n");
    1e70:	83 ec 08             	sub    $0x8,%esp
    1e73:	8d 83 69 e0 ff ff    	lea    -0x1f97(%ebx),%eax
    1e79:	50                   	push   %eax
    1e7a:	6a 01                	push   $0x1
    1e7c:	e8 b7 29 00 00       	call   4838 <printf>
    1e81:	83 c4 10             	add    $0x10,%esp
      exit();
    1e84:	e8 13 28 00 00       	call   469c <exit>
    }
    if(((i % 3) == 0 && pid == 0) ||
    1e89:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1e8c:	ba 56 55 55 55       	mov    $0x55555556,%edx
    1e91:	89 c8                	mov    %ecx,%eax
    1e93:	f7 ea                	imul   %edx
    1e95:	89 ce                	mov    %ecx,%esi
    1e97:	c1 fe 1f             	sar    $0x1f,%esi
    1e9a:	89 d0                	mov    %edx,%eax
    1e9c:	29 f0                	sub    %esi,%eax
    1e9e:	89 c2                	mov    %eax,%edx
    1ea0:	01 d2                	add    %edx,%edx
    1ea2:	01 c2                	add    %eax,%edx
    1ea4:	89 c8                	mov    %ecx,%eax
    1ea6:	29 d0                	sub    %edx,%eax
    1ea8:	85 c0                	test   %eax,%eax
    1eaa:	75 06                	jne    1eb2 <concreate+0x2ca>
    1eac:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1eb0:	74 2a                	je     1edc <concreate+0x2f4>
       ((i % 3) == 1 && pid != 0)){
    1eb2:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1eb5:	ba 56 55 55 55       	mov    $0x55555556,%edx
    1eba:	89 c8                	mov    %ecx,%eax
    1ebc:	f7 ea                	imul   %edx
    1ebe:	89 ce                	mov    %ecx,%esi
    1ec0:	c1 fe 1f             	sar    $0x1f,%esi
    1ec3:	89 d0                	mov    %edx,%eax
    1ec5:	29 f0                	sub    %esi,%eax
    1ec7:	89 c2                	mov    %eax,%edx
    1ec9:	01 d2                	add    %edx,%edx
    1ecb:	01 c2                	add    %eax,%edx
    1ecd:	89 c8                	mov    %ecx,%eax
    1ecf:	29 d0                	sub    %edx,%eax
    if(((i % 3) == 0 && pid == 0) ||
    1ed1:	83 f8 01             	cmp    $0x1,%eax
    1ed4:	75 7c                	jne    1f52 <concreate+0x36a>
       ((i % 3) == 1 && pid != 0)){
    1ed6:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1eda:	74 76                	je     1f52 <concreate+0x36a>
      close(open(file, 0));
    1edc:	83 ec 08             	sub    $0x8,%esp
    1edf:	6a 00                	push   $0x0
    1ee1:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1ee4:	50                   	push   %eax
    1ee5:	e8 f2 27 00 00       	call   46dc <open>
    1eea:	83 c4 10             	add    $0x10,%esp
    1eed:	83 ec 0c             	sub    $0xc,%esp
    1ef0:	50                   	push   %eax
    1ef1:	e8 ce 27 00 00       	call   46c4 <close>
    1ef6:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    1ef9:	83 ec 08             	sub    $0x8,%esp
    1efc:	6a 00                	push   $0x0
    1efe:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1f01:	50                   	push   %eax
    1f02:	e8 d5 27 00 00       	call   46dc <open>
    1f07:	83 c4 10             	add    $0x10,%esp
    1f0a:	83 ec 0c             	sub    $0xc,%esp
    1f0d:	50                   	push   %eax
    1f0e:	e8 b1 27 00 00       	call   46c4 <close>
    1f13:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    1f16:	83 ec 08             	sub    $0x8,%esp
    1f19:	6a 00                	push   $0x0
    1f1b:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1f1e:	50                   	push   %eax
    1f1f:	e8 b8 27 00 00       	call   46dc <open>
    1f24:	83 c4 10             	add    $0x10,%esp
    1f27:	83 ec 0c             	sub    $0xc,%esp
    1f2a:	50                   	push   %eax
    1f2b:	e8 94 27 00 00       	call   46c4 <close>
    1f30:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    1f33:	83 ec 08             	sub    $0x8,%esp
    1f36:	6a 00                	push   $0x0
    1f38:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1f3b:	50                   	push   %eax
    1f3c:	e8 9b 27 00 00       	call   46dc <open>
    1f41:	83 c4 10             	add    $0x10,%esp
    1f44:	83 ec 0c             	sub    $0xc,%esp
    1f47:	50                   	push   %eax
    1f48:	e8 77 27 00 00       	call   46c4 <close>
    1f4d:	83 c4 10             	add    $0x10,%esp
    1f50:	eb 3c                	jmp    1f8e <concreate+0x3a6>
    } else {
      unlink(file);
    1f52:	83 ec 0c             	sub    $0xc,%esp
    1f55:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1f58:	50                   	push   %eax
    1f59:	e8 8e 27 00 00       	call   46ec <unlink>
    1f5e:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    1f61:	83 ec 0c             	sub    $0xc,%esp
    1f64:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1f67:	50                   	push   %eax
    1f68:	e8 7f 27 00 00       	call   46ec <unlink>
    1f6d:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    1f70:	83 ec 0c             	sub    $0xc,%esp
    1f73:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1f76:	50                   	push   %eax
    1f77:	e8 70 27 00 00       	call   46ec <unlink>
    1f7c:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    1f7f:	83 ec 0c             	sub    $0xc,%esp
    1f82:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1f85:	50                   	push   %eax
    1f86:	e8 61 27 00 00       	call   46ec <unlink>
    1f8b:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
    1f8e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1f92:	75 05                	jne    1f99 <concreate+0x3b1>
      exit();
    1f94:	e8 03 27 00 00       	call   469c <exit>
    else
      wait();
    1f99:	e8 06 27 00 00       	call   46a4 <wait>
  for(i = 0; i < 40; i++){
    1f9e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1fa2:	83 7d f4 27          	cmpl   $0x27,-0xc(%ebp)
    1fa6:	0f 8e ad fe ff ff    	jle    1e59 <concreate+0x271>
  }

  printf(1, "concreate ok\n");
    1fac:	83 ec 08             	sub    $0x8,%esp
    1faf:	8d 83 15 e9 ff ff    	lea    -0x16eb(%ebx),%eax
    1fb5:	50                   	push   %eax
    1fb6:	6a 01                	push   $0x1
    1fb8:	e8 7b 28 00 00       	call   4838 <printf>
    1fbd:	83 c4 10             	add    $0x10,%esp
}
    1fc0:	90                   	nop
    1fc1:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1fc4:	5b                   	pop    %ebx
    1fc5:	5e                   	pop    %esi
    1fc6:	5d                   	pop    %ebp
    1fc7:	c3                   	ret    

00001fc8 <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink()
{
    1fc8:	55                   	push   %ebp
    1fc9:	89 e5                	mov    %esp,%ebp
    1fcb:	53                   	push   %ebx
    1fcc:	83 ec 14             	sub    $0x14,%esp
    1fcf:	e8 ff 23 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
    1fd4:	81 c3 9c 4c 00 00    	add    $0x4c9c,%ebx
  int pid, i;

  printf(1, "linkunlink test\n");
    1fda:	83 ec 08             	sub    $0x8,%esp
    1fdd:	8d 83 23 e9 ff ff    	lea    -0x16dd(%ebx),%eax
    1fe3:	50                   	push   %eax
    1fe4:	6a 01                	push   $0x1
    1fe6:	e8 4d 28 00 00       	call   4838 <printf>
    1feb:	83 c4 10             	add    $0x10,%esp

  unlink("x");
    1fee:	83 ec 0c             	sub    $0xc,%esp
    1ff1:	8d 83 9f e4 ff ff    	lea    -0x1b61(%ebx),%eax
    1ff7:	50                   	push   %eax
    1ff8:	e8 ef 26 00 00       	call   46ec <unlink>
    1ffd:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    2000:	e8 8f 26 00 00       	call   4694 <fork>
    2005:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(pid < 0){
    2008:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    200c:	79 19                	jns    2027 <linkunlink+0x5f>
    printf(1, "fork failed\n");
    200e:	83 ec 08             	sub    $0x8,%esp
    2011:	8d 83 69 e0 ff ff    	lea    -0x1f97(%ebx),%eax
    2017:	50                   	push   %eax
    2018:	6a 01                	push   $0x1
    201a:	e8 19 28 00 00       	call   4838 <printf>
    201f:	83 c4 10             	add    $0x10,%esp
    exit();
    2022:	e8 75 26 00 00       	call   469c <exit>
  }

  unsigned int x = (pid ? 1 : 97);
    2027:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    202b:	74 07                	je     2034 <linkunlink+0x6c>
    202d:	b8 01 00 00 00       	mov    $0x1,%eax
    2032:	eb 05                	jmp    2039 <linkunlink+0x71>
    2034:	b8 61 00 00 00       	mov    $0x61,%eax
    2039:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; i < 100; i++){
    203c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2043:	e9 a4 00 00 00       	jmp    20ec <linkunlink+0x124>
    x = x * 1103515245 + 12345;
    2048:	8b 45 f0             	mov    -0x10(%ebp),%eax
    204b:	69 c0 6d 4e c6 41    	imul   $0x41c64e6d,%eax,%eax
    2051:	05 39 30 00 00       	add    $0x3039,%eax
    2056:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((x % 3) == 0){
    2059:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    205c:	ba ab aa aa aa       	mov    $0xaaaaaaab,%edx
    2061:	89 c8                	mov    %ecx,%eax
    2063:	f7 e2                	mul    %edx
    2065:	89 d0                	mov    %edx,%eax
    2067:	d1 e8                	shr    %eax
    2069:	89 c2                	mov    %eax,%edx
    206b:	01 d2                	add    %edx,%edx
    206d:	01 c2                	add    %eax,%edx
    206f:	89 c8                	mov    %ecx,%eax
    2071:	29 d0                	sub    %edx,%eax
    2073:	85 c0                	test   %eax,%eax
    2075:	75 25                	jne    209c <linkunlink+0xd4>
      close(open("x", O_RDWR | O_CREATE));
    2077:	83 ec 08             	sub    $0x8,%esp
    207a:	68 02 02 00 00       	push   $0x202
    207f:	8d 83 9f e4 ff ff    	lea    -0x1b61(%ebx),%eax
    2085:	50                   	push   %eax
    2086:	e8 51 26 00 00       	call   46dc <open>
    208b:	83 c4 10             	add    $0x10,%esp
    208e:	83 ec 0c             	sub    $0xc,%esp
    2091:	50                   	push   %eax
    2092:	e8 2d 26 00 00       	call   46c4 <close>
    2097:	83 c4 10             	add    $0x10,%esp
    209a:	eb 4c                	jmp    20e8 <linkunlink+0x120>
    } else if((x % 3) == 1){
    209c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    209f:	ba ab aa aa aa       	mov    $0xaaaaaaab,%edx
    20a4:	89 c8                	mov    %ecx,%eax
    20a6:	f7 e2                	mul    %edx
    20a8:	89 d0                	mov    %edx,%eax
    20aa:	d1 e8                	shr    %eax
    20ac:	89 c2                	mov    %eax,%edx
    20ae:	01 d2                	add    %edx,%edx
    20b0:	01 c2                	add    %eax,%edx
    20b2:	89 c8                	mov    %ecx,%eax
    20b4:	29 d0                	sub    %edx,%eax
    20b6:	83 f8 01             	cmp    $0x1,%eax
    20b9:	75 1b                	jne    20d6 <linkunlink+0x10e>
      link("cat", "x");
    20bb:	83 ec 08             	sub    $0x8,%esp
    20be:	8d 83 9f e4 ff ff    	lea    -0x1b61(%ebx),%eax
    20c4:	50                   	push   %eax
    20c5:	8d 83 34 e9 ff ff    	lea    -0x16cc(%ebx),%eax
    20cb:	50                   	push   %eax
    20cc:	e8 2b 26 00 00       	call   46fc <link>
    20d1:	83 c4 10             	add    $0x10,%esp
    20d4:	eb 12                	jmp    20e8 <linkunlink+0x120>
    } else {
      unlink("x");
    20d6:	83 ec 0c             	sub    $0xc,%esp
    20d9:	8d 83 9f e4 ff ff    	lea    -0x1b61(%ebx),%eax
    20df:	50                   	push   %eax
    20e0:	e8 07 26 00 00       	call   46ec <unlink>
    20e5:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
    20e8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    20ec:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
    20f0:	0f 8e 52 ff ff ff    	jle    2048 <linkunlink+0x80>
    }
  }

  if(pid)
    20f6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    20fa:	74 07                	je     2103 <linkunlink+0x13b>
    wait();
    20fc:	e8 a3 25 00 00       	call   46a4 <wait>
    2101:	eb 05                	jmp    2108 <linkunlink+0x140>
  else
    exit();
    2103:	e8 94 25 00 00       	call   469c <exit>

  printf(1, "linkunlink ok\n");
    2108:	83 ec 08             	sub    $0x8,%esp
    210b:	8d 83 38 e9 ff ff    	lea    -0x16c8(%ebx),%eax
    2111:	50                   	push   %eax
    2112:	6a 01                	push   $0x1
    2114:	e8 1f 27 00 00       	call   4838 <printf>
    2119:	83 c4 10             	add    $0x10,%esp
}
    211c:	90                   	nop
    211d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2120:	c9                   	leave  
    2121:	c3                   	ret    

00002122 <bigdir>:

// directory that uses indirect blocks
void
bigdir(void)
{
    2122:	55                   	push   %ebp
    2123:	89 e5                	mov    %esp,%ebp
    2125:	53                   	push   %ebx
    2126:	83 ec 24             	sub    $0x24,%esp
    2129:	e8 a5 22 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
    212e:	81 c3 42 4b 00 00    	add    $0x4b42,%ebx
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    2134:	83 ec 08             	sub    $0x8,%esp
    2137:	8d 83 47 e9 ff ff    	lea    -0x16b9(%ebx),%eax
    213d:	50                   	push   %eax
    213e:	6a 01                	push   $0x1
    2140:	e8 f3 26 00 00       	call   4838 <printf>
    2145:	83 c4 10             	add    $0x10,%esp
  unlink("bd");
    2148:	83 ec 0c             	sub    $0xc,%esp
    214b:	8d 83 54 e9 ff ff    	lea    -0x16ac(%ebx),%eax
    2151:	50                   	push   %eax
    2152:	e8 95 25 00 00       	call   46ec <unlink>
    2157:	83 c4 10             	add    $0x10,%esp

  fd = open("bd", O_CREATE);
    215a:	83 ec 08             	sub    $0x8,%esp
    215d:	68 00 02 00 00       	push   $0x200
    2162:	8d 83 54 e9 ff ff    	lea    -0x16ac(%ebx),%eax
    2168:	50                   	push   %eax
    2169:	e8 6e 25 00 00       	call   46dc <open>
    216e:	83 c4 10             	add    $0x10,%esp
    2171:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0){
    2174:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2178:	79 19                	jns    2193 <bigdir+0x71>
    printf(1, "bigdir create failed\n");
    217a:	83 ec 08             	sub    $0x8,%esp
    217d:	8d 83 57 e9 ff ff    	lea    -0x16a9(%ebx),%eax
    2183:	50                   	push   %eax
    2184:	6a 01                	push   $0x1
    2186:	e8 ad 26 00 00       	call   4838 <printf>
    218b:	83 c4 10             	add    $0x10,%esp
    exit();
    218e:	e8 09 25 00 00       	call   469c <exit>
  }
  close(fd);
    2193:	83 ec 0c             	sub    $0xc,%esp
    2196:	ff 75 f0             	push   -0x10(%ebp)
    2199:	e8 26 25 00 00       	call   46c4 <close>
    219e:	83 c4 10             	add    $0x10,%esp

  for(i = 0; i < 500; i++){
    21a1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    21a8:	eb 67                	jmp    2211 <bigdir+0xef>
    name[0] = 'x';
    21aa:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
    name[1] = '0' + (i / 64);
    21ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21b1:	8d 50 3f             	lea    0x3f(%eax),%edx
    21b4:	85 c0                	test   %eax,%eax
    21b6:	0f 48 c2             	cmovs  %edx,%eax
    21b9:	c1 f8 06             	sar    $0x6,%eax
    21bc:	83 c0 30             	add    $0x30,%eax
    21bf:	88 45 e7             	mov    %al,-0x19(%ebp)
    name[2] = '0' + (i % 64);
    21c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21c5:	99                   	cltd   
    21c6:	c1 ea 1a             	shr    $0x1a,%edx
    21c9:	01 d0                	add    %edx,%eax
    21cb:	83 e0 3f             	and    $0x3f,%eax
    21ce:	29 d0                	sub    %edx,%eax
    21d0:	83 c0 30             	add    $0x30,%eax
    21d3:	88 45 e8             	mov    %al,-0x18(%ebp)
    name[3] = '\0';
    21d6:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    if(link("bd", name) != 0){
    21da:	83 ec 08             	sub    $0x8,%esp
    21dd:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    21e0:	50                   	push   %eax
    21e1:	8d 83 54 e9 ff ff    	lea    -0x16ac(%ebx),%eax
    21e7:	50                   	push   %eax
    21e8:	e8 0f 25 00 00       	call   46fc <link>
    21ed:	83 c4 10             	add    $0x10,%esp
    21f0:	85 c0                	test   %eax,%eax
    21f2:	74 19                	je     220d <bigdir+0xeb>
      printf(1, "bigdir link failed\n");
    21f4:	83 ec 08             	sub    $0x8,%esp
    21f7:	8d 83 6d e9 ff ff    	lea    -0x1693(%ebx),%eax
    21fd:	50                   	push   %eax
    21fe:	6a 01                	push   $0x1
    2200:	e8 33 26 00 00       	call   4838 <printf>
    2205:	83 c4 10             	add    $0x10,%esp
      exit();
    2208:	e8 8f 24 00 00       	call   469c <exit>
  for(i = 0; i < 500; i++){
    220d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2211:	81 7d f4 f3 01 00 00 	cmpl   $0x1f3,-0xc(%ebp)
    2218:	7e 90                	jle    21aa <bigdir+0x88>
    }
  }

  unlink("bd");
    221a:	83 ec 0c             	sub    $0xc,%esp
    221d:	8d 83 54 e9 ff ff    	lea    -0x16ac(%ebx),%eax
    2223:	50                   	push   %eax
    2224:	e8 c3 24 00 00       	call   46ec <unlink>
    2229:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 500; i++){
    222c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2233:	eb 60                	jmp    2295 <bigdir+0x173>
    name[0] = 'x';
    2235:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
    name[1] = '0' + (i / 64);
    2239:	8b 45 f4             	mov    -0xc(%ebp),%eax
    223c:	8d 50 3f             	lea    0x3f(%eax),%edx
    223f:	85 c0                	test   %eax,%eax
    2241:	0f 48 c2             	cmovs  %edx,%eax
    2244:	c1 f8 06             	sar    $0x6,%eax
    2247:	83 c0 30             	add    $0x30,%eax
    224a:	88 45 e7             	mov    %al,-0x19(%ebp)
    name[2] = '0' + (i % 64);
    224d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2250:	99                   	cltd   
    2251:	c1 ea 1a             	shr    $0x1a,%edx
    2254:	01 d0                	add    %edx,%eax
    2256:	83 e0 3f             	and    $0x3f,%eax
    2259:	29 d0                	sub    %edx,%eax
    225b:	83 c0 30             	add    $0x30,%eax
    225e:	88 45 e8             	mov    %al,-0x18(%ebp)
    name[3] = '\0';
    2261:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    if(unlink(name) != 0){
    2265:	83 ec 0c             	sub    $0xc,%esp
    2268:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    226b:	50                   	push   %eax
    226c:	e8 7b 24 00 00       	call   46ec <unlink>
    2271:	83 c4 10             	add    $0x10,%esp
    2274:	85 c0                	test   %eax,%eax
    2276:	74 19                	je     2291 <bigdir+0x16f>
      printf(1, "bigdir unlink failed");
    2278:	83 ec 08             	sub    $0x8,%esp
    227b:	8d 83 81 e9 ff ff    	lea    -0x167f(%ebx),%eax
    2281:	50                   	push   %eax
    2282:	6a 01                	push   $0x1
    2284:	e8 af 25 00 00       	call   4838 <printf>
    2289:	83 c4 10             	add    $0x10,%esp
      exit();
    228c:	e8 0b 24 00 00       	call   469c <exit>
  for(i = 0; i < 500; i++){
    2291:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2295:	81 7d f4 f3 01 00 00 	cmpl   $0x1f3,-0xc(%ebp)
    229c:	7e 97                	jle    2235 <bigdir+0x113>
    }
  }

  printf(1, "bigdir ok\n");
    229e:	83 ec 08             	sub    $0x8,%esp
    22a1:	8d 83 96 e9 ff ff    	lea    -0x166a(%ebx),%eax
    22a7:	50                   	push   %eax
    22a8:	6a 01                	push   $0x1
    22aa:	e8 89 25 00 00       	call   4838 <printf>
    22af:	83 c4 10             	add    $0x10,%esp
}
    22b2:	90                   	nop
    22b3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    22b6:	c9                   	leave  
    22b7:	c3                   	ret    

000022b8 <subdir>:

void
subdir(void)
{
    22b8:	55                   	push   %ebp
    22b9:	89 e5                	mov    %esp,%ebp
    22bb:	53                   	push   %ebx
    22bc:	83 ec 14             	sub    $0x14,%esp
    22bf:	e8 0f 21 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
    22c4:	81 c3 ac 49 00 00    	add    $0x49ac,%ebx
  int fd, cc;

  printf(1, "subdir test\n");
    22ca:	83 ec 08             	sub    $0x8,%esp
    22cd:	8d 83 a1 e9 ff ff    	lea    -0x165f(%ebx),%eax
    22d3:	50                   	push   %eax
    22d4:	6a 01                	push   $0x1
    22d6:	e8 5d 25 00 00       	call   4838 <printf>
    22db:	83 c4 10             	add    $0x10,%esp

  unlink("ff");
    22de:	83 ec 0c             	sub    $0xc,%esp
    22e1:	8d 83 ae e9 ff ff    	lea    -0x1652(%ebx),%eax
    22e7:	50                   	push   %eax
    22e8:	e8 ff 23 00 00       	call   46ec <unlink>
    22ed:	83 c4 10             	add    $0x10,%esp
  if(mkdir("dd") != 0){
    22f0:	83 ec 0c             	sub    $0xc,%esp
    22f3:	8d 83 b1 e9 ff ff    	lea    -0x164f(%ebx),%eax
    22f9:	50                   	push   %eax
    22fa:	e8 05 24 00 00       	call   4704 <mkdir>
    22ff:	83 c4 10             	add    $0x10,%esp
    2302:	85 c0                	test   %eax,%eax
    2304:	74 19                	je     231f <subdir+0x67>
    printf(1, "subdir mkdir dd failed\n");
    2306:	83 ec 08             	sub    $0x8,%esp
    2309:	8d 83 b4 e9 ff ff    	lea    -0x164c(%ebx),%eax
    230f:	50                   	push   %eax
    2310:	6a 01                	push   $0x1
    2312:	e8 21 25 00 00       	call   4838 <printf>
    2317:	83 c4 10             	add    $0x10,%esp
    exit();
    231a:	e8 7d 23 00 00       	call   469c <exit>
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    231f:	83 ec 08             	sub    $0x8,%esp
    2322:	68 02 02 00 00       	push   $0x202
    2327:	8d 83 cc e9 ff ff    	lea    -0x1634(%ebx),%eax
    232d:	50                   	push   %eax
    232e:	e8 a9 23 00 00       	call   46dc <open>
    2333:	83 c4 10             	add    $0x10,%esp
    2336:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2339:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    233d:	79 19                	jns    2358 <subdir+0xa0>
    printf(1, "create dd/ff failed\n");
    233f:	83 ec 08             	sub    $0x8,%esp
    2342:	8d 83 d2 e9 ff ff    	lea    -0x162e(%ebx),%eax
    2348:	50                   	push   %eax
    2349:	6a 01                	push   $0x1
    234b:	e8 e8 24 00 00       	call   4838 <printf>
    2350:	83 c4 10             	add    $0x10,%esp
    exit();
    2353:	e8 44 23 00 00       	call   469c <exit>
  }
  write(fd, "ff", 2);
    2358:	83 ec 04             	sub    $0x4,%esp
    235b:	6a 02                	push   $0x2
    235d:	8d 83 ae e9 ff ff    	lea    -0x1652(%ebx),%eax
    2363:	50                   	push   %eax
    2364:	ff 75 f4             	push   -0xc(%ebp)
    2367:	e8 50 23 00 00       	call   46bc <write>
    236c:	83 c4 10             	add    $0x10,%esp
  close(fd);
    236f:	83 ec 0c             	sub    $0xc,%esp
    2372:	ff 75 f4             	push   -0xc(%ebp)
    2375:	e8 4a 23 00 00       	call   46c4 <close>
    237a:	83 c4 10             	add    $0x10,%esp

  if(unlink("dd") >= 0){
    237d:	83 ec 0c             	sub    $0xc,%esp
    2380:	8d 83 b1 e9 ff ff    	lea    -0x164f(%ebx),%eax
    2386:	50                   	push   %eax
    2387:	e8 60 23 00 00       	call   46ec <unlink>
    238c:	83 c4 10             	add    $0x10,%esp
    238f:	85 c0                	test   %eax,%eax
    2391:	78 19                	js     23ac <subdir+0xf4>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    2393:	83 ec 08             	sub    $0x8,%esp
    2396:	8d 83 e8 e9 ff ff    	lea    -0x1618(%ebx),%eax
    239c:	50                   	push   %eax
    239d:	6a 01                	push   $0x1
    239f:	e8 94 24 00 00       	call   4838 <printf>
    23a4:	83 c4 10             	add    $0x10,%esp
    exit();
    23a7:	e8 f0 22 00 00       	call   469c <exit>
  }

  if(mkdir("/dd/dd") != 0){
    23ac:	83 ec 0c             	sub    $0xc,%esp
    23af:	8d 83 0e ea ff ff    	lea    -0x15f2(%ebx),%eax
    23b5:	50                   	push   %eax
    23b6:	e8 49 23 00 00       	call   4704 <mkdir>
    23bb:	83 c4 10             	add    $0x10,%esp
    23be:	85 c0                	test   %eax,%eax
    23c0:	74 19                	je     23db <subdir+0x123>
    printf(1, "subdir mkdir dd/dd failed\n");
    23c2:	83 ec 08             	sub    $0x8,%esp
    23c5:	8d 83 15 ea ff ff    	lea    -0x15eb(%ebx),%eax
    23cb:	50                   	push   %eax
    23cc:	6a 01                	push   $0x1
    23ce:	e8 65 24 00 00       	call   4838 <printf>
    23d3:	83 c4 10             	add    $0x10,%esp
    exit();
    23d6:	e8 c1 22 00 00       	call   469c <exit>
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    23db:	83 ec 08             	sub    $0x8,%esp
    23de:	68 02 02 00 00       	push   $0x202
    23e3:	8d 83 30 ea ff ff    	lea    -0x15d0(%ebx),%eax
    23e9:	50                   	push   %eax
    23ea:	e8 ed 22 00 00       	call   46dc <open>
    23ef:	83 c4 10             	add    $0x10,%esp
    23f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    23f5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    23f9:	79 19                	jns    2414 <subdir+0x15c>
    printf(1, "create dd/dd/ff failed\n");
    23fb:	83 ec 08             	sub    $0x8,%esp
    23fe:	8d 83 39 ea ff ff    	lea    -0x15c7(%ebx),%eax
    2404:	50                   	push   %eax
    2405:	6a 01                	push   $0x1
    2407:	e8 2c 24 00 00       	call   4838 <printf>
    240c:	83 c4 10             	add    $0x10,%esp
    exit();
    240f:	e8 88 22 00 00       	call   469c <exit>
  }
  write(fd, "FF", 2);
    2414:	83 ec 04             	sub    $0x4,%esp
    2417:	6a 02                	push   $0x2
    2419:	8d 83 51 ea ff ff    	lea    -0x15af(%ebx),%eax
    241f:	50                   	push   %eax
    2420:	ff 75 f4             	push   -0xc(%ebp)
    2423:	e8 94 22 00 00       	call   46bc <write>
    2428:	83 c4 10             	add    $0x10,%esp
  close(fd);
    242b:	83 ec 0c             	sub    $0xc,%esp
    242e:	ff 75 f4             	push   -0xc(%ebp)
    2431:	e8 8e 22 00 00       	call   46c4 <close>
    2436:	83 c4 10             	add    $0x10,%esp

  fd = open("dd/dd/../ff", 0);
    2439:	83 ec 08             	sub    $0x8,%esp
    243c:	6a 00                	push   $0x0
    243e:	8d 83 54 ea ff ff    	lea    -0x15ac(%ebx),%eax
    2444:	50                   	push   %eax
    2445:	e8 92 22 00 00       	call   46dc <open>
    244a:	83 c4 10             	add    $0x10,%esp
    244d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2450:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2454:	79 19                	jns    246f <subdir+0x1b7>
    printf(1, "open dd/dd/../ff failed\n");
    2456:	83 ec 08             	sub    $0x8,%esp
    2459:	8d 83 60 ea ff ff    	lea    -0x15a0(%ebx),%eax
    245f:	50                   	push   %eax
    2460:	6a 01                	push   $0x1
    2462:	e8 d1 23 00 00       	call   4838 <printf>
    2467:	83 c4 10             	add    $0x10,%esp
    exit();
    246a:	e8 2d 22 00 00       	call   469c <exit>
  }
  cc = read(fd, buf, sizeof(buf));
    246f:	83 ec 04             	sub    $0x4,%esp
    2472:	68 00 20 00 00       	push   $0x2000
    2477:	8d 83 50 00 00 00    	lea    0x50(%ebx),%eax
    247d:	50                   	push   %eax
    247e:	ff 75 f4             	push   -0xc(%ebp)
    2481:	e8 2e 22 00 00       	call   46b4 <read>
    2486:	83 c4 10             	add    $0x10,%esp
    2489:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(cc != 2 || buf[0] != 'f'){
    248c:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
    2490:	75 0b                	jne    249d <subdir+0x1e5>
    2492:	0f b6 83 50 00 00 00 	movzbl 0x50(%ebx),%eax
    2499:	3c 66                	cmp    $0x66,%al
    249b:	74 19                	je     24b6 <subdir+0x1fe>
    printf(1, "dd/dd/../ff wrong content\n");
    249d:	83 ec 08             	sub    $0x8,%esp
    24a0:	8d 83 79 ea ff ff    	lea    -0x1587(%ebx),%eax
    24a6:	50                   	push   %eax
    24a7:	6a 01                	push   $0x1
    24a9:	e8 8a 23 00 00       	call   4838 <printf>
    24ae:	83 c4 10             	add    $0x10,%esp
    exit();
    24b1:	e8 e6 21 00 00       	call   469c <exit>
  }
  close(fd);
    24b6:	83 ec 0c             	sub    $0xc,%esp
    24b9:	ff 75 f4             	push   -0xc(%ebp)
    24bc:	e8 03 22 00 00       	call   46c4 <close>
    24c1:	83 c4 10             	add    $0x10,%esp

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    24c4:	83 ec 08             	sub    $0x8,%esp
    24c7:	8d 83 94 ea ff ff    	lea    -0x156c(%ebx),%eax
    24cd:	50                   	push   %eax
    24ce:	8d 83 30 ea ff ff    	lea    -0x15d0(%ebx),%eax
    24d4:	50                   	push   %eax
    24d5:	e8 22 22 00 00       	call   46fc <link>
    24da:	83 c4 10             	add    $0x10,%esp
    24dd:	85 c0                	test   %eax,%eax
    24df:	74 19                	je     24fa <subdir+0x242>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    24e1:	83 ec 08             	sub    $0x8,%esp
    24e4:	8d 83 a0 ea ff ff    	lea    -0x1560(%ebx),%eax
    24ea:	50                   	push   %eax
    24eb:	6a 01                	push   $0x1
    24ed:	e8 46 23 00 00       	call   4838 <printf>
    24f2:	83 c4 10             	add    $0x10,%esp
    exit();
    24f5:	e8 a2 21 00 00       	call   469c <exit>
  }

  if(unlink("dd/dd/ff") != 0){
    24fa:	83 ec 0c             	sub    $0xc,%esp
    24fd:	8d 83 30 ea ff ff    	lea    -0x15d0(%ebx),%eax
    2503:	50                   	push   %eax
    2504:	e8 e3 21 00 00       	call   46ec <unlink>
    2509:	83 c4 10             	add    $0x10,%esp
    250c:	85 c0                	test   %eax,%eax
    250e:	74 19                	je     2529 <subdir+0x271>
    printf(1, "unlink dd/dd/ff failed\n");
    2510:	83 ec 08             	sub    $0x8,%esp
    2513:	8d 83 c1 ea ff ff    	lea    -0x153f(%ebx),%eax
    2519:	50                   	push   %eax
    251a:	6a 01                	push   $0x1
    251c:	e8 17 23 00 00       	call   4838 <printf>
    2521:	83 c4 10             	add    $0x10,%esp
    exit();
    2524:	e8 73 21 00 00       	call   469c <exit>
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2529:	83 ec 08             	sub    $0x8,%esp
    252c:	6a 00                	push   $0x0
    252e:	8d 83 30 ea ff ff    	lea    -0x15d0(%ebx),%eax
    2534:	50                   	push   %eax
    2535:	e8 a2 21 00 00       	call   46dc <open>
    253a:	83 c4 10             	add    $0x10,%esp
    253d:	85 c0                	test   %eax,%eax
    253f:	78 19                	js     255a <subdir+0x2a2>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    2541:	83 ec 08             	sub    $0x8,%esp
    2544:	8d 83 dc ea ff ff    	lea    -0x1524(%ebx),%eax
    254a:	50                   	push   %eax
    254b:	6a 01                	push   $0x1
    254d:	e8 e6 22 00 00       	call   4838 <printf>
    2552:	83 c4 10             	add    $0x10,%esp
    exit();
    2555:	e8 42 21 00 00       	call   469c <exit>
  }

  if(chdir("dd") != 0){
    255a:	83 ec 0c             	sub    $0xc,%esp
    255d:	8d 83 b1 e9 ff ff    	lea    -0x164f(%ebx),%eax
    2563:	50                   	push   %eax
    2564:	e8 a3 21 00 00       	call   470c <chdir>
    2569:	83 c4 10             	add    $0x10,%esp
    256c:	85 c0                	test   %eax,%eax
    256e:	74 19                	je     2589 <subdir+0x2d1>
    printf(1, "chdir dd failed\n");
    2570:	83 ec 08             	sub    $0x8,%esp
    2573:	8d 83 00 eb ff ff    	lea    -0x1500(%ebx),%eax
    2579:	50                   	push   %eax
    257a:	6a 01                	push   $0x1
    257c:	e8 b7 22 00 00       	call   4838 <printf>
    2581:	83 c4 10             	add    $0x10,%esp
    exit();
    2584:	e8 13 21 00 00       	call   469c <exit>
  }
  if(chdir("dd/../../dd") != 0){
    2589:	83 ec 0c             	sub    $0xc,%esp
    258c:	8d 83 11 eb ff ff    	lea    -0x14ef(%ebx),%eax
    2592:	50                   	push   %eax
    2593:	e8 74 21 00 00       	call   470c <chdir>
    2598:	83 c4 10             	add    $0x10,%esp
    259b:	85 c0                	test   %eax,%eax
    259d:	74 19                	je     25b8 <subdir+0x300>
    printf(1, "chdir dd/../../dd failed\n");
    259f:	83 ec 08             	sub    $0x8,%esp
    25a2:	8d 83 1d eb ff ff    	lea    -0x14e3(%ebx),%eax
    25a8:	50                   	push   %eax
    25a9:	6a 01                	push   $0x1
    25ab:	e8 88 22 00 00       	call   4838 <printf>
    25b0:	83 c4 10             	add    $0x10,%esp
    exit();
    25b3:	e8 e4 20 00 00       	call   469c <exit>
  }
  if(chdir("dd/../../../dd") != 0){
    25b8:	83 ec 0c             	sub    $0xc,%esp
    25bb:	8d 83 37 eb ff ff    	lea    -0x14c9(%ebx),%eax
    25c1:	50                   	push   %eax
    25c2:	e8 45 21 00 00       	call   470c <chdir>
    25c7:	83 c4 10             	add    $0x10,%esp
    25ca:	85 c0                	test   %eax,%eax
    25cc:	74 19                	je     25e7 <subdir+0x32f>
    printf(1, "chdir dd/../../dd failed\n");
    25ce:	83 ec 08             	sub    $0x8,%esp
    25d1:	8d 83 1d eb ff ff    	lea    -0x14e3(%ebx),%eax
    25d7:	50                   	push   %eax
    25d8:	6a 01                	push   $0x1
    25da:	e8 59 22 00 00       	call   4838 <printf>
    25df:	83 c4 10             	add    $0x10,%esp
    exit();
    25e2:	e8 b5 20 00 00       	call   469c <exit>
  }
  if(chdir("./..") != 0){
    25e7:	83 ec 0c             	sub    $0xc,%esp
    25ea:	8d 83 46 eb ff ff    	lea    -0x14ba(%ebx),%eax
    25f0:	50                   	push   %eax
    25f1:	e8 16 21 00 00       	call   470c <chdir>
    25f6:	83 c4 10             	add    $0x10,%esp
    25f9:	85 c0                	test   %eax,%eax
    25fb:	74 19                	je     2616 <subdir+0x35e>
    printf(1, "chdir ./.. failed\n");
    25fd:	83 ec 08             	sub    $0x8,%esp
    2600:	8d 83 4b eb ff ff    	lea    -0x14b5(%ebx),%eax
    2606:	50                   	push   %eax
    2607:	6a 01                	push   $0x1
    2609:	e8 2a 22 00 00       	call   4838 <printf>
    260e:	83 c4 10             	add    $0x10,%esp
    exit();
    2611:	e8 86 20 00 00       	call   469c <exit>
  }

  fd = open("dd/dd/ffff", 0);
    2616:	83 ec 08             	sub    $0x8,%esp
    2619:	6a 00                	push   $0x0
    261b:	8d 83 94 ea ff ff    	lea    -0x156c(%ebx),%eax
    2621:	50                   	push   %eax
    2622:	e8 b5 20 00 00       	call   46dc <open>
    2627:	83 c4 10             	add    $0x10,%esp
    262a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    262d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2631:	79 19                	jns    264c <subdir+0x394>
    printf(1, "open dd/dd/ffff failed\n");
    2633:	83 ec 08             	sub    $0x8,%esp
    2636:	8d 83 5e eb ff ff    	lea    -0x14a2(%ebx),%eax
    263c:	50                   	push   %eax
    263d:	6a 01                	push   $0x1
    263f:	e8 f4 21 00 00       	call   4838 <printf>
    2644:	83 c4 10             	add    $0x10,%esp
    exit();
    2647:	e8 50 20 00 00       	call   469c <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    264c:	83 ec 04             	sub    $0x4,%esp
    264f:	68 00 20 00 00       	push   $0x2000
    2654:	8d 83 50 00 00 00    	lea    0x50(%ebx),%eax
    265a:	50                   	push   %eax
    265b:	ff 75 f4             	push   -0xc(%ebp)
    265e:	e8 51 20 00 00       	call   46b4 <read>
    2663:	83 c4 10             	add    $0x10,%esp
    2666:	83 f8 02             	cmp    $0x2,%eax
    2669:	74 19                	je     2684 <subdir+0x3cc>
    printf(1, "read dd/dd/ffff wrong len\n");
    266b:	83 ec 08             	sub    $0x8,%esp
    266e:	8d 83 76 eb ff ff    	lea    -0x148a(%ebx),%eax
    2674:	50                   	push   %eax
    2675:	6a 01                	push   $0x1
    2677:	e8 bc 21 00 00       	call   4838 <printf>
    267c:	83 c4 10             	add    $0x10,%esp
    exit();
    267f:	e8 18 20 00 00       	call   469c <exit>
  }
  close(fd);
    2684:	83 ec 0c             	sub    $0xc,%esp
    2687:	ff 75 f4             	push   -0xc(%ebp)
    268a:	e8 35 20 00 00       	call   46c4 <close>
    268f:	83 c4 10             	add    $0x10,%esp

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2692:	83 ec 08             	sub    $0x8,%esp
    2695:	6a 00                	push   $0x0
    2697:	8d 83 30 ea ff ff    	lea    -0x15d0(%ebx),%eax
    269d:	50                   	push   %eax
    269e:	e8 39 20 00 00       	call   46dc <open>
    26a3:	83 c4 10             	add    $0x10,%esp
    26a6:	85 c0                	test   %eax,%eax
    26a8:	78 19                	js     26c3 <subdir+0x40b>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    26aa:	83 ec 08             	sub    $0x8,%esp
    26ad:	8d 83 94 eb ff ff    	lea    -0x146c(%ebx),%eax
    26b3:	50                   	push   %eax
    26b4:	6a 01                	push   $0x1
    26b6:	e8 7d 21 00 00       	call   4838 <printf>
    26bb:	83 c4 10             	add    $0x10,%esp
    exit();
    26be:	e8 d9 1f 00 00       	call   469c <exit>
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    26c3:	83 ec 08             	sub    $0x8,%esp
    26c6:	68 02 02 00 00       	push   $0x202
    26cb:	8d 83 b9 eb ff ff    	lea    -0x1447(%ebx),%eax
    26d1:	50                   	push   %eax
    26d2:	e8 05 20 00 00       	call   46dc <open>
    26d7:	83 c4 10             	add    $0x10,%esp
    26da:	85 c0                	test   %eax,%eax
    26dc:	78 19                	js     26f7 <subdir+0x43f>
    printf(1, "create dd/ff/ff succeeded!\n");
    26de:	83 ec 08             	sub    $0x8,%esp
    26e1:	8d 83 c2 eb ff ff    	lea    -0x143e(%ebx),%eax
    26e7:	50                   	push   %eax
    26e8:	6a 01                	push   $0x1
    26ea:	e8 49 21 00 00       	call   4838 <printf>
    26ef:	83 c4 10             	add    $0x10,%esp
    exit();
    26f2:	e8 a5 1f 00 00       	call   469c <exit>
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    26f7:	83 ec 08             	sub    $0x8,%esp
    26fa:	68 02 02 00 00       	push   $0x202
    26ff:	8d 83 de eb ff ff    	lea    -0x1422(%ebx),%eax
    2705:	50                   	push   %eax
    2706:	e8 d1 1f 00 00       	call   46dc <open>
    270b:	83 c4 10             	add    $0x10,%esp
    270e:	85 c0                	test   %eax,%eax
    2710:	78 19                	js     272b <subdir+0x473>
    printf(1, "create dd/xx/ff succeeded!\n");
    2712:	83 ec 08             	sub    $0x8,%esp
    2715:	8d 83 e7 eb ff ff    	lea    -0x1419(%ebx),%eax
    271b:	50                   	push   %eax
    271c:	6a 01                	push   $0x1
    271e:	e8 15 21 00 00       	call   4838 <printf>
    2723:	83 c4 10             	add    $0x10,%esp
    exit();
    2726:	e8 71 1f 00 00       	call   469c <exit>
  }
  if(open("dd", O_CREATE) >= 0){
    272b:	83 ec 08             	sub    $0x8,%esp
    272e:	68 00 02 00 00       	push   $0x200
    2733:	8d 83 b1 e9 ff ff    	lea    -0x164f(%ebx),%eax
    2739:	50                   	push   %eax
    273a:	e8 9d 1f 00 00       	call   46dc <open>
    273f:	83 c4 10             	add    $0x10,%esp
    2742:	85 c0                	test   %eax,%eax
    2744:	78 19                	js     275f <subdir+0x4a7>
    printf(1, "create dd succeeded!\n");
    2746:	83 ec 08             	sub    $0x8,%esp
    2749:	8d 83 03 ec ff ff    	lea    -0x13fd(%ebx),%eax
    274f:	50                   	push   %eax
    2750:	6a 01                	push   $0x1
    2752:	e8 e1 20 00 00       	call   4838 <printf>
    2757:	83 c4 10             	add    $0x10,%esp
    exit();
    275a:	e8 3d 1f 00 00       	call   469c <exit>
  }
  if(open("dd", O_RDWR) >= 0){
    275f:	83 ec 08             	sub    $0x8,%esp
    2762:	6a 02                	push   $0x2
    2764:	8d 83 b1 e9 ff ff    	lea    -0x164f(%ebx),%eax
    276a:	50                   	push   %eax
    276b:	e8 6c 1f 00 00       	call   46dc <open>
    2770:	83 c4 10             	add    $0x10,%esp
    2773:	85 c0                	test   %eax,%eax
    2775:	78 19                	js     2790 <subdir+0x4d8>
    printf(1, "open dd rdwr succeeded!\n");
    2777:	83 ec 08             	sub    $0x8,%esp
    277a:	8d 83 19 ec ff ff    	lea    -0x13e7(%ebx),%eax
    2780:	50                   	push   %eax
    2781:	6a 01                	push   $0x1
    2783:	e8 b0 20 00 00       	call   4838 <printf>
    2788:	83 c4 10             	add    $0x10,%esp
    exit();
    278b:	e8 0c 1f 00 00       	call   469c <exit>
  }
  if(open("dd", O_WRONLY) >= 0){
    2790:	83 ec 08             	sub    $0x8,%esp
    2793:	6a 01                	push   $0x1
    2795:	8d 83 b1 e9 ff ff    	lea    -0x164f(%ebx),%eax
    279b:	50                   	push   %eax
    279c:	e8 3b 1f 00 00       	call   46dc <open>
    27a1:	83 c4 10             	add    $0x10,%esp
    27a4:	85 c0                	test   %eax,%eax
    27a6:	78 19                	js     27c1 <subdir+0x509>
    printf(1, "open dd wronly succeeded!\n");
    27a8:	83 ec 08             	sub    $0x8,%esp
    27ab:	8d 83 32 ec ff ff    	lea    -0x13ce(%ebx),%eax
    27b1:	50                   	push   %eax
    27b2:	6a 01                	push   $0x1
    27b4:	e8 7f 20 00 00       	call   4838 <printf>
    27b9:	83 c4 10             	add    $0x10,%esp
    exit();
    27bc:	e8 db 1e 00 00       	call   469c <exit>
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    27c1:	83 ec 08             	sub    $0x8,%esp
    27c4:	8d 83 4d ec ff ff    	lea    -0x13b3(%ebx),%eax
    27ca:	50                   	push   %eax
    27cb:	8d 83 b9 eb ff ff    	lea    -0x1447(%ebx),%eax
    27d1:	50                   	push   %eax
    27d2:	e8 25 1f 00 00       	call   46fc <link>
    27d7:	83 c4 10             	add    $0x10,%esp
    27da:	85 c0                	test   %eax,%eax
    27dc:	75 19                	jne    27f7 <subdir+0x53f>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    27de:	83 ec 08             	sub    $0x8,%esp
    27e1:	8d 83 58 ec ff ff    	lea    -0x13a8(%ebx),%eax
    27e7:	50                   	push   %eax
    27e8:	6a 01                	push   $0x1
    27ea:	e8 49 20 00 00       	call   4838 <printf>
    27ef:	83 c4 10             	add    $0x10,%esp
    exit();
    27f2:	e8 a5 1e 00 00       	call   469c <exit>
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    27f7:	83 ec 08             	sub    $0x8,%esp
    27fa:	8d 83 4d ec ff ff    	lea    -0x13b3(%ebx),%eax
    2800:	50                   	push   %eax
    2801:	8d 83 de eb ff ff    	lea    -0x1422(%ebx),%eax
    2807:	50                   	push   %eax
    2808:	e8 ef 1e 00 00       	call   46fc <link>
    280d:	83 c4 10             	add    $0x10,%esp
    2810:	85 c0                	test   %eax,%eax
    2812:	75 19                	jne    282d <subdir+0x575>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    2814:	83 ec 08             	sub    $0x8,%esp
    2817:	8d 83 7c ec ff ff    	lea    -0x1384(%ebx),%eax
    281d:	50                   	push   %eax
    281e:	6a 01                	push   $0x1
    2820:	e8 13 20 00 00       	call   4838 <printf>
    2825:	83 c4 10             	add    $0x10,%esp
    exit();
    2828:	e8 6f 1e 00 00       	call   469c <exit>
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    282d:	83 ec 08             	sub    $0x8,%esp
    2830:	8d 83 94 ea ff ff    	lea    -0x156c(%ebx),%eax
    2836:	50                   	push   %eax
    2837:	8d 83 cc e9 ff ff    	lea    -0x1634(%ebx),%eax
    283d:	50                   	push   %eax
    283e:	e8 b9 1e 00 00       	call   46fc <link>
    2843:	83 c4 10             	add    $0x10,%esp
    2846:	85 c0                	test   %eax,%eax
    2848:	75 19                	jne    2863 <subdir+0x5ab>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    284a:	83 ec 08             	sub    $0x8,%esp
    284d:	8d 83 a0 ec ff ff    	lea    -0x1360(%ebx),%eax
    2853:	50                   	push   %eax
    2854:	6a 01                	push   $0x1
    2856:	e8 dd 1f 00 00       	call   4838 <printf>
    285b:	83 c4 10             	add    $0x10,%esp
    exit();
    285e:	e8 39 1e 00 00       	call   469c <exit>
  }
  if(mkdir("dd/ff/ff") == 0){
    2863:	83 ec 0c             	sub    $0xc,%esp
    2866:	8d 83 b9 eb ff ff    	lea    -0x1447(%ebx),%eax
    286c:	50                   	push   %eax
    286d:	e8 92 1e 00 00       	call   4704 <mkdir>
    2872:	83 c4 10             	add    $0x10,%esp
    2875:	85 c0                	test   %eax,%eax
    2877:	75 19                	jne    2892 <subdir+0x5da>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    2879:	83 ec 08             	sub    $0x8,%esp
    287c:	8d 83 c2 ec ff ff    	lea    -0x133e(%ebx),%eax
    2882:	50                   	push   %eax
    2883:	6a 01                	push   $0x1
    2885:	e8 ae 1f 00 00       	call   4838 <printf>
    288a:	83 c4 10             	add    $0x10,%esp
    exit();
    288d:	e8 0a 1e 00 00       	call   469c <exit>
  }
  if(mkdir("dd/xx/ff") == 0){
    2892:	83 ec 0c             	sub    $0xc,%esp
    2895:	8d 83 de eb ff ff    	lea    -0x1422(%ebx),%eax
    289b:	50                   	push   %eax
    289c:	e8 63 1e 00 00       	call   4704 <mkdir>
    28a1:	83 c4 10             	add    $0x10,%esp
    28a4:	85 c0                	test   %eax,%eax
    28a6:	75 19                	jne    28c1 <subdir+0x609>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    28a8:	83 ec 08             	sub    $0x8,%esp
    28ab:	8d 83 dd ec ff ff    	lea    -0x1323(%ebx),%eax
    28b1:	50                   	push   %eax
    28b2:	6a 01                	push   $0x1
    28b4:	e8 7f 1f 00 00       	call   4838 <printf>
    28b9:	83 c4 10             	add    $0x10,%esp
    exit();
    28bc:	e8 db 1d 00 00       	call   469c <exit>
  }
  if(mkdir("dd/dd/ffff") == 0){
    28c1:	83 ec 0c             	sub    $0xc,%esp
    28c4:	8d 83 94 ea ff ff    	lea    -0x156c(%ebx),%eax
    28ca:	50                   	push   %eax
    28cb:	e8 34 1e 00 00       	call   4704 <mkdir>
    28d0:	83 c4 10             	add    $0x10,%esp
    28d3:	85 c0                	test   %eax,%eax
    28d5:	75 19                	jne    28f0 <subdir+0x638>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    28d7:	83 ec 08             	sub    $0x8,%esp
    28da:	8d 83 f8 ec ff ff    	lea    -0x1308(%ebx),%eax
    28e0:	50                   	push   %eax
    28e1:	6a 01                	push   $0x1
    28e3:	e8 50 1f 00 00       	call   4838 <printf>
    28e8:	83 c4 10             	add    $0x10,%esp
    exit();
    28eb:	e8 ac 1d 00 00       	call   469c <exit>
  }
  if(unlink("dd/xx/ff") == 0){
    28f0:	83 ec 0c             	sub    $0xc,%esp
    28f3:	8d 83 de eb ff ff    	lea    -0x1422(%ebx),%eax
    28f9:	50                   	push   %eax
    28fa:	e8 ed 1d 00 00       	call   46ec <unlink>
    28ff:	83 c4 10             	add    $0x10,%esp
    2902:	85 c0                	test   %eax,%eax
    2904:	75 19                	jne    291f <subdir+0x667>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    2906:	83 ec 08             	sub    $0x8,%esp
    2909:	8d 83 15 ed ff ff    	lea    -0x12eb(%ebx),%eax
    290f:	50                   	push   %eax
    2910:	6a 01                	push   $0x1
    2912:	e8 21 1f 00 00       	call   4838 <printf>
    2917:	83 c4 10             	add    $0x10,%esp
    exit();
    291a:	e8 7d 1d 00 00       	call   469c <exit>
  }
  if(unlink("dd/ff/ff") == 0){
    291f:	83 ec 0c             	sub    $0xc,%esp
    2922:	8d 83 b9 eb ff ff    	lea    -0x1447(%ebx),%eax
    2928:	50                   	push   %eax
    2929:	e8 be 1d 00 00       	call   46ec <unlink>
    292e:	83 c4 10             	add    $0x10,%esp
    2931:	85 c0                	test   %eax,%eax
    2933:	75 19                	jne    294e <subdir+0x696>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    2935:	83 ec 08             	sub    $0x8,%esp
    2938:	8d 83 31 ed ff ff    	lea    -0x12cf(%ebx),%eax
    293e:	50                   	push   %eax
    293f:	6a 01                	push   $0x1
    2941:	e8 f2 1e 00 00       	call   4838 <printf>
    2946:	83 c4 10             	add    $0x10,%esp
    exit();
    2949:	e8 4e 1d 00 00       	call   469c <exit>
  }
  if(chdir("dd/ff") == 0){
    294e:	83 ec 0c             	sub    $0xc,%esp
    2951:	8d 83 cc e9 ff ff    	lea    -0x1634(%ebx),%eax
    2957:	50                   	push   %eax
    2958:	e8 af 1d 00 00       	call   470c <chdir>
    295d:	83 c4 10             	add    $0x10,%esp
    2960:	85 c0                	test   %eax,%eax
    2962:	75 19                	jne    297d <subdir+0x6c5>
    printf(1, "chdir dd/ff succeeded!\n");
    2964:	83 ec 08             	sub    $0x8,%esp
    2967:	8d 83 4d ed ff ff    	lea    -0x12b3(%ebx),%eax
    296d:	50                   	push   %eax
    296e:	6a 01                	push   $0x1
    2970:	e8 c3 1e 00 00       	call   4838 <printf>
    2975:	83 c4 10             	add    $0x10,%esp
    exit();
    2978:	e8 1f 1d 00 00       	call   469c <exit>
  }
  if(chdir("dd/xx") == 0){
    297d:	83 ec 0c             	sub    $0xc,%esp
    2980:	8d 83 65 ed ff ff    	lea    -0x129b(%ebx),%eax
    2986:	50                   	push   %eax
    2987:	e8 80 1d 00 00       	call   470c <chdir>
    298c:	83 c4 10             	add    $0x10,%esp
    298f:	85 c0                	test   %eax,%eax
    2991:	75 19                	jne    29ac <subdir+0x6f4>
    printf(1, "chdir dd/xx succeeded!\n");
    2993:	83 ec 08             	sub    $0x8,%esp
    2996:	8d 83 6b ed ff ff    	lea    -0x1295(%ebx),%eax
    299c:	50                   	push   %eax
    299d:	6a 01                	push   $0x1
    299f:	e8 94 1e 00 00       	call   4838 <printf>
    29a4:	83 c4 10             	add    $0x10,%esp
    exit();
    29a7:	e8 f0 1c 00 00       	call   469c <exit>
  }

  if(unlink("dd/dd/ffff") != 0){
    29ac:	83 ec 0c             	sub    $0xc,%esp
    29af:	8d 83 94 ea ff ff    	lea    -0x156c(%ebx),%eax
    29b5:	50                   	push   %eax
    29b6:	e8 31 1d 00 00       	call   46ec <unlink>
    29bb:	83 c4 10             	add    $0x10,%esp
    29be:	85 c0                	test   %eax,%eax
    29c0:	74 19                	je     29db <subdir+0x723>
    printf(1, "unlink dd/dd/ff failed\n");
    29c2:	83 ec 08             	sub    $0x8,%esp
    29c5:	8d 83 c1 ea ff ff    	lea    -0x153f(%ebx),%eax
    29cb:	50                   	push   %eax
    29cc:	6a 01                	push   $0x1
    29ce:	e8 65 1e 00 00       	call   4838 <printf>
    29d3:	83 c4 10             	add    $0x10,%esp
    exit();
    29d6:	e8 c1 1c 00 00       	call   469c <exit>
  }
  if(unlink("dd/ff") != 0){
    29db:	83 ec 0c             	sub    $0xc,%esp
    29de:	8d 83 cc e9 ff ff    	lea    -0x1634(%ebx),%eax
    29e4:	50                   	push   %eax
    29e5:	e8 02 1d 00 00       	call   46ec <unlink>
    29ea:	83 c4 10             	add    $0x10,%esp
    29ed:	85 c0                	test   %eax,%eax
    29ef:	74 19                	je     2a0a <subdir+0x752>
    printf(1, "unlink dd/ff failed\n");
    29f1:	83 ec 08             	sub    $0x8,%esp
    29f4:	8d 83 83 ed ff ff    	lea    -0x127d(%ebx),%eax
    29fa:	50                   	push   %eax
    29fb:	6a 01                	push   $0x1
    29fd:	e8 36 1e 00 00       	call   4838 <printf>
    2a02:	83 c4 10             	add    $0x10,%esp
    exit();
    2a05:	e8 92 1c 00 00       	call   469c <exit>
  }
  if(unlink("dd") == 0){
    2a0a:	83 ec 0c             	sub    $0xc,%esp
    2a0d:	8d 83 b1 e9 ff ff    	lea    -0x164f(%ebx),%eax
    2a13:	50                   	push   %eax
    2a14:	e8 d3 1c 00 00       	call   46ec <unlink>
    2a19:	83 c4 10             	add    $0x10,%esp
    2a1c:	85 c0                	test   %eax,%eax
    2a1e:	75 19                	jne    2a39 <subdir+0x781>
    printf(1, "unlink non-empty dd succeeded!\n");
    2a20:	83 ec 08             	sub    $0x8,%esp
    2a23:	8d 83 98 ed ff ff    	lea    -0x1268(%ebx),%eax
    2a29:	50                   	push   %eax
    2a2a:	6a 01                	push   $0x1
    2a2c:	e8 07 1e 00 00       	call   4838 <printf>
    2a31:	83 c4 10             	add    $0x10,%esp
    exit();
    2a34:	e8 63 1c 00 00       	call   469c <exit>
  }
  if(unlink("dd/dd") < 0){
    2a39:	83 ec 0c             	sub    $0xc,%esp
    2a3c:	8d 83 b8 ed ff ff    	lea    -0x1248(%ebx),%eax
    2a42:	50                   	push   %eax
    2a43:	e8 a4 1c 00 00       	call   46ec <unlink>
    2a48:	83 c4 10             	add    $0x10,%esp
    2a4b:	85 c0                	test   %eax,%eax
    2a4d:	79 19                	jns    2a68 <subdir+0x7b0>
    printf(1, "unlink dd/dd failed\n");
    2a4f:	83 ec 08             	sub    $0x8,%esp
    2a52:	8d 83 be ed ff ff    	lea    -0x1242(%ebx),%eax
    2a58:	50                   	push   %eax
    2a59:	6a 01                	push   $0x1
    2a5b:	e8 d8 1d 00 00       	call   4838 <printf>
    2a60:	83 c4 10             	add    $0x10,%esp
    exit();
    2a63:	e8 34 1c 00 00       	call   469c <exit>
  }
  if(unlink("dd") < 0){
    2a68:	83 ec 0c             	sub    $0xc,%esp
    2a6b:	8d 83 b1 e9 ff ff    	lea    -0x164f(%ebx),%eax
    2a71:	50                   	push   %eax
    2a72:	e8 75 1c 00 00       	call   46ec <unlink>
    2a77:	83 c4 10             	add    $0x10,%esp
    2a7a:	85 c0                	test   %eax,%eax
    2a7c:	79 19                	jns    2a97 <subdir+0x7df>
    printf(1, "unlink dd failed\n");
    2a7e:	83 ec 08             	sub    $0x8,%esp
    2a81:	8d 83 d3 ed ff ff    	lea    -0x122d(%ebx),%eax
    2a87:	50                   	push   %eax
    2a88:	6a 01                	push   $0x1
    2a8a:	e8 a9 1d 00 00       	call   4838 <printf>
    2a8f:	83 c4 10             	add    $0x10,%esp
    exit();
    2a92:	e8 05 1c 00 00       	call   469c <exit>
  }

  printf(1, "subdir ok\n");
    2a97:	83 ec 08             	sub    $0x8,%esp
    2a9a:	8d 83 e5 ed ff ff    	lea    -0x121b(%ebx),%eax
    2aa0:	50                   	push   %eax
    2aa1:	6a 01                	push   $0x1
    2aa3:	e8 90 1d 00 00       	call   4838 <printf>
    2aa8:	83 c4 10             	add    $0x10,%esp
}
    2aab:	90                   	nop
    2aac:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2aaf:	c9                   	leave  
    2ab0:	c3                   	ret    

00002ab1 <bigwrite>:

// test writes that are larger than the log.
void
bigwrite(void)
{
    2ab1:	55                   	push   %ebp
    2ab2:	89 e5                	mov    %esp,%ebp
    2ab4:	53                   	push   %ebx
    2ab5:	83 ec 14             	sub    $0x14,%esp
    2ab8:	e8 16 19 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
    2abd:	81 c3 b3 41 00 00    	add    $0x41b3,%ebx
  int fd, sz;

  printf(1, "bigwrite test\n");
    2ac3:	83 ec 08             	sub    $0x8,%esp
    2ac6:	8d 83 f0 ed ff ff    	lea    -0x1210(%ebx),%eax
    2acc:	50                   	push   %eax
    2acd:	6a 01                	push   $0x1
    2acf:	e8 64 1d 00 00       	call   4838 <printf>
    2ad4:	83 c4 10             	add    $0x10,%esp

  unlink("bigwrite");
    2ad7:	83 ec 0c             	sub    $0xc,%esp
    2ada:	8d 83 ff ed ff ff    	lea    -0x1201(%ebx),%eax
    2ae0:	50                   	push   %eax
    2ae1:	e8 06 1c 00 00       	call   46ec <unlink>
    2ae6:	83 c4 10             	add    $0x10,%esp
  for(sz = 499; sz < 12*512; sz += 471){
    2ae9:	c7 45 f4 f3 01 00 00 	movl   $0x1f3,-0xc(%ebp)
    2af0:	e9 b2 00 00 00       	jmp    2ba7 <bigwrite+0xf6>
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2af5:	83 ec 08             	sub    $0x8,%esp
    2af8:	68 02 02 00 00       	push   $0x202
    2afd:	8d 83 ff ed ff ff    	lea    -0x1201(%ebx),%eax
    2b03:	50                   	push   %eax
    2b04:	e8 d3 1b 00 00       	call   46dc <open>
    2b09:	83 c4 10             	add    $0x10,%esp
    2b0c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(fd < 0){
    2b0f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2b13:	79 19                	jns    2b2e <bigwrite+0x7d>
      printf(1, "cannot create bigwrite\n");
    2b15:	83 ec 08             	sub    $0x8,%esp
    2b18:	8d 83 08 ee ff ff    	lea    -0x11f8(%ebx),%eax
    2b1e:	50                   	push   %eax
    2b1f:	6a 01                	push   $0x1
    2b21:	e8 12 1d 00 00       	call   4838 <printf>
    2b26:	83 c4 10             	add    $0x10,%esp
      exit();
    2b29:	e8 6e 1b 00 00       	call   469c <exit>
    }
    int i;
    for(i = 0; i < 2; i++){
    2b2e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    2b35:	eb 43                	jmp    2b7a <bigwrite+0xc9>
      int cc = write(fd, buf, sz);
    2b37:	83 ec 04             	sub    $0x4,%esp
    2b3a:	ff 75 f4             	push   -0xc(%ebp)
    2b3d:	8d 83 50 00 00 00    	lea    0x50(%ebx),%eax
    2b43:	50                   	push   %eax
    2b44:	ff 75 ec             	push   -0x14(%ebp)
    2b47:	e8 70 1b 00 00       	call   46bc <write>
    2b4c:	83 c4 10             	add    $0x10,%esp
    2b4f:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(cc != sz){
    2b52:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2b55:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2b58:	74 1c                	je     2b76 <bigwrite+0xc5>
        printf(1, "write(%d) ret %d\n", sz, cc);
    2b5a:	ff 75 e8             	push   -0x18(%ebp)
    2b5d:	ff 75 f4             	push   -0xc(%ebp)
    2b60:	8d 83 20 ee ff ff    	lea    -0x11e0(%ebx),%eax
    2b66:	50                   	push   %eax
    2b67:	6a 01                	push   $0x1
    2b69:	e8 ca 1c 00 00       	call   4838 <printf>
    2b6e:	83 c4 10             	add    $0x10,%esp
        exit();
    2b71:	e8 26 1b 00 00       	call   469c <exit>
    for(i = 0; i < 2; i++){
    2b76:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    2b7a:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    2b7e:	7e b7                	jle    2b37 <bigwrite+0x86>
      }
    }
    close(fd);
    2b80:	83 ec 0c             	sub    $0xc,%esp
    2b83:	ff 75 ec             	push   -0x14(%ebp)
    2b86:	e8 39 1b 00 00       	call   46c4 <close>
    2b8b:	83 c4 10             	add    $0x10,%esp
    unlink("bigwrite");
    2b8e:	83 ec 0c             	sub    $0xc,%esp
    2b91:	8d 83 ff ed ff ff    	lea    -0x1201(%ebx),%eax
    2b97:	50                   	push   %eax
    2b98:	e8 4f 1b 00 00       	call   46ec <unlink>
    2b9d:	83 c4 10             	add    $0x10,%esp
  for(sz = 499; sz < 12*512; sz += 471){
    2ba0:	81 45 f4 d7 01 00 00 	addl   $0x1d7,-0xc(%ebp)
    2ba7:	81 7d f4 ff 17 00 00 	cmpl   $0x17ff,-0xc(%ebp)
    2bae:	0f 8e 41 ff ff ff    	jle    2af5 <bigwrite+0x44>
  }

  printf(1, "bigwrite ok\n");
    2bb4:	83 ec 08             	sub    $0x8,%esp
    2bb7:	8d 83 32 ee ff ff    	lea    -0x11ce(%ebx),%eax
    2bbd:	50                   	push   %eax
    2bbe:	6a 01                	push   $0x1
    2bc0:	e8 73 1c 00 00       	call   4838 <printf>
    2bc5:	83 c4 10             	add    $0x10,%esp
}
    2bc8:	90                   	nop
    2bc9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2bcc:	c9                   	leave  
    2bcd:	c3                   	ret    

00002bce <bigfile>:

void
bigfile(void)
{
    2bce:	55                   	push   %ebp
    2bcf:	89 e5                	mov    %esp,%ebp
    2bd1:	53                   	push   %ebx
    2bd2:	83 ec 14             	sub    $0x14,%esp
    2bd5:	e8 f9 17 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
    2bda:	81 c3 96 40 00 00    	add    $0x4096,%ebx
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    2be0:	83 ec 08             	sub    $0x8,%esp
    2be3:	8d 83 3f ee ff ff    	lea    -0x11c1(%ebx),%eax
    2be9:	50                   	push   %eax
    2bea:	6a 01                	push   $0x1
    2bec:	e8 47 1c 00 00       	call   4838 <printf>
    2bf1:	83 c4 10             	add    $0x10,%esp

  unlink("bigfile");
    2bf4:	83 ec 0c             	sub    $0xc,%esp
    2bf7:	8d 83 4d ee ff ff    	lea    -0x11b3(%ebx),%eax
    2bfd:	50                   	push   %eax
    2bfe:	e8 e9 1a 00 00       	call   46ec <unlink>
    2c03:	83 c4 10             	add    $0x10,%esp
  fd = open("bigfile", O_CREATE | O_RDWR);
    2c06:	83 ec 08             	sub    $0x8,%esp
    2c09:	68 02 02 00 00       	push   $0x202
    2c0e:	8d 83 4d ee ff ff    	lea    -0x11b3(%ebx),%eax
    2c14:	50                   	push   %eax
    2c15:	e8 c2 1a 00 00       	call   46dc <open>
    2c1a:	83 c4 10             	add    $0x10,%esp
    2c1d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    2c20:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2c24:	79 19                	jns    2c3f <bigfile+0x71>
    printf(1, "cannot create bigfile");
    2c26:	83 ec 08             	sub    $0x8,%esp
    2c29:	8d 83 55 ee ff ff    	lea    -0x11ab(%ebx),%eax
    2c2f:	50                   	push   %eax
    2c30:	6a 01                	push   $0x1
    2c32:	e8 01 1c 00 00       	call   4838 <printf>
    2c37:	83 c4 10             	add    $0x10,%esp
    exit();
    2c3a:	e8 5d 1a 00 00       	call   469c <exit>
  }
  for(i = 0; i < 20; i++){
    2c3f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2c46:	eb 58                	jmp    2ca0 <bigfile+0xd2>
    memset(buf, i, 600);
    2c48:	83 ec 04             	sub    $0x4,%esp
    2c4b:	68 58 02 00 00       	push   $0x258
    2c50:	ff 75 f4             	push   -0xc(%ebp)
    2c53:	8d 83 50 00 00 00    	lea    0x50(%ebx),%eax
    2c59:	50                   	push   %eax
    2c5a:	e8 5c 18 00 00       	call   44bb <memset>
    2c5f:	83 c4 10             	add    $0x10,%esp
    if(write(fd, buf, 600) != 600){
    2c62:	83 ec 04             	sub    $0x4,%esp
    2c65:	68 58 02 00 00       	push   $0x258
    2c6a:	8d 83 50 00 00 00    	lea    0x50(%ebx),%eax
    2c70:	50                   	push   %eax
    2c71:	ff 75 ec             	push   -0x14(%ebp)
    2c74:	e8 43 1a 00 00       	call   46bc <write>
    2c79:	83 c4 10             	add    $0x10,%esp
    2c7c:	3d 58 02 00 00       	cmp    $0x258,%eax
    2c81:	74 19                	je     2c9c <bigfile+0xce>
      printf(1, "write bigfile failed\n");
    2c83:	83 ec 08             	sub    $0x8,%esp
    2c86:	8d 83 6b ee ff ff    	lea    -0x1195(%ebx),%eax
    2c8c:	50                   	push   %eax
    2c8d:	6a 01                	push   $0x1
    2c8f:	e8 a4 1b 00 00       	call   4838 <printf>
    2c94:	83 c4 10             	add    $0x10,%esp
      exit();
    2c97:	e8 00 1a 00 00       	call   469c <exit>
  for(i = 0; i < 20; i++){
    2c9c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2ca0:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    2ca4:	7e a2                	jle    2c48 <bigfile+0x7a>
    }
  }
  close(fd);
    2ca6:	83 ec 0c             	sub    $0xc,%esp
    2ca9:	ff 75 ec             	push   -0x14(%ebp)
    2cac:	e8 13 1a 00 00       	call   46c4 <close>
    2cb1:	83 c4 10             	add    $0x10,%esp

  fd = open("bigfile", 0);
    2cb4:	83 ec 08             	sub    $0x8,%esp
    2cb7:	6a 00                	push   $0x0
    2cb9:	8d 83 4d ee ff ff    	lea    -0x11b3(%ebx),%eax
    2cbf:	50                   	push   %eax
    2cc0:	e8 17 1a 00 00       	call   46dc <open>
    2cc5:	83 c4 10             	add    $0x10,%esp
    2cc8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    2ccb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2ccf:	79 19                	jns    2cea <bigfile+0x11c>
    printf(1, "cannot open bigfile\n");
    2cd1:	83 ec 08             	sub    $0x8,%esp
    2cd4:	8d 83 81 ee ff ff    	lea    -0x117f(%ebx),%eax
    2cda:	50                   	push   %eax
    2cdb:	6a 01                	push   $0x1
    2cdd:	e8 56 1b 00 00       	call   4838 <printf>
    2ce2:	83 c4 10             	add    $0x10,%esp
    exit();
    2ce5:	e8 b2 19 00 00       	call   469c <exit>
  }
  total = 0;
    2cea:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(i = 0; ; i++){
    2cf1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    cc = read(fd, buf, 300);
    2cf8:	83 ec 04             	sub    $0x4,%esp
    2cfb:	68 2c 01 00 00       	push   $0x12c
    2d00:	8d 83 50 00 00 00    	lea    0x50(%ebx),%eax
    2d06:	50                   	push   %eax
    2d07:	ff 75 ec             	push   -0x14(%ebp)
    2d0a:	e8 a5 19 00 00       	call   46b4 <read>
    2d0f:	83 c4 10             	add    $0x10,%esp
    2d12:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(cc < 0){
    2d15:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2d19:	79 19                	jns    2d34 <bigfile+0x166>
      printf(1, "read bigfile failed\n");
    2d1b:	83 ec 08             	sub    $0x8,%esp
    2d1e:	8d 83 96 ee ff ff    	lea    -0x116a(%ebx),%eax
    2d24:	50                   	push   %eax
    2d25:	6a 01                	push   $0x1
    2d27:	e8 0c 1b 00 00       	call   4838 <printf>
    2d2c:	83 c4 10             	add    $0x10,%esp
      exit();
    2d2f:	e8 68 19 00 00       	call   469c <exit>
    }
    if(cc == 0)
    2d34:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2d38:	74 7e                	je     2db8 <bigfile+0x1ea>
      break;
    if(cc != 300){
    2d3a:	81 7d e8 2c 01 00 00 	cmpl   $0x12c,-0x18(%ebp)
    2d41:	74 19                	je     2d5c <bigfile+0x18e>
      printf(1, "short read bigfile\n");
    2d43:	83 ec 08             	sub    $0x8,%esp
    2d46:	8d 83 ab ee ff ff    	lea    -0x1155(%ebx),%eax
    2d4c:	50                   	push   %eax
    2d4d:	6a 01                	push   $0x1
    2d4f:	e8 e4 1a 00 00       	call   4838 <printf>
    2d54:	83 c4 10             	add    $0x10,%esp
      exit();
    2d57:	e8 40 19 00 00       	call   469c <exit>
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    2d5c:	0f b6 83 50 00 00 00 	movzbl 0x50(%ebx),%eax
    2d63:	0f be d0             	movsbl %al,%edx
    2d66:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2d69:	89 c1                	mov    %eax,%ecx
    2d6b:	c1 e9 1f             	shr    $0x1f,%ecx
    2d6e:	01 c8                	add    %ecx,%eax
    2d70:	d1 f8                	sar    %eax
    2d72:	39 c2                	cmp    %eax,%edx
    2d74:	75 1a                	jne    2d90 <bigfile+0x1c2>
    2d76:	0f b6 83 7b 01 00 00 	movzbl 0x17b(%ebx),%eax
    2d7d:	0f be d0             	movsbl %al,%edx
    2d80:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2d83:	89 c1                	mov    %eax,%ecx
    2d85:	c1 e9 1f             	shr    $0x1f,%ecx
    2d88:	01 c8                	add    %ecx,%eax
    2d8a:	d1 f8                	sar    %eax
    2d8c:	39 c2                	cmp    %eax,%edx
    2d8e:	74 19                	je     2da9 <bigfile+0x1db>
      printf(1, "read bigfile wrong data\n");
    2d90:	83 ec 08             	sub    $0x8,%esp
    2d93:	8d 83 bf ee ff ff    	lea    -0x1141(%ebx),%eax
    2d99:	50                   	push   %eax
    2d9a:	6a 01                	push   $0x1
    2d9c:	e8 97 1a 00 00       	call   4838 <printf>
    2da1:	83 c4 10             	add    $0x10,%esp
      exit();
    2da4:	e8 f3 18 00 00       	call   469c <exit>
    }
    total += cc;
    2da9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2dac:	01 45 f0             	add    %eax,-0x10(%ebp)
  for(i = 0; ; i++){
    2daf:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    cc = read(fd, buf, 300);
    2db3:	e9 40 ff ff ff       	jmp    2cf8 <bigfile+0x12a>
      break;
    2db8:	90                   	nop
  }
  close(fd);
    2db9:	83 ec 0c             	sub    $0xc,%esp
    2dbc:	ff 75 ec             	push   -0x14(%ebp)
    2dbf:	e8 00 19 00 00       	call   46c4 <close>
    2dc4:	83 c4 10             	add    $0x10,%esp
  if(total != 20*600){
    2dc7:	81 7d f0 e0 2e 00 00 	cmpl   $0x2ee0,-0x10(%ebp)
    2dce:	74 19                	je     2de9 <bigfile+0x21b>
    printf(1, "read bigfile wrong total\n");
    2dd0:	83 ec 08             	sub    $0x8,%esp
    2dd3:	8d 83 d8 ee ff ff    	lea    -0x1128(%ebx),%eax
    2dd9:	50                   	push   %eax
    2dda:	6a 01                	push   $0x1
    2ddc:	e8 57 1a 00 00       	call   4838 <printf>
    2de1:	83 c4 10             	add    $0x10,%esp
    exit();
    2de4:	e8 b3 18 00 00       	call   469c <exit>
  }
  unlink("bigfile");
    2de9:	83 ec 0c             	sub    $0xc,%esp
    2dec:	8d 83 4d ee ff ff    	lea    -0x11b3(%ebx),%eax
    2df2:	50                   	push   %eax
    2df3:	e8 f4 18 00 00       	call   46ec <unlink>
    2df8:	83 c4 10             	add    $0x10,%esp

  printf(1, "bigfile test ok\n");
    2dfb:	83 ec 08             	sub    $0x8,%esp
    2dfe:	8d 83 f2 ee ff ff    	lea    -0x110e(%ebx),%eax
    2e04:	50                   	push   %eax
    2e05:	6a 01                	push   $0x1
    2e07:	e8 2c 1a 00 00       	call   4838 <printf>
    2e0c:	83 c4 10             	add    $0x10,%esp
}
    2e0f:	90                   	nop
    2e10:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2e13:	c9                   	leave  
    2e14:	c3                   	ret    

00002e15 <fourteen>:

void
fourteen(void)
{
    2e15:	55                   	push   %ebp
    2e16:	89 e5                	mov    %esp,%ebp
    2e18:	53                   	push   %ebx
    2e19:	83 ec 14             	sub    $0x14,%esp
    2e1c:	e8 b2 15 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
    2e21:	81 c3 4f 3e 00 00    	add    $0x3e4f,%ebx
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
    2e27:	83 ec 08             	sub    $0x8,%esp
    2e2a:	8d 83 03 ef ff ff    	lea    -0x10fd(%ebx),%eax
    2e30:	50                   	push   %eax
    2e31:	6a 01                	push   $0x1
    2e33:	e8 00 1a 00 00       	call   4838 <printf>
    2e38:	83 c4 10             	add    $0x10,%esp

  if(mkdir("12345678901234") != 0){
    2e3b:	83 ec 0c             	sub    $0xc,%esp
    2e3e:	8d 83 12 ef ff ff    	lea    -0x10ee(%ebx),%eax
    2e44:	50                   	push   %eax
    2e45:	e8 ba 18 00 00       	call   4704 <mkdir>
    2e4a:	83 c4 10             	add    $0x10,%esp
    2e4d:	85 c0                	test   %eax,%eax
    2e4f:	74 19                	je     2e6a <fourteen+0x55>
    printf(1, "mkdir 12345678901234 failed\n");
    2e51:	83 ec 08             	sub    $0x8,%esp
    2e54:	8d 83 21 ef ff ff    	lea    -0x10df(%ebx),%eax
    2e5a:	50                   	push   %eax
    2e5b:	6a 01                	push   $0x1
    2e5d:	e8 d6 19 00 00       	call   4838 <printf>
    2e62:	83 c4 10             	add    $0x10,%esp
    exit();
    2e65:	e8 32 18 00 00       	call   469c <exit>
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    2e6a:	83 ec 0c             	sub    $0xc,%esp
    2e6d:	8d 83 40 ef ff ff    	lea    -0x10c0(%ebx),%eax
    2e73:	50                   	push   %eax
    2e74:	e8 8b 18 00 00       	call   4704 <mkdir>
    2e79:	83 c4 10             	add    $0x10,%esp
    2e7c:	85 c0                	test   %eax,%eax
    2e7e:	74 19                	je     2e99 <fourteen+0x84>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    2e80:	83 ec 08             	sub    $0x8,%esp
    2e83:	8d 83 60 ef ff ff    	lea    -0x10a0(%ebx),%eax
    2e89:	50                   	push   %eax
    2e8a:	6a 01                	push   $0x1
    2e8c:	e8 a7 19 00 00       	call   4838 <printf>
    2e91:	83 c4 10             	add    $0x10,%esp
    exit();
    2e94:	e8 03 18 00 00       	call   469c <exit>
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    2e99:	83 ec 08             	sub    $0x8,%esp
    2e9c:	68 00 02 00 00       	push   $0x200
    2ea1:	8d 83 90 ef ff ff    	lea    -0x1070(%ebx),%eax
    2ea7:	50                   	push   %eax
    2ea8:	e8 2f 18 00 00       	call   46dc <open>
    2ead:	83 c4 10             	add    $0x10,%esp
    2eb0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2eb3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2eb7:	79 19                	jns    2ed2 <fourteen+0xbd>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    2eb9:	83 ec 08             	sub    $0x8,%esp
    2ebc:	8d 83 c0 ef ff ff    	lea    -0x1040(%ebx),%eax
    2ec2:	50                   	push   %eax
    2ec3:	6a 01                	push   $0x1
    2ec5:	e8 6e 19 00 00       	call   4838 <printf>
    2eca:	83 c4 10             	add    $0x10,%esp
    exit();
    2ecd:	e8 ca 17 00 00       	call   469c <exit>
  }
  close(fd);
    2ed2:	83 ec 0c             	sub    $0xc,%esp
    2ed5:	ff 75 f4             	push   -0xc(%ebp)
    2ed8:	e8 e7 17 00 00       	call   46c4 <close>
    2edd:	83 c4 10             	add    $0x10,%esp
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2ee0:	83 ec 08             	sub    $0x8,%esp
    2ee3:	6a 00                	push   $0x0
    2ee5:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
    2eeb:	50                   	push   %eax
    2eec:	e8 eb 17 00 00       	call   46dc <open>
    2ef1:	83 c4 10             	add    $0x10,%esp
    2ef4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2ef7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2efb:	79 19                	jns    2f16 <fourteen+0x101>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    2efd:	83 ec 08             	sub    $0x8,%esp
    2f00:	8d 83 30 f0 ff ff    	lea    -0xfd0(%ebx),%eax
    2f06:	50                   	push   %eax
    2f07:	6a 01                	push   $0x1
    2f09:	e8 2a 19 00 00       	call   4838 <printf>
    2f0e:	83 c4 10             	add    $0x10,%esp
    exit();
    2f11:	e8 86 17 00 00       	call   469c <exit>
  }
  close(fd);
    2f16:	83 ec 0c             	sub    $0xc,%esp
    2f19:	ff 75 f4             	push   -0xc(%ebp)
    2f1c:	e8 a3 17 00 00       	call   46c4 <close>
    2f21:	83 c4 10             	add    $0x10,%esp

  if(mkdir("12345678901234/12345678901234") == 0){
    2f24:	83 ec 0c             	sub    $0xc,%esp
    2f27:	8d 83 6a f0 ff ff    	lea    -0xf96(%ebx),%eax
    2f2d:	50                   	push   %eax
    2f2e:	e8 d1 17 00 00       	call   4704 <mkdir>
    2f33:	83 c4 10             	add    $0x10,%esp
    2f36:	85 c0                	test   %eax,%eax
    2f38:	75 19                	jne    2f53 <fourteen+0x13e>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    2f3a:	83 ec 08             	sub    $0x8,%esp
    2f3d:	8d 83 88 f0 ff ff    	lea    -0xf78(%ebx),%eax
    2f43:	50                   	push   %eax
    2f44:	6a 01                	push   $0x1
    2f46:	e8 ed 18 00 00       	call   4838 <printf>
    2f4b:	83 c4 10             	add    $0x10,%esp
    exit();
    2f4e:	e8 49 17 00 00       	call   469c <exit>
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    2f53:	83 ec 0c             	sub    $0xc,%esp
    2f56:	8d 83 b8 f0 ff ff    	lea    -0xf48(%ebx),%eax
    2f5c:	50                   	push   %eax
    2f5d:	e8 a2 17 00 00       	call   4704 <mkdir>
    2f62:	83 c4 10             	add    $0x10,%esp
    2f65:	85 c0                	test   %eax,%eax
    2f67:	75 19                	jne    2f82 <fourteen+0x16d>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    2f69:	83 ec 08             	sub    $0x8,%esp
    2f6c:	8d 83 d8 f0 ff ff    	lea    -0xf28(%ebx),%eax
    2f72:	50                   	push   %eax
    2f73:	6a 01                	push   $0x1
    2f75:	e8 be 18 00 00       	call   4838 <printf>
    2f7a:	83 c4 10             	add    $0x10,%esp
    exit();
    2f7d:	e8 1a 17 00 00       	call   469c <exit>
  }

  printf(1, "fourteen ok\n");
    2f82:	83 ec 08             	sub    $0x8,%esp
    2f85:	8d 83 09 f1 ff ff    	lea    -0xef7(%ebx),%eax
    2f8b:	50                   	push   %eax
    2f8c:	6a 01                	push   $0x1
    2f8e:	e8 a5 18 00 00       	call   4838 <printf>
    2f93:	83 c4 10             	add    $0x10,%esp
}
    2f96:	90                   	nop
    2f97:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2f9a:	c9                   	leave  
    2f9b:	c3                   	ret    

00002f9c <rmdot>:

void
rmdot(void)
{
    2f9c:	55                   	push   %ebp
    2f9d:	89 e5                	mov    %esp,%ebp
    2f9f:	53                   	push   %ebx
    2fa0:	83 ec 04             	sub    $0x4,%esp
    2fa3:	e8 2b 14 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
    2fa8:	81 c3 c8 3c 00 00    	add    $0x3cc8,%ebx
  printf(1, "rmdot test\n");
    2fae:	83 ec 08             	sub    $0x8,%esp
    2fb1:	8d 83 16 f1 ff ff    	lea    -0xeea(%ebx),%eax
    2fb7:	50                   	push   %eax
    2fb8:	6a 01                	push   $0x1
    2fba:	e8 79 18 00 00       	call   4838 <printf>
    2fbf:	83 c4 10             	add    $0x10,%esp
  if(mkdir("dots") != 0){
    2fc2:	83 ec 0c             	sub    $0xc,%esp
    2fc5:	8d 83 22 f1 ff ff    	lea    -0xede(%ebx),%eax
    2fcb:	50                   	push   %eax
    2fcc:	e8 33 17 00 00       	call   4704 <mkdir>
    2fd1:	83 c4 10             	add    $0x10,%esp
    2fd4:	85 c0                	test   %eax,%eax
    2fd6:	74 19                	je     2ff1 <rmdot+0x55>
    printf(1, "mkdir dots failed\n");
    2fd8:	83 ec 08             	sub    $0x8,%esp
    2fdb:	8d 83 27 f1 ff ff    	lea    -0xed9(%ebx),%eax
    2fe1:	50                   	push   %eax
    2fe2:	6a 01                	push   $0x1
    2fe4:	e8 4f 18 00 00       	call   4838 <printf>
    2fe9:	83 c4 10             	add    $0x10,%esp
    exit();
    2fec:	e8 ab 16 00 00       	call   469c <exit>
  }
  if(chdir("dots") != 0){
    2ff1:	83 ec 0c             	sub    $0xc,%esp
    2ff4:	8d 83 22 f1 ff ff    	lea    -0xede(%ebx),%eax
    2ffa:	50                   	push   %eax
    2ffb:	e8 0c 17 00 00       	call   470c <chdir>
    3000:	83 c4 10             	add    $0x10,%esp
    3003:	85 c0                	test   %eax,%eax
    3005:	74 19                	je     3020 <rmdot+0x84>
    printf(1, "chdir dots failed\n");
    3007:	83 ec 08             	sub    $0x8,%esp
    300a:	8d 83 3a f1 ff ff    	lea    -0xec6(%ebx),%eax
    3010:	50                   	push   %eax
    3011:	6a 01                	push   $0x1
    3013:	e8 20 18 00 00       	call   4838 <printf>
    3018:	83 c4 10             	add    $0x10,%esp
    exit();
    301b:	e8 7c 16 00 00       	call   469c <exit>
  }
  if(unlink(".") == 0){
    3020:	83 ec 0c             	sub    $0xc,%esp
    3023:	8d 83 53 e8 ff ff    	lea    -0x17ad(%ebx),%eax
    3029:	50                   	push   %eax
    302a:	e8 bd 16 00 00       	call   46ec <unlink>
    302f:	83 c4 10             	add    $0x10,%esp
    3032:	85 c0                	test   %eax,%eax
    3034:	75 19                	jne    304f <rmdot+0xb3>
    printf(1, "rm . worked!\n");
    3036:	83 ec 08             	sub    $0x8,%esp
    3039:	8d 83 4d f1 ff ff    	lea    -0xeb3(%ebx),%eax
    303f:	50                   	push   %eax
    3040:	6a 01                	push   $0x1
    3042:	e8 f1 17 00 00       	call   4838 <printf>
    3047:	83 c4 10             	add    $0x10,%esp
    exit();
    304a:	e8 4d 16 00 00       	call   469c <exit>
  }
  if(unlink("..") == 0){
    304f:	83 ec 0c             	sub    $0xc,%esp
    3052:	8d 83 e6 e3 ff ff    	lea    -0x1c1a(%ebx),%eax
    3058:	50                   	push   %eax
    3059:	e8 8e 16 00 00       	call   46ec <unlink>
    305e:	83 c4 10             	add    $0x10,%esp
    3061:	85 c0                	test   %eax,%eax
    3063:	75 19                	jne    307e <rmdot+0xe2>
    printf(1, "rm .. worked!\n");
    3065:	83 ec 08             	sub    $0x8,%esp
    3068:	8d 83 5b f1 ff ff    	lea    -0xea5(%ebx),%eax
    306e:	50                   	push   %eax
    306f:	6a 01                	push   $0x1
    3071:	e8 c2 17 00 00       	call   4838 <printf>
    3076:	83 c4 10             	add    $0x10,%esp
    exit();
    3079:	e8 1e 16 00 00       	call   469c <exit>
  }
  if(chdir("/") != 0){
    307e:	83 ec 0c             	sub    $0xc,%esp
    3081:	8d 83 3a e0 ff ff    	lea    -0x1fc6(%ebx),%eax
    3087:	50                   	push   %eax
    3088:	e8 7f 16 00 00       	call   470c <chdir>
    308d:	83 c4 10             	add    $0x10,%esp
    3090:	85 c0                	test   %eax,%eax
    3092:	74 19                	je     30ad <rmdot+0x111>
    printf(1, "chdir / failed\n");
    3094:	83 ec 08             	sub    $0x8,%esp
    3097:	8d 83 3c e0 ff ff    	lea    -0x1fc4(%ebx),%eax
    309d:	50                   	push   %eax
    309e:	6a 01                	push   $0x1
    30a0:	e8 93 17 00 00       	call   4838 <printf>
    30a5:	83 c4 10             	add    $0x10,%esp
    exit();
    30a8:	e8 ef 15 00 00       	call   469c <exit>
  }
  if(unlink("dots/.") == 0){
    30ad:	83 ec 0c             	sub    $0xc,%esp
    30b0:	8d 83 6a f1 ff ff    	lea    -0xe96(%ebx),%eax
    30b6:	50                   	push   %eax
    30b7:	e8 30 16 00 00       	call   46ec <unlink>
    30bc:	83 c4 10             	add    $0x10,%esp
    30bf:	85 c0                	test   %eax,%eax
    30c1:	75 19                	jne    30dc <rmdot+0x140>
    printf(1, "unlink dots/. worked!\n");
    30c3:	83 ec 08             	sub    $0x8,%esp
    30c6:	8d 83 71 f1 ff ff    	lea    -0xe8f(%ebx),%eax
    30cc:	50                   	push   %eax
    30cd:	6a 01                	push   $0x1
    30cf:	e8 64 17 00 00       	call   4838 <printf>
    30d4:	83 c4 10             	add    $0x10,%esp
    exit();
    30d7:	e8 c0 15 00 00       	call   469c <exit>
  }
  if(unlink("dots/..") == 0){
    30dc:	83 ec 0c             	sub    $0xc,%esp
    30df:	8d 83 88 f1 ff ff    	lea    -0xe78(%ebx),%eax
    30e5:	50                   	push   %eax
    30e6:	e8 01 16 00 00       	call   46ec <unlink>
    30eb:	83 c4 10             	add    $0x10,%esp
    30ee:	85 c0                	test   %eax,%eax
    30f0:	75 19                	jne    310b <rmdot+0x16f>
    printf(1, "unlink dots/.. worked!\n");
    30f2:	83 ec 08             	sub    $0x8,%esp
    30f5:	8d 83 90 f1 ff ff    	lea    -0xe70(%ebx),%eax
    30fb:	50                   	push   %eax
    30fc:	6a 01                	push   $0x1
    30fe:	e8 35 17 00 00       	call   4838 <printf>
    3103:	83 c4 10             	add    $0x10,%esp
    exit();
    3106:	e8 91 15 00 00       	call   469c <exit>
  }
  if(unlink("dots") != 0){
    310b:	83 ec 0c             	sub    $0xc,%esp
    310e:	8d 83 22 f1 ff ff    	lea    -0xede(%ebx),%eax
    3114:	50                   	push   %eax
    3115:	e8 d2 15 00 00       	call   46ec <unlink>
    311a:	83 c4 10             	add    $0x10,%esp
    311d:	85 c0                	test   %eax,%eax
    311f:	74 19                	je     313a <rmdot+0x19e>
    printf(1, "unlink dots failed!\n");
    3121:	83 ec 08             	sub    $0x8,%esp
    3124:	8d 83 a8 f1 ff ff    	lea    -0xe58(%ebx),%eax
    312a:	50                   	push   %eax
    312b:	6a 01                	push   $0x1
    312d:	e8 06 17 00 00       	call   4838 <printf>
    3132:	83 c4 10             	add    $0x10,%esp
    exit();
    3135:	e8 62 15 00 00       	call   469c <exit>
  }
  printf(1, "rmdot ok\n");
    313a:	83 ec 08             	sub    $0x8,%esp
    313d:	8d 83 bd f1 ff ff    	lea    -0xe43(%ebx),%eax
    3143:	50                   	push   %eax
    3144:	6a 01                	push   $0x1
    3146:	e8 ed 16 00 00       	call   4838 <printf>
    314b:	83 c4 10             	add    $0x10,%esp
}
    314e:	90                   	nop
    314f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3152:	c9                   	leave  
    3153:	c3                   	ret    

00003154 <dirfile>:

void
dirfile(void)
{
    3154:	55                   	push   %ebp
    3155:	89 e5                	mov    %esp,%ebp
    3157:	53                   	push   %ebx
    3158:	83 ec 14             	sub    $0x14,%esp
    315b:	e8 73 12 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
    3160:	81 c3 10 3b 00 00    	add    $0x3b10,%ebx
  int fd;

  printf(1, "dir vs file\n");
    3166:	83 ec 08             	sub    $0x8,%esp
    3169:	8d 83 c7 f1 ff ff    	lea    -0xe39(%ebx),%eax
    316f:	50                   	push   %eax
    3170:	6a 01                	push   $0x1
    3172:	e8 c1 16 00 00       	call   4838 <printf>
    3177:	83 c4 10             	add    $0x10,%esp

  fd = open("dirfile", O_CREATE);
    317a:	83 ec 08             	sub    $0x8,%esp
    317d:	68 00 02 00 00       	push   $0x200
    3182:	8d 83 d4 f1 ff ff    	lea    -0xe2c(%ebx),%eax
    3188:	50                   	push   %eax
    3189:	e8 4e 15 00 00       	call   46dc <open>
    318e:	83 c4 10             	add    $0x10,%esp
    3191:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    3194:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3198:	79 19                	jns    31b3 <dirfile+0x5f>
    printf(1, "create dirfile failed\n");
    319a:	83 ec 08             	sub    $0x8,%esp
    319d:	8d 83 dc f1 ff ff    	lea    -0xe24(%ebx),%eax
    31a3:	50                   	push   %eax
    31a4:	6a 01                	push   $0x1
    31a6:	e8 8d 16 00 00       	call   4838 <printf>
    31ab:	83 c4 10             	add    $0x10,%esp
    exit();
    31ae:	e8 e9 14 00 00       	call   469c <exit>
  }
  close(fd);
    31b3:	83 ec 0c             	sub    $0xc,%esp
    31b6:	ff 75 f4             	push   -0xc(%ebp)
    31b9:	e8 06 15 00 00       	call   46c4 <close>
    31be:	83 c4 10             	add    $0x10,%esp
  if(chdir("dirfile") == 0){
    31c1:	83 ec 0c             	sub    $0xc,%esp
    31c4:	8d 83 d4 f1 ff ff    	lea    -0xe2c(%ebx),%eax
    31ca:	50                   	push   %eax
    31cb:	e8 3c 15 00 00       	call   470c <chdir>
    31d0:	83 c4 10             	add    $0x10,%esp
    31d3:	85 c0                	test   %eax,%eax
    31d5:	75 19                	jne    31f0 <dirfile+0x9c>
    printf(1, "chdir dirfile succeeded!\n");
    31d7:	83 ec 08             	sub    $0x8,%esp
    31da:	8d 83 f3 f1 ff ff    	lea    -0xe0d(%ebx),%eax
    31e0:	50                   	push   %eax
    31e1:	6a 01                	push   $0x1
    31e3:	e8 50 16 00 00       	call   4838 <printf>
    31e8:	83 c4 10             	add    $0x10,%esp
    exit();
    31eb:	e8 ac 14 00 00       	call   469c <exit>
  }
  fd = open("dirfile/xx", 0);
    31f0:	83 ec 08             	sub    $0x8,%esp
    31f3:	6a 00                	push   $0x0
    31f5:	8d 83 0d f2 ff ff    	lea    -0xdf3(%ebx),%eax
    31fb:	50                   	push   %eax
    31fc:	e8 db 14 00 00       	call   46dc <open>
    3201:	83 c4 10             	add    $0x10,%esp
    3204:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    3207:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    320b:	78 19                	js     3226 <dirfile+0xd2>
    printf(1, "create dirfile/xx succeeded!\n");
    320d:	83 ec 08             	sub    $0x8,%esp
    3210:	8d 83 18 f2 ff ff    	lea    -0xde8(%ebx),%eax
    3216:	50                   	push   %eax
    3217:	6a 01                	push   $0x1
    3219:	e8 1a 16 00 00       	call   4838 <printf>
    321e:	83 c4 10             	add    $0x10,%esp
    exit();
    3221:	e8 76 14 00 00       	call   469c <exit>
  }
  fd = open("dirfile/xx", O_CREATE);
    3226:	83 ec 08             	sub    $0x8,%esp
    3229:	68 00 02 00 00       	push   $0x200
    322e:	8d 83 0d f2 ff ff    	lea    -0xdf3(%ebx),%eax
    3234:	50                   	push   %eax
    3235:	e8 a2 14 00 00       	call   46dc <open>
    323a:	83 c4 10             	add    $0x10,%esp
    323d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    3240:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3244:	78 19                	js     325f <dirfile+0x10b>
    printf(1, "create dirfile/xx succeeded!\n");
    3246:	83 ec 08             	sub    $0x8,%esp
    3249:	8d 83 18 f2 ff ff    	lea    -0xde8(%ebx),%eax
    324f:	50                   	push   %eax
    3250:	6a 01                	push   $0x1
    3252:	e8 e1 15 00 00       	call   4838 <printf>
    3257:	83 c4 10             	add    $0x10,%esp
    exit();
    325a:	e8 3d 14 00 00       	call   469c <exit>
  }
  if(mkdir("dirfile/xx") == 0){
    325f:	83 ec 0c             	sub    $0xc,%esp
    3262:	8d 83 0d f2 ff ff    	lea    -0xdf3(%ebx),%eax
    3268:	50                   	push   %eax
    3269:	e8 96 14 00 00       	call   4704 <mkdir>
    326e:	83 c4 10             	add    $0x10,%esp
    3271:	85 c0                	test   %eax,%eax
    3273:	75 19                	jne    328e <dirfile+0x13a>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    3275:	83 ec 08             	sub    $0x8,%esp
    3278:	8d 83 36 f2 ff ff    	lea    -0xdca(%ebx),%eax
    327e:	50                   	push   %eax
    327f:	6a 01                	push   $0x1
    3281:	e8 b2 15 00 00       	call   4838 <printf>
    3286:	83 c4 10             	add    $0x10,%esp
    exit();
    3289:	e8 0e 14 00 00       	call   469c <exit>
  }
  if(unlink("dirfile/xx") == 0){
    328e:	83 ec 0c             	sub    $0xc,%esp
    3291:	8d 83 0d f2 ff ff    	lea    -0xdf3(%ebx),%eax
    3297:	50                   	push   %eax
    3298:	e8 4f 14 00 00       	call   46ec <unlink>
    329d:	83 c4 10             	add    $0x10,%esp
    32a0:	85 c0                	test   %eax,%eax
    32a2:	75 19                	jne    32bd <dirfile+0x169>
    printf(1, "unlink dirfile/xx succeeded!\n");
    32a4:	83 ec 08             	sub    $0x8,%esp
    32a7:	8d 83 53 f2 ff ff    	lea    -0xdad(%ebx),%eax
    32ad:	50                   	push   %eax
    32ae:	6a 01                	push   $0x1
    32b0:	e8 83 15 00 00       	call   4838 <printf>
    32b5:	83 c4 10             	add    $0x10,%esp
    exit();
    32b8:	e8 df 13 00 00       	call   469c <exit>
  }
  if(link("README", "dirfile/xx") == 0){
    32bd:	83 ec 08             	sub    $0x8,%esp
    32c0:	8d 83 0d f2 ff ff    	lea    -0xdf3(%ebx),%eax
    32c6:	50                   	push   %eax
    32c7:	8d 83 71 f2 ff ff    	lea    -0xd8f(%ebx),%eax
    32cd:	50                   	push   %eax
    32ce:	e8 29 14 00 00       	call   46fc <link>
    32d3:	83 c4 10             	add    $0x10,%esp
    32d6:	85 c0                	test   %eax,%eax
    32d8:	75 19                	jne    32f3 <dirfile+0x19f>
    printf(1, "link to dirfile/xx succeeded!\n");
    32da:	83 ec 08             	sub    $0x8,%esp
    32dd:	8d 83 78 f2 ff ff    	lea    -0xd88(%ebx),%eax
    32e3:	50                   	push   %eax
    32e4:	6a 01                	push   $0x1
    32e6:	e8 4d 15 00 00       	call   4838 <printf>
    32eb:	83 c4 10             	add    $0x10,%esp
    exit();
    32ee:	e8 a9 13 00 00       	call   469c <exit>
  }
  if(unlink("dirfile") != 0){
    32f3:	83 ec 0c             	sub    $0xc,%esp
    32f6:	8d 83 d4 f1 ff ff    	lea    -0xe2c(%ebx),%eax
    32fc:	50                   	push   %eax
    32fd:	e8 ea 13 00 00       	call   46ec <unlink>
    3302:	83 c4 10             	add    $0x10,%esp
    3305:	85 c0                	test   %eax,%eax
    3307:	74 19                	je     3322 <dirfile+0x1ce>
    printf(1, "unlink dirfile failed!\n");
    3309:	83 ec 08             	sub    $0x8,%esp
    330c:	8d 83 97 f2 ff ff    	lea    -0xd69(%ebx),%eax
    3312:	50                   	push   %eax
    3313:	6a 01                	push   $0x1
    3315:	e8 1e 15 00 00       	call   4838 <printf>
    331a:	83 c4 10             	add    $0x10,%esp
    exit();
    331d:	e8 7a 13 00 00       	call   469c <exit>
  }

  fd = open(".", O_RDWR);
    3322:	83 ec 08             	sub    $0x8,%esp
    3325:	6a 02                	push   $0x2
    3327:	8d 83 53 e8 ff ff    	lea    -0x17ad(%ebx),%eax
    332d:	50                   	push   %eax
    332e:	e8 a9 13 00 00       	call   46dc <open>
    3333:	83 c4 10             	add    $0x10,%esp
    3336:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    3339:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    333d:	78 19                	js     3358 <dirfile+0x204>
    printf(1, "open . for writing succeeded!\n");
    333f:	83 ec 08             	sub    $0x8,%esp
    3342:	8d 83 b0 f2 ff ff    	lea    -0xd50(%ebx),%eax
    3348:	50                   	push   %eax
    3349:	6a 01                	push   $0x1
    334b:	e8 e8 14 00 00       	call   4838 <printf>
    3350:	83 c4 10             	add    $0x10,%esp
    exit();
    3353:	e8 44 13 00 00       	call   469c <exit>
  }
  fd = open(".", 0);
    3358:	83 ec 08             	sub    $0x8,%esp
    335b:	6a 00                	push   $0x0
    335d:	8d 83 53 e8 ff ff    	lea    -0x17ad(%ebx),%eax
    3363:	50                   	push   %eax
    3364:	e8 73 13 00 00       	call   46dc <open>
    3369:	83 c4 10             	add    $0x10,%esp
    336c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(write(fd, "x", 1) > 0){
    336f:	83 ec 04             	sub    $0x4,%esp
    3372:	6a 01                	push   $0x1
    3374:	8d 83 9f e4 ff ff    	lea    -0x1b61(%ebx),%eax
    337a:	50                   	push   %eax
    337b:	ff 75 f4             	push   -0xc(%ebp)
    337e:	e8 39 13 00 00       	call   46bc <write>
    3383:	83 c4 10             	add    $0x10,%esp
    3386:	85 c0                	test   %eax,%eax
    3388:	7e 19                	jle    33a3 <dirfile+0x24f>
    printf(1, "write . succeeded!\n");
    338a:	83 ec 08             	sub    $0x8,%esp
    338d:	8d 83 cf f2 ff ff    	lea    -0xd31(%ebx),%eax
    3393:	50                   	push   %eax
    3394:	6a 01                	push   $0x1
    3396:	e8 9d 14 00 00       	call   4838 <printf>
    339b:	83 c4 10             	add    $0x10,%esp
    exit();
    339e:	e8 f9 12 00 00       	call   469c <exit>
  }
  close(fd);
    33a3:	83 ec 0c             	sub    $0xc,%esp
    33a6:	ff 75 f4             	push   -0xc(%ebp)
    33a9:	e8 16 13 00 00       	call   46c4 <close>
    33ae:	83 c4 10             	add    $0x10,%esp

  printf(1, "dir vs file OK\n");
    33b1:	83 ec 08             	sub    $0x8,%esp
    33b4:	8d 83 e3 f2 ff ff    	lea    -0xd1d(%ebx),%eax
    33ba:	50                   	push   %eax
    33bb:	6a 01                	push   $0x1
    33bd:	e8 76 14 00 00       	call   4838 <printf>
    33c2:	83 c4 10             	add    $0x10,%esp
}
    33c5:	90                   	nop
    33c6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    33c9:	c9                   	leave  
    33ca:	c3                   	ret    

000033cb <iref>:

// test that iput() is called at the end of _namei()
void
iref(void)
{
    33cb:	55                   	push   %ebp
    33cc:	89 e5                	mov    %esp,%ebp
    33ce:	53                   	push   %ebx
    33cf:	83 ec 14             	sub    $0x14,%esp
    33d2:	e8 fc 0f 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
    33d7:	81 c3 99 38 00 00    	add    $0x3899,%ebx
  int i, fd;

  printf(1, "empty file name\n");
    33dd:	83 ec 08             	sub    $0x8,%esp
    33e0:	8d 83 f3 f2 ff ff    	lea    -0xd0d(%ebx),%eax
    33e6:	50                   	push   %eax
    33e7:	6a 01                	push   $0x1
    33e9:	e8 4a 14 00 00       	call   4838 <printf>
    33ee:	83 c4 10             	add    $0x10,%esp

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    33f1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    33f8:	e9 fb 00 00 00       	jmp    34f8 <iref+0x12d>
    if(mkdir("irefd") != 0){
    33fd:	83 ec 0c             	sub    $0xc,%esp
    3400:	8d 83 04 f3 ff ff    	lea    -0xcfc(%ebx),%eax
    3406:	50                   	push   %eax
    3407:	e8 f8 12 00 00       	call   4704 <mkdir>
    340c:	83 c4 10             	add    $0x10,%esp
    340f:	85 c0                	test   %eax,%eax
    3411:	74 19                	je     342c <iref+0x61>
      printf(1, "mkdir irefd failed\n");
    3413:	83 ec 08             	sub    $0x8,%esp
    3416:	8d 83 0a f3 ff ff    	lea    -0xcf6(%ebx),%eax
    341c:	50                   	push   %eax
    341d:	6a 01                	push   $0x1
    341f:	e8 14 14 00 00       	call   4838 <printf>
    3424:	83 c4 10             	add    $0x10,%esp
      exit();
    3427:	e8 70 12 00 00       	call   469c <exit>
    }
    if(chdir("irefd") != 0){
    342c:	83 ec 0c             	sub    $0xc,%esp
    342f:	8d 83 04 f3 ff ff    	lea    -0xcfc(%ebx),%eax
    3435:	50                   	push   %eax
    3436:	e8 d1 12 00 00       	call   470c <chdir>
    343b:	83 c4 10             	add    $0x10,%esp
    343e:	85 c0                	test   %eax,%eax
    3440:	74 19                	je     345b <iref+0x90>
      printf(1, "chdir irefd failed\n");
    3442:	83 ec 08             	sub    $0x8,%esp
    3445:	8d 83 1e f3 ff ff    	lea    -0xce2(%ebx),%eax
    344b:	50                   	push   %eax
    344c:	6a 01                	push   $0x1
    344e:	e8 e5 13 00 00       	call   4838 <printf>
    3453:	83 c4 10             	add    $0x10,%esp
      exit();
    3456:	e8 41 12 00 00       	call   469c <exit>
    }

    mkdir("");
    345b:	83 ec 0c             	sub    $0xc,%esp
    345e:	8d 83 32 f3 ff ff    	lea    -0xcce(%ebx),%eax
    3464:	50                   	push   %eax
    3465:	e8 9a 12 00 00       	call   4704 <mkdir>
    346a:	83 c4 10             	add    $0x10,%esp
    link("README", "");
    346d:	83 ec 08             	sub    $0x8,%esp
    3470:	8d 83 32 f3 ff ff    	lea    -0xcce(%ebx),%eax
    3476:	50                   	push   %eax
    3477:	8d 83 71 f2 ff ff    	lea    -0xd8f(%ebx),%eax
    347d:	50                   	push   %eax
    347e:	e8 79 12 00 00       	call   46fc <link>
    3483:	83 c4 10             	add    $0x10,%esp
    fd = open("", O_CREATE);
    3486:	83 ec 08             	sub    $0x8,%esp
    3489:	68 00 02 00 00       	push   $0x200
    348e:	8d 83 32 f3 ff ff    	lea    -0xcce(%ebx),%eax
    3494:	50                   	push   %eax
    3495:	e8 42 12 00 00       	call   46dc <open>
    349a:	83 c4 10             	add    $0x10,%esp
    349d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0)
    34a0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    34a4:	78 0e                	js     34b4 <iref+0xe9>
      close(fd);
    34a6:	83 ec 0c             	sub    $0xc,%esp
    34a9:	ff 75 f0             	push   -0x10(%ebp)
    34ac:	e8 13 12 00 00       	call   46c4 <close>
    34b1:	83 c4 10             	add    $0x10,%esp
    fd = open("xx", O_CREATE);
    34b4:	83 ec 08             	sub    $0x8,%esp
    34b7:	68 00 02 00 00       	push   $0x200
    34bc:	8d 83 33 f3 ff ff    	lea    -0xccd(%ebx),%eax
    34c2:	50                   	push   %eax
    34c3:	e8 14 12 00 00       	call   46dc <open>
    34c8:	83 c4 10             	add    $0x10,%esp
    34cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0)
    34ce:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    34d2:	78 0e                	js     34e2 <iref+0x117>
      close(fd);
    34d4:	83 ec 0c             	sub    $0xc,%esp
    34d7:	ff 75 f0             	push   -0x10(%ebp)
    34da:	e8 e5 11 00 00       	call   46c4 <close>
    34df:	83 c4 10             	add    $0x10,%esp
    unlink("xx");
    34e2:	83 ec 0c             	sub    $0xc,%esp
    34e5:	8d 83 33 f3 ff ff    	lea    -0xccd(%ebx),%eax
    34eb:	50                   	push   %eax
    34ec:	e8 fb 11 00 00       	call   46ec <unlink>
    34f1:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 50 + 1; i++){
    34f4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    34f8:	83 7d f4 32          	cmpl   $0x32,-0xc(%ebp)
    34fc:	0f 8e fb fe ff ff    	jle    33fd <iref+0x32>
  }

  chdir("/");
    3502:	83 ec 0c             	sub    $0xc,%esp
    3505:	8d 83 3a e0 ff ff    	lea    -0x1fc6(%ebx),%eax
    350b:	50                   	push   %eax
    350c:	e8 fb 11 00 00       	call   470c <chdir>
    3511:	83 c4 10             	add    $0x10,%esp
  printf(1, "empty file name OK\n");
    3514:	83 ec 08             	sub    $0x8,%esp
    3517:	8d 83 36 f3 ff ff    	lea    -0xcca(%ebx),%eax
    351d:	50                   	push   %eax
    351e:	6a 01                	push   $0x1
    3520:	e8 13 13 00 00       	call   4838 <printf>
    3525:	83 c4 10             	add    $0x10,%esp
}
    3528:	90                   	nop
    3529:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    352c:	c9                   	leave  
    352d:	c3                   	ret    

0000352e <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    352e:	55                   	push   %ebp
    352f:	89 e5                	mov    %esp,%ebp
    3531:	53                   	push   %ebx
    3532:	83 ec 14             	sub    $0x14,%esp
    3535:	e8 99 0e 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
    353a:	81 c3 36 37 00 00    	add    $0x3736,%ebx
  int n, pid;

  printf(1, "fork test\n");
    3540:	83 ec 08             	sub    $0x8,%esp
    3543:	8d 83 4a f3 ff ff    	lea    -0xcb6(%ebx),%eax
    3549:	50                   	push   %eax
    354a:	6a 01                	push   $0x1
    354c:	e8 e7 12 00 00       	call   4838 <printf>
    3551:	83 c4 10             	add    $0x10,%esp

  for(n=0; n<1000; n++){
    3554:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    355b:	eb 1d                	jmp    357a <forktest+0x4c>
    pid = fork();
    355d:	e8 32 11 00 00       	call   4694 <fork>
    3562:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0)
    3565:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3569:	78 1a                	js     3585 <forktest+0x57>
      break;
    if(pid == 0)
    356b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    356f:	75 05                	jne    3576 <forktest+0x48>
      exit();
    3571:	e8 26 11 00 00       	call   469c <exit>
  for(n=0; n<1000; n++){
    3576:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    357a:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
    3581:	7e da                	jle    355d <forktest+0x2f>
    3583:	eb 01                	jmp    3586 <forktest+0x58>
      break;
    3585:	90                   	nop
  }

  if(n == 1000){
    3586:	81 7d f4 e8 03 00 00 	cmpl   $0x3e8,-0xc(%ebp)
    358d:	75 3f                	jne    35ce <forktest+0xa0>
    printf(1, "fork claimed to work 1000 times!\n");
    358f:	83 ec 08             	sub    $0x8,%esp
    3592:	8d 83 58 f3 ff ff    	lea    -0xca8(%ebx),%eax
    3598:	50                   	push   %eax
    3599:	6a 01                	push   $0x1
    359b:	e8 98 12 00 00       	call   4838 <printf>
    35a0:	83 c4 10             	add    $0x10,%esp
    exit();
    35a3:	e8 f4 10 00 00       	call   469c <exit>
  }

  for(; n > 0; n--){
    if(wait() < 0){
    35a8:	e8 f7 10 00 00       	call   46a4 <wait>
    35ad:	85 c0                	test   %eax,%eax
    35af:	79 19                	jns    35ca <forktest+0x9c>
      printf(1, "wait stopped early\n");
    35b1:	83 ec 08             	sub    $0x8,%esp
    35b4:	8d 83 7a f3 ff ff    	lea    -0xc86(%ebx),%eax
    35ba:	50                   	push   %eax
    35bb:	6a 01                	push   $0x1
    35bd:	e8 76 12 00 00       	call   4838 <printf>
    35c2:	83 c4 10             	add    $0x10,%esp
      exit();
    35c5:	e8 d2 10 00 00       	call   469c <exit>
  for(; n > 0; n--){
    35ca:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    35ce:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    35d2:	7f d4                	jg     35a8 <forktest+0x7a>
    }
  }

  if(wait() != -1){
    35d4:	e8 cb 10 00 00       	call   46a4 <wait>
    35d9:	83 f8 ff             	cmp    $0xffffffff,%eax
    35dc:	74 19                	je     35f7 <forktest+0xc9>
    printf(1, "wait got too many\n");
    35de:	83 ec 08             	sub    $0x8,%esp
    35e1:	8d 83 8e f3 ff ff    	lea    -0xc72(%ebx),%eax
    35e7:	50                   	push   %eax
    35e8:	6a 01                	push   $0x1
    35ea:	e8 49 12 00 00       	call   4838 <printf>
    35ef:	83 c4 10             	add    $0x10,%esp
    exit();
    35f2:	e8 a5 10 00 00       	call   469c <exit>
  }

  printf(1, "fork test OK\n");
    35f7:	83 ec 08             	sub    $0x8,%esp
    35fa:	8d 83 a1 f3 ff ff    	lea    -0xc5f(%ebx),%eax
    3600:	50                   	push   %eax
    3601:	6a 01                	push   $0x1
    3603:	e8 30 12 00 00       	call   4838 <printf>
    3608:	83 c4 10             	add    $0x10,%esp
}
    360b:	90                   	nop
    360c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    360f:	c9                   	leave  
    3610:	c3                   	ret    

00003611 <sbrktest>:

void
sbrktest(void)
{
    3611:	55                   	push   %ebp
    3612:	89 e5                	mov    %esp,%ebp
    3614:	53                   	push   %ebx
    3615:	83 ec 64             	sub    $0x64,%esp
    3618:	e8 b6 0d 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
    361d:	81 c3 53 36 00 00    	add    $0x3653,%ebx
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
    3623:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
    3629:	83 ec 08             	sub    $0x8,%esp
    362c:	8d 93 af f3 ff ff    	lea    -0xc51(%ebx),%edx
    3632:	52                   	push   %edx
    3633:	50                   	push   %eax
    3634:	e8 ff 11 00 00       	call   4838 <printf>
    3639:	83 c4 10             	add    $0x10,%esp
  oldbrk = sbrk(0);
    363c:	83 ec 0c             	sub    $0xc,%esp
    363f:	6a 00                	push   $0x0
    3641:	e8 de 10 00 00       	call   4724 <sbrk>
    3646:	83 c4 10             	add    $0x10,%esp
    3649:	89 45 ec             	mov    %eax,-0x14(%ebp)

  // can one sbrk() less than a page?
  a = sbrk(0);
    364c:	83 ec 0c             	sub    $0xc,%esp
    364f:	6a 00                	push   $0x0
    3651:	e8 ce 10 00 00       	call   4724 <sbrk>
    3656:	83 c4 10             	add    $0x10,%esp
    3659:	89 45 f4             	mov    %eax,-0xc(%ebp)
  int i;
  for(i = 0; i < 5000; i++){
    365c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3663:	eb 52                	jmp    36b7 <sbrktest+0xa6>
    b = sbrk(1);
    3665:	83 ec 0c             	sub    $0xc,%esp
    3668:	6a 01                	push   $0x1
    366a:	e8 b5 10 00 00       	call   4724 <sbrk>
    366f:	83 c4 10             	add    $0x10,%esp
    3672:	89 45 d0             	mov    %eax,-0x30(%ebp)
    if(b != a){
    3675:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3678:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    367b:	74 27                	je     36a4 <sbrktest+0x93>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    367d:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
    3683:	83 ec 0c             	sub    $0xc,%esp
    3686:	ff 75 d0             	push   -0x30(%ebp)
    3689:	ff 75 f4             	push   -0xc(%ebp)
    368c:	ff 75 f0             	push   -0x10(%ebp)
    368f:	8d 93 ba f3 ff ff    	lea    -0xc46(%ebx),%edx
    3695:	52                   	push   %edx
    3696:	50                   	push   %eax
    3697:	e8 9c 11 00 00       	call   4838 <printf>
    369c:	83 c4 20             	add    $0x20,%esp
      exit();
    369f:	e8 f8 0f 00 00       	call   469c <exit>
    }
    *b = 1;
    36a4:	8b 45 d0             	mov    -0x30(%ebp),%eax
    36a7:	c6 00 01             	movb   $0x1,(%eax)
    a = b + 1;
    36aa:	8b 45 d0             	mov    -0x30(%ebp),%eax
    36ad:	83 c0 01             	add    $0x1,%eax
    36b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; i < 5000; i++){
    36b3:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    36b7:	81 7d f0 87 13 00 00 	cmpl   $0x1387,-0x10(%ebp)
    36be:	7e a5                	jle    3665 <sbrktest+0x54>
  }
  pid = fork();
    36c0:	e8 cf 0f 00 00       	call   4694 <fork>
    36c5:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(pid < 0){
    36c8:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    36cc:	79 1e                	jns    36ec <sbrktest+0xdb>
    printf(stdout, "sbrk test fork failed\n");
    36ce:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
    36d4:	83 ec 08             	sub    $0x8,%esp
    36d7:	8d 93 d5 f3 ff ff    	lea    -0xc2b(%ebx),%edx
    36dd:	52                   	push   %edx
    36de:	50                   	push   %eax
    36df:	e8 54 11 00 00       	call   4838 <printf>
    36e4:	83 c4 10             	add    $0x10,%esp
    exit();
    36e7:	e8 b0 0f 00 00       	call   469c <exit>
  }
  c = sbrk(1);
    36ec:	83 ec 0c             	sub    $0xc,%esp
    36ef:	6a 01                	push   $0x1
    36f1:	e8 2e 10 00 00       	call   4724 <sbrk>
    36f6:	83 c4 10             	add    $0x10,%esp
    36f9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  c = sbrk(1);
    36fc:	83 ec 0c             	sub    $0xc,%esp
    36ff:	6a 01                	push   $0x1
    3701:	e8 1e 10 00 00       	call   4724 <sbrk>
    3706:	83 c4 10             	add    $0x10,%esp
    3709:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(c != a + 1){
    370c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    370f:	83 c0 01             	add    $0x1,%eax
    3712:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
    3715:	74 1e                	je     3735 <sbrktest+0x124>
    printf(stdout, "sbrk test failed post-fork\n");
    3717:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
    371d:	83 ec 08             	sub    $0x8,%esp
    3720:	8d 93 ec f3 ff ff    	lea    -0xc14(%ebx),%edx
    3726:	52                   	push   %edx
    3727:	50                   	push   %eax
    3728:	e8 0b 11 00 00       	call   4838 <printf>
    372d:	83 c4 10             	add    $0x10,%esp
    exit();
    3730:	e8 67 0f 00 00       	call   469c <exit>
  }
  if(pid == 0)
    3735:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    3739:	75 05                	jne    3740 <sbrktest+0x12f>
    exit();
    373b:	e8 5c 0f 00 00       	call   469c <exit>
  wait();
    3740:	e8 5f 0f 00 00       	call   46a4 <wait>

  // can one grow address space to something big?
#define BIG (100*1024*1024)
  a = sbrk(0);
    3745:	83 ec 0c             	sub    $0xc,%esp
    3748:	6a 00                	push   $0x0
    374a:	e8 d5 0f 00 00       	call   4724 <sbrk>
    374f:	83 c4 10             	add    $0x10,%esp
    3752:	89 45 f4             	mov    %eax,-0xc(%ebp)
  amt = (BIG) - (uint)a;
    3755:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3758:	b8 00 00 40 06       	mov    $0x6400000,%eax
    375d:	29 d0                	sub    %edx,%eax
    375f:	89 45 e0             	mov    %eax,-0x20(%ebp)
  p = sbrk(amt);
    3762:	8b 45 e0             	mov    -0x20(%ebp),%eax
    3765:	83 ec 0c             	sub    $0xc,%esp
    3768:	50                   	push   %eax
    3769:	e8 b6 0f 00 00       	call   4724 <sbrk>
    376e:	83 c4 10             	add    $0x10,%esp
    3771:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if (p != a) {
    3774:	8b 45 dc             	mov    -0x24(%ebp),%eax
    3777:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    377a:	74 1e                	je     379a <sbrktest+0x189>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    377c:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
    3782:	83 ec 08             	sub    $0x8,%esp
    3785:	8d 93 08 f4 ff ff    	lea    -0xbf8(%ebx),%edx
    378b:	52                   	push   %edx
    378c:	50                   	push   %eax
    378d:	e8 a6 10 00 00       	call   4838 <printf>
    3792:	83 c4 10             	add    $0x10,%esp
    exit();
    3795:	e8 02 0f 00 00       	call   469c <exit>
  }
  lastaddr = (char*) (BIG-1);
    379a:	c7 45 d8 ff ff 3f 06 	movl   $0x63fffff,-0x28(%ebp)
  *lastaddr = 99;
    37a1:	8b 45 d8             	mov    -0x28(%ebp),%eax
    37a4:	c6 00 63             	movb   $0x63,(%eax)

  // can one de-allocate?
  a = sbrk(0);
    37a7:	83 ec 0c             	sub    $0xc,%esp
    37aa:	6a 00                	push   $0x0
    37ac:	e8 73 0f 00 00       	call   4724 <sbrk>
    37b1:	83 c4 10             	add    $0x10,%esp
    37b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(-4096);
    37b7:	83 ec 0c             	sub    $0xc,%esp
    37ba:	68 00 f0 ff ff       	push   $0xfffff000
    37bf:	e8 60 0f 00 00       	call   4724 <sbrk>
    37c4:	83 c4 10             	add    $0x10,%esp
    37c7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(c == (char*)0xffffffff){
    37ca:	83 7d e4 ff          	cmpl   $0xffffffff,-0x1c(%ebp)
    37ce:	75 1e                	jne    37ee <sbrktest+0x1dd>
    printf(stdout, "sbrk could not deallocate\n");
    37d0:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
    37d6:	83 ec 08             	sub    $0x8,%esp
    37d9:	8d 93 46 f4 ff ff    	lea    -0xbba(%ebx),%edx
    37df:	52                   	push   %edx
    37e0:	50                   	push   %eax
    37e1:	e8 52 10 00 00       	call   4838 <printf>
    37e6:	83 c4 10             	add    $0x10,%esp
    exit();
    37e9:	e8 ae 0e 00 00       	call   469c <exit>
  }
  c = sbrk(0);
    37ee:	83 ec 0c             	sub    $0xc,%esp
    37f1:	6a 00                	push   $0x0
    37f3:	e8 2c 0f 00 00       	call   4724 <sbrk>
    37f8:	83 c4 10             	add    $0x10,%esp
    37fb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(c != a - 4096){
    37fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3801:	2d 00 10 00 00       	sub    $0x1000,%eax
    3806:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
    3809:	74 21                	je     382c <sbrktest+0x21b>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    380b:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
    3811:	ff 75 e4             	push   -0x1c(%ebp)
    3814:	ff 75 f4             	push   -0xc(%ebp)
    3817:	8d 93 64 f4 ff ff    	lea    -0xb9c(%ebx),%edx
    381d:	52                   	push   %edx
    381e:	50                   	push   %eax
    381f:	e8 14 10 00 00       	call   4838 <printf>
    3824:	83 c4 10             	add    $0x10,%esp
    exit();
    3827:	e8 70 0e 00 00       	call   469c <exit>
  }

  // can one re-allocate that page?
  a = sbrk(0);
    382c:	83 ec 0c             	sub    $0xc,%esp
    382f:	6a 00                	push   $0x0
    3831:	e8 ee 0e 00 00       	call   4724 <sbrk>
    3836:	83 c4 10             	add    $0x10,%esp
    3839:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(4096);
    383c:	83 ec 0c             	sub    $0xc,%esp
    383f:	68 00 10 00 00       	push   $0x1000
    3844:	e8 db 0e 00 00       	call   4724 <sbrk>
    3849:	83 c4 10             	add    $0x10,%esp
    384c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(c != a || sbrk(0) != a + 4096){
    384f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3852:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    3855:	75 1a                	jne    3871 <sbrktest+0x260>
    3857:	83 ec 0c             	sub    $0xc,%esp
    385a:	6a 00                	push   $0x0
    385c:	e8 c3 0e 00 00       	call   4724 <sbrk>
    3861:	83 c4 10             	add    $0x10,%esp
    3864:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3867:	81 c2 00 10 00 00    	add    $0x1000,%edx
    386d:	39 d0                	cmp    %edx,%eax
    386f:	74 21                	je     3892 <sbrktest+0x281>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    3871:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
    3877:	ff 75 e4             	push   -0x1c(%ebp)
    387a:	ff 75 f4             	push   -0xc(%ebp)
    387d:	8d 93 9c f4 ff ff    	lea    -0xb64(%ebx),%edx
    3883:	52                   	push   %edx
    3884:	50                   	push   %eax
    3885:	e8 ae 0f 00 00       	call   4838 <printf>
    388a:	83 c4 10             	add    $0x10,%esp
    exit();
    388d:	e8 0a 0e 00 00       	call   469c <exit>
  }
  if(*lastaddr == 99){
    3892:	8b 45 d8             	mov    -0x28(%ebp),%eax
    3895:	0f b6 00             	movzbl (%eax),%eax
    3898:	3c 63                	cmp    $0x63,%al
    389a:	75 1e                	jne    38ba <sbrktest+0x2a9>
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    389c:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
    38a2:	83 ec 08             	sub    $0x8,%esp
    38a5:	8d 93 c4 f4 ff ff    	lea    -0xb3c(%ebx),%edx
    38ab:	52                   	push   %edx
    38ac:	50                   	push   %eax
    38ad:	e8 86 0f 00 00       	call   4838 <printf>
    38b2:	83 c4 10             	add    $0x10,%esp
    exit();
    38b5:	e8 e2 0d 00 00       	call   469c <exit>
  }

  a = sbrk(0);
    38ba:	83 ec 0c             	sub    $0xc,%esp
    38bd:	6a 00                	push   $0x0
    38bf:	e8 60 0e 00 00       	call   4724 <sbrk>
    38c4:	83 c4 10             	add    $0x10,%esp
    38c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(-(sbrk(0) - oldbrk));
    38ca:	83 ec 0c             	sub    $0xc,%esp
    38cd:	6a 00                	push   $0x0
    38cf:	e8 50 0e 00 00       	call   4724 <sbrk>
    38d4:	83 c4 10             	add    $0x10,%esp
    38d7:	89 c2                	mov    %eax,%edx
    38d9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    38dc:	29 d0                	sub    %edx,%eax
    38de:	83 ec 0c             	sub    $0xc,%esp
    38e1:	50                   	push   %eax
    38e2:	e8 3d 0e 00 00       	call   4724 <sbrk>
    38e7:	83 c4 10             	add    $0x10,%esp
    38ea:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(c != a){
    38ed:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    38f0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    38f3:	74 21                	je     3916 <sbrktest+0x305>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    38f5:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
    38fb:	ff 75 e4             	push   -0x1c(%ebp)
    38fe:	ff 75 f4             	push   -0xc(%ebp)
    3901:	8d 93 f4 f4 ff ff    	lea    -0xb0c(%ebx),%edx
    3907:	52                   	push   %edx
    3908:	50                   	push   %eax
    3909:	e8 2a 0f 00 00       	call   4838 <printf>
    390e:	83 c4 10             	add    $0x10,%esp
    exit();
    3911:	e8 86 0d 00 00       	call   469c <exit>
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    3916:	c7 45 f4 00 00 00 80 	movl   $0x80000000,-0xc(%ebp)
    391d:	eb 7c                	jmp    399b <sbrktest+0x38a>
    ppid = getpid();
    391f:	e8 f8 0d 00 00       	call   471c <getpid>
    3924:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    pid = fork();
    3927:	e8 68 0d 00 00       	call   4694 <fork>
    392c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pid < 0){
    392f:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    3933:	79 1e                	jns    3953 <sbrktest+0x342>
      printf(stdout, "fork failed\n");
    3935:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
    393b:	83 ec 08             	sub    $0x8,%esp
    393e:	8d 93 69 e0 ff ff    	lea    -0x1f97(%ebx),%edx
    3944:	52                   	push   %edx
    3945:	50                   	push   %eax
    3946:	e8 ed 0e 00 00       	call   4838 <printf>
    394b:	83 c4 10             	add    $0x10,%esp
      exit();
    394e:	e8 49 0d 00 00       	call   469c <exit>
    }
    if(pid == 0){
    3953:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    3957:	75 36                	jne    398f <sbrktest+0x37e>
      printf(stdout, "oops could read %x = %x\n", a, *a);
    3959:	8b 45 f4             	mov    -0xc(%ebp),%eax
    395c:	0f b6 00             	movzbl (%eax),%eax
    395f:	0f be d0             	movsbl %al,%edx
    3962:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
    3968:	52                   	push   %edx
    3969:	ff 75 f4             	push   -0xc(%ebp)
    396c:	8d 93 15 f5 ff ff    	lea    -0xaeb(%ebx),%edx
    3972:	52                   	push   %edx
    3973:	50                   	push   %eax
    3974:	e8 bf 0e 00 00       	call   4838 <printf>
    3979:	83 c4 10             	add    $0x10,%esp
      kill(ppid);
    397c:	83 ec 0c             	sub    $0xc,%esp
    397f:	ff 75 d4             	push   -0x2c(%ebp)
    3982:	e8 45 0d 00 00       	call   46cc <kill>
    3987:	83 c4 10             	add    $0x10,%esp
      exit();
    398a:	e8 0d 0d 00 00       	call   469c <exit>
    }
    wait();
    398f:	e8 10 0d 00 00       	call   46a4 <wait>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    3994:	81 45 f4 50 c3 00 00 	addl   $0xc350,-0xc(%ebp)
    399b:	81 7d f4 7f 84 1e 80 	cmpl   $0x801e847f,-0xc(%ebp)
    39a2:	0f 86 77 ff ff ff    	jbe    391f <sbrktest+0x30e>
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    39a8:	83 ec 0c             	sub    $0xc,%esp
    39ab:	8d 45 c8             	lea    -0x38(%ebp),%eax
    39ae:	50                   	push   %eax
    39af:	e8 f8 0c 00 00       	call   46ac <pipe>
    39b4:	83 c4 10             	add    $0x10,%esp
    39b7:	85 c0                	test   %eax,%eax
    39b9:	74 19                	je     39d4 <sbrktest+0x3c3>
    printf(1, "pipe() failed\n");
    39bb:	83 ec 08             	sub    $0x8,%esp
    39be:	8d 83 3a e4 ff ff    	lea    -0x1bc6(%ebx),%eax
    39c4:	50                   	push   %eax
    39c5:	6a 01                	push   $0x1
    39c7:	e8 6c 0e 00 00       	call   4838 <printf>
    39cc:	83 c4 10             	add    $0x10,%esp
    exit();
    39cf:	e8 c8 0c 00 00       	call   469c <exit>
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    39d4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    39db:	e9 88 00 00 00       	jmp    3a68 <sbrktest+0x457>
    if((pids[i] = fork()) == 0){
    39e0:	e8 af 0c 00 00       	call   4694 <fork>
    39e5:	8b 55 f0             	mov    -0x10(%ebp),%edx
    39e8:	89 44 95 a0          	mov    %eax,-0x60(%ebp,%edx,4)
    39ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
    39ef:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    39f3:	85 c0                	test   %eax,%eax
    39f5:	75 4c                	jne    3a43 <sbrktest+0x432>
      // allocate a lot of memory
      sbrk(BIG - (uint)sbrk(0));
    39f7:	83 ec 0c             	sub    $0xc,%esp
    39fa:	6a 00                	push   $0x0
    39fc:	e8 23 0d 00 00       	call   4724 <sbrk>
    3a01:	83 c4 10             	add    $0x10,%esp
    3a04:	89 c2                	mov    %eax,%edx
    3a06:	b8 00 00 40 06       	mov    $0x6400000,%eax
    3a0b:	29 d0                	sub    %edx,%eax
    3a0d:	83 ec 0c             	sub    $0xc,%esp
    3a10:	50                   	push   %eax
    3a11:	e8 0e 0d 00 00       	call   4724 <sbrk>
    3a16:	83 c4 10             	add    $0x10,%esp
      write(fds[1], "x", 1);
    3a19:	8b 45 cc             	mov    -0x34(%ebp),%eax
    3a1c:	83 ec 04             	sub    $0x4,%esp
    3a1f:	6a 01                	push   $0x1
    3a21:	8d 93 9f e4 ff ff    	lea    -0x1b61(%ebx),%edx
    3a27:	52                   	push   %edx
    3a28:	50                   	push   %eax
    3a29:	e8 8e 0c 00 00       	call   46bc <write>
    3a2e:	83 c4 10             	add    $0x10,%esp
      // sit around until killed
      for(;;) sleep(1000);
    3a31:	83 ec 0c             	sub    $0xc,%esp
    3a34:	68 e8 03 00 00       	push   $0x3e8
    3a39:	e8 ee 0c 00 00       	call   472c <sleep>
    3a3e:	83 c4 10             	add    $0x10,%esp
    3a41:	eb ee                	jmp    3a31 <sbrktest+0x420>
    }
    if(pids[i] != -1)
    3a43:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3a46:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    3a4a:	83 f8 ff             	cmp    $0xffffffff,%eax
    3a4d:	74 15                	je     3a64 <sbrktest+0x453>
      read(fds[0], &scratch, 1);
    3a4f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3a52:	83 ec 04             	sub    $0x4,%esp
    3a55:	6a 01                	push   $0x1
    3a57:	8d 55 9f             	lea    -0x61(%ebp),%edx
    3a5a:	52                   	push   %edx
    3a5b:	50                   	push   %eax
    3a5c:	e8 53 0c 00 00       	call   46b4 <read>
    3a61:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3a64:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    3a68:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3a6b:	83 f8 09             	cmp    $0x9,%eax
    3a6e:	0f 86 6c ff ff ff    	jbe    39e0 <sbrktest+0x3cf>
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
    3a74:	83 ec 0c             	sub    $0xc,%esp
    3a77:	68 00 10 00 00       	push   $0x1000
    3a7c:	e8 a3 0c 00 00       	call   4724 <sbrk>
    3a81:	83 c4 10             	add    $0x10,%esp
    3a84:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3a87:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3a8e:	eb 2b                	jmp    3abb <sbrktest+0x4aa>
    if(pids[i] == -1)
    3a90:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3a93:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    3a97:	83 f8 ff             	cmp    $0xffffffff,%eax
    3a9a:	74 1a                	je     3ab6 <sbrktest+0x4a5>
      continue;
    kill(pids[i]);
    3a9c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3a9f:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    3aa3:	83 ec 0c             	sub    $0xc,%esp
    3aa6:	50                   	push   %eax
    3aa7:	e8 20 0c 00 00       	call   46cc <kill>
    3aac:	83 c4 10             	add    $0x10,%esp
    wait();
    3aaf:	e8 f0 0b 00 00       	call   46a4 <wait>
    3ab4:	eb 01                	jmp    3ab7 <sbrktest+0x4a6>
      continue;
    3ab6:	90                   	nop
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3ab7:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    3abb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3abe:	83 f8 09             	cmp    $0x9,%eax
    3ac1:	76 cd                	jbe    3a90 <sbrktest+0x47f>
  }
  if(c == (char*)0xffffffff){
    3ac3:	83 7d e4 ff          	cmpl   $0xffffffff,-0x1c(%ebp)
    3ac7:	75 1e                	jne    3ae7 <sbrktest+0x4d6>
    printf(stdout, "failed sbrk leaked memory\n");
    3ac9:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
    3acf:	83 ec 08             	sub    $0x8,%esp
    3ad2:	8d 93 2e f5 ff ff    	lea    -0xad2(%ebx),%edx
    3ad8:	52                   	push   %edx
    3ad9:	50                   	push   %eax
    3ada:	e8 59 0d 00 00       	call   4838 <printf>
    3adf:	83 c4 10             	add    $0x10,%esp
    exit();
    3ae2:	e8 b5 0b 00 00       	call   469c <exit>
  }

  if(sbrk(0) > oldbrk)
    3ae7:	83 ec 0c             	sub    $0xc,%esp
    3aea:	6a 00                	push   $0x0
    3aec:	e8 33 0c 00 00       	call   4724 <sbrk>
    3af1:	83 c4 10             	add    $0x10,%esp
    3af4:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    3af7:	73 20                	jae    3b19 <sbrktest+0x508>
    sbrk(-(sbrk(0) - oldbrk));
    3af9:	83 ec 0c             	sub    $0xc,%esp
    3afc:	6a 00                	push   $0x0
    3afe:	e8 21 0c 00 00       	call   4724 <sbrk>
    3b03:	83 c4 10             	add    $0x10,%esp
    3b06:	89 c2                	mov    %eax,%edx
    3b08:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3b0b:	29 d0                	sub    %edx,%eax
    3b0d:	83 ec 0c             	sub    $0xc,%esp
    3b10:	50                   	push   %eax
    3b11:	e8 0e 0c 00 00       	call   4724 <sbrk>
    3b16:	83 c4 10             	add    $0x10,%esp

  printf(stdout, "sbrk test OK\n");
    3b19:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
    3b1f:	83 ec 08             	sub    $0x8,%esp
    3b22:	8d 93 49 f5 ff ff    	lea    -0xab7(%ebx),%edx
    3b28:	52                   	push   %edx
    3b29:	50                   	push   %eax
    3b2a:	e8 09 0d 00 00       	call   4838 <printf>
    3b2f:	83 c4 10             	add    $0x10,%esp
}
    3b32:	90                   	nop
    3b33:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3b36:	c9                   	leave  
    3b37:	c3                   	ret    

00003b38 <validateint>:

void
validateint(int *p)
{
    3b38:	55                   	push   %ebp
    3b39:	89 e5                	mov    %esp,%ebp
    3b3b:	53                   	push   %ebx
    3b3c:	83 ec 10             	sub    $0x10,%esp
    3b3f:	e8 8b 08 00 00       	call   43cf <__x86.get_pc_thunk.ax>
    3b44:	05 2c 31 00 00       	add    $0x312c,%eax
  int res;
  asm("mov %%esp, %%ebx\n\t"
    3b49:	b8 0d 00 00 00       	mov    $0xd,%eax
    3b4e:	8b 55 08             	mov    0x8(%ebp),%edx
    3b51:	89 d1                	mov    %edx,%ecx
    3b53:	89 e3                	mov    %esp,%ebx
    3b55:	89 cc                	mov    %ecx,%esp
    3b57:	cd 40                	int    $0x40
    3b59:	89 dc                	mov    %ebx,%esp
    3b5b:	89 45 f8             	mov    %eax,-0x8(%ebp)
      "int %2\n\t"
      "mov %%ebx, %%esp" :
      "=a" (res) :
      "a" (SYS_sleep), "n" (T_SYSCALL), "c" (p) :
      "ebx");
}
    3b5e:	90                   	nop
    3b5f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3b62:	c9                   	leave  
    3b63:	c3                   	ret    

00003b64 <validatetest>:

void
validatetest(void)
{
    3b64:	55                   	push   %ebp
    3b65:	89 e5                	mov    %esp,%ebp
    3b67:	53                   	push   %ebx
    3b68:	83 ec 14             	sub    $0x14,%esp
    3b6b:	e8 63 08 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
    3b70:	81 c3 00 31 00 00    	add    $0x3100,%ebx
  int hi, pid;
  uint p;

  printf(stdout, "validate test\n");
    3b76:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
    3b7c:	83 ec 08             	sub    $0x8,%esp
    3b7f:	8d 93 57 f5 ff ff    	lea    -0xaa9(%ebx),%edx
    3b85:	52                   	push   %edx
    3b86:	50                   	push   %eax
    3b87:	e8 ac 0c 00 00       	call   4838 <printf>
    3b8c:	83 c4 10             	add    $0x10,%esp
  hi = 1100*1024;
    3b8f:	c7 45 f0 00 30 11 00 	movl   $0x113000,-0x10(%ebp)

  for(p = 0; p <= (uint)hi; p += 4096){
    3b96:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3b9d:	e9 8f 00 00 00       	jmp    3c31 <validatetest+0xcd>
    if((pid = fork()) == 0){
    3ba2:	e8 ed 0a 00 00       	call   4694 <fork>
    3ba7:	89 45 ec             	mov    %eax,-0x14(%ebp)
    3baa:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3bae:	75 14                	jne    3bc4 <validatetest+0x60>
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
    3bb0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3bb3:	83 ec 0c             	sub    $0xc,%esp
    3bb6:	50                   	push   %eax
    3bb7:	e8 7c ff ff ff       	call   3b38 <validateint>
    3bbc:	83 c4 10             	add    $0x10,%esp
      exit();
    3bbf:	e8 d8 0a 00 00       	call   469c <exit>
    }
    sleep(0);
    3bc4:	83 ec 0c             	sub    $0xc,%esp
    3bc7:	6a 00                	push   $0x0
    3bc9:	e8 5e 0b 00 00       	call   472c <sleep>
    3bce:	83 c4 10             	add    $0x10,%esp
    sleep(0);
    3bd1:	83 ec 0c             	sub    $0xc,%esp
    3bd4:	6a 00                	push   $0x0
    3bd6:	e8 51 0b 00 00       	call   472c <sleep>
    3bdb:	83 c4 10             	add    $0x10,%esp
    kill(pid);
    3bde:	83 ec 0c             	sub    $0xc,%esp
    3be1:	ff 75 ec             	push   -0x14(%ebp)
    3be4:	e8 e3 0a 00 00       	call   46cc <kill>
    3be9:	83 c4 10             	add    $0x10,%esp
    wait();
    3bec:	e8 b3 0a 00 00       	call   46a4 <wait>

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    3bf1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3bf4:	83 ec 08             	sub    $0x8,%esp
    3bf7:	50                   	push   %eax
    3bf8:	8d 83 66 f5 ff ff    	lea    -0xa9a(%ebx),%eax
    3bfe:	50                   	push   %eax
    3bff:	e8 f8 0a 00 00       	call   46fc <link>
    3c04:	83 c4 10             	add    $0x10,%esp
    3c07:	83 f8 ff             	cmp    $0xffffffff,%eax
    3c0a:	74 1e                	je     3c2a <validatetest+0xc6>
      printf(stdout, "link should not succeed\n");
    3c0c:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
    3c12:	83 ec 08             	sub    $0x8,%esp
    3c15:	8d 93 71 f5 ff ff    	lea    -0xa8f(%ebx),%edx
    3c1b:	52                   	push   %edx
    3c1c:	50                   	push   %eax
    3c1d:	e8 16 0c 00 00       	call   4838 <printf>
    3c22:	83 c4 10             	add    $0x10,%esp
      exit();
    3c25:	e8 72 0a 00 00       	call   469c <exit>
  for(p = 0; p <= (uint)hi; p += 4096){
    3c2a:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    3c31:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3c34:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    3c37:	0f 86 65 ff ff ff    	jbe    3ba2 <validatetest+0x3e>
    }
  }

  printf(stdout, "validate ok\n");
    3c3d:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
    3c43:	83 ec 08             	sub    $0x8,%esp
    3c46:	8d 93 8a f5 ff ff    	lea    -0xa76(%ebx),%edx
    3c4c:	52                   	push   %edx
    3c4d:	50                   	push   %eax
    3c4e:	e8 e5 0b 00 00       	call   4838 <printf>
    3c53:	83 c4 10             	add    $0x10,%esp
}
    3c56:	90                   	nop
    3c57:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3c5a:	c9                   	leave  
    3c5b:	c3                   	ret    

00003c5c <bsstest>:

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(void)
{
    3c5c:	55                   	push   %ebp
    3c5d:	89 e5                	mov    %esp,%ebp
    3c5f:	53                   	push   %ebx
    3c60:	83 ec 14             	sub    $0x14,%esp
    3c63:	e8 6b 07 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
    3c68:	81 c3 08 30 00 00    	add    $0x3008,%ebx
  int i;

  printf(stdout, "bss test\n");
    3c6e:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
    3c74:	83 ec 08             	sub    $0x8,%esp
    3c77:	8d 93 97 f5 ff ff    	lea    -0xa69(%ebx),%edx
    3c7d:	52                   	push   %edx
    3c7e:	50                   	push   %eax
    3c7f:	e8 b4 0b 00 00       	call   4838 <printf>
    3c84:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(uninit); i++){
    3c87:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3c8e:	eb 34                	jmp    3cc4 <bsstest+0x68>
    if(uninit[i] != '\0'){
    3c90:	8d 93 70 20 00 00    	lea    0x2070(%ebx),%edx
    3c96:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3c99:	01 d0                	add    %edx,%eax
    3c9b:	0f b6 00             	movzbl (%eax),%eax
    3c9e:	84 c0                	test   %al,%al
    3ca0:	74 1e                	je     3cc0 <bsstest+0x64>
      printf(stdout, "bss test failed\n");
    3ca2:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
    3ca8:	83 ec 08             	sub    $0x8,%esp
    3cab:	8d 93 a1 f5 ff ff    	lea    -0xa5f(%ebx),%edx
    3cb1:	52                   	push   %edx
    3cb2:	50                   	push   %eax
    3cb3:	e8 80 0b 00 00       	call   4838 <printf>
    3cb8:	83 c4 10             	add    $0x10,%esp
      exit();
    3cbb:	e8 dc 09 00 00       	call   469c <exit>
  for(i = 0; i < sizeof(uninit); i++){
    3cc0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    3cc4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3cc7:	3d 0f 27 00 00       	cmp    $0x270f,%eax
    3ccc:	76 c2                	jbe    3c90 <bsstest+0x34>
    }
  }
  printf(stdout, "bss test ok\n");
    3cce:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
    3cd4:	83 ec 08             	sub    $0x8,%esp
    3cd7:	8d 93 b2 f5 ff ff    	lea    -0xa4e(%ebx),%edx
    3cdd:	52                   	push   %edx
    3cde:	50                   	push   %eax
    3cdf:	e8 54 0b 00 00       	call   4838 <printf>
    3ce4:	83 c4 10             	add    $0x10,%esp
}
    3ce7:	90                   	nop
    3ce8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3ceb:	c9                   	leave  
    3cec:	c3                   	ret    

00003ced <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(void)
{
    3ced:	55                   	push   %ebp
    3cee:	89 e5                	mov    %esp,%ebp
    3cf0:	53                   	push   %ebx
    3cf1:	83 ec 14             	sub    $0x14,%esp
    3cf4:	e8 da 06 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
    3cf9:	81 c3 77 2f 00 00    	add    $0x2f77,%ebx
  int pid, fd;

  unlink("bigarg-ok");
    3cff:	83 ec 0c             	sub    $0xc,%esp
    3d02:	8d 83 bf f5 ff ff    	lea    -0xa41(%ebx),%eax
    3d08:	50                   	push   %eax
    3d09:	e8 de 09 00 00       	call   46ec <unlink>
    3d0e:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    3d11:	e8 7e 09 00 00       	call   4694 <fork>
    3d16:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid == 0){
    3d19:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3d1d:	0f 85 a5 00 00 00    	jne    3dc8 <bigargtest+0xdb>
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    3d23:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3d2a:	eb 14                	jmp    3d40 <bigargtest+0x53>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    3d2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3d2f:	8d 93 cc f5 ff ff    	lea    -0xa34(%ebx),%edx
    3d35:	89 94 83 90 47 00 00 	mov    %edx,0x4790(%ebx,%eax,4)
    for(i = 0; i < MAXARG-1; i++)
    3d3c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    3d40:	83 7d f4 1e          	cmpl   $0x1e,-0xc(%ebp)
    3d44:	7e e6                	jle    3d2c <bigargtest+0x3f>
    args[MAXARG-1] = 0;
    3d46:	c7 83 0c 48 00 00 00 	movl   $0x0,0x480c(%ebx)
    3d4d:	00 00 00 
    printf(stdout, "bigarg test\n");
    3d50:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
    3d56:	83 ec 08             	sub    $0x8,%esp
    3d59:	8d 93 a9 f6 ff ff    	lea    -0x957(%ebx),%edx
    3d5f:	52                   	push   %edx
    3d60:	50                   	push   %eax
    3d61:	e8 d2 0a 00 00       	call   4838 <printf>
    3d66:	83 c4 10             	add    $0x10,%esp
    exec("echo", args);
    3d69:	83 ec 08             	sub    $0x8,%esp
    3d6c:	8d 83 90 47 00 00    	lea    0x4790(%ebx),%eax
    3d72:	50                   	push   %eax
    3d73:	8d 83 c8 df ff ff    	lea    -0x2038(%ebx),%eax
    3d79:	50                   	push   %eax
    3d7a:	e8 55 09 00 00       	call   46d4 <exec>
    3d7f:	83 c4 10             	add    $0x10,%esp
    printf(stdout, "bigarg test ok\n");
    3d82:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
    3d88:	83 ec 08             	sub    $0x8,%esp
    3d8b:	8d 93 b6 f6 ff ff    	lea    -0x94a(%ebx),%edx
    3d91:	52                   	push   %edx
    3d92:	50                   	push   %eax
    3d93:	e8 a0 0a 00 00       	call   4838 <printf>
    3d98:	83 c4 10             	add    $0x10,%esp
    fd = open("bigarg-ok", O_CREATE);
    3d9b:	83 ec 08             	sub    $0x8,%esp
    3d9e:	68 00 02 00 00       	push   $0x200
    3da3:	8d 83 bf f5 ff ff    	lea    -0xa41(%ebx),%eax
    3da9:	50                   	push   %eax
    3daa:	e8 2d 09 00 00       	call   46dc <open>
    3daf:	83 c4 10             	add    $0x10,%esp
    3db2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    close(fd);
    3db5:	83 ec 0c             	sub    $0xc,%esp
    3db8:	ff 75 ec             	push   -0x14(%ebp)
    3dbb:	e8 04 09 00 00       	call   46c4 <close>
    3dc0:	83 c4 10             	add    $0x10,%esp
    exit();
    3dc3:	e8 d4 08 00 00       	call   469c <exit>
  } else if(pid < 0){
    3dc8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3dcc:	79 1e                	jns    3dec <bigargtest+0xff>
    printf(stdout, "bigargtest: fork failed\n");
    3dce:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
    3dd4:	83 ec 08             	sub    $0x8,%esp
    3dd7:	8d 93 c6 f6 ff ff    	lea    -0x93a(%ebx),%edx
    3ddd:	52                   	push   %edx
    3dde:	50                   	push   %eax
    3ddf:	e8 54 0a 00 00       	call   4838 <printf>
    3de4:	83 c4 10             	add    $0x10,%esp
    exit();
    3de7:	e8 b0 08 00 00       	call   469c <exit>
  }
  wait();
    3dec:	e8 b3 08 00 00       	call   46a4 <wait>
  fd = open("bigarg-ok", 0);
    3df1:	83 ec 08             	sub    $0x8,%esp
    3df4:	6a 00                	push   $0x0
    3df6:	8d 83 bf f5 ff ff    	lea    -0xa41(%ebx),%eax
    3dfc:	50                   	push   %eax
    3dfd:	e8 da 08 00 00       	call   46dc <open>
    3e02:	83 c4 10             	add    $0x10,%esp
    3e05:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    3e08:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3e0c:	79 1e                	jns    3e2c <bigargtest+0x13f>
    printf(stdout, "bigarg test failed!\n");
    3e0e:	8b 83 0c 00 00 00    	mov    0xc(%ebx),%eax
    3e14:	83 ec 08             	sub    $0x8,%esp
    3e17:	8d 93 df f6 ff ff    	lea    -0x921(%ebx),%edx
    3e1d:	52                   	push   %edx
    3e1e:	50                   	push   %eax
    3e1f:	e8 14 0a 00 00       	call   4838 <printf>
    3e24:	83 c4 10             	add    $0x10,%esp
    exit();
    3e27:	e8 70 08 00 00       	call   469c <exit>
  }
  close(fd);
    3e2c:	83 ec 0c             	sub    $0xc,%esp
    3e2f:	ff 75 ec             	push   -0x14(%ebp)
    3e32:	e8 8d 08 00 00       	call   46c4 <close>
    3e37:	83 c4 10             	add    $0x10,%esp
  unlink("bigarg-ok");
    3e3a:	83 ec 0c             	sub    $0xc,%esp
    3e3d:	8d 83 bf f5 ff ff    	lea    -0xa41(%ebx),%eax
    3e43:	50                   	push   %eax
    3e44:	e8 a3 08 00 00       	call   46ec <unlink>
    3e49:	83 c4 10             	add    $0x10,%esp
}
    3e4c:	90                   	nop
    3e4d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3e50:	c9                   	leave  
    3e51:	c3                   	ret    

00003e52 <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    3e52:	55                   	push   %ebp
    3e53:	89 e5                	mov    %esp,%ebp
    3e55:	56                   	push   %esi
    3e56:	53                   	push   %ebx
    3e57:	83 ec 60             	sub    $0x60,%esp
    3e5a:	e8 74 05 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
    3e5f:	81 c3 11 2e 00 00    	add    $0x2e11,%ebx
  int nfiles;
  int fsblocks = 0;
    3e65:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

  printf(1, "fsfull test\n");
    3e6c:	83 ec 08             	sub    $0x8,%esp
    3e6f:	8d 83 f4 f6 ff ff    	lea    -0x90c(%ebx),%eax
    3e75:	50                   	push   %eax
    3e76:	6a 01                	push   $0x1
    3e78:	e8 bb 09 00 00       	call   4838 <printf>
    3e7d:	83 c4 10             	add    $0x10,%esp

  for(nfiles = 0; ; nfiles++){
    3e80:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    char name[64];
    name[0] = 'f';
    3e87:	c6 45 a4 66          	movb   $0x66,-0x5c(%ebp)
    name[1] = '0' + nfiles / 1000;
    3e8b:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3e8e:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    3e93:	89 c8                	mov    %ecx,%eax
    3e95:	f7 ea                	imul   %edx
    3e97:	89 d0                	mov    %edx,%eax
    3e99:	c1 f8 06             	sar    $0x6,%eax
    3e9c:	c1 f9 1f             	sar    $0x1f,%ecx
    3e9f:	89 ca                	mov    %ecx,%edx
    3ea1:	29 d0                	sub    %edx,%eax
    3ea3:	83 c0 30             	add    $0x30,%eax
    3ea6:	88 45 a5             	mov    %al,-0x5b(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3ea9:	8b 75 f4             	mov    -0xc(%ebp),%esi
    3eac:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    3eb1:	89 f0                	mov    %esi,%eax
    3eb3:	f7 ea                	imul   %edx
    3eb5:	89 d0                	mov    %edx,%eax
    3eb7:	c1 f8 06             	sar    $0x6,%eax
    3eba:	89 f2                	mov    %esi,%edx
    3ebc:	c1 fa 1f             	sar    $0x1f,%edx
    3ebf:	29 d0                	sub    %edx,%eax
    3ec1:	89 c1                	mov    %eax,%ecx
    3ec3:	69 c1 e8 03 00 00    	imul   $0x3e8,%ecx,%eax
    3ec9:	29 c6                	sub    %eax,%esi
    3ecb:	89 f1                	mov    %esi,%ecx
    3ecd:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    3ed2:	89 c8                	mov    %ecx,%eax
    3ed4:	f7 ea                	imul   %edx
    3ed6:	89 d0                	mov    %edx,%eax
    3ed8:	c1 f8 05             	sar    $0x5,%eax
    3edb:	c1 f9 1f             	sar    $0x1f,%ecx
    3ede:	89 ca                	mov    %ecx,%edx
    3ee0:	29 d0                	sub    %edx,%eax
    3ee2:	83 c0 30             	add    $0x30,%eax
    3ee5:	88 45 a6             	mov    %al,-0x5a(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3ee8:	8b 75 f4             	mov    -0xc(%ebp),%esi
    3eeb:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    3ef0:	89 f0                	mov    %esi,%eax
    3ef2:	f7 ea                	imul   %edx
    3ef4:	89 d0                	mov    %edx,%eax
    3ef6:	c1 f8 05             	sar    $0x5,%eax
    3ef9:	89 f2                	mov    %esi,%edx
    3efb:	c1 fa 1f             	sar    $0x1f,%edx
    3efe:	29 d0                	sub    %edx,%eax
    3f00:	89 c1                	mov    %eax,%ecx
    3f02:	6b c1 64             	imul   $0x64,%ecx,%eax
    3f05:	29 c6                	sub    %eax,%esi
    3f07:	89 f1                	mov    %esi,%ecx
    3f09:	ba 67 66 66 66       	mov    $0x66666667,%edx
    3f0e:	89 c8                	mov    %ecx,%eax
    3f10:	f7 ea                	imul   %edx
    3f12:	89 d0                	mov    %edx,%eax
    3f14:	c1 f8 02             	sar    $0x2,%eax
    3f17:	c1 f9 1f             	sar    $0x1f,%ecx
    3f1a:	89 ca                	mov    %ecx,%edx
    3f1c:	29 d0                	sub    %edx,%eax
    3f1e:	83 c0 30             	add    $0x30,%eax
    3f21:	88 45 a7             	mov    %al,-0x59(%ebp)
    name[4] = '0' + (nfiles % 10);
    3f24:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3f27:	ba 67 66 66 66       	mov    $0x66666667,%edx
    3f2c:	89 c8                	mov    %ecx,%eax
    3f2e:	f7 ea                	imul   %edx
    3f30:	89 d0                	mov    %edx,%eax
    3f32:	c1 f8 02             	sar    $0x2,%eax
    3f35:	89 ce                	mov    %ecx,%esi
    3f37:	c1 fe 1f             	sar    $0x1f,%esi
    3f3a:	29 f0                	sub    %esi,%eax
    3f3c:	89 c2                	mov    %eax,%edx
    3f3e:	89 d0                	mov    %edx,%eax
    3f40:	c1 e0 02             	shl    $0x2,%eax
    3f43:	01 d0                	add    %edx,%eax
    3f45:	01 c0                	add    %eax,%eax
    3f47:	29 c1                	sub    %eax,%ecx
    3f49:	89 ca                	mov    %ecx,%edx
    3f4b:	89 d0                	mov    %edx,%eax
    3f4d:	83 c0 30             	add    $0x30,%eax
    3f50:	88 45 a8             	mov    %al,-0x58(%ebp)
    name[5] = '\0';
    3f53:	c6 45 a9 00          	movb   $0x0,-0x57(%ebp)
    printf(1, "writing %s\n", name);
    3f57:	83 ec 04             	sub    $0x4,%esp
    3f5a:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3f5d:	50                   	push   %eax
    3f5e:	8d 83 01 f7 ff ff    	lea    -0x8ff(%ebx),%eax
    3f64:	50                   	push   %eax
    3f65:	6a 01                	push   $0x1
    3f67:	e8 cc 08 00 00       	call   4838 <printf>
    3f6c:	83 c4 10             	add    $0x10,%esp
    int fd = open(name, O_CREATE|O_RDWR);
    3f6f:	83 ec 08             	sub    $0x8,%esp
    3f72:	68 02 02 00 00       	push   $0x202
    3f77:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3f7a:	50                   	push   %eax
    3f7b:	e8 5c 07 00 00       	call   46dc <open>
    3f80:	83 c4 10             	add    $0x10,%esp
    3f83:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(fd < 0){
    3f86:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    3f8a:	79 1a                	jns    3fa6 <fsfull+0x154>
      printf(1, "open %s failed\n", name);
    3f8c:	83 ec 04             	sub    $0x4,%esp
    3f8f:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3f92:	50                   	push   %eax
    3f93:	8d 83 0d f7 ff ff    	lea    -0x8f3(%ebx),%eax
    3f99:	50                   	push   %eax
    3f9a:	6a 01                	push   $0x1
    3f9c:	e8 97 08 00 00       	call   4838 <printf>
    3fa1:	83 c4 10             	add    $0x10,%esp
      break;
    3fa4:	eb 6f                	jmp    4015 <fsfull+0x1c3>
    }
    int total = 0;
    3fa6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    while(1){
      int cc = write(fd, buf, 512);
    3fad:	83 ec 04             	sub    $0x4,%esp
    3fb0:	68 00 02 00 00       	push   $0x200
    3fb5:	8d 83 50 00 00 00    	lea    0x50(%ebx),%eax
    3fbb:	50                   	push   %eax
    3fbc:	ff 75 e8             	push   -0x18(%ebp)
    3fbf:	e8 f8 06 00 00       	call   46bc <write>
    3fc4:	83 c4 10             	add    $0x10,%esp
    3fc7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      if(cc < 512)
    3fca:	81 7d e4 ff 01 00 00 	cmpl   $0x1ff,-0x1c(%ebp)
    3fd1:	7e 0c                	jle    3fdf <fsfull+0x18d>
        break;
      total += cc;
    3fd3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3fd6:	01 45 ec             	add    %eax,-0x14(%ebp)
      fsblocks++;
    3fd9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    while(1){
    3fdd:	eb ce                	jmp    3fad <fsfull+0x15b>
        break;
    3fdf:	90                   	nop
    }
    printf(1, "wrote %d bytes\n", total);
    3fe0:	83 ec 04             	sub    $0x4,%esp
    3fe3:	ff 75 ec             	push   -0x14(%ebp)
    3fe6:	8d 83 1d f7 ff ff    	lea    -0x8e3(%ebx),%eax
    3fec:	50                   	push   %eax
    3fed:	6a 01                	push   $0x1
    3fef:	e8 44 08 00 00       	call   4838 <printf>
    3ff4:	83 c4 10             	add    $0x10,%esp
    close(fd);
    3ff7:	83 ec 0c             	sub    $0xc,%esp
    3ffa:	ff 75 e8             	push   -0x18(%ebp)
    3ffd:	e8 c2 06 00 00       	call   46c4 <close>
    4002:	83 c4 10             	add    $0x10,%esp
    if(total == 0)
    4005:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    4009:	74 09                	je     4014 <fsfull+0x1c2>
  for(nfiles = 0; ; nfiles++){
    400b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    400f:	e9 73 fe ff ff       	jmp    3e87 <fsfull+0x35>
      break;
    4014:	90                   	nop
  }

  while(nfiles >= 0){
    4015:	e9 e3 00 00 00       	jmp    40fd <fsfull+0x2ab>
    char name[64];
    name[0] = 'f';
    401a:	c6 45 a4 66          	movb   $0x66,-0x5c(%ebp)
    name[1] = '0' + nfiles / 1000;
    401e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    4021:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    4026:	89 c8                	mov    %ecx,%eax
    4028:	f7 ea                	imul   %edx
    402a:	89 d0                	mov    %edx,%eax
    402c:	c1 f8 06             	sar    $0x6,%eax
    402f:	c1 f9 1f             	sar    $0x1f,%ecx
    4032:	89 ca                	mov    %ecx,%edx
    4034:	29 d0                	sub    %edx,%eax
    4036:	83 c0 30             	add    $0x30,%eax
    4039:	88 45 a5             	mov    %al,-0x5b(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    403c:	8b 75 f4             	mov    -0xc(%ebp),%esi
    403f:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    4044:	89 f0                	mov    %esi,%eax
    4046:	f7 ea                	imul   %edx
    4048:	89 d0                	mov    %edx,%eax
    404a:	c1 f8 06             	sar    $0x6,%eax
    404d:	89 f2                	mov    %esi,%edx
    404f:	c1 fa 1f             	sar    $0x1f,%edx
    4052:	29 d0                	sub    %edx,%eax
    4054:	89 c1                	mov    %eax,%ecx
    4056:	69 c1 e8 03 00 00    	imul   $0x3e8,%ecx,%eax
    405c:	29 c6                	sub    %eax,%esi
    405e:	89 f1                	mov    %esi,%ecx
    4060:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    4065:	89 c8                	mov    %ecx,%eax
    4067:	f7 ea                	imul   %edx
    4069:	89 d0                	mov    %edx,%eax
    406b:	c1 f8 05             	sar    $0x5,%eax
    406e:	c1 f9 1f             	sar    $0x1f,%ecx
    4071:	89 ca                	mov    %ecx,%edx
    4073:	29 d0                	sub    %edx,%eax
    4075:	83 c0 30             	add    $0x30,%eax
    4078:	88 45 a6             	mov    %al,-0x5a(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    407b:	8b 75 f4             	mov    -0xc(%ebp),%esi
    407e:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    4083:	89 f0                	mov    %esi,%eax
    4085:	f7 ea                	imul   %edx
    4087:	89 d0                	mov    %edx,%eax
    4089:	c1 f8 05             	sar    $0x5,%eax
    408c:	89 f2                	mov    %esi,%edx
    408e:	c1 fa 1f             	sar    $0x1f,%edx
    4091:	29 d0                	sub    %edx,%eax
    4093:	89 c1                	mov    %eax,%ecx
    4095:	6b c1 64             	imul   $0x64,%ecx,%eax
    4098:	29 c6                	sub    %eax,%esi
    409a:	89 f1                	mov    %esi,%ecx
    409c:	ba 67 66 66 66       	mov    $0x66666667,%edx
    40a1:	89 c8                	mov    %ecx,%eax
    40a3:	f7 ea                	imul   %edx
    40a5:	89 d0                	mov    %edx,%eax
    40a7:	c1 f8 02             	sar    $0x2,%eax
    40aa:	c1 f9 1f             	sar    $0x1f,%ecx
    40ad:	89 ca                	mov    %ecx,%edx
    40af:	29 d0                	sub    %edx,%eax
    40b1:	83 c0 30             	add    $0x30,%eax
    40b4:	88 45 a7             	mov    %al,-0x59(%ebp)
    name[4] = '0' + (nfiles % 10);
    40b7:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    40ba:	ba 67 66 66 66       	mov    $0x66666667,%edx
    40bf:	89 c8                	mov    %ecx,%eax
    40c1:	f7 ea                	imul   %edx
    40c3:	89 d0                	mov    %edx,%eax
    40c5:	c1 f8 02             	sar    $0x2,%eax
    40c8:	89 ce                	mov    %ecx,%esi
    40ca:	c1 fe 1f             	sar    $0x1f,%esi
    40cd:	29 f0                	sub    %esi,%eax
    40cf:	89 c2                	mov    %eax,%edx
    40d1:	89 d0                	mov    %edx,%eax
    40d3:	c1 e0 02             	shl    $0x2,%eax
    40d6:	01 d0                	add    %edx,%eax
    40d8:	01 c0                	add    %eax,%eax
    40da:	29 c1                	sub    %eax,%ecx
    40dc:	89 ca                	mov    %ecx,%edx
    40de:	89 d0                	mov    %edx,%eax
    40e0:	83 c0 30             	add    $0x30,%eax
    40e3:	88 45 a8             	mov    %al,-0x58(%ebp)
    name[5] = '\0';
    40e6:	c6 45 a9 00          	movb   $0x0,-0x57(%ebp)
    unlink(name);
    40ea:	83 ec 0c             	sub    $0xc,%esp
    40ed:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    40f0:	50                   	push   %eax
    40f1:	e8 f6 05 00 00       	call   46ec <unlink>
    40f6:	83 c4 10             	add    $0x10,%esp
    nfiles--;
    40f9:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  while(nfiles >= 0){
    40fd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    4101:	0f 89 13 ff ff ff    	jns    401a <fsfull+0x1c8>
  }

  printf(1, "fsfull test finished\n");
    4107:	83 ec 08             	sub    $0x8,%esp
    410a:	8d 83 2d f7 ff ff    	lea    -0x8d3(%ebx),%eax
    4110:	50                   	push   %eax
    4111:	6a 01                	push   $0x1
    4113:	e8 20 07 00 00       	call   4838 <printf>
    4118:	83 c4 10             	add    $0x10,%esp
}
    411b:	90                   	nop
    411c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    411f:	5b                   	pop    %ebx
    4120:	5e                   	pop    %esi
    4121:	5d                   	pop    %ebp
    4122:	c3                   	ret    

00004123 <uio>:

void
uio()
{
    4123:	55                   	push   %ebp
    4124:	89 e5                	mov    %esp,%ebp
    4126:	53                   	push   %ebx
    4127:	83 ec 14             	sub    $0x14,%esp
    412a:	e8 a4 02 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
    412f:	81 c3 41 2b 00 00    	add    $0x2b41,%ebx
  #define RTC_ADDR 0x70
  #define RTC_DATA 0x71

  ushort port = 0;
    4135:	66 c7 45 f6 00 00    	movw   $0x0,-0xa(%ebp)
  uchar val = 0;
    413b:	c6 45 f5 00          	movb   $0x0,-0xb(%ebp)
  int pid;

  printf(1, "uio test\n");
    413f:	83 ec 08             	sub    $0x8,%esp
    4142:	8d 83 43 f7 ff ff    	lea    -0x8bd(%ebx),%eax
    4148:	50                   	push   %eax
    4149:	6a 01                	push   $0x1
    414b:	e8 e8 06 00 00       	call   4838 <printf>
    4150:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    4153:	e8 3c 05 00 00       	call   4694 <fork>
    4158:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid == 0){
    415b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    415f:	75 3c                	jne    419d <uio+0x7a>
    port = RTC_ADDR;
    4161:	66 c7 45 f6 70 00    	movw   $0x70,-0xa(%ebp)
    val = 0x09;  /* year */
    4167:	c6 45 f5 09          	movb   $0x9,-0xb(%ebp)
    /* http://wiki.osdev.org/Inline_Assembly/Examples */
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    416b:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    416f:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
    4173:	ee                   	out    %al,(%dx)
    port = RTC_DATA;
    4174:	66 c7 45 f6 71 00    	movw   $0x71,-0xa(%ebp)
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    417a:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
    417e:	89 c2                	mov    %eax,%edx
    4180:	ec                   	in     (%dx),%al
    4181:	88 45 f5             	mov    %al,-0xb(%ebp)
    printf(1, "uio: uio succeeded; test FAILED\n");
    4184:	83 ec 08             	sub    $0x8,%esp
    4187:	8d 83 50 f7 ff ff    	lea    -0x8b0(%ebx),%eax
    418d:	50                   	push   %eax
    418e:	6a 01                	push   $0x1
    4190:	e8 a3 06 00 00       	call   4838 <printf>
    4195:	83 c4 10             	add    $0x10,%esp
    exit();
    4198:	e8 ff 04 00 00       	call   469c <exit>
  } else if(pid < 0){
    419d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    41a1:	79 19                	jns    41bc <uio+0x99>
    printf (1, "fork failed\n");
    41a3:	83 ec 08             	sub    $0x8,%esp
    41a6:	8d 83 69 e0 ff ff    	lea    -0x1f97(%ebx),%eax
    41ac:	50                   	push   %eax
    41ad:	6a 01                	push   $0x1
    41af:	e8 84 06 00 00       	call   4838 <printf>
    41b4:	83 c4 10             	add    $0x10,%esp
    exit();
    41b7:	e8 e0 04 00 00       	call   469c <exit>
  }
  wait();
    41bc:	e8 e3 04 00 00       	call   46a4 <wait>
  printf(1, "uio test done\n");
    41c1:	83 ec 08             	sub    $0x8,%esp
    41c4:	8d 83 71 f7 ff ff    	lea    -0x88f(%ebx),%eax
    41ca:	50                   	push   %eax
    41cb:	6a 01                	push   $0x1
    41cd:	e8 66 06 00 00       	call   4838 <printf>
    41d2:	83 c4 10             	add    $0x10,%esp
}
    41d5:	90                   	nop
    41d6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    41d9:	c9                   	leave  
    41da:	c3                   	ret    

000041db <argptest>:

void argptest()
{
    41db:	55                   	push   %ebp
    41dc:	89 e5                	mov    %esp,%ebp
    41de:	53                   	push   %ebx
    41df:	83 ec 14             	sub    $0x14,%esp
    41e2:	e8 ec 01 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
    41e7:	81 c3 89 2a 00 00    	add    $0x2a89,%ebx
  int fd;
  fd = open("init", O_RDONLY);
    41ed:	83 ec 08             	sub    $0x8,%esp
    41f0:	6a 00                	push   $0x0
    41f2:	8d 83 80 f7 ff ff    	lea    -0x880(%ebx),%eax
    41f8:	50                   	push   %eax
    41f9:	e8 de 04 00 00       	call   46dc <open>
    41fe:	83 c4 10             	add    $0x10,%esp
    4201:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if (fd < 0) {
    4204:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    4208:	79 19                	jns    4223 <argptest+0x48>
    printf(2, "open failed\n");
    420a:	83 ec 08             	sub    $0x8,%esp
    420d:	8d 83 85 f7 ff ff    	lea    -0x87b(%ebx),%eax
    4213:	50                   	push   %eax
    4214:	6a 02                	push   $0x2
    4216:	e8 1d 06 00 00       	call   4838 <printf>
    421b:	83 c4 10             	add    $0x10,%esp
    exit();
    421e:	e8 79 04 00 00       	call   469c <exit>
  }
  read(fd, sbrk(0) - 1, -1);
    4223:	83 ec 0c             	sub    $0xc,%esp
    4226:	6a 00                	push   $0x0
    4228:	e8 f7 04 00 00       	call   4724 <sbrk>
    422d:	83 c4 10             	add    $0x10,%esp
    4230:	83 e8 01             	sub    $0x1,%eax
    4233:	83 ec 04             	sub    $0x4,%esp
    4236:	6a ff                	push   $0xffffffff
    4238:	50                   	push   %eax
    4239:	ff 75 f4             	push   -0xc(%ebp)
    423c:	e8 73 04 00 00       	call   46b4 <read>
    4241:	83 c4 10             	add    $0x10,%esp
  close(fd);
    4244:	83 ec 0c             	sub    $0xc,%esp
    4247:	ff 75 f4             	push   -0xc(%ebp)
    424a:	e8 75 04 00 00       	call   46c4 <close>
    424f:	83 c4 10             	add    $0x10,%esp
  printf(1, "arg test passed\n");
    4252:	83 ec 08             	sub    $0x8,%esp
    4255:	8d 83 92 f7 ff ff    	lea    -0x86e(%ebx),%eax
    425b:	50                   	push   %eax
    425c:	6a 01                	push   $0x1
    425e:	e8 d5 05 00 00       	call   4838 <printf>
    4263:	83 c4 10             	add    $0x10,%esp
}
    4266:	90                   	nop
    4267:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    426a:	c9                   	leave  
    426b:	c3                   	ret    

0000426c <rand>:

unsigned long randstate = 1;
unsigned int
rand()
{
    426c:	55                   	push   %ebp
    426d:	89 e5                	mov    %esp,%ebp
    426f:	e8 5b 01 00 00       	call   43cf <__x86.get_pc_thunk.ax>
    4274:	05 fc 29 00 00       	add    $0x29fc,%eax
  randstate = randstate * 1664525 + 1013904223;
    4279:	8b 90 10 00 00 00    	mov    0x10(%eax),%edx
    427f:	69 d2 0d 66 19 00    	imul   $0x19660d,%edx,%edx
    4285:	81 c2 5f f3 6e 3c    	add    $0x3c6ef35f,%edx
    428b:	89 90 10 00 00 00    	mov    %edx,0x10(%eax)
  return randstate;
    4291:	8b 80 10 00 00 00    	mov    0x10(%eax),%eax
}
    4297:	5d                   	pop    %ebp
    4298:	c3                   	ret    

00004299 <main>:

int
main(int argc, char *argv[])
{
    4299:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    429d:	83 e4 f0             	and    $0xfffffff0,%esp
    42a0:	ff 71 fc             	push   -0x4(%ecx)
    42a3:	55                   	push   %ebp
    42a4:	89 e5                	mov    %esp,%ebp
    42a6:	53                   	push   %ebx
    42a7:	51                   	push   %ecx
    42a8:	e8 26 01 00 00       	call   43d3 <__x86.get_pc_thunk.bx>
    42ad:	81 c3 c3 29 00 00    	add    $0x29c3,%ebx
  printf(1, "usertests starting\n");
    42b3:	83 ec 08             	sub    $0x8,%esp
    42b6:	8d 83 a3 f7 ff ff    	lea    -0x85d(%ebx),%eax
    42bc:	50                   	push   %eax
    42bd:	6a 01                	push   $0x1
    42bf:	e8 74 05 00 00       	call   4838 <printf>
    42c4:	83 c4 10             	add    $0x10,%esp

  if(open("usertests.ran", 0) >= 0){
    42c7:	83 ec 08             	sub    $0x8,%esp
    42ca:	6a 00                	push   $0x0
    42cc:	8d 83 b7 f7 ff ff    	lea    -0x849(%ebx),%eax
    42d2:	50                   	push   %eax
    42d3:	e8 04 04 00 00       	call   46dc <open>
    42d8:	83 c4 10             	add    $0x10,%esp
    42db:	85 c0                	test   %eax,%eax
    42dd:	78 19                	js     42f8 <main+0x5f>
    printf(1, "already ran user tests -- rebuild fs.img\n");
    42df:	83 ec 08             	sub    $0x8,%esp
    42e2:	8d 83 c8 f7 ff ff    	lea    -0x838(%ebx),%eax
    42e8:	50                   	push   %eax
    42e9:	6a 01                	push   $0x1
    42eb:	e8 48 05 00 00       	call   4838 <printf>
    42f0:	83 c4 10             	add    $0x10,%esp
    exit();
    42f3:	e8 a4 03 00 00       	call   469c <exit>
  }
  close(open("usertests.ran", O_CREATE));
    42f8:	83 ec 08             	sub    $0x8,%esp
    42fb:	68 00 02 00 00       	push   $0x200
    4300:	8d 83 b7 f7 ff ff    	lea    -0x849(%ebx),%eax
    4306:	50                   	push   %eax
    4307:	e8 d0 03 00 00       	call   46dc <open>
    430c:	83 c4 10             	add    $0x10,%esp
    430f:	83 ec 0c             	sub    $0xc,%esp
    4312:	50                   	push   %eax
    4313:	e8 ac 03 00 00       	call   46c4 <close>
    4318:	83 c4 10             	add    $0x10,%esp

  argptest();
    431b:	e8 bb fe ff ff       	call   41db <argptest>
  createdelete();
    4320:	e8 b8 d1 ff ff       	call   14dd <createdelete>
  linkunlink();
    4325:	e8 9e dc ff ff       	call   1fc8 <linkunlink>
  concreate();
    432a:	e8 b9 d8 ff ff       	call   1be8 <concreate>
  fourfiles();
    432f:	e8 2a cf ff ff       	call   125e <fourfiles>
  sharedfd();
    4334:	e8 1f cd ff ff       	call   1058 <sharedfd>

  bigargtest();
    4339:	e8 af f9 ff ff       	call   3ced <bigargtest>
  bigwrite();
    433e:	e8 6e e7 ff ff       	call   2ab1 <bigwrite>
  bigargtest();
    4343:	e8 a5 f9 ff ff       	call   3ced <bigargtest>
  bsstest();
    4348:	e8 0f f9 ff ff       	call   3c5c <bsstest>
  sbrktest();
    434d:	e8 bf f2 ff ff       	call   3611 <sbrktest>
  validatetest();
    4352:	e8 0d f8 ff ff       	call   3b64 <validatetest>

  opentest();
    4357:	e8 1a c0 ff ff       	call   376 <opentest>
  writetest();
    435c:	e8 e3 c0 ff ff       	call   444 <writetest>
  writetest1();
    4361:	e8 31 c3 ff ff       	call   697 <writetest1>
  createtest();
    4366:	e8 63 c5 ff ff       	call   8ce <createtest>

  openiputtest();
    436b:	e8 d0 be ff ff       	call   240 <openiputtest>
  exitiputtest();
    4370:	e8 a5 bd ff ff       	call   11a <exitiputtest>
  iputtest();
    4375:	e8 86 bc ff ff       	call   0 <iputtest>

  mem();
    437a:	e8 d3 cb ff ff       	call   f52 <mem>
  pipe1();
    437f:	e8 ae c7 ff ff       	call   b32 <pipe1>
  preempt();
    4384:	e8 b7 c9 ff ff       	call   d40 <preempt>
  exitwait();
    4389:	e8 37 cb ff ff       	call   ec5 <exitwait>

  rmdot();
    438e:	e8 09 ec ff ff       	call   2f9c <rmdot>
  fourteen();
    4393:	e8 7d ea ff ff       	call   2e15 <fourteen>
  bigfile();
    4398:	e8 31 e8 ff ff       	call   2bce <bigfile>
  subdir();
    439d:	e8 16 df ff ff       	call   22b8 <subdir>
  linktest();
    43a2:	e8 b8 d5 ff ff       	call   195f <linktest>
  unlinkread();
    43a7:	e8 c0 d3 ff ff       	call   176c <unlinkread>
  dirfile();
    43ac:	e8 a3 ed ff ff       	call   3154 <dirfile>
  iref();
    43b1:	e8 15 f0 ff ff       	call   33cb <iref>
  forktest();
    43b6:	e8 73 f1 ff ff       	call   352e <forktest>
  bigdir(); // slow
    43bb:	e8 62 dd ff ff       	call   2122 <bigdir>

  uio();
    43c0:	e8 5e fd ff ff       	call   4123 <uio>

  exectest();
    43c5:	e8 fc c6 ff ff       	call   ac6 <exectest>

  exit();
    43ca:	e8 cd 02 00 00       	call   469c <exit>

000043cf <__x86.get_pc_thunk.ax>:
    43cf:	8b 04 24             	mov    (%esp),%eax
    43d2:	c3                   	ret    

000043d3 <__x86.get_pc_thunk.bx>:
    43d3:	8b 1c 24             	mov    (%esp),%ebx
    43d6:	c3                   	ret    

000043d7 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    43d7:	55                   	push   %ebp
    43d8:	89 e5                	mov    %esp,%ebp
    43da:	57                   	push   %edi
    43db:	53                   	push   %ebx
    43dc:	e8 ee ff ff ff       	call   43cf <__x86.get_pc_thunk.ax>
    43e1:	05 8f 28 00 00       	add    $0x288f,%eax
  asm volatile("cld; rep stosb" :
    43e6:	8b 4d 08             	mov    0x8(%ebp),%ecx
    43e9:	8b 55 10             	mov    0x10(%ebp),%edx
    43ec:	8b 45 0c             	mov    0xc(%ebp),%eax
    43ef:	89 cb                	mov    %ecx,%ebx
    43f1:	89 df                	mov    %ebx,%edi
    43f3:	89 d1                	mov    %edx,%ecx
    43f5:	fc                   	cld    
    43f6:	f3 aa                	rep stos %al,%es:(%edi)
    43f8:	89 ca                	mov    %ecx,%edx
    43fa:	89 fb                	mov    %edi,%ebx
    43fc:	89 5d 08             	mov    %ebx,0x8(%ebp)
    43ff:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    4402:	90                   	nop
    4403:	5b                   	pop    %ebx
    4404:	5f                   	pop    %edi
    4405:	5d                   	pop    %ebp
    4406:	c3                   	ret    

00004407 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    4407:	55                   	push   %ebp
    4408:	89 e5                	mov    %esp,%ebp
    440a:	83 ec 10             	sub    $0x10,%esp
    440d:	e8 bd ff ff ff       	call   43cf <__x86.get_pc_thunk.ax>
    4412:	05 5e 28 00 00       	add    $0x285e,%eax
  char *os;

  os = s;
    4417:	8b 45 08             	mov    0x8(%ebp),%eax
    441a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    441d:	90                   	nop
    441e:	8b 55 0c             	mov    0xc(%ebp),%edx
    4421:	8d 42 01             	lea    0x1(%edx),%eax
    4424:	89 45 0c             	mov    %eax,0xc(%ebp)
    4427:	8b 45 08             	mov    0x8(%ebp),%eax
    442a:	8d 48 01             	lea    0x1(%eax),%ecx
    442d:	89 4d 08             	mov    %ecx,0x8(%ebp)
    4430:	0f b6 12             	movzbl (%edx),%edx
    4433:	88 10                	mov    %dl,(%eax)
    4435:	0f b6 00             	movzbl (%eax),%eax
    4438:	84 c0                	test   %al,%al
    443a:	75 e2                	jne    441e <strcpy+0x17>
    ;
  return os;
    443c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    443f:	c9                   	leave  
    4440:	c3                   	ret    

00004441 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    4441:	55                   	push   %ebp
    4442:	89 e5                	mov    %esp,%ebp
    4444:	e8 86 ff ff ff       	call   43cf <__x86.get_pc_thunk.ax>
    4449:	05 27 28 00 00       	add    $0x2827,%eax
  while(*p && *p == *q)
    444e:	eb 08                	jmp    4458 <strcmp+0x17>
    p++, q++;
    4450:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    4454:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
    4458:	8b 45 08             	mov    0x8(%ebp),%eax
    445b:	0f b6 00             	movzbl (%eax),%eax
    445e:	84 c0                	test   %al,%al
    4460:	74 10                	je     4472 <strcmp+0x31>
    4462:	8b 45 08             	mov    0x8(%ebp),%eax
    4465:	0f b6 10             	movzbl (%eax),%edx
    4468:	8b 45 0c             	mov    0xc(%ebp),%eax
    446b:	0f b6 00             	movzbl (%eax),%eax
    446e:	38 c2                	cmp    %al,%dl
    4470:	74 de                	je     4450 <strcmp+0xf>
  return (uchar)*p - (uchar)*q;
    4472:	8b 45 08             	mov    0x8(%ebp),%eax
    4475:	0f b6 00             	movzbl (%eax),%eax
    4478:	0f b6 d0             	movzbl %al,%edx
    447b:	8b 45 0c             	mov    0xc(%ebp),%eax
    447e:	0f b6 00             	movzbl (%eax),%eax
    4481:	0f b6 c8             	movzbl %al,%ecx
    4484:	89 d0                	mov    %edx,%eax
    4486:	29 c8                	sub    %ecx,%eax
}
    4488:	5d                   	pop    %ebp
    4489:	c3                   	ret    

0000448a <strlen>:

uint
strlen(const char *s)
{
    448a:	55                   	push   %ebp
    448b:	89 e5                	mov    %esp,%ebp
    448d:	83 ec 10             	sub    $0x10,%esp
    4490:	e8 3a ff ff ff       	call   43cf <__x86.get_pc_thunk.ax>
    4495:	05 db 27 00 00       	add    $0x27db,%eax
  int n;

  for(n = 0; s[n]; n++)
    449a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    44a1:	eb 04                	jmp    44a7 <strlen+0x1d>
    44a3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    44a7:	8b 55 fc             	mov    -0x4(%ebp),%edx
    44aa:	8b 45 08             	mov    0x8(%ebp),%eax
    44ad:	01 d0                	add    %edx,%eax
    44af:	0f b6 00             	movzbl (%eax),%eax
    44b2:	84 c0                	test   %al,%al
    44b4:	75 ed                	jne    44a3 <strlen+0x19>
    ;
  return n;
    44b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    44b9:	c9                   	leave  
    44ba:	c3                   	ret    

000044bb <memset>:

void*
memset(void *dst, int c, uint n)
{
    44bb:	55                   	push   %ebp
    44bc:	89 e5                	mov    %esp,%ebp
    44be:	e8 0c ff ff ff       	call   43cf <__x86.get_pc_thunk.ax>
    44c3:	05 ad 27 00 00       	add    $0x27ad,%eax
  stosb(dst, c, n);
    44c8:	8b 45 10             	mov    0x10(%ebp),%eax
    44cb:	50                   	push   %eax
    44cc:	ff 75 0c             	push   0xc(%ebp)
    44cf:	ff 75 08             	push   0x8(%ebp)
    44d2:	e8 00 ff ff ff       	call   43d7 <stosb>
    44d7:	83 c4 0c             	add    $0xc,%esp
  return dst;
    44da:	8b 45 08             	mov    0x8(%ebp),%eax
}
    44dd:	c9                   	leave  
    44de:	c3                   	ret    

000044df <strchr>:

char*
strchr(const char *s, char c)
{
    44df:	55                   	push   %ebp
    44e0:	89 e5                	mov    %esp,%ebp
    44e2:	83 ec 04             	sub    $0x4,%esp
    44e5:	e8 e5 fe ff ff       	call   43cf <__x86.get_pc_thunk.ax>
    44ea:	05 86 27 00 00       	add    $0x2786,%eax
    44ef:	8b 45 0c             	mov    0xc(%ebp),%eax
    44f2:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    44f5:	eb 14                	jmp    450b <strchr+0x2c>
    if(*s == c)
    44f7:	8b 45 08             	mov    0x8(%ebp),%eax
    44fa:	0f b6 00             	movzbl (%eax),%eax
    44fd:	38 45 fc             	cmp    %al,-0x4(%ebp)
    4500:	75 05                	jne    4507 <strchr+0x28>
      return (char*)s;
    4502:	8b 45 08             	mov    0x8(%ebp),%eax
    4505:	eb 13                	jmp    451a <strchr+0x3b>
  for(; *s; s++)
    4507:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    450b:	8b 45 08             	mov    0x8(%ebp),%eax
    450e:	0f b6 00             	movzbl (%eax),%eax
    4511:	84 c0                	test   %al,%al
    4513:	75 e2                	jne    44f7 <strchr+0x18>
  return 0;
    4515:	b8 00 00 00 00       	mov    $0x0,%eax
}
    451a:	c9                   	leave  
    451b:	c3                   	ret    

0000451c <gets>:

char*
gets(char *buf, int max)
{
    451c:	55                   	push   %ebp
    451d:	89 e5                	mov    %esp,%ebp
    451f:	53                   	push   %ebx
    4520:	83 ec 14             	sub    $0x14,%esp
    4523:	e8 ab fe ff ff       	call   43d3 <__x86.get_pc_thunk.bx>
    4528:	81 c3 48 27 00 00    	add    $0x2748,%ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    452e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    4535:	eb 42                	jmp    4579 <gets+0x5d>
    cc = read(0, &c, 1);
    4537:	83 ec 04             	sub    $0x4,%esp
    453a:	6a 01                	push   $0x1
    453c:	8d 45 ef             	lea    -0x11(%ebp),%eax
    453f:	50                   	push   %eax
    4540:	6a 00                	push   $0x0
    4542:	e8 6d 01 00 00       	call   46b4 <read>
    4547:	83 c4 10             	add    $0x10,%esp
    454a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    454d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    4551:	7e 33                	jle    4586 <gets+0x6a>
      break;
    buf[i++] = c;
    4553:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4556:	8d 50 01             	lea    0x1(%eax),%edx
    4559:	89 55 f4             	mov    %edx,-0xc(%ebp)
    455c:	89 c2                	mov    %eax,%edx
    455e:	8b 45 08             	mov    0x8(%ebp),%eax
    4561:	01 c2                	add    %eax,%edx
    4563:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    4567:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    4569:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    456d:	3c 0a                	cmp    $0xa,%al
    456f:	74 16                	je     4587 <gets+0x6b>
    4571:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    4575:	3c 0d                	cmp    $0xd,%al
    4577:	74 0e                	je     4587 <gets+0x6b>
  for(i=0; i+1 < max; ){
    4579:	8b 45 f4             	mov    -0xc(%ebp),%eax
    457c:	83 c0 01             	add    $0x1,%eax
    457f:	39 45 0c             	cmp    %eax,0xc(%ebp)
    4582:	7f b3                	jg     4537 <gets+0x1b>
    4584:	eb 01                	jmp    4587 <gets+0x6b>
      break;
    4586:	90                   	nop
      break;
  }
  buf[i] = '\0';
    4587:	8b 55 f4             	mov    -0xc(%ebp),%edx
    458a:	8b 45 08             	mov    0x8(%ebp),%eax
    458d:	01 d0                	add    %edx,%eax
    458f:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    4592:	8b 45 08             	mov    0x8(%ebp),%eax
}
    4595:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    4598:	c9                   	leave  
    4599:	c3                   	ret    

0000459a <stat>:

int
stat(const char *n, struct stat *st)
{
    459a:	55                   	push   %ebp
    459b:	89 e5                	mov    %esp,%ebp
    459d:	53                   	push   %ebx
    459e:	83 ec 14             	sub    $0x14,%esp
    45a1:	e8 2d fe ff ff       	call   43d3 <__x86.get_pc_thunk.bx>
    45a6:	81 c3 ca 26 00 00    	add    $0x26ca,%ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    45ac:	83 ec 08             	sub    $0x8,%esp
    45af:	6a 00                	push   $0x0
    45b1:	ff 75 08             	push   0x8(%ebp)
    45b4:	e8 23 01 00 00       	call   46dc <open>
    45b9:	83 c4 10             	add    $0x10,%esp
    45bc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    45bf:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    45c3:	79 07                	jns    45cc <stat+0x32>
    return -1;
    45c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    45ca:	eb 25                	jmp    45f1 <stat+0x57>
  r = fstat(fd, st);
    45cc:	83 ec 08             	sub    $0x8,%esp
    45cf:	ff 75 0c             	push   0xc(%ebp)
    45d2:	ff 75 f4             	push   -0xc(%ebp)
    45d5:	e8 1a 01 00 00       	call   46f4 <fstat>
    45da:	83 c4 10             	add    $0x10,%esp
    45dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    45e0:	83 ec 0c             	sub    $0xc,%esp
    45e3:	ff 75 f4             	push   -0xc(%ebp)
    45e6:	e8 d9 00 00 00       	call   46c4 <close>
    45eb:	83 c4 10             	add    $0x10,%esp
  return r;
    45ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    45f1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    45f4:	c9                   	leave  
    45f5:	c3                   	ret    

000045f6 <atoi>:

int
atoi(const char *s)
{
    45f6:	55                   	push   %ebp
    45f7:	89 e5                	mov    %esp,%ebp
    45f9:	83 ec 10             	sub    $0x10,%esp
    45fc:	e8 ce fd ff ff       	call   43cf <__x86.get_pc_thunk.ax>
    4601:	05 6f 26 00 00       	add    $0x266f,%eax
  int n;

  n = 0;
    4606:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    460d:	eb 25                	jmp    4634 <atoi+0x3e>
    n = n*10 + *s++ - '0';
    460f:	8b 55 fc             	mov    -0x4(%ebp),%edx
    4612:	89 d0                	mov    %edx,%eax
    4614:	c1 e0 02             	shl    $0x2,%eax
    4617:	01 d0                	add    %edx,%eax
    4619:	01 c0                	add    %eax,%eax
    461b:	89 c1                	mov    %eax,%ecx
    461d:	8b 45 08             	mov    0x8(%ebp),%eax
    4620:	8d 50 01             	lea    0x1(%eax),%edx
    4623:	89 55 08             	mov    %edx,0x8(%ebp)
    4626:	0f b6 00             	movzbl (%eax),%eax
    4629:	0f be c0             	movsbl %al,%eax
    462c:	01 c8                	add    %ecx,%eax
    462e:	83 e8 30             	sub    $0x30,%eax
    4631:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    4634:	8b 45 08             	mov    0x8(%ebp),%eax
    4637:	0f b6 00             	movzbl (%eax),%eax
    463a:	3c 2f                	cmp    $0x2f,%al
    463c:	7e 0a                	jle    4648 <atoi+0x52>
    463e:	8b 45 08             	mov    0x8(%ebp),%eax
    4641:	0f b6 00             	movzbl (%eax),%eax
    4644:	3c 39                	cmp    $0x39,%al
    4646:	7e c7                	jle    460f <atoi+0x19>
  return n;
    4648:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    464b:	c9                   	leave  
    464c:	c3                   	ret    

0000464d <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    464d:	55                   	push   %ebp
    464e:	89 e5                	mov    %esp,%ebp
    4650:	83 ec 10             	sub    $0x10,%esp
    4653:	e8 77 fd ff ff       	call   43cf <__x86.get_pc_thunk.ax>
    4658:	05 18 26 00 00       	add    $0x2618,%eax
  char *dst;
  const char *src;

  dst = vdst;
    465d:	8b 45 08             	mov    0x8(%ebp),%eax
    4660:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    4663:	8b 45 0c             	mov    0xc(%ebp),%eax
    4666:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    4669:	eb 17                	jmp    4682 <memmove+0x35>
    *dst++ = *src++;
    466b:	8b 55 f8             	mov    -0x8(%ebp),%edx
    466e:	8d 42 01             	lea    0x1(%edx),%eax
    4671:	89 45 f8             	mov    %eax,-0x8(%ebp)
    4674:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4677:	8d 48 01             	lea    0x1(%eax),%ecx
    467a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    467d:	0f b6 12             	movzbl (%edx),%edx
    4680:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    4682:	8b 45 10             	mov    0x10(%ebp),%eax
    4685:	8d 50 ff             	lea    -0x1(%eax),%edx
    4688:	89 55 10             	mov    %edx,0x10(%ebp)
    468b:	85 c0                	test   %eax,%eax
    468d:	7f dc                	jg     466b <memmove+0x1e>
  return vdst;
    468f:	8b 45 08             	mov    0x8(%ebp),%eax
}
    4692:	c9                   	leave  
    4693:	c3                   	ret    

00004694 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    4694:	b8 01 00 00 00       	mov    $0x1,%eax
    4699:	cd 40                	int    $0x40
    469b:	c3                   	ret    

0000469c <exit>:
SYSCALL(exit)
    469c:	b8 02 00 00 00       	mov    $0x2,%eax
    46a1:	cd 40                	int    $0x40
    46a3:	c3                   	ret    

000046a4 <wait>:
SYSCALL(wait)
    46a4:	b8 03 00 00 00       	mov    $0x3,%eax
    46a9:	cd 40                	int    $0x40
    46ab:	c3                   	ret    

000046ac <pipe>:
SYSCALL(pipe)
    46ac:	b8 04 00 00 00       	mov    $0x4,%eax
    46b1:	cd 40                	int    $0x40
    46b3:	c3                   	ret    

000046b4 <read>:
SYSCALL(read)
    46b4:	b8 05 00 00 00       	mov    $0x5,%eax
    46b9:	cd 40                	int    $0x40
    46bb:	c3                   	ret    

000046bc <write>:
SYSCALL(write)
    46bc:	b8 10 00 00 00       	mov    $0x10,%eax
    46c1:	cd 40                	int    $0x40
    46c3:	c3                   	ret    

000046c4 <close>:
SYSCALL(close)
    46c4:	b8 15 00 00 00       	mov    $0x15,%eax
    46c9:	cd 40                	int    $0x40
    46cb:	c3                   	ret    

000046cc <kill>:
SYSCALL(kill)
    46cc:	b8 06 00 00 00       	mov    $0x6,%eax
    46d1:	cd 40                	int    $0x40
    46d3:	c3                   	ret    

000046d4 <exec>:
SYSCALL(exec)
    46d4:	b8 07 00 00 00       	mov    $0x7,%eax
    46d9:	cd 40                	int    $0x40
    46db:	c3                   	ret    

000046dc <open>:
SYSCALL(open)
    46dc:	b8 0f 00 00 00       	mov    $0xf,%eax
    46e1:	cd 40                	int    $0x40
    46e3:	c3                   	ret    

000046e4 <mknod>:
SYSCALL(mknod)
    46e4:	b8 11 00 00 00       	mov    $0x11,%eax
    46e9:	cd 40                	int    $0x40
    46eb:	c3                   	ret    

000046ec <unlink>:
SYSCALL(unlink)
    46ec:	b8 12 00 00 00       	mov    $0x12,%eax
    46f1:	cd 40                	int    $0x40
    46f3:	c3                   	ret    

000046f4 <fstat>:
SYSCALL(fstat)
    46f4:	b8 08 00 00 00       	mov    $0x8,%eax
    46f9:	cd 40                	int    $0x40
    46fb:	c3                   	ret    

000046fc <link>:
SYSCALL(link)
    46fc:	b8 13 00 00 00       	mov    $0x13,%eax
    4701:	cd 40                	int    $0x40
    4703:	c3                   	ret    

00004704 <mkdir>:
SYSCALL(mkdir)
    4704:	b8 14 00 00 00       	mov    $0x14,%eax
    4709:	cd 40                	int    $0x40
    470b:	c3                   	ret    

0000470c <chdir>:
SYSCALL(chdir)
    470c:	b8 09 00 00 00       	mov    $0x9,%eax
    4711:	cd 40                	int    $0x40
    4713:	c3                   	ret    

00004714 <dup>:
SYSCALL(dup)
    4714:	b8 0a 00 00 00       	mov    $0xa,%eax
    4719:	cd 40                	int    $0x40
    471b:	c3                   	ret    

0000471c <getpid>:
SYSCALL(getpid)
    471c:	b8 0b 00 00 00       	mov    $0xb,%eax
    4721:	cd 40                	int    $0x40
    4723:	c3                   	ret    

00004724 <sbrk>:
SYSCALL(sbrk)
    4724:	b8 0c 00 00 00       	mov    $0xc,%eax
    4729:	cd 40                	int    $0x40
    472b:	c3                   	ret    

0000472c <sleep>:
SYSCALL(sleep)
    472c:	b8 0d 00 00 00       	mov    $0xd,%eax
    4731:	cd 40                	int    $0x40
    4733:	c3                   	ret    

00004734 <uptime>:
SYSCALL(uptime)
    4734:	b8 0e 00 00 00       	mov    $0xe,%eax
    4739:	cd 40                	int    $0x40
    473b:	c3                   	ret    

0000473c <random>:
SYSCALL(random)
    473c:	b8 16 00 00 00       	mov    $0x16,%eax
    4741:	cd 40                	int    $0x40
    4743:	c3                   	ret    

00004744 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    4744:	55                   	push   %ebp
    4745:	89 e5                	mov    %esp,%ebp
    4747:	53                   	push   %ebx
    4748:	83 ec 14             	sub    $0x14,%esp
    474b:	e8 7f fc ff ff       	call   43cf <__x86.get_pc_thunk.ax>
    4750:	05 20 25 00 00       	add    $0x2520,%eax
    4755:	8b 55 0c             	mov    0xc(%ebp),%edx
    4758:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    475b:	83 ec 04             	sub    $0x4,%esp
    475e:	6a 01                	push   $0x1
    4760:	8d 55 f4             	lea    -0xc(%ebp),%edx
    4763:	52                   	push   %edx
    4764:	ff 75 08             	push   0x8(%ebp)
    4767:	89 c3                	mov    %eax,%ebx
    4769:	e8 4e ff ff ff       	call   46bc <write>
    476e:	83 c4 10             	add    $0x10,%esp
}
    4771:	90                   	nop
    4772:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    4775:	c9                   	leave  
    4776:	c3                   	ret    

00004777 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    4777:	55                   	push   %ebp
    4778:	89 e5                	mov    %esp,%ebp
    477a:	53                   	push   %ebx
    477b:	83 ec 24             	sub    $0x24,%esp
    477e:	e8 58 02 00 00       	call   49db <__x86.get_pc_thunk.cx>
    4783:	81 c1 ed 24 00 00    	add    $0x24ed,%ecx
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    4789:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    4790:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    4794:	74 17                	je     47ad <printint+0x36>
    4796:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    479a:	79 11                	jns    47ad <printint+0x36>
    neg = 1;
    479c:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    47a3:	8b 45 0c             	mov    0xc(%ebp),%eax
    47a6:	f7 d8                	neg    %eax
    47a8:	89 45 ec             	mov    %eax,-0x14(%ebp)
    47ab:	eb 06                	jmp    47b3 <printint+0x3c>
  } else {
    x = xx;
    47ad:	8b 45 0c             	mov    0xc(%ebp),%eax
    47b0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    47b3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    47ba:	8b 5d 10             	mov    0x10(%ebp),%ebx
    47bd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    47c0:	ba 00 00 00 00       	mov    $0x0,%edx
    47c5:	f7 f3                	div    %ebx
    47c7:	89 d3                	mov    %edx,%ebx
    47c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    47cc:	8d 50 01             	lea    0x1(%eax),%edx
    47cf:	89 55 f4             	mov    %edx,-0xc(%ebp)
    47d2:	0f b6 94 19 28 00 00 	movzbl 0x28(%ecx,%ebx,1),%edx
    47d9:	00 
    47da:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    47de:	8b 5d 10             	mov    0x10(%ebp),%ebx
    47e1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    47e4:	ba 00 00 00 00       	mov    $0x0,%edx
    47e9:	f7 f3                	div    %ebx
    47eb:	89 45 ec             	mov    %eax,-0x14(%ebp)
    47ee:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    47f2:	75 c6                	jne    47ba <printint+0x43>
  if(neg)
    47f4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    47f8:	74 2d                	je     4827 <printint+0xb0>
    buf[i++] = '-';
    47fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    47fd:	8d 50 01             	lea    0x1(%eax),%edx
    4800:	89 55 f4             	mov    %edx,-0xc(%ebp)
    4803:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    4808:	eb 1d                	jmp    4827 <printint+0xb0>
    putc(fd, buf[i]);
    480a:	8d 55 dc             	lea    -0x24(%ebp),%edx
    480d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4810:	01 d0                	add    %edx,%eax
    4812:	0f b6 00             	movzbl (%eax),%eax
    4815:	0f be c0             	movsbl %al,%eax
    4818:	83 ec 08             	sub    $0x8,%esp
    481b:	50                   	push   %eax
    481c:	ff 75 08             	push   0x8(%ebp)
    481f:	e8 20 ff ff ff       	call   4744 <putc>
    4824:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    4827:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    482b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    482f:	79 d9                	jns    480a <printint+0x93>
}
    4831:	90                   	nop
    4832:	90                   	nop
    4833:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    4836:	c9                   	leave  
    4837:	c3                   	ret    

00004838 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    4838:	55                   	push   %ebp
    4839:	89 e5                	mov    %esp,%ebp
    483b:	53                   	push   %ebx
    483c:	83 ec 24             	sub    $0x24,%esp
    483f:	e8 8f fb ff ff       	call   43d3 <__x86.get_pc_thunk.bx>
    4844:	81 c3 2c 24 00 00    	add    $0x242c,%ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    484a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    4851:	8d 45 0c             	lea    0xc(%ebp),%eax
    4854:	83 c0 04             	add    $0x4,%eax
    4857:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    485a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    4861:	e9 5b 01 00 00       	jmp    49c1 <printf+0x189>
    c = fmt[i] & 0xff;
    4866:	8b 55 0c             	mov    0xc(%ebp),%edx
    4869:	8b 45 f0             	mov    -0x10(%ebp),%eax
    486c:	01 d0                	add    %edx,%eax
    486e:	0f b6 00             	movzbl (%eax),%eax
    4871:	0f be c0             	movsbl %al,%eax
    4874:	25 ff 00 00 00       	and    $0xff,%eax
    4879:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    487c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    4880:	75 2c                	jne    48ae <printf+0x76>
      if(c == '%'){
    4882:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    4886:	75 0c                	jne    4894 <printf+0x5c>
        state = '%';
    4888:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    488f:	e9 29 01 00 00       	jmp    49bd <printf+0x185>
      } else {
        putc(fd, c);
    4894:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    4897:	0f be c0             	movsbl %al,%eax
    489a:	83 ec 08             	sub    $0x8,%esp
    489d:	50                   	push   %eax
    489e:	ff 75 08             	push   0x8(%ebp)
    48a1:	e8 9e fe ff ff       	call   4744 <putc>
    48a6:	83 c4 10             	add    $0x10,%esp
    48a9:	e9 0f 01 00 00       	jmp    49bd <printf+0x185>
      }
    } else if(state == '%'){
    48ae:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    48b2:	0f 85 05 01 00 00    	jne    49bd <printf+0x185>
      if(c == 'd'){
    48b8:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    48bc:	75 1e                	jne    48dc <printf+0xa4>
        printint(fd, *ap, 10, 1);
    48be:	8b 45 e8             	mov    -0x18(%ebp),%eax
    48c1:	8b 00                	mov    (%eax),%eax
    48c3:	6a 01                	push   $0x1
    48c5:	6a 0a                	push   $0xa
    48c7:	50                   	push   %eax
    48c8:	ff 75 08             	push   0x8(%ebp)
    48cb:	e8 a7 fe ff ff       	call   4777 <printint>
    48d0:	83 c4 10             	add    $0x10,%esp
        ap++;
    48d3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    48d7:	e9 da 00 00 00       	jmp    49b6 <printf+0x17e>
      } else if(c == 'x' || c == 'p'){
    48dc:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    48e0:	74 06                	je     48e8 <printf+0xb0>
    48e2:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    48e6:	75 1e                	jne    4906 <printf+0xce>
        printint(fd, *ap, 16, 0);
    48e8:	8b 45 e8             	mov    -0x18(%ebp),%eax
    48eb:	8b 00                	mov    (%eax),%eax
    48ed:	6a 00                	push   $0x0
    48ef:	6a 10                	push   $0x10
    48f1:	50                   	push   %eax
    48f2:	ff 75 08             	push   0x8(%ebp)
    48f5:	e8 7d fe ff ff       	call   4777 <printint>
    48fa:	83 c4 10             	add    $0x10,%esp
        ap++;
    48fd:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    4901:	e9 b0 00 00 00       	jmp    49b6 <printf+0x17e>
      } else if(c == 's'){
    4906:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    490a:	75 45                	jne    4951 <printf+0x119>
        s = (char*)*ap;
    490c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    490f:	8b 00                	mov    (%eax),%eax
    4911:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    4914:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    4918:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    491c:	75 27                	jne    4945 <printf+0x10d>
          s = "(null)";
    491e:	8d 83 f2 f7 ff ff    	lea    -0x80e(%ebx),%eax
    4924:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while(*s != 0){
    4927:	eb 1c                	jmp    4945 <printf+0x10d>
          putc(fd, *s);
    4929:	8b 45 f4             	mov    -0xc(%ebp),%eax
    492c:	0f b6 00             	movzbl (%eax),%eax
    492f:	0f be c0             	movsbl %al,%eax
    4932:	83 ec 08             	sub    $0x8,%esp
    4935:	50                   	push   %eax
    4936:	ff 75 08             	push   0x8(%ebp)
    4939:	e8 06 fe ff ff       	call   4744 <putc>
    493e:	83 c4 10             	add    $0x10,%esp
          s++;
    4941:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    4945:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4948:	0f b6 00             	movzbl (%eax),%eax
    494b:	84 c0                	test   %al,%al
    494d:	75 da                	jne    4929 <printf+0xf1>
    494f:	eb 65                	jmp    49b6 <printf+0x17e>
        }
      } else if(c == 'c'){
    4951:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    4955:	75 1d                	jne    4974 <printf+0x13c>
        putc(fd, *ap);
    4957:	8b 45 e8             	mov    -0x18(%ebp),%eax
    495a:	8b 00                	mov    (%eax),%eax
    495c:	0f be c0             	movsbl %al,%eax
    495f:	83 ec 08             	sub    $0x8,%esp
    4962:	50                   	push   %eax
    4963:	ff 75 08             	push   0x8(%ebp)
    4966:	e8 d9 fd ff ff       	call   4744 <putc>
    496b:	83 c4 10             	add    $0x10,%esp
        ap++;
    496e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    4972:	eb 42                	jmp    49b6 <printf+0x17e>
      } else if(c == '%'){
    4974:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    4978:	75 17                	jne    4991 <printf+0x159>
        putc(fd, c);
    497a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    497d:	0f be c0             	movsbl %al,%eax
    4980:	83 ec 08             	sub    $0x8,%esp
    4983:	50                   	push   %eax
    4984:	ff 75 08             	push   0x8(%ebp)
    4987:	e8 b8 fd ff ff       	call   4744 <putc>
    498c:	83 c4 10             	add    $0x10,%esp
    498f:	eb 25                	jmp    49b6 <printf+0x17e>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    4991:	83 ec 08             	sub    $0x8,%esp
    4994:	6a 25                	push   $0x25
    4996:	ff 75 08             	push   0x8(%ebp)
    4999:	e8 a6 fd ff ff       	call   4744 <putc>
    499e:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    49a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    49a4:	0f be c0             	movsbl %al,%eax
    49a7:	83 ec 08             	sub    $0x8,%esp
    49aa:	50                   	push   %eax
    49ab:	ff 75 08             	push   0x8(%ebp)
    49ae:	e8 91 fd ff ff       	call   4744 <putc>
    49b3:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    49b6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    49bd:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    49c1:	8b 55 0c             	mov    0xc(%ebp),%edx
    49c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    49c7:	01 d0                	add    %edx,%eax
    49c9:	0f b6 00             	movzbl (%eax),%eax
    49cc:	84 c0                	test   %al,%al
    49ce:	0f 85 92 fe ff ff    	jne    4866 <printf+0x2e>
    }
  }
}
    49d4:	90                   	nop
    49d5:	90                   	nop
    49d6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    49d9:	c9                   	leave  
    49da:	c3                   	ret    

000049db <__x86.get_pc_thunk.cx>:
    49db:	8b 0c 24             	mov    (%esp),%ecx
    49de:	c3                   	ret    

000049df <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    49df:	55                   	push   %ebp
    49e0:	89 e5                	mov    %esp,%ebp
    49e2:	83 ec 10             	sub    $0x10,%esp
    49e5:	e8 e5 f9 ff ff       	call   43cf <__x86.get_pc_thunk.ax>
    49ea:	05 86 22 00 00       	add    $0x2286,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
    49ef:	8b 55 08             	mov    0x8(%ebp),%edx
    49f2:	83 ea 08             	sub    $0x8,%edx
    49f5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    49f8:	8b 90 18 48 00 00    	mov    0x4818(%eax),%edx
    49fe:	89 55 fc             	mov    %edx,-0x4(%ebp)
    4a01:	eb 24                	jmp    4a27 <free+0x48>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    4a03:	8b 55 fc             	mov    -0x4(%ebp),%edx
    4a06:	8b 12                	mov    (%edx),%edx
    4a08:	39 55 fc             	cmp    %edx,-0x4(%ebp)
    4a0b:	72 12                	jb     4a1f <free+0x40>
    4a0d:	8b 55 f8             	mov    -0x8(%ebp),%edx
    4a10:	3b 55 fc             	cmp    -0x4(%ebp),%edx
    4a13:	77 24                	ja     4a39 <free+0x5a>
    4a15:	8b 55 fc             	mov    -0x4(%ebp),%edx
    4a18:	8b 12                	mov    (%edx),%edx
    4a1a:	39 55 f8             	cmp    %edx,-0x8(%ebp)
    4a1d:	72 1a                	jb     4a39 <free+0x5a>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    4a1f:	8b 55 fc             	mov    -0x4(%ebp),%edx
    4a22:	8b 12                	mov    (%edx),%edx
    4a24:	89 55 fc             	mov    %edx,-0x4(%ebp)
    4a27:	8b 55 f8             	mov    -0x8(%ebp),%edx
    4a2a:	3b 55 fc             	cmp    -0x4(%ebp),%edx
    4a2d:	76 d4                	jbe    4a03 <free+0x24>
    4a2f:	8b 55 fc             	mov    -0x4(%ebp),%edx
    4a32:	8b 12                	mov    (%edx),%edx
    4a34:	39 55 f8             	cmp    %edx,-0x8(%ebp)
    4a37:	73 ca                	jae    4a03 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
    4a39:	8b 55 f8             	mov    -0x8(%ebp),%edx
    4a3c:	8b 52 04             	mov    0x4(%edx),%edx
    4a3f:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
    4a46:	8b 55 f8             	mov    -0x8(%ebp),%edx
    4a49:	01 d1                	add    %edx,%ecx
    4a4b:	8b 55 fc             	mov    -0x4(%ebp),%edx
    4a4e:	8b 12                	mov    (%edx),%edx
    4a50:	39 d1                	cmp    %edx,%ecx
    4a52:	75 24                	jne    4a78 <free+0x99>
    bp->s.size += p->s.ptr->s.size;
    4a54:	8b 55 f8             	mov    -0x8(%ebp),%edx
    4a57:	8b 4a 04             	mov    0x4(%edx),%ecx
    4a5a:	8b 55 fc             	mov    -0x4(%ebp),%edx
    4a5d:	8b 12                	mov    (%edx),%edx
    4a5f:	8b 52 04             	mov    0x4(%edx),%edx
    4a62:	01 d1                	add    %edx,%ecx
    4a64:	8b 55 f8             	mov    -0x8(%ebp),%edx
    4a67:	89 4a 04             	mov    %ecx,0x4(%edx)
    bp->s.ptr = p->s.ptr->s.ptr;
    4a6a:	8b 55 fc             	mov    -0x4(%ebp),%edx
    4a6d:	8b 12                	mov    (%edx),%edx
    4a6f:	8b 0a                	mov    (%edx),%ecx
    4a71:	8b 55 f8             	mov    -0x8(%ebp),%edx
    4a74:	89 0a                	mov    %ecx,(%edx)
    4a76:	eb 0a                	jmp    4a82 <free+0xa3>
  } else
    bp->s.ptr = p->s.ptr;
    4a78:	8b 55 fc             	mov    -0x4(%ebp),%edx
    4a7b:	8b 0a                	mov    (%edx),%ecx
    4a7d:	8b 55 f8             	mov    -0x8(%ebp),%edx
    4a80:	89 0a                	mov    %ecx,(%edx)
  if(p + p->s.size == bp){
    4a82:	8b 55 fc             	mov    -0x4(%ebp),%edx
    4a85:	8b 52 04             	mov    0x4(%edx),%edx
    4a88:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
    4a8f:	8b 55 fc             	mov    -0x4(%ebp),%edx
    4a92:	01 ca                	add    %ecx,%edx
    4a94:	39 55 f8             	cmp    %edx,-0x8(%ebp)
    4a97:	75 20                	jne    4ab9 <free+0xda>
    p->s.size += bp->s.size;
    4a99:	8b 55 fc             	mov    -0x4(%ebp),%edx
    4a9c:	8b 4a 04             	mov    0x4(%edx),%ecx
    4a9f:	8b 55 f8             	mov    -0x8(%ebp),%edx
    4aa2:	8b 52 04             	mov    0x4(%edx),%edx
    4aa5:	01 d1                	add    %edx,%ecx
    4aa7:	8b 55 fc             	mov    -0x4(%ebp),%edx
    4aaa:	89 4a 04             	mov    %ecx,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    4aad:	8b 55 f8             	mov    -0x8(%ebp),%edx
    4ab0:	8b 0a                	mov    (%edx),%ecx
    4ab2:	8b 55 fc             	mov    -0x4(%ebp),%edx
    4ab5:	89 0a                	mov    %ecx,(%edx)
    4ab7:	eb 08                	jmp    4ac1 <free+0xe2>
  } else
    p->s.ptr = bp;
    4ab9:	8b 55 fc             	mov    -0x4(%ebp),%edx
    4abc:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    4abf:	89 0a                	mov    %ecx,(%edx)
  freep = p;
    4ac1:	8b 55 fc             	mov    -0x4(%ebp),%edx
    4ac4:	89 90 18 48 00 00    	mov    %edx,0x4818(%eax)
}
    4aca:	90                   	nop
    4acb:	c9                   	leave  
    4acc:	c3                   	ret    

00004acd <morecore>:

static Header*
morecore(uint nu)
{
    4acd:	55                   	push   %ebp
    4ace:	89 e5                	mov    %esp,%ebp
    4ad0:	53                   	push   %ebx
    4ad1:	83 ec 14             	sub    $0x14,%esp
    4ad4:	e8 fa f8 ff ff       	call   43d3 <__x86.get_pc_thunk.bx>
    4ad9:	81 c3 97 21 00 00    	add    $0x2197,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    4adf:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    4ae6:	77 07                	ja     4aef <morecore+0x22>
    nu = 4096;
    4ae8:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    4aef:	8b 45 08             	mov    0x8(%ebp),%eax
    4af2:	c1 e0 03             	shl    $0x3,%eax
    4af5:	83 ec 0c             	sub    $0xc,%esp
    4af8:	50                   	push   %eax
    4af9:	e8 26 fc ff ff       	call   4724 <sbrk>
    4afe:	83 c4 10             	add    $0x10,%esp
    4b01:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    4b04:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    4b08:	75 07                	jne    4b11 <morecore+0x44>
    return 0;
    4b0a:	b8 00 00 00 00       	mov    $0x0,%eax
    4b0f:	eb 27                	jmp    4b38 <morecore+0x6b>
  hp = (Header*)p;
    4b11:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4b14:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    4b17:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4b1a:	8b 55 08             	mov    0x8(%ebp),%edx
    4b1d:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    4b20:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4b23:	83 c0 08             	add    $0x8,%eax
    4b26:	83 ec 0c             	sub    $0xc,%esp
    4b29:	50                   	push   %eax
    4b2a:	e8 b0 fe ff ff       	call   49df <free>
    4b2f:	83 c4 10             	add    $0x10,%esp
  return freep;
    4b32:	8b 83 18 48 00 00    	mov    0x4818(%ebx),%eax
}
    4b38:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    4b3b:	c9                   	leave  
    4b3c:	c3                   	ret    

00004b3d <malloc>:

void*
malloc(uint nbytes)
{
    4b3d:	55                   	push   %ebp
    4b3e:	89 e5                	mov    %esp,%ebp
    4b40:	53                   	push   %ebx
    4b41:	83 ec 14             	sub    $0x14,%esp
    4b44:	e8 8a f8 ff ff       	call   43d3 <__x86.get_pc_thunk.bx>
    4b49:	81 c3 27 21 00 00    	add    $0x2127,%ebx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    4b4f:	8b 45 08             	mov    0x8(%ebp),%eax
    4b52:	83 c0 07             	add    $0x7,%eax
    4b55:	c1 e8 03             	shr    $0x3,%eax
    4b58:	83 c0 01             	add    $0x1,%eax
    4b5b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    4b5e:	8b 83 18 48 00 00    	mov    0x4818(%ebx),%eax
    4b64:	89 45 f0             	mov    %eax,-0x10(%ebp)
    4b67:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    4b6b:	75 28                	jne    4b95 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    4b6d:	8d 83 10 48 00 00    	lea    0x4810(%ebx),%eax
    4b73:	89 45 f0             	mov    %eax,-0x10(%ebp)
    4b76:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4b79:	89 83 18 48 00 00    	mov    %eax,0x4818(%ebx)
    4b7f:	8b 83 18 48 00 00    	mov    0x4818(%ebx),%eax
    4b85:	89 83 10 48 00 00    	mov    %eax,0x4810(%ebx)
    base.s.size = 0;
    4b8b:	c7 83 14 48 00 00 00 	movl   $0x0,0x4814(%ebx)
    4b92:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4b95:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4b98:	8b 00                	mov    (%eax),%eax
    4b9a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    4b9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4ba0:	8b 40 04             	mov    0x4(%eax),%eax
    4ba3:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    4ba6:	77 4e                	ja     4bf6 <malloc+0xb9>
      if(p->s.size == nunits)
    4ba8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4bab:	8b 40 04             	mov    0x4(%eax),%eax
    4bae:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    4bb1:	75 0c                	jne    4bbf <malloc+0x82>
        prevp->s.ptr = p->s.ptr;
    4bb3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4bb6:	8b 10                	mov    (%eax),%edx
    4bb8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4bbb:	89 10                	mov    %edx,(%eax)
    4bbd:	eb 26                	jmp    4be5 <malloc+0xa8>
      else {
        p->s.size -= nunits;
    4bbf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4bc2:	8b 40 04             	mov    0x4(%eax),%eax
    4bc5:	2b 45 ec             	sub    -0x14(%ebp),%eax
    4bc8:	89 c2                	mov    %eax,%edx
    4bca:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4bcd:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    4bd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4bd3:	8b 40 04             	mov    0x4(%eax),%eax
    4bd6:	c1 e0 03             	shl    $0x3,%eax
    4bd9:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    4bdc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4bdf:	8b 55 ec             	mov    -0x14(%ebp),%edx
    4be2:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    4be5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4be8:	89 83 18 48 00 00    	mov    %eax,0x4818(%ebx)
      return (void*)(p + 1);
    4bee:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4bf1:	83 c0 08             	add    $0x8,%eax
    4bf4:	eb 3c                	jmp    4c32 <malloc+0xf5>
    }
    if(p == freep)
    4bf6:	8b 83 18 48 00 00    	mov    0x4818(%ebx),%eax
    4bfc:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    4bff:	75 1e                	jne    4c1f <malloc+0xe2>
      if((p = morecore(nunits)) == 0)
    4c01:	83 ec 0c             	sub    $0xc,%esp
    4c04:	ff 75 ec             	push   -0x14(%ebp)
    4c07:	e8 c1 fe ff ff       	call   4acd <morecore>
    4c0c:	83 c4 10             	add    $0x10,%esp
    4c0f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    4c12:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    4c16:	75 07                	jne    4c1f <malloc+0xe2>
        return 0;
    4c18:	b8 00 00 00 00       	mov    $0x0,%eax
    4c1d:	eb 13                	jmp    4c32 <malloc+0xf5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4c1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4c22:	89 45 f0             	mov    %eax,-0x10(%ebp)
    4c25:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4c28:	8b 00                	mov    (%eax),%eax
    4c2a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    4c2d:	e9 6b ff ff ff       	jmp    4b9d <malloc+0x60>
  }
}
    4c32:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    4c35:	c9                   	leave  
    4c36:	c3                   	ret    
