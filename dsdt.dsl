/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20141107-32 [Nov  7 2014]
 * Copyright (c) 2000 - 2014 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of dsdt.dat, Sun May 21 13:13:45 2017
 *
 * Original Table Header:
 *     Signature        "DSDT"
 *     Length           0x0000F3B5 (62389)
 *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
 *     Checksum         0x6F
 *     OEM ID           "UL80V"
 *     OEM Table ID     "UL80V213"
 *     OEM Revision     0x00000213 (531)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20051117 (537202967)
 */
DefinitionBlock ("dsdt.aml", "DSDT", 1, "UL80V", "UL80V213", 0x00000213)
{
    Scope (_PR)
    {
        Processor (P001, 0x01, 0x00000810, 0x06) {}
        Alias (P001, CPU0)
    }

    Scope (_PR)
    {
        Processor (P002, 0x02, 0x00000810, 0x06) {}
        Alias (P002, CPU1)
    }

    Method (WDTS, 1, NotSerialized)
    {
        If ((Arg0 == 0x03))
        {
            TRAP (0x46)
        }

        If ((Arg0 == 0x04))
        {
            If (DTSE)
            {
                TRAP (0x47)
            }

            Notify (\_TZ.THRM, 0x80) // Thermal Status Change
        }
    }

    Method (TRAP, 1, NotSerialized)
    {
        OperationRegion (SSMI, SystemIO, SMIP, One)
        Field (SSMI, ByteAcc, NoLock, Preserve)
        {
            SMIC,   8
        }

        SMIF = Arg0
        SMIC = DTSS /* \DTSS */
    }

    Scope (_SB)
    {
        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            If (DTSE)
            {
                TRAP (0x47)
            }
        }
    }

    Scope (_GPE)
    {
        Method (_L02, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
        {
            GPEC = Zero
            ODTS ()
            Notify (\_TZ.THRM, 0x80) // Thermal Status Change
        }
    }

    Name (DP80, 0x80)
    Name (DP90, 0x90)
    Name (DTSS, 0x5A)
    Name (SMIP, 0xB2)
    Name (PMBS, 0x0800)
    Name (PMLN, 0x80)
    Name (GPBS, 0x0500)
    Name (GPLN, 0x80)
    Name (PM30, 0x0830)
    Name (SUSW, 0xFF)
    Name (APIC, One)
    Name (TOBS, 0x0860)
    Name (SUCC, One)
    Name (NVLD, 0x02)
    Name (CRIT, 0x04)
    Name (NCRT, 0x06)
    Name (LIDS, One)
    Name (PCIB, 0xC0000000)
    Name (PCIL, 0x10000000)
    Name (SMIT, 0xB2)
    Name (CMRQ, 0xB0)
    Name (CMER, 0xB1)
    Name (CMOR, 0xB3)
    Name (MBLF, 0x0A)
    Name (HPIO, 0x025E)
    Name (SMBS, 0x0400)
    Name (SMBL, 0x20)
    Name (IO1B, 0x06C0)
    OperationRegion (BIOS, SystemMemory, 0xBDD82064, 0xFF)
    Field (BIOS, ByteAcc, NoLock, Preserve)
    {
        SS1,    1, 
        SS2,    1, 
        SS3,    1, 
        SS4,    1, 
        Offset (0x01), 
        IOST,   16, 
        TOPM,   32, 
        ROMS,   32, 
        MG1B,   32, 
        MG1L,   32, 
        MG2B,   32, 
        MG2L,   32, 
        Offset (0x1C), 
        DMAX,   8, 
        HPTA,   32, 
        CPB0,   32, 
        CPB1,   32, 
        CPB2,   32, 
        CPB3,   32, 
        ASSB,   8, 
        AOTB,   8, 
        AAXB,   32, 
        SMIF,   8, 
        DTSE,   8, 
        DTS1,   8, 
        DTS2,   8, 
        MPEN,   8, 
        TPMF,   8, 
        MG3B,   32, 
        MG3L,   32, 
        MH1B,   32, 
        MH1L,   32
    }

    Method (RRIO, 4, NotSerialized)
    {
        Debug = "RRIO"
    }

    Method (RDMA, 3, NotSerialized)
    {
        Debug = "rDMA"
    }

    Name (PICM, Zero)
    Method (_PIC, 1, NotSerialized)  // _PIC: Interrupt Model
    {
        If (Arg0)
        {
            DIAG (0xAA)
        }
        Else
        {
            DIAG (0xAC)
        }

        PICM = Arg0
    }

    Name (OSVR, Ones)
    Method (OSFL, 0, NotSerialized)
    {
        If ((OSVR != Ones))
        {
            Return (OSVR) /* \OSVR */
        }

        If ((PICM == Zero))
        {
            DBG8 = 0xAC
        }

        OSVR = One
        If (CondRefOf (_OSI, Local1))
        {
            If (_OSI ("Windows 2000"))
            {
                OSVR = 0x04
            }

            If (_OSI ("Windows 2001"))
            {
                OSVR = Zero
            }

            If (_OSI ("Windows 2001 SP1"))
            {
                OSVR = Zero
            }

            If (_OSI ("Windows 2001 SP2"))
            {
                OSVR = Zero
            }

            If (_OSI ("Windows 2001.1"))
            {
                OSVR = Zero
            }

            If (_OSI ("Windows 2001.1 SP1"))
            {
                OSVR = Zero
            }

            If (_OSI ("Windows 2006"))
            {
                OSVR = Zero
            }
        }
        Else
        {
            If (MCTH (_OS, "Microsoft Windows NT"))
            {
                OSVR = 0x04
            }
            Else
            {
                If (MCTH (_OS, "Microsoft WindowsME: Millennium Edition"))
                {
                    OSVR = 0x02
                }

                If (MCTH (_OS, "Linux"))
                {
                    OSVR = 0x03
                }
            }
        }

        Return (OSVR) /* \OSVR */
    }

    Method (MCTH, 2, NotSerialized)
    {
        If ((SizeOf (Arg0) < SizeOf (Arg1)))
        {
            Return (Zero)
        }

        Local0 = (SizeOf (Arg0) + One)
        Name (BUF0, Buffer (Local0) {})
        Name (BUF1, Buffer (Local0) {})
        BUF0 = Arg0
        BUF1 = Arg1
        While (Local0)
        {
            Local0--
            If ((DerefOf (Index (BUF0, Local0)) != DerefOf (Index (BUF1, Local0
                ))))
            {
                Return (Zero)
            }
        }

        Return (One)
    }

    Name (PRWP, Package (0x02)
    {
        Zero, 
        Zero
    })
    Method (GPRW, 2, NotSerialized)
    {
        Index (PRWP, Zero) = Arg0
        Local0 = (SS1 << One)
        Local0 |= (SS2 << 0x02)
        Local0 |= (SS3 << 0x03)
        Local0 |= (SS4 << 0x04)
        If (((One << Arg1) & Local0))
        {
            Index (PRWP, One) = Arg1
        }
        Else
        {
            Local0 >>= One
            If (((OSFL () == One) || (OSFL () == 0x02)))
            {
                FindSetLeftBit (Local0, Index (PRWP, One))
            }
            Else
            {
                FindSetRightBit (Local0, Index (PRWP, One))
            }
        }

        Return (PRWP) /* \PRWP */
    }

    Name (WAKP, Package (0x02)
    {
        Zero, 
        Zero
    })
    OperationRegion (DEB0, SystemIO, DP80, One)
    Field (DEB0, ByteAcc, NoLock, Preserve)
    {
        DBG8,   8
    }

    OperationRegion (DEB1, SystemIO, DP90, 0x02)
    Field (DEB1, WordAcc, NoLock, Preserve)
    {
        DBG9,   16
    }

    Scope (_SB)
    {
        Name (PR00, Package (0x15)
        {
            Package (0x04)
            {
                0x001FFFFF, 
                Zero, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x001FFFFF, 
                One, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x001FFFFF, 
                0x02, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                Zero, 
                LNKH, 
                Zero
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                One, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                0x02, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                0x03, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x001AFFFF, 
                Zero, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x001AFFFF, 
                One, 
                LNKF, 
                Zero
            }, 

            Package (0x04)
            {
                0x001AFFFF, 
                0x03, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x001AFFFF, 
                0x02, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x001BFFFF, 
                Zero, 
                LNKG, 
                Zero
            }, 

            Package (0x04)
            {
                0x0002FFFF, 
                Zero, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                Zero, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                One, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x02, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x03, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                Zero, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                One, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                0x02, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                0x03, 
                LNKD, 
                Zero
            }
        })
        Name (AR00, Package (0x15)
        {
            Package (0x04)
            {
                0x001FFFFF, 
                Zero, 
                Zero, 
                0x12
            }, 

            Package (0x04)
            {
                0x001FFFFF, 
                One, 
                Zero, 
                0x13
            }, 

            Package (0x04)
            {
                0x001FFFFF, 
                0x02, 
                Zero, 
                0x12
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                Zero, 
                Zero, 
                0x17
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                One, 
                Zero, 
                0x13
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                0x02, 
                Zero, 
                0x12
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                0x03, 
                Zero, 
                0x10
            }, 

            Package (0x04)
            {
                0x001AFFFF, 
                Zero, 
                Zero, 
                0x10
            }, 

            Package (0x04)
            {
                0x001AFFFF, 
                One, 
                Zero, 
                0x15
            }, 

            Package (0x04)
            {
                0x001AFFFF, 
                0x03, 
                Zero, 
                0x13
            }, 

            Package (0x04)
            {
                0x001AFFFF, 
                0x02, 
                Zero, 
                0x12
            }, 

            Package (0x04)
            {
                0x001BFFFF, 
                Zero, 
                Zero, 
                0x16
            }, 

            Package (0x04)
            {
                0x0002FFFF, 
                Zero, 
                Zero, 
                0x10
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                Zero, 
                Zero, 
                0x10
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                One, 
                Zero, 
                0x11
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x02, 
                Zero, 
                0x12
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x03, 
                Zero, 
                0x13
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                Zero, 
                Zero, 
                0x10
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                One, 
                Zero, 
                0x11
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                0x02, 
                Zero, 
                0x12
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                0x03, 
                Zero, 
                0x13
            }
        })
        Name (PR04, Package (0x01)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKC, 
                Zero
            }
        })
        Name (AR04, Package (0x01)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x12
            }
        })
        Name (PR08, Package (0x01)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKB, 
                Zero
            }
        })
        Name (AR08, Package (0x01)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x11
            }
        })
        Name (PR09, Package (0x01)
        {
            Package (0x04)
            {
                0x0003FFFF, 
                Zero, 
                LNKA, 
                Zero
            }
        })
        Name (AR09, Package (0x01)
        {
            Package (0x04)
            {
                0x0003FFFF, 
                Zero, 
                Zero, 
                0x10
            }
        })
        Name (PR01, Package (0x02)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKB, 
                Zero
            }
        })
        Name (AR01, Package (0x02)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x10
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x11
            }
        })
        Name (PR03, Package (0x01)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKB, 
                Zero
            }
        })
        Name (AR03, Package (0x01)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x11
            }
        })
        Name (PRSA, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared, )
                {3,4,5,6,7,10,11,12}
        })
        Name (PRSB, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared, )
                {3,4,5,10,12}
        })
        Name (PRSC, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared, )
                {6}
        })
        Name (PRSD, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared, )
                {3,4,5,7,10,12}
        })
        Alias (PRSC, PRSE)
        Name (PRSF, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared, )
                {3,4,5,6,7,10,12}
        })
        Alias (PRSF, PRSG)
        Alias (PRSF, PRSH)
        Device (PCI0)
        {
            Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
            Name (_ADR, Zero)  // _ADR: Address
            Method (^BN00, 0, NotSerialized)
            {
                Return (Zero)
            }

            Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
            {
                Return (BN00 ())
            }

            Name (_UID, Zero)  // _UID: Unique ID
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    Return (AR00) /* \_SB_.AR00 */
                }

                Return (PR00) /* \_SB_.PR00 */
            }

            Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
            {
                If (((OSFL () == One) || (OSFL () == 0x02)))
                {
                    Return (0x02)
                }
                Else
                {
                    Return (0x03)
                }
            }

            Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
            Device (MCH)
            {
                Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
                Name (_UID, 0x0A)  // _UID: Unique ID
                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    Memory32Fixed (ReadWrite,
                        0xFED10000,         // Address Base
                        0x0000A000,         // Address Length
                        )
                })
            }

            Method (NPTS, 1, NotSerialized)
            {
            }

            Method (NWAK, 1, NotSerialized)
            {
            }

            Device (SBRG)
            {
                Name (_ADR, 0x001F0000)  // _ADR: Address
                Device (IELK)
                {
                    Name (_HID, "AWY0001")  // _HID: Hardware ID
                    OperationRegion (RXA0, PCI_Config, 0xA0, 0x20)
                    Field (RXA0, ByteAcc, NoLock, Preserve)
                    {
                            ,   9, 
                        PBLV,   1, 
                        BCPE,   1, 
                        Offset (0x10), 
                            ,   1, 
                        PBMS,   1, 
                            ,   1, 
                        PMCS,   1, 
                        ECNS,   1, 
                        Offset (0x11), 
                        ECT1,   16, 
                        ELEN,   1, 
                        Offset (0x14)
                    }

                    Method (\_GPE._L0A, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
                    {
                        Notify (\_SB.PCI0.SBRG.IELK, 0x81) // Information Change
                        \_SB.PCI0.SBRG.IELK.PMCS = One
                    }

                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If (ELEN)
                        {
                            Return (0x0F)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }

                    Method (SMOD, 1, NotSerialized)
                    {
                    }

                    Method (GPBS, 0, NotSerialized)
                    {
                        Return ((PBLV ^ One))
                    }
                }

                Method (SPTS, 1, NotSerialized)
                {
                    PS1S = One
                    PS1E = One
                }

                Method (SWAK, 1, NotSerialized)
                {
                    PS1E = Zero
                }

                OperationRegion (APMP, SystemIO, SMIP, 0x02)
                Field (APMP, ByteAcc, NoLock, Preserve)
                {
                    APMC,   8, 
                    APMS,   8
                }

                Field (APMP, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x01), 
                        ,   1, 
                    BRTC,   1
                }

                OperationRegion (PMS0, SystemIO, PMBS, 0x04)
                Field (PMS0, ByteAcc, NoLock, Preserve)
                {
                        ,   10, 
                    RTCS,   1, 
                        ,   4, 
                    WAKS,   1, 
                    Offset (0x03), 
                    PWBT,   1, 
                    Offset (0x04)
                }

                OperationRegion (SMIE, SystemIO, PM30, 0x08)
                Field (SMIE, ByteAcc, NoLock, Preserve)
                {
                        ,   4, 
                    PS1E,   1, 
                        ,   31, 
                    PS1S,   1, 
                    Offset (0x08)
                }

                Device (PIC)
                {
                    Name (_HID, EisaId ("PNP0000") /* 8259-compatible Programmable Interrupt Controller */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0020,             // Range Minimum
                            0x0020,             // Range Maximum
                            0x00,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A0,             // Range Minimum
                            0x00A0,             // Range Maximum
                            0x00,               // Alignment
                            0x02,               // Length
                            )
                        IRQNoFlags ()
                            {2}
                    })
                }

                Device (DMAD)
                {
                    Name (_HID, EisaId ("PNP0200") /* PC-class DMA Controller */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        DMA (Compatibility, BusMaster, Transfer8, )
                            {4}
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x00,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x0081,             // Range Minimum
                            0x0081,             // Range Maximum
                            0x00,               // Alignment
                            0x03,               // Length
                            )
                        IO (Decode16,
                            0x0087,             // Range Minimum
                            0x0087,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0089,             // Range Minimum
                            0x0089,             // Range Maximum
                            0x00,               // Alignment
                            0x03,               // Length
                            )
                        IO (Decode16,
                            0x008F,             // Range Minimum
                            0x008F,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x00C0,             // Range Minimum
                            0x00C0,             // Range Maximum
                            0x00,               // Alignment
                            0x20,               // Length
                            )
                    })
                }

                Device (TMR)
                {
                    Name (_HID, EisaId ("PNP0100") /* PC-class System Timer */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0040,             // Range Minimum
                            0x0040,             // Range Maximum
                            0x00,               // Alignment
                            0x04,               // Length
                            )
                        IRQNoFlags ()
                            {0}
                    })
                }

                Device (RTC0)
                {
                    Name (_HID, EisaId ("PNP0B00") /* AT Real-Time Clock */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0070,             // Range Minimum
                            0x0070,             // Range Maximum
                            0x00,               // Alignment
                            0x02,               // Length
                            )
                        IRQNoFlags ()
                            {8}
                    })
                }

                Device (PS2K)
                {
                    Name (_HID, EisaId ("PNP0303") /* IBM Enhanced Keyboard (101/102-key, PS/2 Mouse) */)  // _HID: Hardware ID
                    Name (_CID, EisaId ("PNP030B"))  // _CID: Compatible ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Local0 = (One << 0x0A)
                        If ((IOST & Local0))
                        {
                            Return (0x0F)
                        }

                        Return (Zero)
                    }

                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0060,             // Range Minimum
                            0x0060,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0064,             // Range Minimum
                            0x0064,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                        IRQNoFlags ()
                            {1}
                    })
                }

                Device (PS2M)
                {
                    Method (_HID, 0, NotSerialized)  // _HID: Hardware ID
                    {
                        If (SYNA)
                        {
                            Return (0x060A2E4F)
                        }

                        If (ALPS)
                        {
                            Return (0x0713A906)
                        }

                        If (ELAN)
                        {
                            Return (0x01008416)
                        }

                        Return (0x060A2E4F)
                    }

                    Name (CID1, Package (0x05)
                    {
                        0x000A2E4F, 
                        0x02002E4F, 
                        0x030FD041, 
                        0x130FD041, 
                        0x120FD041
                    })
                    Name (CID2, Package (0x05)
                    {
                        0x0E0FD041, 
                        0x0B0FD041, 
                        0x030FD041, 
                        0x130FD041, 
                        0x120FD041
                    })
                    Method (_CID, 0, NotSerialized)  // _CID: Compatible ID
                    {
                        If (SYNA)
                        {
                            Return (CID1) /* \_SB_.PCI0.SBRG.PS2M.CID1 */
                        }

                        If (ALPS)
                        {
                            Return (CID1) /* \_SB_.PCI0.SBRG.PS2M.CID1 */
                        }

                        If (ELAN)
                        {
                            Return (CID2) /* \_SB_.PCI0.SBRG.PS2M.CID2 */
                        }

                        Return (CID1) /* \_SB_.PCI0.SBRG.PS2M.CID1 */
                    }

                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Local0 = (One << 0x0C)
                        If ((IOST & Local0))
                        {
                            Return (0x0F)
                        }

                        Return (Zero)
                    }

                    Name (CRS1, ResourceTemplate ()
                    {
                        IRQNoFlags ()
                            {12}
                    })
                    Name (CRS2, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0060,             // Range Minimum
                            0x0060,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0064,             // Range Minimum
                            0x0064,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                        IRQNoFlags ()
                            {12}
                    })
                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        Local0 = (One << 0x0A)
                        If ((IOST & Local0))
                        {
                            Return (CRS1) /* \_SB_.PCI0.SBRG.PS2M.CRS1 */
                        }
                        Else
                        {
                            Return (CRS2) /* \_SB_.PCI0.SBRG.PS2M.CRS2 */
                        }
                    }
                }

                Device (SPKR)
                {
                    Name (_HID, EisaId ("PNP0800") /* Microsoft Sound System Compatible Device */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0061,             // Range Minimum
                            0x0061,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                    })
                }

                Device (COPR)
                {
                    Name (_HID, EisaId ("PNP0C04") /* x87-compatible Floating Point Processing Unit */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x00F0,             // Range Minimum
                            0x00F0,             // Range Maximum
                            0x00,               // Alignment
                            0x10,               // Length
                            )
                        IRQNoFlags ()
                            {13}
                    })
                }

                Device (RMSC)
                {
                    Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
                    Name (_UID, 0x10)  // _UID: Unique ID
                    Name (CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0010,             // Range Minimum
                            0x0010,             // Range Maximum
                            0x00,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x0022,             // Range Minimum
                            0x0022,             // Range Maximum
                            0x00,               // Alignment
                            0x1E,               // Length
                            )
                        IO (Decode16,
                            0x0044,             // Range Minimum
                            0x0044,             // Range Maximum
                            0x00,               // Alignment
                            0x1C,               // Length
                            )
                        IO (Decode16,
                            0x0063,             // Range Minimum
                            0x0063,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0065,             // Range Minimum
                            0x0065,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0067,             // Range Minimum
                            0x0067,             // Range Maximum
                            0x00,               // Alignment
                            0x09,               // Length
                            )
                        IO (Decode16,
                            0x0072,             // Range Minimum
                            0x0072,             // Range Maximum
                            0x00,               // Alignment
                            0x0E,               // Length
                            )
                        IO (Decode16,
                            0x0080,             // Range Minimum
                            0x0080,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0084,             // Range Minimum
                            0x0084,             // Range Maximum
                            0x00,               // Alignment
                            0x03,               // Length
                            )
                        IO (Decode16,
                            0x0088,             // Range Minimum
                            0x0088,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x008C,             // Range Minimum
                            0x008C,             // Range Maximum
                            0x00,               // Alignment
                            0x03,               // Length
                            )
                        IO (Decode16,
                            0x0090,             // Range Minimum
                            0x0090,             // Range Maximum
                            0x00,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x00A2,             // Range Minimum
                            0x00A2,             // Range Maximum
                            0x00,               // Alignment
                            0x1E,               // Length
                            )
                        IO (Decode16,
                            0x00E0,             // Range Minimum
                            0x00E0,             // Range Maximum
                            0x00,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x04D0,             // Range Minimum
                            0x04D0,             // Range Maximum
                            0x00,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x04C0,             // Range Minimum
                            0x04C0,             // Range Maximum
                            0x00,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x04D2,             // Range Minimum
                            0x04D2,             // Range Maximum
                            0x00,               // Alignment
                            0x2E,               // Length
                            )
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x00,               // Alignment
                            0x00,               // Length
                            _Y00)
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x00,               // Alignment
                            0x00,               // Length
                            _Y01)
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x00,               // Alignment
                            0x00,               // Length
                            _Y03)
                        DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                            0x00000000,         // Granularity
                            0x00000000,         // Range Minimum
                            0x00000000,         // Range Maximum
                            0x00000000,         // Translation Offset
                            0x00000000,         // Length
                            ,, _Y02, AddressRangeMemory, TypeStatic)
                        Memory32Fixed (ReadWrite,
                            0xFED1C000,         // Address Base
                            0x00004000,         // Address Length
                            )
                        Memory32Fixed (ReadWrite,
                            0xFED20000,         // Address Base
                            0x00020000,         // Address Length
                            )
                        Memory32Fixed (ReadWrite,
                            0xFED45000,         // Address Base
                            0x00045000,         // Address Length
                            )
                        Memory32Fixed (ReadWrite,
                            0xFED90000,         // Address Base
                            0x00001000,         // Address Length
                            )
                        Memory32Fixed (ReadWrite,
                            0xFED91000,         // Address Base
                            0x00001000,         // Address Length
                            )
                        Memory32Fixed (ReadWrite,
                            0xFED92000,         // Address Base
                            0x00001000,         // Address Length
                            )
                        Memory32Fixed (ReadWrite,
                            0xFED93000,         // Address Base
                            0x00001000,         // Address Length
                            )
                        Memory32Fixed (ReadWrite,
                            0xFFB00000,         // Address Base
                            0x00100000,         // Address Length
                            )
                        Memory32Fixed (ReadWrite,
                            0xFFF00000,         // Address Base
                            0x00100000,         // Address Length
                            )
                    })
                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        CreateWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y00._MIN, GP00)  // _MIN: Minimum Base Address
                        CreateWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y00._MAX, GP01)  // _MAX: Maximum Base Address
                        CreateByteField (CRS, \_SB.PCI0.SBRG.RMSC._Y00._LEN, GP0L)  // _LEN: Length
                        GP00 = PMBS /* \PMBS */
                        GP01 = PMBS /* \PMBS */
                        GP0L = PMLN /* \PMLN */
                        If (SMBS)
                        {
                            CreateWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y01._MIN, GP10)  // _MIN: Minimum Base Address
                            CreateWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y01._MAX, GP11)  // _MAX: Maximum Base Address
                            CreateByteField (CRS, \_SB.PCI0.SBRG.RMSC._Y01._LEN, GP1L)  // _LEN: Length
                            GP10 = SMBS /* \SMBS */
                            GP11 = SMBS /* \SMBS */
                            GP1L = SMBL /* \SMBL */
                            CreateDWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y02._MIN, BMIN)  // _MIN: Minimum Base Address
                            CreateDWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y02._MAX, BMAX)  // _MAX: Maximum Base Address
                            CreateDWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y02._LEN, BLEN)  // _LEN: Length
                            BMIN = SMEM /* \SMEM */
                            BLEN = 0x0100
                            BMAX = (BMIN + BLEN--)
                        }

                        If (GPBS)
                        {
                            CreateWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y03._MIN, GP20)  // _MIN: Minimum Base Address
                            CreateWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y03._MAX, GP21)  // _MAX: Maximum Base Address
                            CreateByteField (CRS, \_SB.PCI0.SBRG.RMSC._Y03._LEN, GP2L)  // _LEN: Length
                            GP20 = GPBS /* \GPBS */
                            GP21 = GPBS /* \GPBS */
                            GP2L = GPLN /* \GPLN */
                        }

                        Return (CRS) /* \_SB_.PCI0.SBRG.RMSC.CRS_ */
                    }
                }

                Device (HPET)
                {
                    Name (_HID, EisaId ("PNP0103") /* HPET System Timer */)  // _HID: Hardware ID
                    Name (CRS, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadOnly,
                            0xFED00000,         // Address Base
                            0x00000400,         // Address Length
                            _Y04)
                    })
                    OperationRegion (^LPCR, SystemMemory, 0xFED1F404, 0x04)
                    Field (LPCR, AnyAcc, NoLock, Preserve)
                    {
                        HPTS,   2, 
                            ,   5, 
                        HPTE,   1, 
                        Offset (0x04)
                    }

                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If ((OSFL () == Zero))
                        {
                            If (HPTE)
                            {
                                Return (0x0F)
                            }
                        }
                        Else
                        {
                            If (HPTE)
                            {
                                Return (0x0B)
                            }
                        }

                        Return (Zero)
                    }

                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        CreateDWordField (CRS, \_SB.PCI0.SBRG.HPET._Y04._BAS, HPT)  // _BAS: Base Address
                        Local0 = (HPTS * 0x1000)
                        HPT = (Local0 + 0xFED00000)
                        Return (CRS) /* \_SB_.PCI0.SBRG.HPET.CRS_ */
                    }
                }

                OperationRegion (RX80, PCI_Config, Zero, 0xFF)
                Field (RX80, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x80), 
                    LPCD,   16, 
                    LPCE,   16
                }

                Name (DBPT, Package (0x04)
                {
                    Package (0x08)
                    {
                        0x03F8, 
                        0x02F8, 
                        0x0220, 
                        0x0228, 
                        0x0238, 
                        0x02E8, 
                        0x0338, 
                        0x03E8
                    }, 

                    Package (0x08)
                    {
                        0x03F8, 
                        0x02F8, 
                        0x0220, 
                        0x0228, 
                        0x0238, 
                        0x02E8, 
                        0x0338, 
                        0x03E8
                    }, 

                    Package (0x03)
                    {
                        0x0378, 
                        0x0278, 
                        0x03BC
                    }, 

                    Package (0x02)
                    {
                        0x03F0, 
                        0x0370
                    }
                })
                Name (DDLT, Package (0x04)
                {
                    Package (0x02)
                    {
                        Zero, 
                        0xFFF8
                    }, 

                    Package (0x02)
                    {
                        0x04, 
                        0xFF8F
                    }, 

                    Package (0x02)
                    {
                        0x08, 
                        0xFCFF
                    }, 

                    Package (0x02)
                    {
                        0x0C, 
                        0xEFFF
                    }
                })
                Method (RRIO, 4, NotSerialized)
                {
                    If (((Arg0 <= 0x03) && (Arg0 >= Zero)))
                    {
                        Local0 = Match (DerefOf (Index (DBPT, Arg0)), MEQ, Arg2, MTR, Zero, 
                            Zero)
                        If ((Local0 != Ones))
                        {
                            Local1 = DerefOf (Index (DerefOf (Index (DDLT, Arg0)), Zero))
                            Local2 = DerefOf (Index (DerefOf (Index (DDLT, Arg0)), One))
                            Local0 <<= Local1
                            LPCD &= Local2
                            LPCD |= Local0
                            WX82 (Arg0, Arg1)
                        }
                    }

                    If ((Arg0 == 0x08))
                    {
                        If ((Arg2 == 0x0200))
                        {
                            WX82 (0x08, Arg0)
                        }
                        Else
                        {
                            If ((Arg2 == 0x0208))
                            {
                                WX82 (0x09, Arg0)
                            }
                        }
                    }

                    If (((Arg0 <= 0x0D) && (Arg0 >= 0x0A)))
                    {
                        WX82 (Arg0, Arg1)
                    }
                }

                Method (WX82, 2, NotSerialized)
                {
                    Local0 = (One << Arg0)
                    If (Arg1)
                    {
                        LPCE |= Local0
                    }
                    Else
                    {
                        Local0 = ~Local0
                        LPCE &= Local0
                    }
                }

                Method (RDMA, 3, NotSerialized)
                {
                }

                Device (FWH)
                {
                    Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
                    Name (_UID, 0x02)  // _UID: Unique ID
                    Name (CRS, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadOnly,
                            0x00000000,         // Address Base
                            0x00000000,         // Address Length
                            _Y05)
                        Memory32Fixed (ReadOnly,
                            0x00000000,         // Address Base
                            0x00000000,         // Address Length
                            _Y06)
                    })
                    CreateDWordField (CRS, \_SB.PCI0.SBRG.FWH._Y05._BAS, BS00)  // _BAS: Base Address
                    CreateDWordField (CRS, \_SB.PCI0.SBRG.FWH._Y05._LEN, BL00)  // _LEN: Length
                    CreateDWordField (CRS, \_SB.PCI0.SBRG.FWH._Y06._BAS, BS10)  // _BAS: Base Address
                    CreateDWordField (CRS, \_SB.PCI0.SBRG.FWH._Y06._LEN, BL10)  // _LEN: Length
                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        Local0 = 0xFF800000
                        FindSetRightBit (FHD0, Local1)
                        Local1--
                        If (Local1)
                        {
                            Local1 *= 0x00080000
                        }

                        Local2 = (Local0 + Local1)
                        BS00 = Local2
                        BS10 = (BS00 + 0x00400000)
                        BL00 = (Zero - BS10) /* \_SB_.PCI0.SBRG.FWH_.BS10 */
                        BL10 = BL00 /* \_SB_.PCI0.SBRG.FWH_.BL00 */
                        Return (CRS) /* \_SB_.PCI0.SBRG.FWH_.CRS_ */
                    }
                }

                Device (FWHE)
                {
                    Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
                    Name (_UID, 0x03)  // _UID: Unique ID
                    Name (CRS, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadOnly,
                            0x00000000,         // Address Base
                            0x00000000,         // Address Length
                            _Y07)
                    })
                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        CreateDWordField (CRS, \_SB.PCI0.SBRG.FWHE._Y07._BAS, BS00)  // _BAS: Base Address
                        CreateDWordField (CRS, \_SB.PCI0.SBRG.FWHE._Y07._LEN, BL00)  // _LEN: Length
                        If ((^^FWH.BS00 == Zero))
                        {
                            ^^FWH._CRS ()
                        }

                        BS00 = (^^FWH.BS00 + ^^FWH.BL00) /* \_SB_.PCI0.SBRG.FWH_.BL00 */
                        BL00 = (^^FWH.BS10 - BS00) /* \_SB_.PCI0.SBRG.FWHE._CRS.BS00 */
                        Return (CRS) /* \_SB_.PCI0.SBRG.FWHE.CRS_ */
                    }
                }

                OperationRegion (FHR0, PCI_Config, 0xE3, One)
                Field (FHR0, ByteAcc, NoLock, Preserve)
                {
                    FHD0,   8
                }

                Device (^PCIE)
                {
                    Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
                    Name (_UID, 0x11)  // _UID: Unique ID
                    Name (CRS, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadOnly,
                            0xC0000000,         // Address Base
                            0x10000000,         // Address Length
                            _Y08)
                    })
                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        CreateDWordField (CRS, \_SB.PCI0.PCIE._Y08._BAS, BAS1)  // _BAS: Base Address
                        CreateDWordField (CRS, \_SB.PCI0.PCIE._Y08._LEN, LEN1)  // _LEN: Length
                        BAS1 = PCIB /* \PCIB */
                        LEN1 = PCIL /* \PCIL */
                        Return (CRS) /* \_SB_.PCI0.PCIE.CRS_ */
                    }
                }

                Device (OMSC)
                {
                    Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
                    Name (_UID, Zero)  // _UID: Unique ID
                    Name (CRS, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadOnly,
                            0x00000000,         // Address Base
                            0x00000000,         // Address Length
                            _Y09)
                        Memory32Fixed (ReadOnly,
                            0x00000000,         // Address Base
                            0x00000000,         // Address Length
                            _Y0A)
                        Memory32Fixed (ReadOnly,
                            0xFEC18000,         // Address Base
                            0x00008000,         // Address Length
                            )
                        Memory32Fixed (ReadOnly,
                            0xFEC38000,         // Address Base
                            0x00008000,         // Address Length
                            )
                        IO (Decode16,
                            0x0250,             // Range Minimum
                            0x0253,             // Range Maximum
                            0x01,               // Alignment
                            0x04,               // Length
                            )
                        IO (Decode16,
                            0x0256,             // Range Minimum
                            0x025F,             // Range Maximum
                            0x01,               // Alignment
                            0x0A,               // Length
                            )
                    })
                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        If (APIC)
                        {
                            CreateDWordField (CRS, \_SB.PCI0.SBRG.OMSC._Y09._LEN, ML01)  // _LEN: Length
                            CreateDWordField (CRS, \_SB.PCI0.SBRG.OMSC._Y09._BAS, MB01)  // _BAS: Base Address
                            CreateDWordField (CRS, \_SB.PCI0.SBRG.OMSC._Y0A._LEN, ML02)  // _LEN: Length
                            CreateDWordField (CRS, \_SB.PCI0.SBRG.OMSC._Y0A._BAS, MB02)  // _BAS: Base Address
                            MB01 = 0xFEC00000
                            ML01 = 0x1000
                            MB02 = 0xFEE00000
                            ML02 = 0x1000
                        }

                        Return (CRS) /* \_SB_.PCI0.SBRG.OMSC.CRS_ */
                    }
                }

                Device (^^RMEM)
                {
                    Name (_HID, EisaId ("PNP0C01") /* System Board */)  // _HID: Hardware ID
                    Name (_UID, One)  // _UID: Unique ID
                    Name (CRS, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadWrite,
                            0x00000000,         // Address Base
                            0x000A0000,         // Address Length
                            )
                        Memory32Fixed (ReadOnly,
                            0x00000000,         // Address Base
                            0x00000000,         // Address Length
                            _Y0B)
                        Memory32Fixed (ReadOnly,
                            0x000E0000,         // Address Base
                            0x00020000,         // Address Length
                            _Y0C)
                        Memory32Fixed (ReadWrite,
                            0x00100000,         // Address Base
                            0x00000000,         // Address Length
                            _Y0D)
                        Memory32Fixed (ReadOnly,
                            0x00000000,         // Address Base
                            0x00000000,         // Address Length
                            _Y0E)
                    })
                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        CreateDWordField (CRS, \_SB.RMEM._Y0B._BAS, BAS1)  // _BAS: Base Address
                        CreateDWordField (CRS, \_SB.RMEM._Y0B._LEN, LEN1)  // _LEN: Length
                        CreateDWordField (CRS, \_SB.RMEM._Y0C._BAS, BAS2)  // _BAS: Base Address
                        CreateDWordField (CRS, \_SB.RMEM._Y0C._LEN, LEN2)  // _LEN: Length
                        CreateDWordField (CRS, \_SB.RMEM._Y0D._LEN, LEN3)  // _LEN: Length
                        CreateDWordField (CRS, \_SB.RMEM._Y0E._BAS, BAS4)  // _BAS: Base Address
                        CreateDWordField (CRS, \_SB.RMEM._Y0E._LEN, LEN4)  // _LEN: Length
                        If (OSFL ()) {}
                        Else
                        {
                            If (MG1B)
                            {
                                If ((MG1B > 0x000C0000))
                                {
                                    BAS1 = 0x000C0000
                                    LEN1 = (MG1B - BAS1) /* \_SB_.RMEM._CRS.BAS1 */
                                }
                            }
                            Else
                            {
                                BAS1 = 0x000C0000
                                LEN1 = 0x00020000
                            }

                            If (Local0 = (MG1B + MG1L) /* \MG1L */)
                            {
                                BAS2 = Local0
                                LEN2 = (0x00100000 - BAS2) /* \_SB_.RMEM._CRS.BAS2 */
                            }
                        }

                        LEN3 = (MG2B - 0x00100000)
                        BAS4 = (MG2B + MG2L) /* \MG2L */
                        LEN4 = (Zero - BAS4) /* \_SB_.RMEM._CRS.BAS4 */
                        Return (CRS) /* \_SB_.RMEM.CRS_ */
                    }
                }

                Device (DSIO)
                {
                    Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
                    Name (_UID, 0x05)  // _UID: Unique ID
                    Name (CRS1, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0260,             // Range Minimum
                            0x0260,             // Range Maximum
                            0x00,               // Alignment
                            0x10,               // Length
                            )
                    })
                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        Return (CRS1) /* \_SB_.PCI0.SBRG.DSIO.CRS1 */
                    }

                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If (ACRD)
                        {
                            Return (0x1F)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }
                }
            }

            Device (IDE0)
            {
                Name (_ADR, 0x001F0002)  // _ADR: Address
                Name (REGF, One)
                Method (_REG, 2, NotSerialized)  // _REG: Region Availability
                {
                    If ((Arg0 == 0x02))
                    {
                        REGF = Arg1
                    }
                }

                OperationRegion (BAR0, PCI_Config, Zero, 0x0100)
                Field (BAR0, DWordAcc, NoLock, Preserve)
                {
                    VDID,   32, 
                    Offset (0x0A), 
                    SCCR,   8, 
                    BCCR,   8, 
                    Offset (0x40), 
                    TIMP,   16, 
                    TIMS,   16, 
                    STMP,   4, 
                    STMS,   4, 
                    Offset (0x48), 
                    UDMP,   2, 
                    UDMS,   2, 
                    Offset (0x4A), 
                    UDTP,   6, 
                    Offset (0x4B), 
                    UDTS,   6, 
                    Offset (0x54), 
                    PCB0,   2, 
                    SCB0,   2, 
                        ,   8, 
                    FPB0,   2, 
                    FSB0,   2, 
                    PSIG,   2, 
                    SSIG,   2, 
                    Offset (0x90), 
                    MAPV,   2, 
                        ,   4, 
                    SMS,    2, 
                    Offset (0x92), 
                    P0EN,   1, 
                    P1EN,   1, 
                    P2EN,   1, 
                    P3EN,   1, 
                    P4EN,   1, 
                    P5EN,   1, 
                        ,   1, 
                    Offset (0x93), 
                    P0PF,   1, 
                    P1PF,   1, 
                    P2PF,   1, 
                    P3PF,   1, 
                    P4PF,   1, 
                    P5PF,   1, 
                        ,   1, 
                    Offset (0x94)
                }

                Name (TIM0, Package (0x09)
                {
                    Package (0x04)
                    {
                        0x78, 
                        0xB4, 
                        0xF0, 
                        0x0384
                    }, 

                    Package (0x04)
                    {
                        0x23, 
                        0x21, 
                        0x10, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x0B, 
                        0x09, 
                        0x04, 
                        Zero
                    }, 

                    Package (0x07)
                    {
                        0x70, 
                        0x49, 
                        0x36, 
                        0x27, 
                        0x19, 
                        0x10, 
                        0x0D
                    }, 

                    Package (0x07)
                    {
                        Zero, 
                        One, 
                        0x02, 
                        One, 
                        0x02, 
                        One, 
                        0x02
                    }, 

                    Package (0x07)
                    {
                        Zero, 
                        Zero, 
                        Zero, 
                        One, 
                        One, 
                        One, 
                        One
                    }, 

                    Package (0x07)
                    {
                        Zero, 
                        Zero, 
                        Zero, 
                        Zero, 
                        Zero, 
                        One, 
                        One
                    }, 

                    Package (0x04)
                    {
                        0x04, 
                        0x03, 
                        0x02, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x02, 
                        One, 
                        Zero, 
                        Zero
                    }
                })
                Name (TMD0, Buffer (0x14) {})
                CreateDWordField (TMD0, Zero, PIO0)
                CreateDWordField (TMD0, 0x04, DMA0)
                CreateDWordField (TMD0, 0x08, PIO1)
                CreateDWordField (TMD0, 0x0C, DMA1)
                CreateDWordField (TMD0, 0x10, CHNF)
                Name (GTIM, Zero)
                Name (GSTM, Zero)
                Name (GUDM, Zero)
                Name (GUDT, Zero)
                Name (GCB0, Zero)
                Name (GFB0, Zero)
                Device (CHN0)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Method (_GTM, 0, NotSerialized)  // _GTM: Get Timing Mode
                    {
                        Return (GTM (TIMP, STMP, UDMP, UDTP, PCB0, FPB0))
                    }

                    Method (_STM, 3, NotSerialized)  // _STM: Set Timing Mode
                    {
                        Debug = Arg0
                        TMD0 = Arg0
                        GTIM = TIMP /* \_SB_.PCI0.IDE0.TIMP */
                        GUDT = UDTP /* \_SB_.PCI0.IDE0.UDTP */
                        If (STM ())
                        {
                            TIMP = GTIM /* \_SB_.PCI0.IDE0.GTIM */
                            STMP = GSTM /* \_SB_.PCI0.IDE0.GSTM */
                            UDMP = GUDM /* \_SB_.PCI0.IDE0.GUDM */
                            UDTP = GUDT /* \_SB_.PCI0.IDE0.GUDT */
                            PCB0 = GCB0 /* \_SB_.PCI0.IDE0.GCB0 */
                            FPB0 = GFB0 /* \_SB_.PCI0.IDE0.GFB0 */
                        }

                        ATA0 = GTF (Zero, Arg1)
                        ATA1 = GTF (One, Arg2)
                    }

                    Device (DRV0)
                    {
                        Name (_ADR, Zero)  // _ADR: Address
                        Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                        {
                            Return (RATA (ATA0))
                        }
                    }

                    Device (DRV1)
                    {
                        Name (_ADR, One)  // _ADR: Address
                        Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                        {
                            Return (RATA (ATA1))
                        }
                    }
                }

                Device (CHN1)
                {
                    Name (_ADR, One)  // _ADR: Address
                    Method (_GTM, 0, NotSerialized)  // _GTM: Get Timing Mode
                    {
                        Return (GTM (TIMS, STMS, UDMS, UDTS, SCB0, FSB0))
                    }

                    Method (_STM, 3, NotSerialized)  // _STM: Set Timing Mode
                    {
                        Debug = Arg0
                        TMD0 = Arg0
                        GTIM = TIMS /* \_SB_.PCI0.IDE0.TIMS */
                        GUDT = UDTS /* \_SB_.PCI0.IDE0.UDTS */
                        If (STM ())
                        {
                            TIMS = GTIM /* \_SB_.PCI0.IDE0.GTIM */
                            STMS = GSTM /* \_SB_.PCI0.IDE0.GSTM */
                            UDMS = GUDM /* \_SB_.PCI0.IDE0.GUDM */
                            UDTS = GUDT /* \_SB_.PCI0.IDE0.GUDT */
                            SCB0 = GCB0 /* \_SB_.PCI0.IDE0.GCB0 */
                            FSB0 = GFB0 /* \_SB_.PCI0.IDE0.GFB0 */
                        }

                        ATA2 = GTF (Zero, Arg1)
                        ATA3 = GTF (One, Arg2)
                    }

                    Device (DRV0)
                    {
                        Name (_ADR, Zero)  // _ADR: Address
                        Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                        {
                            Return (RATA (ATA2))
                        }
                    }

                    Device (DRV1)
                    {
                        Name (_ADR, One)  // _ADR: Address
                        Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                        {
                            Return (RATA (ATA3))
                        }
                    }
                }

                Method (GTM, 6, Serialized)
                {
                    PIO0 = Ones
                    PIO1 = PIO0 /* \_SB_.PCI0.IDE0.PIO0 */
                    DMA0 = PIO0 /* \_SB_.PCI0.IDE0.PIO0 */
                    DMA1 = PIO0 /* \_SB_.PCI0.IDE0.PIO0 */
                    CHNF = Zero
                    If (REGF) {}
                    Else
                    {
                        Return (TMD0) /* \_SB_.PCI0.IDE0.TMD0 */
                    }

                    If ((Arg0 & 0x02))
                    {
                        CHNF |= 0x02
                    }

                    Local5 = ((Arg0 & 0x3300) >> 0x08)
                    Local6 = Match (DerefOf (Index (TIM0, One)), MLE, Local5, MTR, Zero, 
                        Zero)
                    Local7 = DerefOf (Index (DerefOf (Index (TIM0, Zero)), Local6))
                    DMA0 = Local7
                    If ((Arg0 & 0x08))
                    {
                        PIO0 = 0x0384
                    }
                    Else
                    {
                        PIO0 = Local7
                    }

                    If ((Arg0 & 0x20))
                    {
                        CHNF |= 0x08
                    }

                    If ((Arg0 & 0x4000))
                    {
                        CHNF |= 0x10
                        Local5 = Match (DerefOf (Index (TIM0, 0x02)), MLE, Arg1, MTR, Zero, 
                            Zero)
                        Local6 = DerefOf (Index (DerefOf (Index (TIM0, Zero)), Local5))
                        DMA1 = Local6
                        If ((Arg0 & 0x80))
                        {
                            PIO1 = 0x0384
                        }
                        Else
                        {
                            PIO1 = Local6
                        }
                    }

                    If ((Arg2 & One))
                    {
                        Local5 = (Arg3 & 0x03)
                        If ((Arg5 & One))
                        {
                            Local5 += 0x04
                        }
                        Else
                        {
                            If ((Arg4 & One))
                            {
                                Local5 += 0x02
                            }
                        }

                        DMA0 = DerefOf (Index (DerefOf (Index (TIM0, 0x03)), Local5))
                        CHNF |= One
                    }

                    If ((Arg2 & 0x02))
                    {
                        Local5 = ((Arg3 >> 0x04) & 0x03)
                        If ((Arg5 & 0x02))
                        {
                            Local5 += 0x04
                        }
                        Else
                        {
                            If ((Arg4 & 0x02))
                            {
                                Local5 += 0x02
                            }
                        }

                        DMA1 = DerefOf (Index (DerefOf (Index (TIM0, 0x03)), Local5))
                        CHNF |= 0x04
                    }

                    Debug = TMD0 /* \_SB_.PCI0.IDE0.TMD0 */
                    Return (TMD0) /* \_SB_.PCI0.IDE0.TMD0 */
                }

                Method (STM, 0, Serialized)
                {
                    If (REGF) {}
                    Else
                    {
                        Return (Zero)
                    }

                    GTIM &= 0x8044
                    GSTM = Zero
                    GUDM = Zero
                    GCB0 = Zero
                    GUDT &= 0xCC
                    GFB0 = Zero
                    If ((CHNF & One))
                    {
                        Local0 = Match (DerefOf (Index (TIM0, 0x03)), MLE, DMA0, MTR, Zero, 
                            Zero)
                        If ((Local0 > 0x06))
                        {
                            Local0 = 0x06
                        }

                        GUDT |= DerefOf (Index (DerefOf (Index (TIM0, 0x04)), Local0))
                        GCB0 |= DerefOf (Index (DerefOf (Index (TIM0, 0x05)), Local0))
                        GFB0 |= DerefOf (Index (DerefOf (Index (TIM0, 0x06)), Local0))
                        GUDM |= One
                    }
                    Else
                    {
                        If (((PIO0 == Ones) | (PIO0 == Zero)))
                        {
                            If (((DMA0 < Ones) & (DMA0 > Zero)))
                            {
                                PIO0 = DMA0 /* \_SB_.PCI0.IDE0.DMA0 */
                                GTIM |= 0x08
                            }
                        }
                    }

                    If ((CHNF & 0x04))
                    {
                        Local0 = Match (DerefOf (Index (TIM0, 0x03)), MLE, DMA1, MTR, Zero, 
                            Zero)
                        If ((Local0 > 0x06))
                        {
                            Local0 = 0x06
                        }

                        GUDT |= (DerefOf (Index (DerefOf (Index (TIM0, 0x04)), Local0)) << 
                            0x04)
                        GCB0 |= (DerefOf (Index (DerefOf (Index (TIM0, 0x05)), Local0)) << 
                            One)
                        GFB0 |= (DerefOf (Index (DerefOf (Index (TIM0, 0x06)), Local0)) << 
                            One)
                        GUDM |= 0x02
                    }
                    Else
                    {
                        If (((PIO1 == Ones) | (PIO1 == Zero)))
                        {
                            If (((DMA1 < Ones) & (DMA1 > Zero)))
                            {
                                PIO1 = DMA1 /* \_SB_.PCI0.IDE0.DMA1 */
                                GTIM |= 0x80
                            }
                        }
                    }

                    If ((CHNF & 0x02))
                    {
                        GTIM |= 0x03
                    }

                    If ((CHNF & 0x08))
                    {
                        GTIM |= 0x30
                    }

                    Local0 = (Match (DerefOf (Index (TIM0, Zero)), MGE, PIO0, MTR, Zero, 
                        Zero) & 0x03)
                    Local1 = DerefOf (Index (DerefOf (Index (TIM0, One)), Local0))
                    Local2 = (Local1 << 0x08)
                    GTIM |= Local2
                    If ((CHNF & 0x10))
                    {
                        GTIM |= 0x4000
                        Local0 = (Match (DerefOf (Index (TIM0, Zero)), MGE, PIO1, MTR, Zero, 
                            Zero) & 0x03)
                        GSTM = DerefOf (Index (DerefOf (Index (TIM0, 0x02)), Local0))
                    }

                    Return (One)
                }

                Name (AT01, Buffer (0x07)
                {
                     0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0xEF         /* ....... */
                })
                Name (AT02, Buffer (0x07)
                {
                     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x90         /* ....... */
                })
                Name (AT03, Buffer (0x07)
                {
                     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xC6         /* ....... */
                })
                Name (AT04, Buffer (0x07)
                {
                     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x91         /* ....... */
                })
                Name (AT05, Buffer (0x07)
                {
                     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xF5         /* ....... */
                })
                Name (AT06, Buffer (0x07)
                {
                     0x10, 0x03, 0x00, 0x00, 0x00, 0x00, 0xEF         /* ....... */
                })
                Name (AT61, Buffer (0x07)
                {
                     0x90, 0x03, 0x00, 0x00, 0x00, 0x00, 0xEF         /* ....... */
                })
                Name (AT07, Buffer (0x07)
                {
                     0x10, 0x06, 0x00, 0x00, 0x00, 0x00, 0xEF         /* ....... */
                })
                Name (AT08, Buffer (0x07)
                {
                     0x41, 0x00, 0x00, 0x00, 0x00, 0x00, 0xEF         /* A...... */
                })
                Name (AT81, Buffer (0x07)
                {
                     0xC1, 0x00, 0x00, 0x00, 0x00, 0x00, 0xEF         /* ....... */
                })
                Name (ATA0, Buffer (0x32) {})
                Name (ATA1, Buffer (0x32) {})
                Name (ATA2, Buffer (0x32) {})
                Name (ATA3, Buffer (0x32) {})
                Name (ATAB, Buffer (0x32) {})
                CreateByteField (ATAB, Zero, CMDC)
                Method (GTFB, 3, Serialized)
                {
                    Local0 = (CMDC * 0x38)
                    Local1 = (Local0 + 0x08)
                    CreateField (ATAB, Local1, 0x38, CMDX)
                    Local0 = (CMDC * 0x07)
                    CreateByteField (ATAB, (Local0 + 0x02), A001)
                    CreateByteField (ATAB, (Local0 + 0x06), A005)
                    CMDX = Arg0
                    A001 = Arg1
                    A005 = Arg2
                    CMDC++
                }

                Method (GTF, 2, Serialized)
                {
                    Debug = Arg1
                    CMDC = Zero
                    Name (ID49, 0x0C00)
                    Name (ID59, Zero)
                    Name (ID53, 0x04)
                    Name (ID63, 0x0F00)
                    Name (ID88, 0x0F00)
                    Name (ID78, Zero)
                    Name (W128, Zero)
                    Name (W119, Zero)
                    Name (W120, Zero)
                    Name (IRDY, One)
                    Name (PIOT, Zero)
                    Name (DMAT, Zero)
                    If ((SizeOf (Arg1) == 0x0200))
                    {
                        CreateWordField (Arg1, 0x62, IW49)
                        ID49 = IW49 /* \_SB_.PCI0.IDE0.GTF_.IW49 */
                        CreateWordField (Arg1, 0x6A, IW53)
                        ID53 = IW53 /* \_SB_.PCI0.IDE0.GTF_.IW53 */
                        CreateWordField (Arg1, 0x7E, IW63)
                        ID63 = IW63 /* \_SB_.PCI0.IDE0.GTF_.IW63 */
                        CreateWordField (Arg1, 0x76, IW59)
                        ID59 = IW59 /* \_SB_.PCI0.IDE0.GTF_.IW59 */
                        CreateWordField (Arg1, 0xB0, IW88)
                        ID88 = IW88 /* \_SB_.PCI0.IDE0.GTF_.IW88 */
                        CreateWordField (Arg1, 0x9C, IW78)
                        ID78 = IW78 /* \_SB_.PCI0.IDE0.GTF_.IW78 */
                        CreateWordField (Arg1, 0x0100, I128)
                        W128 = I128 /* \_SB_.PCI0.IDE0.GTF_.I128 */
                        CreateWordField (Arg1, 0xEE, I119)
                        W119 = I119 /* \_SB_.PCI0.IDE0.GTF_.I119 */
                        CreateWordField (Arg1, 0xF0, I120)
                        W120 = I120 /* \_SB_.PCI0.IDE0.GTF_.I120 */
                    }

                    Local7 = 0xA0
                    If (Arg0)
                    {
                        Local7 = 0xB0
                        IRDY = (CHNF & 0x08)
                        If ((CHNF & 0x10))
                        {
                            PIOT = PIO1 /* \_SB_.PCI0.IDE0.PIO1 */
                        }
                        Else
                        {
                            PIOT = PIO0 /* \_SB_.PCI0.IDE0.PIO0 */
                        }

                        If ((CHNF & 0x04))
                        {
                            If ((CHNF & 0x10))
                            {
                                DMAT = DMA1 /* \_SB_.PCI0.IDE0.DMA1 */
                            }
                            Else
                            {
                                DMAT = DMA0 /* \_SB_.PCI0.IDE0.DMA0 */
                            }
                        }
                    }
                    Else
                    {
                        IRDY = (CHNF & 0x02)
                        PIOT = PIO0 /* \_SB_.PCI0.IDE0.PIO0 */
                        If ((CHNF & One))
                        {
                            DMAT = DMA0 /* \_SB_.PCI0.IDE0.DMA0 */
                        }
                    }

                    If ((((ID53 & 0x04) && (ID88 & 0xFF00)) && DMAT))
                    {
                        Local1 = Match (DerefOf (Index (TIM0, 0x03)), MLE, DMAT, MTR, Zero, 
                            Zero)
                        If ((Local1 > 0x06))
                        {
                            Local1 = 0x06
                        }

                        GTFB (AT01, (0x40 | Local1), Local7)
                    }
                    Else
                    {
                        If (((ID63 & 0xFF00) && PIOT))
                        {
                            Local0 = (Match (DerefOf (Index (TIM0, Zero)), MGE, PIOT, MTR, Zero, 
                                Zero) & 0x03)
                            Local1 = (0x20 | DerefOf (Index (DerefOf (Index (TIM0, 0x08)), Local0)))
                            GTFB (AT01, Local1, Local7)
                        }
                    }

                    If (IRDY)
                    {
                        Local0 = (Match (DerefOf (Index (TIM0, Zero)), MGE, PIOT, MTR, Zero, 
                            Zero) & 0x03)
                        Local1 = (0x08 | DerefOf (Index (DerefOf (Index (TIM0, 0x07)), Local0)))
                        GTFB (AT01, Local1, Local7)
                    }
                    Else
                    {
                        If ((ID49 & 0x0400))
                        {
                            GTFB (AT01, One, Local7)
                        }
                    }

                    If (((ID59 & 0x0100) && (ID59 & 0xFF)))
                    {
                        GTFB (AT03, (ID59 & 0xFF), Local7)
                    }

                    If ((Local7 == 0xA0))
                    {
                        If ((W128 & One))
                        {
                            GTFB (AT05, Zero, Local7)
                        }

                        If ((ID78 & 0x40))
                        {
                            GTFB (AT07, 0x06, Local7)
                        }

                        If ((ID78 & 0x08))
                        {
                            If ((ANCK && One))
                            {
                                GTFB (AT61, 0x03, Local7)
                            }
                            Else
                            {
                                GTFB (AT06, 0x03, Local7)
                            }
                        }

                        If ((W119 & 0x20))
                        {
                            If ((HDDF & One))
                            {
                                GTFB (AT08, Zero, Local7)
                            }
                            Else
                            {
                                GTFB (AT81, Zero, Local7)
                            }
                        }
                    }

                    Debug = ATAB /* \_SB_.PCI0.IDE0.ATAB */
                    Return (ATAB) /* \_SB_.PCI0.IDE0.ATAB */
                }

                Method (RATA, 1, NotSerialized)
                {
                    CreateByteField (Arg0, Zero, CMDN)
                    Local0 = (CMDN * 0x38)
                    CreateField (Arg0, 0x08, Local0, RETB)
                    Debug = RETB /* \_SB_.PCI0.IDE0.RATA.RETB */
                    Return (RETB) /* \_SB_.PCI0.IDE0.RATA.RETB */
                }

                Name (ATP0, Buffer (0x32) {})
                Device (PRT0)
                {
                    Name (_ADR, 0xFFFF)  // _ADR: Address
                    Method (_SDD, 1, NotSerialized)  // _SDD: Set Device Data
                    {
                        ATP0 = AGTF (Zero, Arg0)
                    }

                    Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                    {
                        Return (RATA (ATP0))
                    }
                }

                Name (ATP1, Buffer (0x32) {})
                Device (PRT1)
                {
                    Name (_ADR, 0x0001FFFF)  // _ADR: Address
                    Method (_SDD, 1, NotSerialized)  // _SDD: Set Device Data
                    {
                        ATP1 = AGTF (Zero, Arg0)
                    }

                    Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                    {
                        Return (RATA (ATP1))
                    }
                }

                Method (AGTF, 2, Serialized)
                {
                    Local0 = 0xA0
                    CMDC = Zero
                    If ((SizeOf (Arg1) == 0x0200))
                    {
                        CreateWordField (Arg1, 0x0100, I128)
                        If ((I128 & One))
                        {
                            GTFB (AT05, Zero, Local0)
                        }

                        CreateWordField (Arg1, 0x9C, IW78)
                        If ((IW78 & 0x40))
                        {
                            GTFB (AT07, 0x06, Local0)
                        }

                        If ((IW78 & 0x08))
                        {
                            If ((ANCK && One))
                            {
                                GTFB (AT61, 0x03, Local0)
                            }
                            Else
                            {
                                GTFB (AT06, 0x03, Local0)
                            }
                        }

                        CreateWordField (Arg1, 0xEE, I119)
                        If ((I119 & 0x20))
                        {
                            If ((HDDF & One))
                            {
                                GTFB (AT08, Zero, Local0)
                            }
                            Else
                            {
                                GTFB (AT81, Zero, Local0)
                            }
                        }
                    }

                    Return (ATAB) /* \_SB_.PCI0.IDE0.ATAB */
                }
            }

            Device (USB0)
            {
                Name (_ADR, 0x001D0000)  // _ADR: Address
                OperationRegion (BAR0, PCI_Config, 0xC0, 0x05)
                Field (BAR0, ByteAcc, NoLock, Preserve)
                {
                    UBL1,   16, 
                    Offset (0x04), 
                    P0WE,   1, 
                    P1WE,   1, 
                    Offset (0x05)
                }

                Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                {
                    If (((OSFL () == One) || (OSFL () == 0x02)))
                    {
                        Return (0x02)
                    }
                    Else
                    {
                        Return (0x03)
                    }
                }

                Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
                {
                    If (Arg0)
                    {
                        P0WE = One
                        P1WE = One
                    }
                    Else
                    {
                        P0WE = Zero
                        P1WE = Zero
                    }
                }

                Method (UPAC, 1, NotSerialized)
                {
                    Local0 = Zero
                    If ((OSFG == OS9X))
                    {
                        Local0 = One
                    }
                    Else
                    {
                        If ((OSFG == OS98))
                        {
                            Local0 = One
                        }
                    }

                    If (Local0)
                    {
                        If ((Arg0 == 0x03))
                        {
                            Return (One)
                        }
                    }

                    Return (Zero)
                }

                OperationRegion (UPCI, PCI_Config, 0x20, 0x04)
                Field (UPCI, ByteAcc, NoLock, Preserve)
                {
                    UBAS,   32
                }

                Name (BASA, 0xB400)
                Name (P0ST, Zero)
                Name (P1ST, Zero)
                Method (SSTA, 0, NotSerialized)
                {
                    BASA = UBAS /* \_SB_.PCI0.USB0.UBAS */
                    BASA &= 0xFFFFFFFE
                    OperationRegion (UHCI, SystemIO, BASA, 0x20)
                    Field (UHCI, ByteAcc, NoLock, Preserve)
                    {
                        RSTP,   1, 
                        HRST,   1, 
                        GRST,   1, 
                        Offset (0x10), 
                        CCS0,   1, 
                        CSC0,   1, 
                        PED0,   1, 
                        Offset (0x12), 
                        CCS1,   1, 
                        CSC1,   1, 
                        PED1,   1
                    }

                    P0ST = CCS0 /* \_SB_.PCI0.USB0.SSTA.CCS0 */
                    P1ST = CCS1 /* \_SB_.PCI0.USB0.SSTA.CCS1 */
                }

                Method (RSTA, 0, NotSerialized)
                {
                    UBAS = BASA /* \_SB_.PCI0.USB0.BASA */
                    OperationRegion (UHCI, SystemIO, BASA, 0x20)
                    Field (UHCI, ByteAcc, NoLock, Preserve)
                    {
                        RSTP,   1, 
                        HRST,   1, 
                        GRST,   1, 
                        Offset (0x10), 
                        CCS0,   1, 
                        CSC0,   1, 
                        PED0,   1, 
                        Offset (0x12), 
                        CCS1,   1, 
                        CSC1,   1, 
                        PED1,   1
                    }
                }

                Method (USBS, 1, NotSerialized)
                {
                    If (UPAC (Arg0))
                    {
                        SSTA ()
                    }
                }

                Method (USBW, 1, NotSerialized)
                {
                    If (UPAC (Arg0))
                    {
                        RSTA ()
                    }
                }

                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x03, 0x03))
                }
            }

            Device (USB1)
            {
                Name (_ADR, 0x001D0001)  // _ADR: Address
                OperationRegion (BAR0, PCI_Config, 0xC0, 0x05)
                Field (BAR0, ByteAcc, NoLock, Preserve)
                {
                    UBL1,   16, 
                    Offset (0x04), 
                    P0WE,   1, 
                    P1WE,   1, 
                    Offset (0x05)
                }

                Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                {
                    If (((OSFL () == One) || (OSFL () == 0x02)))
                    {
                        Return (0x02)
                    }
                    Else
                    {
                        Return (0x03)
                    }
                }

                Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
                {
                    If (Arg0)
                    {
                        P0WE = One
                        P1WE = One
                    }
                    Else
                    {
                        P0WE = Zero
                        P1WE = Zero
                    }
                }

                Method (UPAC, 1, NotSerialized)
                {
                    Local0 = Zero
                    If ((OSFG == OS9X))
                    {
                        Local0 = One
                    }
                    Else
                    {
                        If ((OSFG == OS98))
                        {
                            Local0 = One
                        }
                    }

                    If (Local0)
                    {
                        If ((Arg0 == 0x03))
                        {
                            Return (One)
                        }
                    }

                    Return (Zero)
                }

                OperationRegion (UPCI, PCI_Config, 0x20, 0x04)
                Field (UPCI, ByteAcc, NoLock, Preserve)
                {
                    UBAS,   32
                }

                Name (BASA, 0xB400)
                Name (P0ST, Zero)
                Name (P1ST, Zero)
                Method (SSTA, 0, NotSerialized)
                {
                    BASA = UBAS /* \_SB_.PCI0.USB1.UBAS */
                    BASA &= 0xFFFFFFFE
                    OperationRegion (UHCI, SystemIO, BASA, 0x20)
                    Field (UHCI, ByteAcc, NoLock, Preserve)
                    {
                        RSTP,   1, 
                        HRST,   1, 
                        GRST,   1, 
                        Offset (0x10), 
                        CCS0,   1, 
                        CSC0,   1, 
                        PED0,   1, 
                        Offset (0x12), 
                        CCS1,   1, 
                        CSC1,   1, 
                        PED1,   1
                    }

                    P0ST = CCS0 /* \_SB_.PCI0.USB1.SSTA.CCS0 */
                    P1ST = CCS1 /* \_SB_.PCI0.USB1.SSTA.CCS1 */
                }

                Method (RSTA, 0, NotSerialized)
                {
                    UBAS = BASA /* \_SB_.PCI0.USB1.BASA */
                    OperationRegion (UHCI, SystemIO, BASA, 0x20)
                    Field (UHCI, ByteAcc, NoLock, Preserve)
                    {
                        RSTP,   1, 
                        HRST,   1, 
                        GRST,   1, 
                        Offset (0x10), 
                        CCS0,   1, 
                        CSC0,   1, 
                        PED0,   1, 
                        Offset (0x12), 
                        CCS1,   1, 
                        CSC1,   1, 
                        PED1,   1
                    }
                }

                Method (USBS, 1, NotSerialized)
                {
                    If (UPAC (Arg0))
                    {
                        SSTA ()
                    }
                }

                Method (USBW, 1, NotSerialized)
                {
                    If (UPAC (Arg0))
                    {
                        RSTA ()
                    }
                }

                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x04, 0x03))
                }
            }

            Device (USB2)
            {
                Name (_ADR, 0x001D0002)  // _ADR: Address
                OperationRegion (BAR0, PCI_Config, 0xC0, 0x05)
                Field (BAR0, ByteAcc, NoLock, Preserve)
                {
                    UBL1,   16, 
                    Offset (0x04), 
                    P0WE,   1, 
                    P1WE,   1, 
                    Offset (0x05)
                }

                Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                {
                    If (((OSFL () == One) || (OSFL () == 0x02)))
                    {
                        Return (0x02)
                    }
                    Else
                    {
                        Return (0x03)
                    }
                }

                Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
                {
                    If (Arg0)
                    {
                        P0WE = One
                        P1WE = One
                    }
                    Else
                    {
                        P0WE = Zero
                        P1WE = Zero
                    }
                }

                Method (UPAC, 1, NotSerialized)
                {
                    Local0 = Zero
                    If ((OSFG == OS9X))
                    {
                        Local0 = One
                    }
                    Else
                    {
                        If ((OSFG == OS98))
                        {
                            Local0 = One
                        }
                    }

                    If (Local0)
                    {
                        If ((Arg0 == 0x03))
                        {
                            Return (One)
                        }
                    }

                    Return (Zero)
                }

                OperationRegion (UPCI, PCI_Config, 0x20, 0x04)
                Field (UPCI, ByteAcc, NoLock, Preserve)
                {
                    UBAS,   32
                }

                Name (BASA, 0xB400)
                Name (P0ST, Zero)
                Name (P1ST, Zero)
                Method (SSTA, 0, NotSerialized)
                {
                    BASA = UBAS /* \_SB_.PCI0.USB2.UBAS */
                    BASA &= 0xFFFFFFFE
                    OperationRegion (UHCI, SystemIO, BASA, 0x20)
                    Field (UHCI, ByteAcc, NoLock, Preserve)
                    {
                        RSTP,   1, 
                        HRST,   1, 
                        GRST,   1, 
                        Offset (0x10), 
                        CCS0,   1, 
                        CSC0,   1, 
                        PED0,   1, 
                        Offset (0x12), 
                        CCS1,   1, 
                        CSC1,   1, 
                        PED1,   1
                    }

                    P0ST = CCS0 /* \_SB_.PCI0.USB2.SSTA.CCS0 */
                    P1ST = CCS1 /* \_SB_.PCI0.USB2.SSTA.CCS1 */
                }

                Method (RSTA, 0, NotSerialized)
                {
                    UBAS = BASA /* \_SB_.PCI0.USB2.BASA */
                    OperationRegion (UHCI, SystemIO, BASA, 0x20)
                    Field (UHCI, ByteAcc, NoLock, Preserve)
                    {
                        RSTP,   1, 
                        HRST,   1, 
                        GRST,   1, 
                        Offset (0x10), 
                        CCS0,   1, 
                        CSC0,   1, 
                        PED0,   1, 
                        Offset (0x12), 
                        CCS1,   1, 
                        CSC1,   1, 
                        PED1,   1
                    }
                }

                Method (USBS, 1, NotSerialized)
                {
                    If (UPAC (Arg0))
                    {
                        SSTA ()
                    }
                }

                Method (USBW, 1, NotSerialized)
                {
                    If (UPAC (Arg0))
                    {
                        RSTA ()
                    }
                }

                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x0C, 0x03))
                }
            }

            Device (USB5)
            {
                Name (_ADR, 0x001D0003)  // _ADR: Address
                OperationRegion (BAR0, PCI_Config, 0xC0, 0x05)
                Field (BAR0, ByteAcc, NoLock, Preserve)
                {
                    UBL1,   16, 
                    Offset (0x04), 
                    P0WE,   1, 
                    P1WE,   1, 
                    Offset (0x05)
                }

                Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                {
                    If (((OSFL () == One) || (OSFL () == 0x02)))
                    {
                        Return (0x02)
                    }
                    Else
                    {
                        Return (0x03)
                    }
                }

                Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
                {
                    If (Arg0)
                    {
                        P0WE = One
                        P1WE = One
                    }
                    Else
                    {
                        P0WE = Zero
                        P1WE = Zero
                    }
                }

                Method (UPAC, 1, NotSerialized)
                {
                    Local0 = Zero
                    If ((OSFG == OS9X))
                    {
                        Local0 = One
                    }
                    Else
                    {
                        If ((OSFG == OS98))
                        {
                            Local0 = One
                        }
                    }

                    If (Local0)
                    {
                        If ((Arg0 == 0x03))
                        {
                            Return (One)
                        }
                    }

                    Return (Zero)
                }

                OperationRegion (UPCI, PCI_Config, 0x20, 0x04)
                Field (UPCI, ByteAcc, NoLock, Preserve)
                {
                    UBAS,   32
                }

                Name (BASA, 0xB400)
                Name (P0ST, Zero)
                Name (P1ST, Zero)
                Method (SSTA, 0, NotSerialized)
                {
                    BASA = UBAS /* \_SB_.PCI0.USB5.UBAS */
                    BASA &= 0xFFFFFFFE
                    OperationRegion (UHCI, SystemIO, BASA, 0x20)
                    Field (UHCI, ByteAcc, NoLock, Preserve)
                    {
                        RSTP,   1, 
                        HRST,   1, 
                        GRST,   1, 
                        Offset (0x10), 
                        CCS0,   1, 
                        CSC0,   1, 
                        PED0,   1, 
                        Offset (0x12), 
                        CCS1,   1, 
                        CSC1,   1, 
                        PED1,   1
                    }

                    P0ST = CCS0 /* \_SB_.PCI0.USB5.SSTA.CCS0 */
                    P1ST = CCS1 /* \_SB_.PCI0.USB5.SSTA.CCS1 */
                }

                Method (RSTA, 0, NotSerialized)
                {
                    UBAS = BASA /* \_SB_.PCI0.USB5.BASA */
                    OperationRegion (UHCI, SystemIO, BASA, 0x20)
                    Field (UHCI, ByteAcc, NoLock, Preserve)
                    {
                        RSTP,   1, 
                        HRST,   1, 
                        GRST,   1, 
                        Offset (0x10), 
                        CCS0,   1, 
                        CSC0,   1, 
                        PED0,   1, 
                        Offset (0x12), 
                        CCS1,   1, 
                        CSC1,   1, 
                        PED1,   1
                    }
                }

                Method (USBS, 1, NotSerialized)
                {
                    If (UPAC (Arg0))
                    {
                        SSTA ()
                    }
                }

                Method (USBW, 1, NotSerialized)
                {
                    If (UPAC (Arg0))
                    {
                        RSTA ()
                    }
                }

                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x20, 0x03))
                }
            }

            Device (EUSB)
            {
                Name (_ADR, 0x001D0007)  // _ADR: Address
                OperationRegion (U20P, PCI_Config, Zero, 0x0100)
                Field (U20P, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x04), 
                        ,   1, 
                    MSPE,   1, 
                    Offset (0x06), 
                    Offset (0x10), 
                    MBAS,   32, 
                    Offset (0x54), 
                    PSTA,   2, 
                    Offset (0x55), 
                    PMEE,   1, 
                        ,   6, 
                    PMES,   1
                }

                Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
                {
                    Local0 = MBAS /* \_SB_.PCI0.EUSB.MBAS */
                    If ((Local0 == Ones)) {}
                    Else
                    {
                        Local0 &= 0xFFFFFFF0
                        OperationRegion (MMIO, SystemMemory, Local0, 0x0100)
                        Field (MMIO, ByteAcc, NoLock, Preserve)
                        {
                            Offset (0x64), 
                            P0SC,   32, 
                            P1SC,   32, 
                            P2SC,   32, 
                            P3SC,   32, 
                            P4SC,   32, 
                            P5SC,   32
                        }

                        If (!Local0)
                        {
                            Local2 = PSTA /* \_SB_.PCI0.EUSB.PSTA */
                            PSTA = Zero
                            Local3 = MSPE /* \_SB_.PCI0.EUSB.MSPE */
                            MSPE = One
                            If (Arg0)
                            {
                                Local4 = P0SC /* \_SB_.PCI0.EUSB._PSW.P0SC */
                                Local4 |= 0x00300000
                                P0SC = Local4
                                Local4 = P1SC /* \_SB_.PCI0.EUSB._PSW.P1SC */
                                Local4 |= 0x00300000
                                P1SC = Local4
                                Local4 = P2SC /* \_SB_.PCI0.EUSB._PSW.P2SC */
                                Local4 |= 0x00300000
                                P2SC = Local4
                                Local4 = P3SC /* \_SB_.PCI0.EUSB._PSW.P3SC */
                                Local4 |= 0x00300000
                                P3SC = Local4
                                Local4 = P4SC /* \_SB_.PCI0.EUSB._PSW.P4SC */
                                Local4 |= 0x00300000
                                P4SC = Local4
                                Local4 = P5SC /* \_SB_.PCI0.EUSB._PSW.P5SC */
                                Local4 |= 0x00300000
                                P5SC = Local4
                                PMES = One
                                PMEE = One
                            }
                            Else
                            {
                                Local4 = P0SC /* \_SB_.PCI0.EUSB._PSW.P0SC */
                                Local4 &= 0xFFCFFFFF
                                P0SC = Local4
                                Local4 = P1SC /* \_SB_.PCI0.EUSB._PSW.P1SC */
                                Local4 &= 0xFFCFFFFF
                                P1SC = Local4
                                Local4 = P2SC /* \_SB_.PCI0.EUSB._PSW.P2SC */
                                Local4 &= 0xFFCFFFFF
                                P2SC = Local4
                                Local4 = P3SC /* \_SB_.PCI0.EUSB._PSW.P3SC */
                                Local4 &= 0xFFCFFFFF
                                P3SC = Local4
                                Local4 = P4SC /* \_SB_.PCI0.EUSB._PSW.P4SC */
                                Local4 &= 0xFFCFFFFF
                                P4SC = Local4
                                Local4 = P5SC /* \_SB_.PCI0.EUSB._PSW.P5SC */
                                Local4 &= 0xFFCFFFFF
                                P5SC = Local4
                                PMES = One
                                PMEE = Zero
                            }

                            MSPE = Local3
                            PSTA = Local2
                        }
                    }
                }

                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x0D, 0x03))
                }
            }

            Device (USB3)
            {
                Name (_ADR, 0x001A0000)  // _ADR: Address
                OperationRegion (BAR0, PCI_Config, 0xC0, 0x05)
                Field (BAR0, ByteAcc, NoLock, Preserve)
                {
                    UBL1,   16, 
                    Offset (0x04), 
                    P0WE,   1, 
                    P1WE,   1, 
                    Offset (0x05)
                }

                Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                {
                    If (((OSFL () == One) || (OSFL () == 0x02)))
                    {
                        Return (0x02)
                    }
                    Else
                    {
                        Return (0x03)
                    }
                }

                Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
                {
                    If (Arg0)
                    {
                        P0WE = One
                        P1WE = One
                    }
                    Else
                    {
                        P0WE = Zero
                        P1WE = Zero
                    }
                }

                Method (UPAC, 1, NotSerialized)
                {
                    Local0 = Zero
                    If ((OSFG == OS9X))
                    {
                        Local0 = One
                    }
                    Else
                    {
                        If ((OSFG == OS98))
                        {
                            Local0 = One
                        }
                    }

                    If (Local0)
                    {
                        If ((Arg0 == 0x03))
                        {
                            Return (One)
                        }
                    }

                    Return (Zero)
                }

                OperationRegion (UPCI, PCI_Config, 0x20, 0x04)
                Field (UPCI, ByteAcc, NoLock, Preserve)
                {
                    UBAS,   32
                }

                Name (BASA, 0xB400)
                Name (P0ST, Zero)
                Name (P1ST, Zero)
                Method (SSTA, 0, NotSerialized)
                {
                    BASA = UBAS /* \_SB_.PCI0.USB3.UBAS */
                    BASA &= 0xFFFFFFFE
                    OperationRegion (UHCI, SystemIO, BASA, 0x20)
                    Field (UHCI, ByteAcc, NoLock, Preserve)
                    {
                        RSTP,   1, 
                        HRST,   1, 
                        GRST,   1, 
                        Offset (0x10), 
                        CCS0,   1, 
                        CSC0,   1, 
                        PED0,   1, 
                        Offset (0x12), 
                        CCS1,   1, 
                        CSC1,   1, 
                        PED1,   1
                    }

                    P0ST = CCS0 /* \_SB_.PCI0.USB3.SSTA.CCS0 */
                    P1ST = CCS1 /* \_SB_.PCI0.USB3.SSTA.CCS1 */
                }

                Method (RSTA, 0, NotSerialized)
                {
                    UBAS = BASA /* \_SB_.PCI0.USB3.BASA */
                    OperationRegion (UHCI, SystemIO, BASA, 0x20)
                    Field (UHCI, ByteAcc, NoLock, Preserve)
                    {
                        RSTP,   1, 
                        HRST,   1, 
                        GRST,   1, 
                        Offset (0x10), 
                        CCS0,   1, 
                        CSC0,   1, 
                        PED0,   1, 
                        Offset (0x12), 
                        CCS1,   1, 
                        CSC1,   1, 
                        PED1,   1
                    }
                }

                Method (USBS, 1, NotSerialized)
                {
                    If (UPAC (Arg0))
                    {
                        SSTA ()
                    }
                }

                Method (USBW, 1, NotSerialized)
                {
                    If (UPAC (Arg0))
                    {
                        RSTA ()
                    }
                }

                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x0E, 0x03))
                }
            }

            Device (USB4)
            {
                Name (_ADR, 0x001A0001)  // _ADR: Address
                OperationRegion (BAR0, PCI_Config, 0xC0, 0x05)
                Field (BAR0, ByteAcc, NoLock, Preserve)
                {
                    UBL1,   16, 
                    Offset (0x04), 
                    P0WE,   1, 
                    P1WE,   1, 
                    Offset (0x05)
                }

                Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                {
                    If (((OSFL () == One) || (OSFL () == 0x02)))
                    {
                        Return (0x02)
                    }
                    Else
                    {
                        Return (0x03)
                    }
                }

                Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
                {
                    If (Arg0)
                    {
                        P0WE = One
                        P1WE = One
                    }
                    Else
                    {
                        P0WE = Zero
                        P1WE = Zero
                    }
                }

                Method (UPAC, 1, NotSerialized)
                {
                    Local0 = Zero
                    If ((OSFG == OS9X))
                    {
                        Local0 = One
                    }
                    Else
                    {
                        If ((OSFG == OS98))
                        {
                            Local0 = One
                        }
                    }

                    If (Local0)
                    {
                        If ((Arg0 == 0x03))
                        {
                            Return (One)
                        }
                    }

                    Return (Zero)
                }

                OperationRegion (UPCI, PCI_Config, 0x20, 0x04)
                Field (UPCI, ByteAcc, NoLock, Preserve)
                {
                    UBAS,   32
                }

                Name (BASA, 0xB400)
                Name (P0ST, Zero)
                Name (P1ST, Zero)
                Method (SSTA, 0, NotSerialized)
                {
                    BASA = UBAS /* \_SB_.PCI0.USB4.UBAS */
                    BASA &= 0xFFFFFFFE
                    OperationRegion (UHCI, SystemIO, BASA, 0x20)
                    Field (UHCI, ByteAcc, NoLock, Preserve)
                    {
                        RSTP,   1, 
                        HRST,   1, 
                        GRST,   1, 
                        Offset (0x10), 
                        CCS0,   1, 
                        CSC0,   1, 
                        PED0,   1, 
                        Offset (0x12), 
                        CCS1,   1, 
                        CSC1,   1, 
                        PED1,   1
                    }

                    P0ST = CCS0 /* \_SB_.PCI0.USB4.SSTA.CCS0 */
                    P1ST = CCS1 /* \_SB_.PCI0.USB4.SSTA.CCS1 */
                }

                Method (RSTA, 0, NotSerialized)
                {
                    UBAS = BASA /* \_SB_.PCI0.USB4.BASA */
                    OperationRegion (UHCI, SystemIO, BASA, 0x20)
                    Field (UHCI, ByteAcc, NoLock, Preserve)
                    {
                        RSTP,   1, 
                        HRST,   1, 
                        GRST,   1, 
                        Offset (0x10), 
                        CCS0,   1, 
                        CSC0,   1, 
                        PED0,   1, 
                        Offset (0x12), 
                        CCS1,   1, 
                        CSC1,   1, 
                        PED1,   1
                    }
                }

                Method (USBS, 1, NotSerialized)
                {
                    If (UPAC (Arg0))
                    {
                        SSTA ()
                    }
                }

                Method (USBW, 1, NotSerialized)
                {
                    If (UPAC (Arg0))
                    {
                        RSTA ()
                    }
                }

                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x05, 0x03))
                }
            }

            Device (USB6)
            {
                Name (_ADR, 0x001A0002)  // _ADR: Address
                OperationRegion (BAR0, PCI_Config, 0xC0, 0x05)
                Field (BAR0, ByteAcc, NoLock, Preserve)
                {
                    UBL1,   16, 
                    Offset (0x04), 
                    P0WE,   1, 
                    P1WE,   1, 
                    Offset (0x05)
                }

                Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                {
                    If (((OSFL () == One) || (OSFL () == 0x02)))
                    {
                        Return (0x02)
                    }
                    Else
                    {
                        Return (0x03)
                    }
                }

                Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
                {
                    If (Arg0)
                    {
                        P0WE = One
                        P1WE = One
                    }
                    Else
                    {
                        P0WE = Zero
                        P1WE = Zero
                    }
                }

                Method (UPAC, 1, NotSerialized)
                {
                    Local0 = Zero
                    If ((OSFG == OS9X))
                    {
                        Local0 = One
                    }
                    Else
                    {
                        If ((OSFG == OS98))
                        {
                            Local0 = One
                        }
                    }

                    If (Local0)
                    {
                        If ((Arg0 == 0x03))
                        {
                            Return (One)
                        }
                    }

                    Return (Zero)
                }

                OperationRegion (UPCI, PCI_Config, 0x20, 0x04)
                Field (UPCI, ByteAcc, NoLock, Preserve)
                {
                    UBAS,   32
                }

                Name (BASA, 0xB400)
                Name (P0ST, Zero)
                Name (P1ST, Zero)
                Method (SSTA, 0, NotSerialized)
                {
                    BASA = UBAS /* \_SB_.PCI0.USB6.UBAS */
                    BASA &= 0xFFFFFFFE
                    OperationRegion (UHCI, SystemIO, BASA, 0x20)
                    Field (UHCI, ByteAcc, NoLock, Preserve)
                    {
                        RSTP,   1, 
                        HRST,   1, 
                        GRST,   1, 
                        Offset (0x10), 
                        CCS0,   1, 
                        CSC0,   1, 
                        PED0,   1, 
                        Offset (0x12), 
                        CCS1,   1, 
                        CSC1,   1, 
                        PED1,   1
                    }

                    P0ST = CCS0 /* \_SB_.PCI0.USB6.SSTA.CCS0 */
                    P1ST = CCS1 /* \_SB_.PCI0.USB6.SSTA.CCS1 */
                }

                Method (RSTA, 0, NotSerialized)
                {
                    UBAS = BASA /* \_SB_.PCI0.USB6.BASA */
                    OperationRegion (UHCI, SystemIO, BASA, 0x20)
                    Field (UHCI, ByteAcc, NoLock, Preserve)
                    {
                        RSTP,   1, 
                        HRST,   1, 
                        GRST,   1, 
                        Offset (0x10), 
                        CCS0,   1, 
                        CSC0,   1, 
                        PED0,   1, 
                        Offset (0x12), 
                        CCS1,   1, 
                        CSC1,   1, 
                        PED1,   1
                    }
                }

                Method (USBS, 1, NotSerialized)
                {
                    If (UPAC (Arg0))
                    {
                        SSTA ()
                    }
                }

                Method (USBW, 1, NotSerialized)
                {
                    If (UPAC (Arg0))
                    {
                        RSTA ()
                    }
                }

                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x20, 0x03))
                }
            }

            Device (USBE)
            {
                Name (_ADR, 0x001A0007)  // _ADR: Address
                OperationRegion (U20P, PCI_Config, Zero, 0x0100)
                Field (U20P, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x04), 
                        ,   1, 
                    MSPE,   1, 
                    Offset (0x06), 
                    Offset (0x10), 
                    MBAS,   32, 
                    Offset (0x54), 
                    PSTA,   2, 
                    Offset (0x55), 
                    PMEE,   1, 
                        ,   6, 
                    PMES,   1
                }

                Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
                {
                    Local0 = MBAS /* \_SB_.PCI0.USBE.MBAS */
                    If ((Local0 == Ones)) {}
                    Else
                    {
                        Local0 &= 0xFFFFFFF0
                        OperationRegion (MMIO, SystemMemory, Local0, 0x0100)
                        Field (MMIO, ByteAcc, NoLock, Preserve)
                        {
                            Offset (0x64), 
                            P0SC,   32, 
                            P1SC,   32, 
                            P2SC,   32, 
                            P3SC,   32, 
                            P4SC,   32, 
                            P5SC,   32
                        }

                        If (!Local0)
                        {
                            Local2 = PSTA /* \_SB_.PCI0.USBE.PSTA */
                            PSTA = Zero
                            Local3 = MSPE /* \_SB_.PCI0.USBE.MSPE */
                            MSPE = One
                            If (Arg0)
                            {
                                Local4 = P0SC /* \_SB_.PCI0.USBE._PSW.P0SC */
                                Local4 |= 0x00300000
                                P0SC = Local4
                                Local4 = P1SC /* \_SB_.PCI0.USBE._PSW.P1SC */
                                Local4 |= 0x00300000
                                P1SC = Local4
                                Local4 = P2SC /* \_SB_.PCI0.USBE._PSW.P2SC */
                                Local4 |= 0x00300000
                                P2SC = Local4
                                Local4 = P3SC /* \_SB_.PCI0.USBE._PSW.P3SC */
                                Local4 |= 0x00300000
                                P3SC = Local4
                                Local4 = P4SC /* \_SB_.PCI0.USBE._PSW.P4SC */
                                Local4 |= 0x00300000
                                P4SC = Local4
                                Local4 = P5SC /* \_SB_.PCI0.USBE._PSW.P5SC */
                                Local4 |= 0x00300000
                                P5SC = Local4
                                PMES = One
                                PMEE = One
                            }
                            Else
                            {
                                Local4 = P0SC /* \_SB_.PCI0.USBE._PSW.P0SC */
                                Local4 &= 0xFFCFFFFF
                                P0SC = Local4
                                Local4 = P1SC /* \_SB_.PCI0.USBE._PSW.P1SC */
                                Local4 &= 0xFFCFFFFF
                                P1SC = Local4
                                Local4 = P2SC /* \_SB_.PCI0.USBE._PSW.P2SC */
                                Local4 &= 0xFFCFFFFF
                                P2SC = Local4
                                Local4 = P3SC /* \_SB_.PCI0.USBE._PSW.P3SC */
                                Local4 &= 0xFFCFFFFF
                                P3SC = Local4
                                Local4 = P4SC /* \_SB_.PCI0.USBE._PSW.P4SC */
                                Local4 &= 0xFFCFFFFF
                                P4SC = Local4
                                Local4 = P5SC /* \_SB_.PCI0.USBE._PSW.P5SC */
                                Local4 &= 0xFFCFFFFF
                                P5SC = Local4
                                PMES = One
                                PMEE = Zero
                            }

                            MSPE = Local3
                            PSTA = Local2
                        }
                    }
                }

                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x0D, 0x03))
                }
            }

            Device (HDAC)
            {
                Name (_ADR, 0x001B0000)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x0D, 0x03))
                }
            }

            Device (VGA)
            {
                Name (_ADR, 0x00020000)  // _ADR: Address
            }

            Device (P0P1)
            {
                Name (_ADR, 0x00010000)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x09, 0x04))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AR01) /* \_SB_.AR01 */
                    }

                    Return (PR01) /* \_SB_.PR01 */
                }

                Device (VGA)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                }
            }

            Device (P0P2)
            {
                Name (_ADR, 0x001C0000)  // _ADR: Address
                OperationRegion (LCTL, PCI_Config, 0x50, 0x04)
                Field (LCTL, ByteAcc, NoLock, Preserve)
                {
                        ,   4, 
                    PELD,   1, 
                    PERL,   1
                }

                OperationRegion (SLOT, PCI_Config, 0x54, 0x10)
                Field (SLOT, ByteAcc, NoLock, Preserve)
                {
                    SCAP,   32, 
                    SCTL,   16, 
                    ABP1,   1, 
                    PFD1,   1, 
                    MSC1,   1, 
                    PDC1,   1, 
                    CC10,   1, 
                    MS10,   1, 
                    PDS1,   1, 
                    RSV0,   1, 
                    LASC,   1, 
                    RSV1,   7
                }

                OperationRegion (RHUB, PCI_Config, 0x60, 0x10)
                Field (RHUB, ByteAcc, NoLock, Preserve)
                {
                    PMID,   16, 
                    PMES,   1, 
                    PMEP,   1, 
                    RSV2,   14
                }

                OperationRegion (MISC, PCI_Config, 0xD8, 0x08)
                Field (MISC, ByteAcc, NoLock, Preserve)
                {
                    RSV4,   30, 
                    PMCE,   1, 
                    HPCE,   1, 
                    PMMS,   1, 
                    HPPD,   1, 
                    HPAB,   1, 
                    HPCC,   1, 
                    HPLA,   1, 
                    RSV3,   25, 
                    HPCS,   1, 
                    PMCS,   1
                }

                Method (HPHK, 0, NotSerialized)
                {
                    PDC1 = One
                    HPCS = One
                    PELD = Zero
                    Sleep (0xFA)
                }

                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x09, 0x03))
                }
            }

            Device (P0P3)
            {
                Name (_ADR, 0x001C0001)  // _ADR: Address
                OperationRegion (LCTL, PCI_Config, 0x50, 0x04)
                Field (LCTL, ByteAcc, NoLock, Preserve)
                {
                        ,   4, 
                    PELD,   1, 
                    PERL,   1
                }

                OperationRegion (SLOT, PCI_Config, 0x54, 0x10)
                Field (SLOT, ByteAcc, NoLock, Preserve)
                {
                    SCAP,   32, 
                    SCTL,   16, 
                    ABP1,   1, 
                    PFD1,   1, 
                    MSC1,   1, 
                    PDC1,   1, 
                    CC10,   1, 
                    MS10,   1, 
                    PDS1,   1, 
                    RSV0,   1, 
                    LASC,   1, 
                    RSV1,   7
                }

                OperationRegion (RHUB, PCI_Config, 0x60, 0x10)
                Field (RHUB, ByteAcc, NoLock, Preserve)
                {
                    PMID,   16, 
                    PMES,   1, 
                    PMEP,   1, 
                    RSV2,   14
                }

                OperationRegion (MISC, PCI_Config, 0xD8, 0x08)
                Field (MISC, ByteAcc, NoLock, Preserve)
                {
                    RSV4,   30, 
                    PMCE,   1, 
                    HPCE,   1, 
                    PMMS,   1, 
                    HPPD,   1, 
                    HPAB,   1, 
                    HPCC,   1, 
                    HPLA,   1, 
                    RSV3,   25, 
                    HPCS,   1, 
                    PMCS,   1
                }

                Method (HPHK, 0, NotSerialized)
                {
                    PDC1 = One
                    HPCS = One
                    PELD = Zero
                    Sleep (0xFA)
                }

                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x09, 0x03))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AR03) /* \_SB_.AR03 */
                    }

                    Return (PR03) /* \_SB_.PR03 */
                }

                Device (WLAN)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    OperationRegion (MINP, PCI_Config, Zero, 0x68)
                    Field (MINP, ByteAcc, NoLock, Preserve)
                    {
                        VNUM,   32, 
                        Offset (0x09), 
                        PINF,   8, 
                        SBCC,   8, 
                        BSCC,   8, 
                        Offset (0x2C), 
                        SNUM,   32, 
                        Offset (0x34)
                    }

                    Method (MPDP, 0, NotSerialized)
                    {
                        Local0 = (WLDP & One)
                        If ((Local0 != One))
                        {
                            Return (Zero)
                        }

                        Return (One)
                    }

                    Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                    {
                        Return (GPRW (0x09, 0x03))
                    }
                }
            }

            Device (P0P4)
            {
                Name (_ADR, 0x001C0002)  // _ADR: Address
                Name (_HPP, Package (0x04)  // _HPP: Hot Plug Parameters
                {
                    0x08, 
                    0x40, 
                    One, 
                    Zero
                })
                OperationRegion (LCTL, PCI_Config, 0x50, 0x04)
                Field (LCTL, ByteAcc, NoLock, Preserve)
                {
                        ,   4, 
                    PELD,   1, 
                    PERL,   1
                }

                OperationRegion (SLOT, PCI_Config, 0x54, 0x10)
                Field (SLOT, ByteAcc, NoLock, Preserve)
                {
                    SCAP,   32, 
                    SCTL,   16, 
                    ABP1,   1, 
                    PFD1,   1, 
                    MSC1,   1, 
                    PDC1,   1, 
                    CC10,   1, 
                    MS10,   1, 
                    PDS1,   1, 
                    RSV0,   1, 
                    LASC,   1, 
                    RSV1,   7
                }

                OperationRegion (RHUB, PCI_Config, 0x60, 0x10)
                Field (RHUB, ByteAcc, NoLock, Preserve)
                {
                    PMID,   16, 
                    PMES,   1, 
                    PMEP,   1, 
                    RSV2,   14
                }

                OperationRegion (MISC, PCI_Config, 0xD8, 0x08)
                Field (MISC, ByteAcc, NoLock, Preserve)
                {
                    RSV4,   30, 
                    PMCE,   1, 
                    HPCE,   1, 
                    PMMS,   1, 
                    HPPD,   1, 
                    HPAB,   1, 
                    HPCC,   1, 
                    HPLA,   1, 
                    RSV3,   25, 
                    HPCS,   1, 
                    PMCS,   1
                }

                Method (HPHK, 0, NotSerialized)
                {
                    PDC1 = One
                    HPCS = One
                    PELD = Zero
                    Sleep (0xFA)
                }

                Device (XCF0)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (Zero)
                    }

                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                    {
                    }
                }

                Device (XCF1)
                {
                    Name (_ADR, One)  // _ADR: Address
                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                    {
                    }
                }

                Device (XCF2)
                {
                    Name (_ADR, 0x02)  // _ADR: Address
                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                    {
                    }
                }

                Device (XCF3)
                {
                    Name (_ADR, 0x03)  // _ADR: Address
                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                    {
                    }
                }

                Device (XCF4)
                {
                    Name (_ADR, 0x04)  // _ADR: Address
                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                    {
                    }
                }

                Device (XCF5)
                {
                    Name (_ADR, 0x05)  // _ADR: Address
                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                    {
                    }
                }

                Device (XCF6)
                {
                    Name (_ADR, 0x06)  // _ADR: Address
                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                    {
                    }
                }

                Device (XCF7)
                {
                    Name (_ADR, 0x07)  // _ADR: Address
                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                    {
                    }
                }

                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x09, 0x03))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AR04) /* \_SB_.AR04 */
                    }

                    Return (PR04) /* \_SB_.PR04 */
                }
            }

            Device (P0P6)
            {
                Name (_ADR, 0x001C0003)  // _ADR: Address
                OperationRegion (LCTL, PCI_Config, 0x50, 0x04)
                Field (LCTL, ByteAcc, NoLock, Preserve)
                {
                        ,   4, 
                    PELD,   1, 
                    PERL,   1
                }

                OperationRegion (SLOT, PCI_Config, 0x54, 0x10)
                Field (SLOT, ByteAcc, NoLock, Preserve)
                {
                    SCAP,   32, 
                    SCTL,   16, 
                    ABP1,   1, 
                    PFD1,   1, 
                    MSC1,   1, 
                    PDC1,   1, 
                    CC10,   1, 
                    MS10,   1, 
                    PDS1,   1, 
                    RSV0,   1, 
                    LASC,   1, 
                    RSV1,   7
                }

                OperationRegion (RHUB, PCI_Config, 0x60, 0x10)
                Field (RHUB, ByteAcc, NoLock, Preserve)
                {
                    PMID,   16, 
                    PMES,   1, 
                    PMEP,   1, 
                    RSV2,   14
                }

                OperationRegion (MISC, PCI_Config, 0xD8, 0x08)
                Field (MISC, ByteAcc, NoLock, Preserve)
                {
                    RSV4,   30, 
                    PMCE,   1, 
                    HPCE,   1, 
                    PMMS,   1, 
                    HPPD,   1, 
                    HPAB,   1, 
                    HPCC,   1, 
                    HPLA,   1, 
                    RSV3,   25, 
                    HPCS,   1, 
                    PMCS,   1
                }

                Method (HPHK, 0, NotSerialized)
                {
                    PDC1 = One
                    HPCS = One
                    PELD = Zero
                    Sleep (0xFA)
                }

                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x09, 0x03))
                }
            }

            Device (P0P7)
            {
                Name (_ADR, 0x001C0004)  // _ADR: Address
                OperationRegion (LCTL, PCI_Config, 0x50, 0x04)
                Field (LCTL, ByteAcc, NoLock, Preserve)
                {
                        ,   4, 
                    PELD,   1, 
                    PERL,   1
                }

                OperationRegion (SLOT, PCI_Config, 0x54, 0x10)
                Field (SLOT, ByteAcc, NoLock, Preserve)
                {
                    SCAP,   32, 
                    SCTL,   16, 
                    ABP1,   1, 
                    PFD1,   1, 
                    MSC1,   1, 
                    PDC1,   1, 
                    CC10,   1, 
                    MS10,   1, 
                    PDS1,   1, 
                    RSV0,   1, 
                    LASC,   1, 
                    RSV1,   7
                }

                OperationRegion (RHUB, PCI_Config, 0x60, 0x10)
                Field (RHUB, ByteAcc, NoLock, Preserve)
                {
                    PMID,   16, 
                    PMES,   1, 
                    PMEP,   1, 
                    RSV2,   14
                }

                OperationRegion (MISC, PCI_Config, 0xD8, 0x08)
                Field (MISC, ByteAcc, NoLock, Preserve)
                {
                    RSV4,   30, 
                    PMCE,   1, 
                    HPCE,   1, 
                    PMMS,   1, 
                    HPPD,   1, 
                    HPAB,   1, 
                    HPCC,   1, 
                    HPLA,   1, 
                    RSV3,   25, 
                    HPCS,   1, 
                    PMCS,   1
                }

                Method (HPHK, 0, NotSerialized)
                {
                    PDC1 = One
                    HPCS = One
                    PELD = Zero
                    Sleep (0xFA)
                }

                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x09, 0x04))
                }
            }

            Device (P0P8)
            {
                Name (_ADR, 0x001C0005)  // _ADR: Address
                OperationRegion (LCTL, PCI_Config, 0x50, 0x04)
                Field (LCTL, ByteAcc, NoLock, Preserve)
                {
                        ,   4, 
                    PELD,   1, 
                    PERL,   1
                }

                OperationRegion (SLOT, PCI_Config, 0x54, 0x10)
                Field (SLOT, ByteAcc, NoLock, Preserve)
                {
                    SCAP,   32, 
                    SCTL,   16, 
                    ABP1,   1, 
                    PFD1,   1, 
                    MSC1,   1, 
                    PDC1,   1, 
                    CC10,   1, 
                    MS10,   1, 
                    PDS1,   1, 
                    RSV0,   1, 
                    LASC,   1, 
                    RSV1,   7
                }

                OperationRegion (RHUB, PCI_Config, 0x60, 0x10)
                Field (RHUB, ByteAcc, NoLock, Preserve)
                {
                    PMID,   16, 
                    PMES,   1, 
                    PMEP,   1, 
                    RSV2,   14
                }

                OperationRegion (MISC, PCI_Config, 0xD8, 0x08)
                Field (MISC, ByteAcc, NoLock, Preserve)
                {
                    RSV4,   30, 
                    PMCE,   1, 
                    HPCE,   1, 
                    PMMS,   1, 
                    HPPD,   1, 
                    HPAB,   1, 
                    HPCC,   1, 
                    HPLA,   1, 
                    RSV3,   25, 
                    HPCS,   1, 
                    PMCS,   1
                }

                Method (HPHK, 0, NotSerialized)
                {
                    PDC1 = One
                    HPCS = One
                    PELD = Zero
                    Sleep (0xFA)
                }

                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x09, 0x04))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AR08) /* \_SB_.AR08 */
                    }

                    Return (PR08) /* \_SB_.PR08 */
                }

                Device (GLAN)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    OperationRegion (LANR, PCI_Config, Zero, 0x0100)
                    Field (LANR, ByteAcc, NoLock, Preserve)
                    {
                        VID,    16, 
                        Offset (0x44), 
                        DSST,   8, 
                        Offset (0xE0), 
                            ,   15, 
                        PMES,   1
                    }

                    Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                    {
                        Return (GPRW (0x09, 0x04))
                    }
                }
            }

            Device (P0P9)
            {
                Name (_ADR, 0x001E0000)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x0B, 0x03))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AR09) /* \_SB_.AR09 */
                    }

                    Return (PR09) /* \_SB_.PR09 */
                }
            }
        }
    }

    Scope (_SB.PCI0.SBRG)
    {
        Device (EC0)
        {
            Name (_HID, EisaId ("PNP0C09") /* Embedded Controller Device */)  // _HID: Hardware ID
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IO (Decode16,
                    0x0062,             // Range Minimum
                    0x0062,             // Range Maximum
                    0x00,               // Alignment
                    0x01,               // Length
                    )
                IO (Decode16,
                    0x0066,             // Range Minimum
                    0x0066,             // Range Maximum
                    0x00,               // Alignment
                    0x01,               // Length
                    )
            })
            Name (_GPE, 0x1B)  // _GPE: General Purpose Events
            Mutex (MUEC, 0x00)
            Mutex (ASIO, 0x00)
            Name (ECFL, Ones)
            Method (ECAV, 0, NotSerialized)
            {
                If ((_REV >= 0x02))
                {
                    Return (One)
                }

                If ((SLPN && (SLPT >= 0x04)))
                {
                    Return (Zero)
                }

                If ((ECFL == Ones))
                {
                    Return (Zero)
                }

                Return (ECFL) /* \_SB_.PCI0.SBRG.EC0_.ECFL */
            }

            OperationRegion (ECOR, EmbeddedControl, Zero, 0xFF)
            Field (ECOR, ByteAcc, Lock, Preserve)
            {
                Offset (0x04), 
                CMD1,   8, 
                CDT1,   8, 
                CDT2,   8, 
                CDT3,   8, 
                Offset (0x80), 
                EPWS,   8, 
                EB0S,   8, 
                EB1S,   8, 
                EB0R,   8, 
                EB1R,   8, 
                EPWF,   8, 
                Offset (0x87), 
                EB0T,   8, 
                EB1T,   8, 
                Offset (0x8A), 
                HKEN,   1, 
                Offset (0x93), 
                TAH0,   16, 
                TAH1,   16, 
                TSTP,   8, 
                Offset (0x9C), 
                CDT4,   8, 
                CDT5,   8, 
                Offset (0xA0), 
                ECPU,   8, 
                ECRT,   8, 
                EPSV,   8, 
                EACT,   8, 
                TH1R,   8, 
                TH1L,   8, 
                TH0R,   8, 
                TH0L,   8, 
                Offset (0xB0), 
                B0PN,   16, 
                B0VL,   16, 
                B0RC,   16, 
                B0FC,   16, 
                B0MD,   16, 
                B0ST,   16, 
                B0CC,   16, 
                B0TM,   16, 
                B0C1,   16, 
                B0C2,   16, 
                B0C3,   16, 
                B0C4,   16, 
                Offset (0xD0), 
                B1PN,   16, 
                B1VL,   16, 
                B1RC,   16, 
                B1FC,   16, 
                B1MD,   16, 
                B1ST,   16, 
                B1CC,   16, 
                B1TM,   16, 
                B1C1,   16, 
                B1C2,   16, 
                B1C3,   16, 
                B1C4,   16, 
                Offset (0xF0), 
                B0DC,   16, 
                B0DV,   16, 
                B0SN,   16, 
                Offset (0xF8), 
                B1DC,   16, 
                B1DV,   16, 
                B1SN,   16
            }

            Name (SMBF, Zero)
            OperationRegion (SMBX, EmbeddedControl, 0x18, 0x28)
            Field (SMBX, ByteAcc, NoLock, Preserve)
            {
                PRTC,   8, 
                SSTS,   5, 
                    ,   1, 
                ALFG,   1, 
                CDFG,   1, 
                ADDR,   8, 
                CMDB,   8, 
                BDAT,   256, 
                BCNT,   8, 
                    ,   1, 
                ALAD,   7, 
                ALD0,   8, 
                ALD1,   8
            }

            OperationRegion (SMB2, EmbeddedControl, 0x40, 0x28)
            Field (SMB2, ByteAcc, NoLock, Preserve)
            {
                PRT2,   8, 
                SST2,   5, 
                    ,   1, 
                ALF2,   1, 
                CDF2,   1, 
                ADD2,   8, 
                CMD2,   8, 
                BDA2,   256, 
                BCN2,   8, 
                    ,   1, 
                ALA2,   7, 
                ALR0,   8, 
                ALR1,   8
            }

            Field (SMB2, ByteAcc, NoLock, Preserve)
            {
                Offset (0x04), 
                DA20,   8, 
                DA21,   8
            }

            Field (SMBX, ByteAcc, NoLock, Preserve)
            {
                Offset (0x04), 
                DAT0,   8, 
                DAT1,   8
            }

            Field (SMBX, ByteAcc, NoLock, Preserve)
            {
                Offset (0x04), 
                DT2B,   16
            }

            OperationRegion (NSBS, EmbeddedControl, 0x40, 0x04)
            Field (NSBS, ByteAcc, NoLock, Preserve)
            {
                A2AD,   8, 
                A2D0,   8, 
                A2D1,   8, 
                A3AD,   8
            }

            Method (_INI, 0, NotSerialized)  // _INI: Initialize
            {
                If ((OSFG <= OSME))
                {
                    ECFL = One
                }
            }

            Method (_REG, 2, NotSerialized)  // _REG: Region Availability
            {
                If ((Arg0 == 0x03))
                {
                    If ((VGAF & One))
                    {
                        If ((Arg1 == One))
                        {
                            ^^^VGA.CLID = GLID ()
                        }
                    }

                    ECFL = Arg1
                }
            }

            Method (_Q20, 0, NotSerialized)  // _Qxx: EC Query
            {
                If (CDFG)
                {
                    SMBF = One
                    CDFG = Zero
                }

                If (ALFG)
                {
                    ALMH (ALAD)
                    ALFG = Zero
                }
            }

            Method (_QB0, 0, NotSerialized)  // _Qxx: EC Query
            {
                Notify (\_TZ.THRM, 0x80) // Thermal Status Change
            }
        }
    }

    OperationRegion (_SB.PCI0.SBRG.PIX0, PCI_Config, 0x60, 0x0C)
    Field (\_SB.PCI0.SBRG.PIX0, ByteAcc, NoLock, Preserve)
    {
        PIRA,   8, 
        PIRB,   8, 
        PIRC,   8, 
        PIRD,   8, 
        Offset (0x08), 
        PIRE,   8, 
        PIRF,   8, 
        PIRG,   8, 
        PIRH,   8
    }

    Scope (_SB)
    {
        Name (BUFA, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared, )
                {15}
        })
        CreateWordField (BUFA, One, IRA0)
        Device (LNKA)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Local0 = (PIRA & 0x80)
                If (Local0)
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRSA) /* \_SB_.PRSA */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                PIRA |= 0x80
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Local0 = (PIRA & 0x0F)
                IRA0 = (One << Local0)
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Local0--
                PIRA = Local0
            }
        }

        Device (LNKB)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Local0 = (PIRB & 0x80)
                If (Local0)
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRSB) /* \_SB_.PRSB */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                PIRB |= 0x80
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Local0 = (PIRB & 0x0F)
                IRA0 = (One << Local0)
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Local0--
                PIRB = Local0
            }
        }

        Device (LNKC)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Local0 = (PIRC & 0x80)
                If (Local0)
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRSC) /* \_SB_.PRSC */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                PIRC |= 0x80
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Local0 = (PIRC & 0x0F)
                IRA0 = (One << Local0)
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Local0--
                PIRC = Local0
            }
        }

        Device (LNKD)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x04)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Local0 = (PIRD & 0x80)
                If (Local0)
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRSD) /* \_SB_.PRSD */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                PIRD |= 0x80
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Local0 = (PIRD & 0x0F)
                IRA0 = (One << Local0)
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Local0--
                PIRD = Local0
            }
        }

        Device (LNKE)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x05)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Local0 = (PIRE & 0x80)
                If (Local0)
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRSE) /* \_SB_.PRSE */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                PIRE |= 0x80
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Local0 = (PIRE & 0x0F)
                IRA0 = (One << Local0)
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Local0--
                PIRE = Local0
            }
        }

        Device (LNKF)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x06)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Local0 = (PIRF & 0x80)
                If (Local0)
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRSF) /* \_SB_.PRSF */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                PIRF |= 0x80
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Local0 = (PIRF & 0x0F)
                IRA0 = (One << Local0)
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Local0--
                PIRF = Local0
            }
        }

        Device (LNKG)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x07)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Local0 = (PIRG & 0x80)
                If (Local0)
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRSG) /* \_SB_.PRSG */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                PIRG |= 0x80
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Local0 = (PIRG & 0x0F)
                IRA0 = (One << Local0)
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Local0--
                PIRG = Local0
            }
        }

        Device (LNKH)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x08)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Local0 = (PIRH & 0x80)
                If (Local0)
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRSH) /* \_SB_.PRSH */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                PIRH |= 0x80
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Local0 = (PIRH & 0x0F)
                IRA0 = (One << Local0)
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Local0--
                PIRH = Local0
            }
        }
    }

    Scope (_SB)
    {
        Name (XCPD, Zero)
        Name (XNPT, One)
        Name (XCAP, 0x02)
        Name (XDCP, 0x04)
        Name (XDCT, 0x08)
        Name (XDST, 0x0A)
        Name (XLCP, 0x0C)
        Name (XLCT, 0x10)
        Name (XLST, 0x12)
        Name (XSCP, 0x14)
        Name (XSCT, 0x18)
        Name (XSST, 0x1A)
        Name (XRCT, 0x1C)
        Mutex (MUTE, 0x00)
        Method (RBPE, 1, NotSerialized)
        {
            Acquire (MUTE, 0x03E8)
            Local0 = (Arg0 + PCIB) /* \PCIB */
            OperationRegion (PCFG, SystemMemory, Local0, One)
            Field (PCFG, ByteAcc, NoLock, Preserve)
            {
                XCFG,   8
            }

            Release (MUTE)
            Return (XCFG) /* \_SB_.RBPE.XCFG */
        }

        Method (RWPE, 1, NotSerialized)
        {
            Acquire (MUTE, 0x03E8)
            Arg0 &= 0xFFFFFFFE
            Local0 = (Arg0 + PCIB) /* \PCIB */
            OperationRegion (PCFG, SystemMemory, Local0, 0x02)
            Field (PCFG, WordAcc, NoLock, Preserve)
            {
                XCFG,   16
            }

            Release (MUTE)
            Return (XCFG) /* \_SB_.RWPE.XCFG */
        }

        Method (RDPE, 1, NotSerialized)
        {
            Acquire (MUTE, 0x03E8)
            Arg0 &= 0xFFFFFFFC
            Local0 = (Arg0 + PCIB) /* \PCIB */
            OperationRegion (PCFG, SystemMemory, Local0, 0x04)
            Field (PCFG, DWordAcc, NoLock, Preserve)
            {
                XCFG,   32
            }

            Release (MUTE)
            Return (XCFG) /* \_SB_.RDPE.XCFG */
        }

        Method (WBPE, 2, NotSerialized)
        {
            Acquire (MUTE, 0x0FFF)
            Local0 = (Arg0 + PCIB) /* \PCIB */
            OperationRegion (PCFG, SystemMemory, Local0, One)
            Field (PCFG, ByteAcc, NoLock, Preserve)
            {
                XCFG,   8
            }

            XCFG = Arg1
            Release (MUTE)
        }

        Method (WWPE, 2, NotSerialized)
        {
            Acquire (MUTE, 0x03E8)
            Arg0 &= 0xFFFFFFFE
            Local0 = (Arg0 + PCIB) /* \PCIB */
            OperationRegion (PCFG, SystemMemory, Local0, 0x02)
            Field (PCFG, WordAcc, NoLock, Preserve)
            {
                XCFG,   16
            }

            XCFG = Arg1
            Release (MUTE)
        }

        Method (WDPE, 2, NotSerialized)
        {
            Acquire (MUTE, 0x03E8)
            Arg0 &= 0xFFFFFFFC
            Local0 = (Arg0 + PCIB) /* \PCIB */
            OperationRegion (PCFG, SystemMemory, Local0, 0x04)
            Field (PCFG, DWordAcc, NoLock, Preserve)
            {
                XCFG,   32
            }

            XCFG = Arg1
            Release (MUTE)
        }

        Method (RWDP, 3, NotSerialized)
        {
            Acquire (MUTE, 0x03E8)
            Arg0 &= 0xFFFFFFFC
            Local0 = (Arg0 + PCIB) /* \PCIB */
            OperationRegion (PCFG, SystemMemory, Local0, 0x04)
            Field (PCFG, DWordAcc, NoLock, Preserve)
            {
                XCFG,   32
            }

            Local1 = (XCFG & Arg2)
            XCFG = (Local1 | Arg1)
            Release (MUTE)
        }

        Method (RPME, 1, NotSerialized)
        {
            Local0 = (Arg0 + 0x84)
            Local1 = RDPE (Local0)
            If ((Local1 == Ones))
            {
                Return (Zero)
            }
            Else
            {
                If ((Local1 && 0x00010000))
                {
                    WDPE (Local0, (Local1 & 0x00010000))
                    Return (One)
                }

                Return (Zero)
            }
        }
    }

    Scope (_SB.PCI0.SBRG.EC0)
    {
        Method (GBTT, 1, Serialized)
        {
            If (ECAV ())
            {
                If ((Arg0 == Zero))
                {
                    Local0 = EB0T /* \_SB_.PCI0.SBRG.EC0_.EB0T */
                }
                Else
                {
                    Local0 = EB1T /* \_SB_.PCI0.SBRG.EC0_.EB1T */
                }
            }
            Else
            {
                Local0 = 0xFF
            }

            Return (Local0)
        }

        Method (WCMD, 1, Serialized)
        {
            If (ECAV ())
            {
                If ((Acquire (MUEC, 0xFFFF) == Zero))
                {
                    CMD1 = Arg0
                    Release (MUEC)
                }
            }
        }

        Method (DLY0, 1, Serialized)
        {
            If (!ECAV ())
            {
                Return (Ones)
            }

            Local0 = Ones
            If ((Acquire (MUEC, 0xFFFF) == Zero))
            {
                CDT1 = Arg0
                CDT2 = 0x6B
                CDT3 = Zero
                CMD1 = 0xBB
                Local1 = 0x7F
                While ((Local1 && CMD1))
                {
                    Sleep (One)
                    Local1--
                }

                If ((CMD1 == Zero))
                {
                    Local0 = CDT1 /* \_SB_.PCI0.SBRG.EC0_.CDT1 */
                }

                Release (MUEC)
            }

            Return (Local0)
        }

        Method (RRAM, 1, Serialized)
        {
            If (ECAV ())
            {
                If ((Acquire (MUEC, 0xFFFF) == Zero))
                {
                    Local0 = Arg0
                    Local1 = (Local0 & 0xFF)
                    Local0 >>= 0x08
                    Local0 &= 0xFF
                    CDT3 = Local1
                    CDT2 = Local0
                    CDT1 = 0x80
                    CMD1 = 0xB6
                    Local0 = 0x7F
                    While ((Local0 && CMD1))
                    {
                        Sleep (One)
                        Local0--
                    }

                    If ((CMD1 == Zero))
                    {
                        Local0 = CDT1 /* \_SB_.PCI0.SBRG.EC0_.CDT1 */
                    }
                    Else
                    {
                        Local0 = Ones
                    }

                    Release (MUEC)
                    Return (Local0)
                }
            }

            Return (Ones)
        }

        Method (WRAM, 2, Serialized)
        {
            If (ECAV ())
            {
                If ((Acquire (MUEC, 0xFFFF) == Zero))
                {
                    Local0 = Arg0
                    Local1 = (Local0 & 0xFF)
                    Local0 >>= 0x08
                    Local0 &= 0xFF
                    CDT3 = Local1
                    CDT2 = Local0
                    CDT1 = 0x81
                    CDT4 = Arg1
                    CMD1 = 0xB6
                    Local0 = 0x7F
                    While ((Local0 && CMD1))
                    {
                        Sleep (One)
                        Local0--
                    }

                    If ((CMD1 == Zero))
                    {
                        Local0 = One
                    }
                    Else
                    {
                        Local0 = Ones
                    }

                    Release (MUEC)
                    Return (Local0)
                }
            }

            Return (Ones)
        }

        Method (STBR, 0, Serialized)
        {
            LBTN &= 0x0F
            Local0 = (VGAF & One)
            Local0 = RGPL (0x34, One)
            If ((!Local0 || (OSFG == OSEG)))
            {
                If (((GDOS () == One) || (OSFG == OSEG)))
                {
                    ISMI (0x9A)
                }
                Else
                {
                    Local0 = DerefOf (Index (PWAC, LBTN))
                    ^^^VGA.BCLP = Local0
                    ^^^VGA.BCLP |= 0x80000000
                    ^^^VGA.ASLC = 0x02
                    ^^^VGA.LBPC = Zero
                }
            }

            Local0 = Zero
            If (Local0)
            {
                ISMI (0x9A)
            }
            Else
            {
                If ((ACAP () | (OSFG == OSVT)))
                {
                    Local0 = DerefOf (Index (PWAC, LBTN))
                }
                Else
                {
                    Local0 = DerefOf (Index (PWDC, LBTN))
                }

                Local1 = (0x05 + 0x83)
                SADC (Local0, Local1)
            }
        }

        Method (SBRV, 1, Serialized)
        {
            WBOV (Zero, Arg0)
        }

        Name (DECF, Zero)
        Method (SFNV, 2, Serialized)
        {
            If ((Arg0 == Zero))
            {
                If ((DECF & One))
                {
                    Local0 = RRAM (0x0521)
                    Local0 |= 0x80
                    WRAM (0x0521, Local0)
                }

                If ((DECF & 0x02))
                {
                    Local0 = RRAM (0x0522)
                    Local0 |= 0x80
                    WRAM (0x0522, Local0)
                }

                DECF = Zero
                Return (Zero)
            }

            If ((Arg0 == One))
            {
                Local0 = RRAM (0x0521)
                Local0 &= 0x7F
                WRAM (0x0521, Local0)
                DECF |= One
                WFOV (Zero, Arg1)
                Return (Zero)
            }

            If ((Arg0 == 0x02))
            {
                Local0 = RRAM (0x0522)
                Local0 &= 0x7F
                WRAM (0x0522, Local0)
                DECF |= 0x02
                WFOV (One, Arg1)
                Return (Zero)
            }

            Return (Zero)
        }

        Method (SADC, 2, Serialized)
        {
            If (ECAV ())
            {
                If ((Acquire (MUEC, 0xFFFF) == Zero))
                {
                    CDT1 = 0x86
                    CDT2 = Zero
                    CDT3 = Arg0
                    CMD1 = 0xB6
                    Local0 = 0x7F
                    While ((Local0 && CMD1))
                    {
                        Sleep (One)
                        Local0--
                    }

                    If ((CMD1 == Zero))
                    {
                        Local0 = CDT1 /* \_SB_.PCI0.SBRG.EC0_.CDT1 */
                    }
                    Else
                    {
                        Local0 = Ones
                    }

                    Release (MUEC)
                    Return (Local0)
                }
            }

            Return (Ones)
        }

        Method (SBQH, 3, Serialized)
        {
            If (ECAV ())
            {
                If ((Acquire (MUEC, 0xFFFF) == Zero))
                {
                    CDT1 = Arg0
                    CDT2 = Arg1
                    CMD1 = Arg2
                    Local0 = 0x7F
                    While ((Local0 && CMD1))
                    {
                        Sleep (One)
                        Local0--
                    }

                    If ((CMD1 == Zero))
                    {
                        Local0 = CDT1 /* \_SB_.PCI0.SBRG.EC0_.CDT1 */
                    }
                    Else
                    {
                        Local0 = Ones
                    }

                    Release (MUEC)
                    Return (Local0)
                }
            }

            Return (Ones)
        }

        Method (SPIN, 2, Serialized)
        {
            Local0 = Arg0
            If (Arg1)
            {
                Local0 |= 0x20
            }
            Else
            {
                Local0 |= 0x40
            }

            STC5 (Local0)
            Return (One)
        }

        Method (RPIN, 1, Serialized)
        {
            Local0 = (Arg0 & 0x1F)
            Local1 = STC5 (Local0)
            Return (Local1)
        }

        Method (ST87, 2, Serialized)
        {
            If (ECAV ())
            {
                If ((Acquire (MUEC, 0xFFFF) == Zero))
                {
                    CDT1 = 0x87
                    CDT2 = Arg0
                    CDT3 = Arg1
                    CMD1 = 0xB6
                    Local0 = 0x7F
                    While ((Local0 && CMD1))
                    {
                        Sleep (One)
                        Local0--
                    }

                    If ((CMD1 == Zero))
                    {
                        Local0 = CDT1 /* \_SB_.PCI0.SBRG.EC0_.CDT1 */
                    }
                    Else
                    {
                        Local0 = Ones
                    }

                    Release (MUEC)
                    Return (Local0)
                }
            }

            Return (Ones)
        }

        Method (STC5, 1, Serialized)
        {
            If (ECAV ())
            {
                If ((Acquire (MUEC, 0xFFFF) == Zero))
                {
                    CDT1 = Arg0
                    CMD1 = 0xC5
                    Local0 = 0x7F
                    While ((Local0 && CMD1))
                    {
                        Sleep (One)
                        Local0--
                    }

                    If ((CMD1 == Zero))
                    {
                        Local0 = CDT1 /* \_SB_.PCI0.SBRG.EC0_.CDT1 */
                    }
                    Else
                    {
                        Local0 = Ones
                    }

                    Release (MUEC)
                    Return (Local0)
                }
            }

            Return (Ones)
        }

        Method (WKTM, 1, Serialized)
        {
            If (ECAV ())
            {
                If ((Acquire (MUEC, 0xFFFF) == Zero))
                {
                    CDT1 = 0x9E
                    CDT2 = 0x08
                    CDT3 = 0xFF
                    CDT4 = Arg0
                    CMD1 = 0xB6
                    Local0 = 0x7F
                    While ((Local0 && CMD1))
                    {
                        Sleep (One)
                        Local0--
                    }

                    If ((CMD1 == Zero))
                    {
                        Local0 = CDT1 /* \_SB_.PCI0.SBRG.EC0_.CDT1 */
                    }
                    Else
                    {
                        Local0 = Ones
                    }

                    Release (MUEC)
                    Return (Local0)
                }
            }

            Return (Ones)
        }

        Method (WKFG, 1, Serialized)
        {
            If (ECAV ())
            {
                If ((Acquire (MUEC, 0xFFFF) == Zero))
                {
                    CDT1 = 0x9E
                    CDT2 = 0x06
                    CDT3 = Arg0
                    CMD1 = 0xB6
                    Local0 = 0x7F
                    While ((Local0 && CMD1))
                    {
                        Sleep (One)
                        Local0--
                    }

                    If ((CMD1 == Zero))
                    {
                        Local0 = CDT1 /* \_SB_.PCI0.SBRG.EC0_.CDT1 */
                    }
                    Else
                    {
                        Local0 = Ones
                    }

                    Release (MUEC)
                    Return (Local0)
                }
            }

            Return (Ones)
        }

        Method (RBAT, 2, Serialized)
        {
            If (!ECAV ())
            {
                Return (Ones)
            }

            If ((Acquire (MUEC, 0xFFFF) == Zero))
            {
                Local0 = 0x03
                While (Local0)
                {
                    CDT2 = Arg0
                    Local1 = Arg1
                    Local1 <<= One
                    Local1 += 0xDA
                    CMD1 = Local1
                    Local1 = 0x7F
                    While ((CMD1 && Local1))
                    {
                        Local1--
                        Sleep (One)
                    }

                    If ((CMD1 == Zero))
                    {
                        Local1 = CDT1 /* \_SB_.PCI0.SBRG.EC0_.CDT1 */
                        Local0 = Zero
                    }
                    Else
                    {
                        Local1 = Ones
                        Local0--
                    }
                }

                Release (MUEC)
                Return (Local1)
            }

            Return (Ones)
        }

        Method (WBAT, 3, Serialized)
        {
            Local3 = (Arg0 | 0x80)
            If (!ECAV ())
            {
                Return (Ones)
            }

            If ((Acquire (MUEC, 0xFFFF) == Zero))
            {
                Local0 = 0x03
                While (Local0)
                {
                    CDT1 = Arg2
                    CDT2 = Local3
                    Local1 = Arg1
                    Local1 <<= One
                    Local1 += 0xDA
                    CMD1 = Local1
                    Local1 = 0x7F
                    While ((CMD1 && Local1))
                    {
                        Local1--
                        Sleep (One)
                    }
                }

                Release (MUEC)
                Return (Local1)
            }

            Return (Ones)
        }

        Method (FNCT, 2, Serialized)
        {
            If (ECAV ())
            {
                If ((Acquire (MUEC, 0xFFFF) == Zero))
                {
                    CDT2 = Arg0
                    CDT1 = Arg1
                    CMD1 = 0xC4
                    Local0 = 0x7F
                    While ((Local0 && CMD1))
                    {
                        Sleep (One)
                        Local0--
                    }

                    Release (MUEC)
                }
            }
        }

        Name (WRQK, 0x02)
        Name (RDQK, 0x03)
        Name (SDBT, 0x04)
        Name (RCBT, 0x05)
        Name (WRBT, 0x06)
        Name (RDBT, 0x07)
        Name (WRWD, 0x08)
        Name (RDWD, 0x09)
        Name (WRBL, 0x0A)
        Name (RDBL, 0x0B)
        Name (PCLL, 0x0C)
        Name (GOOD, Zero)
        Name (UKER, 0x07)
        Name (DAER, 0x10)
        Name (CMDN, 0x12)
        Name (UKE2, 0x13)
        Name (DADN, 0x17)
        Name (SBTO, 0x18)
        Name (USPT, 0x19)
        Name (SBBY, 0x1A)
        Method (SWTC, 1, Serialized)
        {
            Local0 = UKER /* \_SB_.PCI0.SBRG.EC0_.UKER */
            Local1 = 0x03
            While ((Local0 && Local1))
            {
                Local2 = 0x23
                While (Local2)
                {
                    If (PRTC)
                    {
                        Sleep (One)
                        Local2--
                    }
                    Else
                    {
                        Local2 = Zero
                        Local0 = SSTS /* \_SB_.PCI0.SBRG.EC0_.SSTS */
                    }
                }

                If (Local0)
                {
                    PRTC = Zero
                    Local1--
                    If (Local1)
                    {
                        Sleep (One)
                        PRTC = Arg0
                    }
                }
            }

            Return (Local0)
        }

        Method (SMBR, 3, Serialized)
        {
            Local0 = Package (0x03)
                {
                    0x07, 
                    Zero, 
                    Zero
                }
            If (!ECAV ())
            {
                Return (Local0)
            }

            If ((Arg0 != RDBL))
            {
                If ((Arg0 != RDWD))
                {
                    If ((Arg0 != RDBT))
                    {
                        If ((Arg0 != RCBT))
                        {
                            If ((Arg0 != RDQK))
                            {
                                Return (Local0)
                            }
                        }
                    }
                }
            }

            If ((Acquire (MUEC, 0xFFFF) == Zero))
            {
                Local1 = PRTC /* \_SB_.PCI0.SBRG.EC0_.PRTC */
                Local2 = Zero
                While ((Local1 != Zero))
                {
                    Stall (0x0A)
                    Local2++
                    If ((Local2 > 0x03E8))
                    {
                        Index (Local0, Zero) = SBBY /* \_SB_.PCI0.SBRG.EC0_.SBBY */
                        Local1 = Zero
                    }
                    Else
                    {
                        Local1 = PRTC /* \_SB_.PCI0.SBRG.EC0_.PRTC */
                    }
                }

                If ((Local2 <= 0x03E8))
                {
                    Local3 = (Arg1 << One)
                    Local3 |= One
                    ADDR = Local3
                    If ((Arg0 != RDQK))
                    {
                        If ((Arg0 != RCBT))
                        {
                            CMDB = Arg2
                        }
                    }

                    BDAT = Zero
                    PRTC = Arg0
                    Index (Local0, Zero) = SWTC (Arg0)
                    If ((DerefOf (Index (Local0, Zero)) == Zero))
                    {
                        If ((Arg0 == RDBL))
                        {
                            Index (Local0, One) = BCNT /* \_SB_.PCI0.SBRG.EC0_.BCNT */
                            Index (Local0, 0x02) = BDAT /* \_SB_.PCI0.SBRG.EC0_.BDAT */
                        }

                        If ((Arg0 == RDWD))
                        {
                            Index (Local0, One) = 0x02
                            Index (Local0, 0x02) = DT2B /* \_SB_.PCI0.SBRG.EC0_.DT2B */
                        }

                        If ((Arg0 == RDBT))
                        {
                            Index (Local0, One) = One
                            Index (Local0, 0x02) = DAT0 /* \_SB_.PCI0.SBRG.EC0_.DAT0 */
                        }

                        If ((Arg0 == RCBT))
                        {
                            Index (Local0, One) = One
                            Index (Local0, 0x02) = DAT0 /* \_SB_.PCI0.SBRG.EC0_.DAT0 */
                        }
                    }
                }

                Release (MUEC)
            }

            Return (Local0)
        }

        Method (SMBW, 5, Serialized)
        {
            Local0 = Package (0x01)
                {
                    0x07
                }
            If (!ECAV ())
            {
                Return (Local0)
            }

            If ((Arg0 != WRBL))
            {
                If ((Arg0 != WRWD))
                {
                    If ((Arg0 != WRBT))
                    {
                        If ((Arg0 != SDBT))
                        {
                            If ((Arg0 != WRQK))
                            {
                                Return (Local0)
                            }
                        }
                    }
                }
            }

            If ((Acquire (MUEC, 0xFFFF) == Zero))
            {
                Local1 = PRTC /* \_SB_.PCI0.SBRG.EC0_.PRTC */
                Local2 = Zero
                While ((Local1 != Zero))
                {
                    Stall (0x0A)
                    Local2++
                    If ((Local2 > 0x03E8))
                    {
                        Index (Local0, Zero) = SBBY /* \_SB_.PCI0.SBRG.EC0_.SBBY */
                        Local1 = Zero
                    }
                    Else
                    {
                        Local1 = PRTC /* \_SB_.PCI0.SBRG.EC0_.PRTC */
                    }
                }

                If ((Local2 <= 0x03E8))
                {
                    BDAT = Zero
                    Local3 = (Arg1 << One)
                    ADDR = Local3
                    If ((Arg0 != WRQK))
                    {
                        If ((Arg0 != SDBT))
                        {
                            CMDB = Arg2
                        }
                    }

                    If ((Arg0 == WRBL))
                    {
                        BCNT = Arg3
                        BDAT = Arg4
                    }

                    If ((Arg0 == WRWD))
                    {
                        DT2B = Arg4
                    }

                    If ((Arg0 == WRBT))
                    {
                        DAT0 = Arg4
                    }

                    If ((Arg0 == SDBT))
                    {
                        DAT0 = Arg4
                    }

                    PRTC = Arg0
                    Index (Local0, Zero) = SWTC (Arg0)
                }

                Release (MUEC)
            }

            Return (Local0)
        }

        Mutex (MUEP, 0x00)
        Method (RBEP, 1, NotSerialized)
        {
            Local1 = 0xFFFF
            If ((Acquire (MUEP, 0xFFFF) == Zero))
            {
                Local3 = RRAM (0x0620)
                Local4 = (Local3 & 0x7F)
                WRAM (0x0620, Local4)
                Local2 = 0x10
                Local1 = 0x10
                While (((Local1 == 0x10) & (Local2 != Zero)))
                {
                    SMBW (WRWD, BADR, Zero, 0x02, 0x0635)
                    SMBW (WRWD, BADR, Zero, 0x02, 0x0606)
                    Local0 = SMBR (RDBT, 0x50, Arg0)
                    Local1 = DerefOf (Index (Local0, Zero))
                    Local2--
                }

                WRAM (0x0620, Local3)
                Local1 <<= 0x08
                Local1 |= DerefOf (Index (Local0, 0x02))
                Release (MUEP)
            }

            Return (Local1)
        }

        Method (WBEP, 2, NotSerialized)
        {
            Local1 = 0xFFFF
            If ((Acquire (MUEP, 0xFFFF) == Zero))
            {
                Local3 = RRAM (0x0620)
                Local4 = (Local3 & 0x7F)
                WRAM (0x0620, Local4)
                Local2 = 0x10
                Local1 = 0x10
                While (((Local1 == 0x10) & (Local2 != Zero)))
                {
                    SMBW (WRWD, BADR, Zero, 0x02, 0x0635)
                    SMBW (WRWD, BADR, Zero, 0x02, 0x0606)
                    Local0 = SMBW (WRBT, 0x50, Arg0, One, Arg1)
                    Local1 = DerefOf (Index (Local0, Zero))
                    Local2--
                }

                WRAM (0x0620, Local3)
                Release (MUEP)
            }

            Return (Local1)
        }

        Method (ECXT, 6, NotSerialized)
        {
            Local1 = Package (0x06)
                {
                    0x10, 
                    Zero, 
                    Zero, 
                    Zero, 
                    Zero, 
                    Zero
                }
            If (ECAV ())
            {
                If ((Acquire (MUEC, 0xFFFF) == Zero))
                {
                    CDT1 = Arg1
                    CDT2 = Arg2
                    CDT3 = Arg3
                    CDT4 = Arg4
                    CDT5 = Arg5
                    CMD1 = Arg0
                    Local0 = 0x7F
                    While ((Local0 && CMD1))
                    {
                        Sleep (One)
                        Local0--
                    }

                    If (Local0)
                    {
                        Index (Local1, Zero) = Zero
                        Index (Local1, One) = CDT1 /* \_SB_.PCI0.SBRG.EC0_.CDT1 */
                        Index (Local1, 0x02) = CDT2 /* \_SB_.PCI0.SBRG.EC0_.CDT2 */
                        Index (Local1, 0x03) = CDT3 /* \_SB_.PCI0.SBRG.EC0_.CDT3 */
                        Index (Local1, 0x04) = CDT4 /* \_SB_.PCI0.SBRG.EC0_.CDT4 */
                        Index (Local1, 0x05) = CDT5 /* \_SB_.PCI0.SBRG.EC0_.CDT5 */
                    }
                    Else
                    {
                        Index (Local1, Zero) = 0x10
                    }

                    Release (MUEC)
                }
            }

            Return (Local1)
        }

        Method (ECSB, 6, NotSerialized)
        {
            Local1 = Package (0x05)
                {
                    0x11, 
                    Zero, 
                    Zero, 
                    Zero, 
                    Zero
                }
            If ((Arg0 > One))
            {
                Return (Local1)
            }

            If (ECAV ())
            {
                If ((Acquire (MUEC, 0xFFFF) == Zero))
                {
                    If ((Arg0 == Zero))
                    {
                        ADDR = Arg2
                        CMDB = Arg3
                        DAT0 = Arg4
                        DAT1 = Arg5
                        PRTC = Arg1
                    }
                    Else
                    {
                        ADD2 = Arg2
                        CMD2 = Arg3
                        DA20 = Arg4
                        DA21 = Arg5
                        PRT2 = Arg1
                    }

                    Local0 = 0x7F
                    While (PRTC)
                    {
                        Sleep (One)
                        Local0--
                    }

                    If (Local0)
                    {
                        If ((Arg0 == Zero))
                        {
                            Local0 = SSTS /* \_SB_.PCI0.SBRG.EC0_.SSTS */
                            Index (Local1, One) = DAT0 /* \_SB_.PCI0.SBRG.EC0_.DAT0 */
                            Index (Local1, 0x02) = DAT1 /* \_SB_.PCI0.SBRG.EC0_.DAT1 */
                            Index (Local1, 0x03) = BCNT /* \_SB_.PCI0.SBRG.EC0_.BCNT */
                            Index (Local1, 0x04) = BDAT /* \_SB_.PCI0.SBRG.EC0_.BDAT */
                        }
                        Else
                        {
                            Local0 = SST2 /* \_SB_.PCI0.SBRG.EC0_.SST2 */
                            Index (Local1, One) = DA20 /* \_SB_.PCI0.SBRG.EC0_.DA20 */
                            Index (Local1, 0x02) = DA21 /* \_SB_.PCI0.SBRG.EC0_.DA21 */
                            Index (Local1, 0x03) = BCN2 /* \_SB_.PCI0.SBRG.EC0_.BCN2 */
                            Index (Local1, 0x04) = BDA2 /* \_SB_.PCI0.SBRG.EC0_.BDA2 */
                        }

                        Local0 &= 0x1F
                        If (Local0)
                        {
                            Local0 += 0x10
                        }

                        Index (Local1, Zero) = Local0
                    }
                    Else
                    {
                        Index (Local1, Zero) = 0x10
                    }

                    Release (MUEC)
                }
            }

            Return (Local1)
        }

        OperationRegion (KAID, SystemIO, 0x025C, One)
        Field (KAID, ByteAcc, NoLock, Preserve)
        {
            AEID,   8
        }

        OperationRegion (KAIC, SystemIO, 0x025D, One)
        Field (KAIC, ByteAcc, NoLock, Preserve)
        {
            AEIC,   8
        }

        Method (WEIE, 0, Serialized)
        {
            Local0 = 0x4000
            Local1 = (AEIC & 0x02)
            While (((Local0 != Zero) && (Local1 == 0x02)))
            {
                Local1 = (AEIC & 0x02)
                Local0--
            }
        }

        Method (WEOF, 0, Serialized)
        {
            Local0 = 0x4000
            Local1 = (AEIC & One)
            While (((Local0 != Zero) && (Local1 == Zero)))
            {
                Local1 = (AEIC & One)
                Local0--
            }
        }

        Method (RFOV, 1, Serialized)
        {
            Local0 = Zero
            If ((Acquire (ASIO, 0xFFFF) == Zero))
            {
                WEIE ()
                AEIC = 0x83
                WEIE ()
                AEID = Arg0
                WEOF ()
                Local0 = AEID /* \_SB_.PCI0.SBRG.EC0_.AEID */
                WEIE ()
                Release (ASIO)
            }

            Return (Local0)
        }

        Method (WFOV, 2, Serialized)
        {
            If ((Acquire (ASIO, 0xFFFF) == Zero))
            {
                WEIE ()
                AEIC = 0x84
                WEIE ()
                AEID = Arg0
                WEIE ()
                AEID = Arg1
                Release (ASIO)
            }
        }

        Method (RBOV, 1, Serialized)
        {
            Local0 = Zero
            If ((Acquire (ASIO, 0xFFFF) == Zero))
            {
                WEIE ()
                AEIC = 0x85
                WEIE ()
                AEID = Arg0
                WEOF ()
                Local0 = AEID /* \_SB_.PCI0.SBRG.EC0_.AEID */
                WEIE ()
                Release (ASIO)
            }

            Return (Local0)
        }

        Method (WBOV, 2, Serialized)
        {
            If ((Acquire (ASIO, 0xFFFF) == Zero))
            {
                WEIE ()
                AEIC = 0x86
                WEIE ()
                AEID = Arg0
                WEIE ()
                AEID = Arg1
                Release (ASIO)
            }
        }

        Method (WMFN, 1, Serialized)
        {
            If ((Acquire (ASIO, 0xFFFF) == Zero))
            {
                WEIE ()
                AEIC = 0x98
                WEIE ()
                AEID = Arg0
                WEIE ()
                Release (ASIO)
            }
        }

        Method (ECRS, 2, Serialized)
        {
            If (ECAV ())
            {
                If ((Acquire (MUEC, 0xFFFF) == Zero))
                {
                    ADD2 = Arg0
                    CMD2 = Arg1
                    PRT2 = 0x07
                    Local0 = 0x7F
                    While (PRT2)
                    {
                        Sleep (One)
                        Local0--
                    }

                    If (Local0)
                    {
                        Local0 = DA20 /* \_SB_.PCI0.SBRG.EC0_.DA20 */
                    }
                    Else
                    {
                        Local0 = Ones
                    }

                    Release (MUEC)
                }
            }

            Return (Local0)
        }

        Method (ECWS, 3, Serialized)
        {
            If (ECAV ())
            {
                If ((Acquire (MUEC, 0xFFFF) == Zero))
                {
                    ADD2 = Arg0
                    CMD2 = Arg1
                    DA20 = Arg2
                    PRT2 = 0x06
                    Local0 = 0x07FF
                    While (PRT2)
                    {
                        Sleep (One)
                        Local0--
                    }

                    Release (MUEC)
                }
            }

            Return (Local0)
        }
    }

    Scope (_SB.PCI0.SBRG.EC0)
    {
        Name (PWAC, Buffer (0x10)
        {
            /* 0000 */  0x0C, 0x1C, 0x2B, 0x3A, 0x49, 0x59, 0x68, 0x77,  /* ..+:IYhw */
            /* 0008 */  0x87, 0x96, 0xA5, 0xB5, 0xC4, 0xD3, 0xE2, 0xFF   /* ........ */
        })
        Name (PWDC, Buffer (0x10)
        {
            /* 0000 */  0x0C, 0x1C, 0x2B, 0x3A, 0x49, 0x59, 0x68, 0x77,  /* ..+:IYhw */
            /* 0008 */  0x87, 0x96, 0xA5, 0xB5, 0xC4, 0xD3, 0xE2, 0xFF   /* ........ */
        })
        Method (ACPS, 0, Serialized)
        {
            Return ((GPWS () & One))
        }

        Method (DCPS, 1, Serialized)
        {
            Local0 = GPWS ()
            If (Arg0)
            {
                Local0 &= 0x04
            }
            Else
            {
                Local0 &= 0x02
            }

            If (Local0)
            {
                Local0 = One
            }
            Else
            {
                Local0 = Zero
            }

            Return (Local0)
        }

        Method (GPWS, 0, Serialized)
        {
            If (ECAV ())
            {
                Local0 = (EPWS & 0x07)
            }
            Else
            {
                Local0 = Zero
            }

            Return (Local0)
        }

        Method (BCHG, 1, Serialized)
        {
            If (Arg0)
            {
                If (ECAV ())
                {
                    Local0 = EB1S /* \_SB_.PCI0.SBRG.EC0_.EB1S */
                    Local0 &= 0xFF
                    If ((Local0 != 0xFF))
                    {
                        Local0 &= 0x02
                    }
                    Else
                    {
                        Local0 = Zero
                    }
                }
                Else
                {
                    Local0 = Zero
                }

                Return (Local0)
            }
            Else
            {
                If (ECAV ())
                {
                    Local0 = EB0S /* \_SB_.PCI0.SBRG.EC0_.EB0S */
                    Local0 &= 0xFF
                    If ((Local0 != 0xFF))
                    {
                        Local0 &= 0x02
                    }
                    Else
                    {
                        Local0 = Zero
                    }
                }
                Else
                {
                    Local0 = Zero
                }

                Return (Local0)
            }
        }

        Method (BCLE, 1, Serialized)
        {
            If (Arg0)
            {
                If (ECAV ())
                {
                    Local0 = Ones
                    Local1 = EB1S /* \_SB_.PCI0.SBRG.EC0_.EB1S */
                    Local1 &= 0xFFFF
                    If ((Local1 != 0xFFFF))
                    {
                        Local1 &= 0x16
                        If ((Local1 == 0x04))
                        {
                            Local0 = Zero
                        }
                        Else
                        {
                            If ((Local1 == 0x02))
                            {
                                Local0 = One
                            }
                            Else
                            {
                                If ((Local1 == 0x10))
                                {
                                    Local0 = One
                                }
                            }
                        }
                    }
                }
                Else
                {
                    Local0 = Ones
                }

                Return (Local0)
            }
            Else
            {
                If (ECAV ())
                {
                    Local0 = Ones
                    Local1 = EB0S /* \_SB_.PCI0.SBRG.EC0_.EB0S */
                    Local1 &= 0xFFFF
                    If ((Local1 != 0xFFFF))
                    {
                        Local1 &= 0x16
                        If ((Local1 == 0x04))
                        {
                            Local0 = Zero
                        }
                        Else
                        {
                            If ((Local1 == 0x02))
                            {
                                Local0 = One
                            }
                            Else
                            {
                                If ((Local1 == 0x10))
                                {
                                    Local0 = One
                                }
                            }
                        }
                    }
                }
                Else
                {
                    Local0 = Ones
                }

                Return (Local0)
            }
        }

        Method (CHBT, 1, Serialized)
        {
            If (ECAV ())
            {
                Local1 = GBTT (Arg0)
                If ((Local1 == 0xFF))
                {
                    Local0 = Zero
                }
                Else
                {
                    Local0 = (Local1 & 0x10)
                    If (Local0)
                    {
                        Local0 = Zero
                    }
                    Else
                    {
                        Local0 = One
                    }
                }
            }
            Else
            {
                Local0 = DCTP /* \DCTP */
            }

            Return (Local0)
        }

        Method (TACH, 1, NotSerialized)
        {
            If (Arg0)
            {
                If (ECAV ())
                {
                    If ((DECF & 0x02))
                    {
                        Local0 = RRAM (0x1820)
                        Local1 = RRAM (0x1821)
                        Local1 <<= 0x08
                        Local0 += Local1
                    }
                    Else
                    {
                        Local0 = TAH1 /* \_SB_.PCI0.SBRG.EC0_.TAH1 */
                    }

                    Local0 &= 0xFFFF
                    If ((Local0 != Zero))
                    {
                        If ((Local0 == 0xFFFF))
                        {
                            Local0 = Zero
                        }
                        Else
                        {
                            Local1 = 0x80
                            Local2 = 0x02
                            Local3 = (Local1 * Local2)
                            Local4 = (Local0 * Local3)
                            Divide (0x03938700, Local4, Local5, Local6)
                            Local6 *= 0x0A
                            Local0 = Local6
                        }
                    }
                    Else
                    {
                        Local0 = Zero
                    }
                }
                Else
                {
                    Local0 = Ones
                }

                Return (Local0)
            }
            Else
            {
                If (ECAV ())
                {
                    If ((DECF & One))
                    {
                        Local0 = RRAM (0x181E)
                        Local1 = RRAM (0x181F)
                        Local1 <<= 0x08
                        Local0 += Local1
                    }
                    Else
                    {
                        Local0 = TAH0 /* \_SB_.PCI0.SBRG.EC0_.TAH0 */
                    }

                    Local0 &= 0xFFFF
                    If ((Local0 != Zero))
                    {
                        If ((Local0 == 0xFFFF))
                        {
                            Local0 = Zero
                        }
                        Else
                        {
                            Local1 = 0x80
                            Local2 = 0x02
                            Local3 = (Local1 * Local2)
                            Local4 = (Local0 * Local3)
                            Divide (0x03938700, Local4, Local5, Local6)
                            Local6 *= 0x0A
                            Local0 = Local6
                        }
                    }
                    Else
                    {
                        Local0 = Zero
                    }
                }
                Else
                {
                    Local0 = Ones
                }

                Return (Local0)
            }
        }

        Name (HKFG, Zero)
        Method (EC0S, 1, NotSerialized)
        {
            If ((Arg0 == 0x03)) {}
            HKFG = HKEN /* \_SB_.PCI0.SBRG.EC0_.HKEN */
            LLOW = Zero
            If (((Arg0 == 0x03) || (Arg0 == 0x04))) {}
        }

        Method (EC0W, 1, NotSerialized)
        {
            If ((Arg0 == 0x03)) {}
            If ((Arg0 <= 0x04))
            {
                ACPF = ACPS ()
                DCPF = DCPS (Zero)
            }

            If ((Arg0 >= 0x04))
            {
                HKEN = HKFG /* \_SB_.PCI0.SBRG.EC0_.HKFG */
            }

            Local0 = RRAM (0x0605)
            Local0 &= 0xF7
            WRAM (0x0605, Local0)
            If (((Arg0 == 0x03) || (Arg0 == 0x04))) {}
        }

        Method (_Q01, 0, NotSerialized)  // _Qxx: EC Query
        {
            If (ATKP)
            {
                Notify (ATKD, 0x52) // Reserved
            }
        }

        Method (_Q02, 0, NotSerialized)  // _Qxx: EC Query
        {
            If (ATKP)
            {
                Notify (ATKD, 0x53) // Reserved
            }
        }

        Method (_Q03, 0, NotSerialized)  // _Qxx: EC Query
        {
            If (ATKP)
            {
                Notify (ATKD, 0x54) // Reserved
            }
        }

        Method (_Q04, 0, NotSerialized)  // _Qxx: EC Query
        {
            If (ATKP)
            {
                Notify (ATKD, 0x55) // Reserved
            }
        }

        Method (_Q05, 0, NotSerialized)  // _Qxx: EC Query
        {
            If (ATKP)
            {
                Notify (ATKD, 0x56) // Reserved
            }
        }

        Method (_Q0A, 0, NotSerialized)  // _Qxx: EC Query
        {
            Notify (SLPB, 0x80) // Status Change
        }

        Method (_Q0B, 0, NotSerialized)  // _Qxx: EC Query
        {
            If ((^^^^ATKD.WAPF & 0x04))
            {
                If (ATKP)
                {
                    Notify (ATKD, 0x88) // Device-Specific
                }
            }
            Else
            {
                Local0 = OHWR ()
                If ((Local0 & 0x02))
                {
                    If ((Local0 & One))
                    {
                        Local0 = One
                    }
                    Else
                    {
                        Local0 = Zero
                    }
                }
                Else
                {
                    Local0 = One
                }

                If (Local0)
                {
                    If ((^^^^ATKD.WAPF & One))
                    {
                        If ((WLDP && BTDP))
                        {
                            Local0 = WRST /* \WRST */
                            Local0 |= (BRST << One)
                            Local0++
                            If ((Local0 > 0x03))
                            {
                                Local0 = Zero
                            }

                            Local1 = DerefOf (Index (WBTL, Local0))
                            If ((Local1 == Zero))
                            {
                                Notify (ATKD, 0x5D) // Reserved
                                Sleep (0x0DAC)
                                OBTD (Zero)
                                Notify (ATKD, 0x7E) // Reserved
                            }

                            If ((Local1 == One))
                            {
                                Notify (ATKD, 0x5D) // Reserved
                                Sleep (0x0DAC)
                                OBTD (Zero)
                                Notify (ATKD, 0x7E) // Reserved
                            }

                            If ((Local1 == 0x02))
                            {
                                Notify (ATKD, 0x5D) // Reserved
                                Sleep (0x0DAC)
                                OBTD (One)
                                Notify (ATKD, 0x7D) // Reserved
                            }

                            If ((Local1 == 0x03))
                            {
                                Notify (ATKD, 0x5D) // Reserved
                                Sleep (0x0DAC)
                                OBTD (One)
                                Notify (ATKD, 0x7D) // Reserved
                            }
                        }
                        Else
                        {
                            If (WLDP)
                            {
                                Notify (ATKD, 0x5D) // Reserved
                            }
                            Else
                            {
                                If (BTDP)
                                {
                                    If (BRST)
                                    {
                                        OBTD (Zero)
                                        Notify (ATKD, 0x7E) // Reserved
                                    }
                                    Else
                                    {
                                        OBTD (One)
                                        Notify (ATKD, 0x7D) // Reserved
                                    }
                                }
                            }
                        }
                    }
                    Else
                    {
                        Local0 = (WLDP && BTDP)
                        Local1 = (OSFG != OSEG)
                        If ((Local0 && Local1))
                        {
                            Local0 = WRST /* \WRST */
                            Local0 |= (BRST << One)
                            Local0++
                            If ((Local0 > 0x03))
                            {
                                Local0 = Zero
                            }

                            Local1 = DerefOf (Index (WBTL, Local0))
                            If ((Local1 == Zero))
                            {
                                OWLD (Zero)
                                Notify (ATKD, 0x5F) // Reserved
                                Sleep (0x0DAC)
                                OBTD (Zero)
                                Notify (ATKD, 0x7E) // Reserved
                            }

                            If ((Local1 == One))
                            {
                                OWLD (One)
                                Notify (ATKD, 0x5E) // Reserved
                                Sleep (0x0DAC)
                                OBTD (Zero)
                                Notify (ATKD, 0x7E) // Reserved
                            }

                            If ((Local1 == 0x02))
                            {
                                OWLD (Zero)
                                Notify (ATKD, 0x5F) // Reserved
                                Sleep (0x0DAC)
                                OBTD (One)
                                Notify (ATKD, 0x7D) // Reserved
                            }

                            If ((Local1 == 0x03))
                            {
                                OWLD (One)
                                Notify (ATKD, 0x5E) // Reserved
                                Sleep (0x0DAC)
                                OBTD (One)
                                Notify (ATKD, 0x7D) // Reserved
                            }
                        }
                        Else
                        {
                            If (WLDP)
                            {
                                If (WRST)
                                {
                                    OWLD (Zero)
                                    Notify (ATKD, 0x5F) // Reserved
                                }
                                Else
                                {
                                    OWLD (One)
                                    Notify (ATKD, 0x5E) // Reserved
                                }
                            }
                            Else
                            {
                                If (BTDP)
                                {
                                    If (BRST)
                                    {
                                        OBTD (Zero)
                                        Notify (ATKD, 0x7E) // Reserved
                                    }
                                    Else
                                    {
                                        OBTD (One)
                                        Notify (ATKD, 0x7D) // Reserved
                                    }
                                }
                            }
                        }
                    }
                }
                Else
                {
                    If (WLDP)
                    {
                        Notify (ATKD, 0x5F) // Reserved
                    }

                    If ((OSFG != OSEG))
                    {
                        If ((WLDP && BTDP))
                        {
                            Sleep (0x0DAC)
                        }

                        If (BTDP)
                        {
                            Notify (ATKD, 0x7E) // Reserved
                        }
                    }
                }
            }
        }

        Name (WBTL, Package (0x04)
        {
            Zero, 
            One, 
            0x02, 
            0x03
        })
        Method (_Q0C, 0, NotSerialized)  // _Qxx: EC Query
        {
            If (ATKP)
            {
                Notify (ATKD, 0x50) // Reserved
            }
        }

        Method (_Q0D, 0, NotSerialized)  // _Qxx: EC Query
        {
            If (ATKP)
            {
                Notify (ATKD, 0x51) // Reserved
            }
        }

        Method (_Q0E, 0, Serialized)  // _Qxx: EC Query
        {
            If ((OSFG >= OSVT))
            {
                Local0 = LBTN /* \LBTN */
                If (^^^VGA.PRST ())
                {
                    ^^^VGA.LCDD.BCBH = 0x02
                    ^^^VGA.DWBL ()
                }

                If (^^^P0P1.VGA.PRST ())
                {
                    ^^^P0P1.VGA.LCDD.BCBH = 0x02
                    ^^^P0P1.VGA.DWBL ()
                }

                If (ATKP)
                {
                    If ((Local0 > Zero))
                    {
                        Local0--
                    }

                    If ((Local0 > 0x0F))
                    {
                        Local0 = 0x0F
                    }

                    Notify (ATKD, (Local0 + 0x20))
                }
            }
            Else
            {
                If ((LBTN > Zero))
                {
                    LBTN--
                }

                If ((LBTN > 0x0F))
                {
                    LBTN = 0x0F
                }

                STBR ()
                If (ATKP)
                {
                    Notify (ATKD, (LBTN + 0x20))
                }
            }

            Return (One)
        }

        Method (_Q0F, 0, Serialized)  // _Qxx: EC Query
        {
            If ((OSFG >= OSVT))
            {
                Local0 = LBTN /* \LBTN */
                If (^^^VGA.PRST ())
                {
                    ^^^VGA.LCDD.BCBH = One
                    ^^^VGA.UPBL ()
                }

                If (^^^P0P1.VGA.PRST ())
                {
                    ^^^P0P1.VGA.LCDD.BCBH = One
                    ^^^P0P1.VGA.UPBL ()
                }

                If (ATKP)
                {
                    If ((Local0 < 0x0F))
                    {
                        Local0++
                    }
                    Else
                    {
                        Local0 = 0x0F
                    }

                    Notify (ATKD, (Local0 + 0x10))
                }
            }
            Else
            {
                If ((LBTN < 0x0F))
                {
                    LBTN++
                }
                Else
                {
                    LBTN = 0x0F
                }

                STBR ()
                If (ATKP)
                {
                    Notify (ATKD, (LBTN + 0x10))
                }
            }

            Return (One)
        }

        Method (_Q10, 0, NotSerialized)  // _Qxx: EC Query
        {
            Local0 = One
            Local0 = RPIN (0x11)
            Local0 ^= One
            SPIN (0x11, Local0)
            If (ATKP)
            {
                Local0 -= 0x34
                Notify (ATKD, Local0)
            }
        }

        Name (AVNC, Package (0x19)
        {
            Zero, 
            0x61, 
            0x62, 
            0x63, 
            0x64, 
            0x65, 
            0x66, 
            0x67, 
            0xA0, 
            0xA1, 
            0xA2, 
            0xA4, 
            0xA3, 
            0xA5, 
            0xA6, 
            0xA7, 
            0x8C, 
            0x8D, 
            0x8E, 
            0x90, 
            0x8F, 
            0x91, 
            0x92, 
            0x93, 
            Zero
        })
        Method (_Q11, 0, NotSerialized)  // _Qxx: EC Query
        {
            If ((GDOS () >= 0x02))
            {
                If ((GDOS () == 0x03))
                {
                    NVGA (0x82)
                }
            }
            Else
            {
                FHKW ()
                If ((OSFG == OSEG))
                {
                    Local0 = ^^^P0P1.VGA.ADVD ()
                    Local1 = DerefOf (Index (AVNC, Local0))
                    SFUN = 0x04
                    ISMI (0x94)
                }
                Else
                {
                    If (NATK ())
                    {
                        If (((OSFG == OSVT) || (OSFG == OSW7)))
                        {
                            Local0 = ^^^VGA.HDVG ()
                            Local1 = DerefOf (Index (AVNC, Local0))
                            Notify (ATKD, Local1)
                        }
                        Else
                        {
                            Local0 = ^^^P0P1.VGA.ADVD ()
                            Local1 = DerefOf (Index (AVNC, Local0))
                            If (ATKP)
                            {
                                Notify (ATKD, Local1)
                            }
                            Else
                            {
                                SWHG (Local0)
                            }
                        }
                    }
                }

                FHKS ()
            }
        }

        Name (FHKM, One)
        Method (FHKW, 0, Serialized)
        {
            While (!FHKM)
            {
                Sleep (0x0A)
            }

            FHKM = Zero
        }

        Method (FHKS, 0, Serialized)
        {
            FHKM = One
        }

        Method (_Q12, 0, NotSerialized)  // _Qxx: EC Query
        {
            If (!(DSYN & One))
            {
                If (ATKP)
                {
                    Notify (ATKD, 0x6B) // Reserved
                }
            }
            Else
            {
                If (ATKP)
                {
                    Notify (ATKD, 0x6F) // Reserved
                }
            }
        }

        Method (_Q13, 0, NotSerialized)  // _Qxx: EC Query
        {
            If (ATKP)
            {
                Notify (ATKD, 0x32) // Reserved
            }
        }

        Method (_Q14, 0, NotSerialized)  // _Qxx: EC Query
        {
            If ((AVOL < 0x0F))
            {
                AVOL++
            }

            If (ATKP)
            {
                Notify (ATKD, 0x31) // Reserved
            }
        }

        Method (_Q15, 0, NotSerialized)  // _Qxx: EC Query
        {
            If ((AVOL > Zero))
            {
                AVOL--
            }

            If (ATKP)
            {
                Notify (ATKD, 0x30) // Reserved
            }
        }

        Method (_Q6F, 0, NotSerialized)  // _Qxx: EC Query
        {
            If (ATKP)
            {
                Notify (ATKD, 0x45) // Reserved
            }
        }

        Method (_Q6E, 0, NotSerialized)  // _Qxx: EC Query
        {
            If (ATKP)
            {
                Notify (ATKD, 0x43) // Reserved
            }
        }

        Method (_Q6C, 0, NotSerialized)  // _Qxx: EC Query
        {
            If (ATKP)
            {
                Notify (ATKD, 0x40) // Reserved
            }
        }

        Method (_Q6D, 0, NotSerialized)  // _Qxx: EC Query
        {
            If (ATKP)
            {
                Notify (ATKD, 0x41) // Reserved
            }
        }

        Method (_Q68, 0, NotSerialized)  // _Qxx: EC Query
        {
            DBGR (0x12, 0x34, 0x56, 0x78)
        }

        Method (_Q69, 0, NotSerialized)  // _Qxx: EC Query
        {
            If (ATKP)
            {
                Notify (ATKD, 0x5C) // Reserved
            }
        }

        Method (_Q6A, 0, NotSerialized)  // _Qxx: EC Query
        {
            If (ATKP)
            {
                Notify (ATKD, 0x8A) // Device-Specific
            }
        }

        Method (_Q74, 0, NotSerialized)  // _Qxx: EC Query
        {
            If (ATKP)
            {
                Notify (ATKD, 0x82) // Device-Specific Change
            }
        }

        Method (_Q77, 0, NotSerialized)  // _Qxx: EC Query
        {
            If (ATKP)
            {
                Notify (ATKD, 0x55) // Reserved
            }
        }

        Method (_Q87, 0, NotSerialized)  // _Qxx: EC Query
        {
            If (^^^P0P3.WLAN.MPDP ())
            {
                If (ATKP)
                {
                    Notify (ATKD, 0x5D) // Reserved
                }
            }
        }

        Method (_Q81, 0, NotSerialized)  // _Qxx: EC Query
        {
            If (!(DSYN & One))
            {
                If (ATKP)
                {
                    Notify (ATKD, 0x6B) // Reserved
                }
            }
            Else
            {
                If (ATKP)
                {
                    Notify (ATKD, 0x6F) // Reserved
                }
            }
        }

        Method (_Q80, 0, NotSerialized)  // _Qxx: EC Query
        {
            If (ATKP)
            {
                If ((OSFG == OSXP))
                {
                    Notify (ATKD, 0x5C) // Reserved
                }
                Else
                {
                    Notify (ATKD, 0xB4) // Device-Specific
                }
            }
        }

        Method (_Q86, 0, NotSerialized)  // _Qxx: EC Query
        {
            If (ATKP)
            {
                If (BTDP)
                {
                    Local0 = BRST /* \BRST */
                    Local1 = (Local0 ^ One)
                    Local0 += 0x7D
                    OBTD (Local1)
                    Notify (ATKD, Local0)
                }
            }
        }

        Method (_Q8D, 0, NotSerialized)  // _Qxx: EC Query
        {
            Local0 = OHWR ()
            If ((Local0 & 0x02))
            {
                If ((^^^^ATKD.WAPF & 0x04))
                {
                    If (ATKP)
                    {
                        If ((Local0 & One))
                        {
                            Notify (ATKD, 0x80) // Status Change
                        }
                        Else
                        {
                            Notify (ATKD, 0x81) // Information Change
                        }
                    }
                }
                Else
                {
                    If ((^^^^ATKD.WAPF & One))
                    {
                        If ((Local0 & One))
                        {
                            If (WLDP)
                            {
                                If (((^^^P0P3.WLAN.VNUM & 0xFFFF) == 0x8086))
                                {
                                    Sleep (0x09C4)
                                }

                                If ((WRPS == One))
                                {
                                    Notify (ATKD, 0x5E) // Reserved
                                }
                                Else
                                {
                                    Notify (ATKD, 0x5F) // Reserved
                                }
                            }

                            If ((WLDP && BTDP))
                            {
                                Sleep (0x0DAC)
                            }

                            If (BTDP)
                            {
                                If (BRPS)
                                {
                                    OBTD (One)
                                    Notify (ATKD, 0x7D) // Reserved
                                }
                                Else
                                {
                                    OBTD (Zero)
                                    Notify (ATKD, 0x7E) // Reserved
                                }
                            }
                        }
                        Else
                        {
                            If (WLDP)
                            {
                                WRPS = WRST /* \WRST */
                                Notify (ATKD, 0x5F) // Reserved
                            }

                            If ((WLDP && BTDP))
                            {
                                Sleep (0x0DAC)
                            }

                            If (BTDP)
                            {
                                BRPS = BRST /* \BRST */
                                OBTD (Zero)
                                Notify (ATKD, 0x7E) // Reserved
                            }
                        }
                    }
                    Else
                    {
                        If ((Local0 & One))
                        {
                            If (WLDP)
                            {
                                If (WRPS)
                                {
                                    OWLD (One)
                                    Notify (ATKD, 0x5E) // Reserved
                                }
                                Else
                                {
                                    OWLD (Zero)
                                    Notify (ATKD, 0x5F) // Reserved
                                }
                            }

                            If ((OSFG != OSEG))
                            {
                                If ((WLDP && BTDP))
                                {
                                    Sleep (0x0DAC)
                                }

                                If (BTDP)
                                {
                                    If (BRPS)
                                    {
                                        OBTD (One)
                                        Notify (ATKD, 0x7D) // Reserved
                                    }
                                    Else
                                    {
                                        OBTD (Zero)
                                        Notify (ATKD, 0x7E) // Reserved
                                    }
                                }
                            }
                        }
                        Else
                        {
                            If (WLDP)
                            {
                                WRPS = WRST /* \WRST */
                                OWLD (Zero)
                                Notify (ATKD, 0x5F) // Reserved
                            }

                            If ((OSFG != OSEG))
                            {
                                If ((WLDP && BTDP))
                                {
                                    Sleep (0x0DAC)
                                }

                                If (BTDP)
                                {
                                    BRPS = BRST /* \BRST */
                                    OBTD (Zero)
                                    Notify (ATKD, 0x7E) // Reserved
                                }
                            }
                        }
                    }
                }
            }
        }

        Method (_Q85, 0, NotSerialized)  // _Qxx: EC Query
        {
            If (ATKP)
            {
                Notify (ATKD, 0xB2) // Device-Specific
            }
        }

        Method (_QB3, 0, NotSerialized)  // _Qxx: EC Query
        {
            Notify (ATKD, 0x6D) // Reserved
        }
    }

    Scope (\)
    {
        Name (TSP, 0x0A)
        Name (TC1, 0x02)
        Name (TC2, 0x0A)
    }

    Scope (_TZ)
    {
        Method (KELV, 1, NotSerialized)
        {
            Local0 = (Arg0 & 0xFF)
            If ((Local0 >= 0x80))
            {
                Local0 -= 0x0100
                Local0 *= 0x0A
                Local0 -= 0x0AAC
                Return (Local0)
            }

            Local0 *= 0x0A
            Local0 += 0x0AAC
            Return (Local0)
        }

        Method (CELC, 1, NotSerialized)
        {
            Local0 = (Arg0 - 0x0AAC)
            Divide (Local0, 0x0A, Local1, Local0)
            Return (Local0)
        }

        Name (PLCY, Zero)
        ThermalZone (THRM)
        {
            Method (_CRT, 0, NotSerialized)  // _CRT: Critical Temperature
            {
                RCRT ()
                Return (KELV (TCRT))
            }

            Method (_TMP, 0, NotSerialized)  // _TMP: Temperature
            {
                Local1 = 0x05
                While (Local1)
                {
                    Local0 = RTMP ()
                    If ((Local0 > TCRT))
                    {
                        Local1--
                    }
                    Else
                    {
                        Local1 = Zero
                    }
                }

                Return (KELV (Local0))
            }

            Method (_PSL, 0, Serialized)  // _PSL: Passive List
            {
                If ((CPUN >= 0x02))
                {
                    Return (Package (0x02)
                    {
                        \_PR.P001, 
                        \_PR.P002
                    })
                }

                Return (Package (0x01)
                {
                    \_PR.P001
                })
            }

            Method (_TSP, 0, NotSerialized)  // _TSP: Thermal Sampling Period
            {
                Local0 = (TSP * 0x0A)
                Return (Local0)
            }

            Method (_TC1, 0, NotSerialized)  // _TC1: Thermal Constant 1
            {
                Return (TC1) /* \TC1_ */
            }

            Method (_TC2, 0, NotSerialized)  // _TC2: Thermal Constant 2
            {
                Return (TC2) /* \TC2_ */
            }

            Method (_PSV, 0, NotSerialized)  // _PSV: Passive Temperature
            {
                RPSV ()
                If (PLCY)
                {
                    Return (KELV (PPSV))
                }
                Else
                {
                    Return (KELV (TPSV))
                }
            }

            Method (_SCP, 1, NotSerialized)  // _SCP: Set Cooling Policy
            {
                PLCY = Zero
                Notify (THRM, 0x81) // Thermal Trip Point Change
            }
        }
    }

    Scope (_TZ)
    {
        Name (ATMP, 0x3C)
        Name (LTMP, 0x3C)
        Name (FANS, Zero)
        Method (RTMP, 0, NotSerialized)
        {
            If (\_SB.PCI0.SBRG.EC0.ECAV ())
            {
                Local0 = \_SB.PCI0.SBRG.EC0.ECPU
                If ((Local0 < 0x80))
                {
                    LTMP = Local0
                }
            }

            Return (LTMP) /* \_TZ_.LTMP */
        }

        Method (RCRT, 0, NotSerialized)
        {
            If (\_SB.PCI0.SBRG.EC0.ECAV ())
            {
                Local0 = \_SB.PCI0.SBRG.EC0.ECRT
                If ((Local0 < 0x80))
                {
                    TCRT = Local0
                }
            }
        }

        Method (RPSV, 0, NotSerialized)
        {
            If (\_SB.PCI0.SBRG.EC0.ECAV ())
            {
                Local0 = \_SB.PCI0.SBRG.EC0.EPSV
                If ((Local0 < 0x80))
                {
                    TPSV = Local0
                }
            }
        }

        Method (RFAN, 1, NotSerialized)
        {
            If (\_SB.PCI0.SBRG.EC0.ECAV ())
            {
                Local0 = \_SB.PCI0.SBRG.EC0.TACH (Arg0)
                Divide (Local0, 0x64, Local1, Local0)
                Local0 += One
                If ((Local0 <= 0x3C))
                {
                    FANS = Local0
                }
                Else
                {
                    Local0 = FANS /* \_TZ_.FANS */
                }
            }
            Else
            {
                Local0 = Zero
            }

            Return (Local0)
        }

        Method (RFSE, 0, NotSerialized)
        {
            If (\_SB.PCI0.SBRG.EC0.ECAV ())
            {
                Local1 = \_SB.PCI0.SBRG.EC0.RFOV (Zero)
                If ((Local1 < 0x80))
                {
                    If ((Local1 < 0x0A))
                    {
                        Local0 = Zero
                    }
                    Else
                    {
                        Local0 = One
                    }
                }
                Else
                {
                    If ((Local1 < 0xF5))
                    {
                        Local0 = 0x02
                    }
                    Else
                    {
                        Local0 = 0x0F
                    }
                }
            }
            Else
            {
                Local0 = Zero
            }

            Return (Local0)
        }

        Method (TCHG, 0, NotSerialized)
        {
        }

        Method (THDL, 0, NotSerialized)
        {
        }

        Method (TMSS, 1, NotSerialized)
        {
        }

        Method (TMSW, 1, NotSerialized)
        {
        }
    }

    Scope (\)
    {
        OperationRegion (PMIO, SystemIO, PMBS, 0x50)
        Field (PMIO, ByteAcc, NoLock, Preserve)
        {
            Offset (0x10), 
                ,   1, 
            TDTY,   3, 
            TENA,   1, 
            TTDT,   3, 
            FRCT,   1, 
                ,   8, 
            THLS,   1, 
            Offset (0x13), 
            Offset (0x20), 
                ,   1, 
            PEHS,   1, 
                ,   7, 
            PEPS,   1, 
            BLLS,   1, 
            SBPS,   1, 
            Offset (0x22), 
            G00S,   1, 
            G01S,   1, 
            G02S,   1, 
            G03S,   1, 
            G04S,   1, 
            G05S,   1, 
            G06S,   1, 
            G07S,   1, 
            G08S,   1, 
            G09S,   1, 
            G0AS,   1, 
            G0BS,   1, 
            G0CS,   1, 
            G0DS,   1, 
            G0ES,   1, 
            G0FS,   1, 
                ,   1, 
            Offset (0x28), 
                ,   1, 
            PEHE,   1, 
            TPOL,   1, 
                ,   6, 
            PEPE,   1, 
            BLLE,   1, 
            SBPE,   1, 
            Offset (0x2A), 
            G00E,   1, 
            G01E,   1, 
            G02E,   1, 
            G03E,   1, 
            G04E,   1, 
            G05E,   1, 
            G06E,   1, 
            G07E,   1, 
            G08E,   1, 
            G09E,   1, 
            G0AE,   1, 
            G0BE,   1, 
            G0CE,   1, 
            G0DE,   1, 
            G0EE,   1, 
            G0FE,   1, 
                ,   1, 
            Offset (0x30), 
                ,   4, 
            SLPE,   1, 
            APME,   1, 
                ,   5, 
            MCSE,   1, 
                ,   1, 
            TCOE,   1, 
            PERE,   1, 
            Offset (0x32), 
            Offset (0x34), 
                ,   4, 
            SLPS,   1, 
            APMS,   1, 
                ,   5, 
            MCSS,   1, 
                ,   1, 
            TCOS,   1, 
            PERS,   1, 
            Offset (0x36), 
            Offset (0x3C), 
                ,   1, 
            PRWE,   1, 
            Offset (0x42), 
                ,   1, 
            GPEC,   1
        }

        OperationRegion (GPIO, SystemIO, GPBS, GPLN)
        Field (GPIO, ByteAcc, NoLock, Preserve)
        {
            Offset (0x0C), 
            GL00,   16, 
            GL10,   16, 
            Offset (0x18), 
            GB00,   32, 
            Offset (0x2C), 
            GP00,   16, 
            Offset (0x38), 
            GL20,   32
        }

        OperationRegion (RCBA, SystemMemory, 0xFED1C000, 0x4000)
        Field (RCBA, ByteAcc, NoLock, Preserve)
        {
            Offset (0x3418), 
            FDRT,   32, 
            Offset (0x3518), 
            UPDO,   16
        }

        Method (RGPL, 2, Serialized)
        {
            Local0 = Arg1
            Local1 = Zero
            While (Local0)
            {
                Local1 <<= One
                Local1 |= One
                Local0--
            }

            If ((Arg0 < 0x10))
            {
                Local1 <<= Arg0
                Local0 = GL00 /* \GL00 */
                Local0 &= Local1
                Local0 >>= Arg0
            }
            Else
            {
                If ((Arg0 < 0x20))
                {
                    Local0 = GL10 /* \GL10 */
                    Local2 = (Arg0 - 0x10)
                }
                Else
                {
                    Local0 = GL20 /* \GL20 */
                    Local2 = (Arg0 - 0x20)
                }

                Local1 <<= Local2
                Local0 &= Local1
                Local0 >>= Local2
            }

            Return (Local0)
        }

        Method (SGPL, 3, Serialized)
        {
            Local0 = Arg1
            Local1 = Zero
            While (Local0)
            {
                Local1 <<= One
                Local1 |= One
                Local0--
            }

            If ((Arg0 >= 0x10))
            {
                If ((Arg0 < 0x20))
                {
                    Local0 = GL10 /* \GL10 */
                    Local2 = (Arg0 - 0x10)
                }
                Else
                {
                    Local0 = GL20 /* \GL20 */
                    Local2 = (Arg0 - 0x20)
                }

                Local1 <<= Local2
                Local3 = ~Local1
                Local0 &= Local3
                Local4 = (Arg2 << Local2)
                Local0 |= Local4
                If ((Arg0 < 0x20))
                {
                    GL10 = Local0
                }
                Else
                {
                    GL20 = Local0
                }
            }
            Else
            {
                Local1 <<= Arg0
                Local3 = ~Local1
                Local0 = (GL00 & Local3)
                Local4 = (Arg2 << Arg0)
                Local0 |= Local4
                GL00 = Local0
            }
        }

        Method (RGPP, 1, Serialized)
        {
            Local0 = (GP00 >> Arg0)
            Local0 &= One
            Return (Local0)
        }

        Method (TGPP, 1, Serialized)
        {
            Local0 = (One << Arg0)
            GP00 ^= Local0
        }

        Method (SGPP, 2, Serialized)
        {
            Local0 = (One << Arg0)
            If (Arg1)
            {
                GP00 |= Local0
            }
            Else
            {
                Local1 = ~Local0
                GP00 &= Local1
            }
        }

        Name (PMEW, Zero)
        Method (SBRS, 1, NotSerialized)
        {
            CPXS ()
            \_SB.PCI0.USB0.USBS (Arg0)
            \_SB.PCI0.USB1.USBS (Arg0)
            \_SB.PCI0.USB2.USBS (Arg0)
            \_SB.PCI0.USB3.USBS (Arg0)
            \_SB.PCI0.USB4.USBS (Arg0)
            \_SB.PCI0.USB5.USBS (Arg0)
            \_SB.PCI0.USB6.USBS (Arg0)
        }

        Method (SBRW, 1, NotSerialized)
        {
            PMEW = SBPS /* \SBPS */
            \_SB.PCI0.USB0.USBW (Arg0)
            \_SB.PCI0.USB1.USBW (Arg0)
            \_SB.PCI0.USB2.USBW (Arg0)
            \_SB.PCI0.USB3.USBW (Arg0)
            \_SB.PCI0.USB4.USBW (Arg0)
            \_SB.PCI0.USB5.USBW (Arg0)
            \_SB.PCI0.USB6.USBW (Arg0)
        }

        Method (STRP, 1, NotSerialized)
        {
            If (Arg0)
            {
                SLPS = One
                SLPE = One
            }
            Else
            {
                SLPE = Zero
                SLPS = One
            }
        }

        Method (HKTH, 0, Serialized)
        {
            If (THLS)
            {
                Return (TTDT) /* \TTDT */
            }
            Else
            {
                Return (0xFFFF)
            }
        }

        Method (CPXS, 0, NotSerialized)
        {
            Local0 = Zero
            Local1 = 0x00010000
            Local2 = 0x000E0060
            Local3 = 0x000E00DC
            While ((Local0 < 0x04))
            {
                If (!(FDRT & Local1))
                {
                    While ((\_SB.RDPE (Local2) & 0x00010000))
                    {
                        Local4 = (\_SB.RDPE (Local2) | 0x00010000)
                        \_SB.WDPE (Local2, Local4)
                    }

                    While ((\_SB.RDPE (Local3) & 0x80000000))
                    {
                        Local4 = (\_SB.RDPE (Local3) | 0x80000000)
                        \_SB.WDPE (Local3, Local4)
                    }
                }

                Local2 += 0x1000
                Local3 += 0x1000
                Local1 <<= One
                Local0++
            }

            While ((PEPS & One))
            {
                PEPS |= One
            }
        }
    }

    Scope (_GPE)
    {
        Method (_L03, 0, Serialized)  // _Lxx: Level-Triggered GPE
        {
            Notify (\_SB.PCI0.USB0, 0x02) // Device Wake
        }

        Method (_L04, 0, Serialized)  // _Lxx: Level-Triggered GPE
        {
            Notify (\_SB.PCI0.USB1, 0x02) // Device Wake
        }

        Method (_L0C, 0, Serialized)  // _Lxx: Level-Triggered GPE
        {
            Notify (\_SB.PCI0.USB2, 0x02) // Device Wake
        }

        Method (_L0E, 0, Serialized)  // _Lxx: Level-Triggered GPE
        {
            Notify (\_SB.PCI0.USB3, 0x02) // Device Wake
        }

        Method (_L05, 0, Serialized)  // _Lxx: Level-Triggered GPE
        {
            Notify (\_SB.PCI0.USB4, 0x02) // Device Wake
        }

        Method (_L20, 0, Serialized)  // _Lxx: Level-Triggered GPE
        {
            Notify (\_SB.PCI0.USB5, 0x02) // Device Wake
            Notify (\_SB.PCI0.USB6, 0x02) // Device Wake
        }

        Method (_L0D, 0, Serialized)  // _Lxx: Level-Triggered GPE
        {
            Notify (\_SB.PCI0.EUSB, 0x02) // Device Wake
            Notify (\_SB.PCI0.USBE, 0x02) // Device Wake
            Notify (\_SB.PCI0.HDAC, 0x02) // Device Wake
        }

        Method (_L08, 0, Serialized)  // _Lxx: Level-Triggered GPE
        {
            Notify (\_SB.PCI0.HDAC, 0x02) // Device Wake
        }

        Method (_L01, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
        {
        }

        Method (_L09, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
        {
            If (\_SB.PCI0.P0P3.PMES)
            {
                While (\_SB.PCI0.P0P3.PMES)
                {
                    \_SB.PCI0.P0P3.PMES = One
                    \_SB.PCI0.P0P3.PMCS = One
                }

                Notify (\_SB.PCI0.P0P3, 0x02) // Device Wake
            }

            If (\_SB.PCI0.P0P8.PMES)
            {
                While (\_SB.PCI0.P0P8.PMES)
                {
                    \_SB.PCI0.P0P8.PMES = One
                    \_SB.PCI0.P0P8.PMCS = One
                }

                Notify (\_SB.PCI0.P0P8, 0x02) // Device Wake
            }
        }
    }

    Scope (\)
    {
        OperationRegion (SMB0, SystemIO, SMBS, 0x10)
        Field (SMB0, ByteAcc, NoLock, Preserve)
        {
            HSTS,   8, 
            SSTS,   8, 
            HSTC,   8, 
            HCMD,   8, 
            HADR,   8, 
            HDT0,   8, 
            HDT1,   8, 
            BLKD,   8, 
            Offset (0x0D), 
            AUXC,   8
        }

        Name (RBUF, Buffer (0x20) {})
        Method (HBSY, 0, NotSerialized)
        {
            Local0 = 0x00FFFFFF
            While (Local0)
            {
                Local1 = (HSTS & One)
                If (!Local1)
                {
                    Return (Zero)
                }

                Local0--
            }

            Return (One)
        }

        Method (WTSB, 0, NotSerialized)
        {
            Local0 = 0x00FFFFFF
            While (Local0)
            {
                Local0--
                Local1 = (HSTS & 0x1E)
                If ((Local1 == 0x02))
                {
                    Return (One)
                }

                If (Local1)
                {
                    Return (Zero)
                }
            }

            Return (Zero)
        }

        Mutex (P4SM, 0x00)
        Method (SBYT, 2, Serialized)
        {
            If ((Acquire (P4SM, 0xFFFF) != Zero))
            {
                Return (Ones)
            }

            Local0 = 0x05
            While (Local0)
            {
                If (HBSY ())
                {
                    Local0--
                }
                Else
                {
                    HADR = Arg0
                    HCMD = Arg1
                    HSTS = 0xFF
                    HSTC = 0x44
                    If (WTSB ())
                    {
                        Release (P4SM)
                        Return (One)
                    }
                    Else
                    {
                        Local0--
                    }
                }
            }

            Release (P4SM)
            Return (Ones)
        }

        Method (WBYT, 3, Serialized)
        {
            If ((Acquire (P4SM, 0xFFFF) != Zero))
            {
                Return (Ones)
            }

            Local0 = 0x05
            While (Local0)
            {
                If (HBSY ())
                {
                    Local0--
                }
                Else
                {
                    HADR = Arg0
                    HCMD = Arg1
                    HDT0 = Arg2
                    HSTS = 0xFF
                    HSTC = 0x48
                    If (WTSB ())
                    {
                        Release (P4SM)
                        Return (One)
                    }
                    Else
                    {
                        Local0--
                    }
                }
            }

            Release (P4SM)
            Return (Ones)
        }

        Method (WWRD, 3, Serialized)
        {
            If ((Acquire (P4SM, 0xFFFF) != Zero))
            {
                Return (Ones)
            }

            Local0 = 0x05
            While (Local0)
            {
                If (HBSY ())
                {
                    Local0--
                }
                Else
                {
                    HADR = Arg0
                    HCMD = Arg1
                    Local1 = (Arg2 & 0xFF)
                    Local2 = (Arg2 >> 0x08)
                    Local2 &= 0xFF
                    HDT0 = Local2
                    HDT1 = Local1
                    HSTS = 0xFF
                    HSTC = 0x4C
                    If (WTSB ())
                    {
                        Release (P4SM)
                        Return (One)
                    }
                    Else
                    {
                        Local0--
                    }
                }
            }

            Release (P4SM)
            Return (Ones)
        }

        Method (WBLK, 3, Serialized)
        {
            If ((Acquire (P4SM, 0xFFFF) != Zero))
            {
                Return (Ones)
            }

            Local0 = 0x05
            While (Local0)
            {
                If (HBSY ())
                {
                    Local0--
                }
                Else
                {
                    AUXC |= 0x02
                    HADR = Arg0
                    HCMD = Arg1
                    Local1 = HSTC /* \HSTC */
                    Local2 = Arg2
                    Local1 = Zero
                    While (Local2)
                    {
                        BLKD = DerefOf (Index (RBUF, Local1))
                        Local2--
                        Local1++
                    }

                    HDT0 = Arg2
                    Local1 = HSTC /* \HSTC */
                    HSTS = 0xFF
                    HSTC = 0x54
                    If (WTSB ())
                    {
                        Release (P4SM)
                        Return (One)
                    }
                    Else
                    {
                        Local0--
                    }
                }
            }

            Release (P4SM)
            Return (Ones)
        }

        Method (RSBT, 2, Serialized)
        {
            If ((Acquire (P4SM, 0xFFFF) != Zero))
            {
                Return (Ones)
            }

            Local0 = 0x05
            While (Local0)
            {
                If (HBSY ())
                {
                    Local0--
                }
                Else
                {
                    HADR = (Arg0 | One)
                    HCMD = Arg1
                    HSTS = 0xFF
                    HSTC = 0x44
                    If (WTSB ())
                    {
                        Release (P4SM)
                        Return (HDT0) /* \HDT0 */
                    }
                    Else
                    {
                        Local0--
                    }
                }
            }

            Release (P4SM)
            Return (Ones)
        }

        Method (RBYT, 2, Serialized)
        {
            If ((Acquire (P4SM, 0xFFFF) != Zero))
            {
                Return (Ones)
            }

            Local0 = 0x05
            While (Local0)
            {
                If (HBSY ())
                {
                    Local0--
                }
                Else
                {
                    HADR = (Arg0 | One)
                    HCMD = Arg1
                    HSTS = 0xFF
                    HSTC = 0x48
                    If (WTSB ())
                    {
                        Release (P4SM)
                        Return (HDT0) /* \HDT0 */
                    }
                    Else
                    {
                        Local0--
                    }
                }
            }

            Release (P4SM)
            Return (Ones)
        }

        Method (RWRD, 2, Serialized)
        {
            If ((Acquire (P4SM, 0xFFFF) != Zero))
            {
                Return (Ones)
            }

            Local0 = 0x05
            While (Local0)
            {
                If (HBSY ())
                {
                    Local0--
                }
                Else
                {
                    HADR = (Arg0 | One)
                    HCMD = Arg1
                    HSTS = 0xFF
                    HSTC = 0x4C
                    If (WTSB ())
                    {
                        Local1 = HDT0 /* \HDT0 */
                        Local1 <<= 0x08
                        Local2 = HDT1 /* \HDT1 */
                        Local1 += Local2
                        Release (P4SM)
                        Return (Local1)
                    }
                    Else
                    {
                        Local0--
                    }
                }
            }

            Release (P4SM)
            Return (Ones)
        }

        Method (RBLK, 3, Serialized)
        {
            If ((Acquire (P4SM, 0xFFFF) != Zero))
            {
                Return (Ones)
            }

            Local0 = 0x05
            While (Local0)
            {
                If (HBSY ())
                {
                    Local0--
                }
                Else
                {
                    AUXC |= 0x02
                    HADR = (Arg0 | One)
                    HCMD = Arg1
                    HSTS = 0xFF
                    HSTC = 0x54
                    If (WTSB ())
                    {
                        Local1 = HSTC /* \HSTC */
                        Local2 = HDT0 /* \HDT0 */
                        Local3 = Local2
                        RBUF = Zero
                        Local1 = Zero
                        While (Local2)
                        {
                            Index (RBUF, Local1) = BLKD /* \BLKD */
                            Local2--
                            Local1++
                        }

                        Release (P4SM)
                        Return (Local3)
                    }
                    Else
                    {
                        Local0--
                    }
                }
            }

            Release (P4SM)
            Return (Ones)
        }
    }

    Scope (_SB.PCI0)
    {
        Name (SUPP, Zero)
        Name (CTRL, Zero)
        Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
        {
            If ((Arg0 == ToUUID ("33db4d5b-1ff7-401c-9657-7441c03dd766") /* PCI Host Bridge Device */))
            {
                CreateDWordField (Arg3, Zero, CDW1)
                CreateDWordField (Arg3, 0x04, CDW2)
                CreateDWordField (Arg3, 0x08, CDW3)
                SUPP = CDW2 /* \_SB_.PCI0._OSC.CDW2 */
                CTRL = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
                If (((SUPP & 0x16) != 0x16))
                {
                    (CTRL & 0x1E)
                }

                CTRL &= 0x1D
                If (~(CDW1 & One))
                {
                    If ((CTRL & One))
                    {
                        ^P0P4.HPCE = Zero
                        ^P0P4.HPCS = One
                        ^P0P4.ABP1 = One
                        ^P0P4.PDC1 = One
                        OSCF |= One /* \_SB_.PCI0.OSCF */
                    }

                    If ((CTRL & 0x04))
                    {
                        ^SBRG.IELK.BCPE = Zero
                        ^P0P4.PMCE = Zero
                        ^P0P4.PMCS = One
                        OSCF |= 0x04 /* \_SB_.PCI0.OSCF */
                    }
                }

                If ((Arg1 != One))
                {
                    CDW1 |= 0x08
                }

                If ((CDW3 != CTRL))
                {
                    CDW1 |= 0x10
                }

                CDW3 = CTRL /* \_SB_.PCI0.CTRL */
                Return (Arg3)
            }
            Else
            {
                CDW1 |= 0x04
                Return (Arg3)
            }
        }

        Name (OSCF, Zero)
        Method (OSCW, 0, NotSerialized)
        {
            If ((OSCF & One))
            {
                ^P0P4.HPCE = Zero
                ^P0P4.HPCS = One
                ^P0P4.ABP1 = One
                ^P0P4.PDC1 = One
            }

            If ((OSCF & 0x04))
            {
                ^SBRG.IELK.BCPE = Zero
                ^P0P4.PMCE = Zero
                ^P0P4.PMCS = One
            }
        }
    }

    Scope (_SB)
    {
        Name (ATKP, Zero)
        Device (ATKD)
        {
            Name (_HID, "ATK0100")  // _HID: Hardware ID
            Name (_UID, 0x01010100)  // _UID: Unique ID
            Method (INIT, 1, NotSerialized)
            {
                ATKP = One
                Return (MNAM) /* \MNAM */
            }

            Method (BSTS, 0, NotSerialized)
            {
                Local0 = IKFG /* \IKFG */
                Local0 |= (IKF2 << 0x08)
                If (ACPF)
                {
                    Local0 &= 0xFF7F
                }

                Local0 &= 0xFFDF
                Return (Local0)
            }

            Method (TMPR, 0, NotSerialized)
            {
                Local0 = \_TZ.RTMP ()
                Local1 = \_TZ.RFAN (Zero)
                Local1 <<= 0x10
                Local0 = (\_TZ.KELV (Local0) + Local1)
                Local2 = Zero
                If (TENA)
                {
                    Local2 = TDTY /* \TDTY */
                }
                Else
                {
                    Local3 = HKTH ()
                    If ((Local3 != 0xFFFF))
                    {
                        Local2 = Local3
                    }
                }

                Local2 <<= 0x18
                Local0 += Local2
                Local3 = \_TZ.RFSE ()
                Local3 <<= 0x1C
                Local0 += Local3
                Return (Local0)
            }

            Method (SFUN, 0, NotSerialized)
            {
                Local0 = 0x37
                Local0 |= 0x40
                Local0 |= 0x80
                Local0 |= 0x0800
                Local0 |= 0x1000
                Local0 |= 0x00020000
                Local0 |= 0x00080000
                Local0 |= 0x00100000
                Return (Local0)
            }

            Method (OSVR, 1, NotSerialized)
            {
                OSFG = Arg0
            }

            Method (GPLV, 0, NotSerialized)
            {
                Return (LBTN) /* \LBTN */
            }

            Method (SPLV, 1, NotSerialized)
            {
                LBTN = Arg0
                ^^PCI0.SBRG.EC0.STBR ()
            }

            Method (SPBL, 1, NotSerialized)
            {
                If ((Arg0 == 0x80))
                {
                    Return (One)
                }

                If ((Arg0 > 0x0F))
                {
                    Return (Zero)
                }

                If ((Arg0 < Zero))
                {
                    Return (Zero)
                }

                SPLV (Arg0)
                Return (One)
            }

            Method (WLLC, 1, NotSerialized)
            {
                If ((Arg0 < 0x02))
                {
                    SGPL (0x2E, One, Arg0)
                    OWLD (Arg0)
                    Return (One)
                }

                If ((Arg0 == 0x02))
                {
                    If ((OSFG == OSXP))
                    {
                        Return (One)
                    }
                }

                Return (Zero)
            }

            Method (WLED, 1, NotSerialized)
            {
                OWLD (Arg0)
            }

            Method (BLED, 1, NotSerialized)
            {
                OBTD (Arg0)
            }

            Method (GSMC, 1, NotSerialized)
            {
                OTGD (Arg0)
            }

            Method (WMXC, 1, NotSerialized)
            {
                OWMD (Arg0)
            }

            Method (RSTS, 0, NotSerialized)
            {
                Return (ORST ())
            }

            Method (SDSP, 1, NotSerialized)
            {
                If (NATK ())
                {
                    If ((OSFG == OSEG))
                    {
                        SWHG (Arg0)
                    }
                    Else
                    {
                        If (VGAS)
                        {
                            Local0 = (Arg0 & 0x07)
                            Local1 = (Arg0 & 0x08)
                            If ((Local1 == 0x08))
                            {
                                Local0 |= 0x10
                            }

                            Local1 = (Arg0 & 0x10)
                            If ((Local1 == 0x10))
                            {
                                Local0 |= 0x08
                            }

                            SWHG (Local0)
                        }
                        Else
                        {
                            SWHG (Arg0)
                        }
                    }
                }
            }

            Method (GPID, 0, NotSerialized)
            {
                Return (LCDR) /* \LCDR */
            }

            Method (FPID, 0, NotSerialized)
            {
                Return (LCDF) /* \LCDF */
            }

            Method (HWRS, 0, NotSerialized)
            {
                Return (OHWR ())
            }

            Method (GLCD, 0, NotSerialized)
            {
                Return (LCDV) /* \LCDV */
            }

            Name (WAPF, Zero)
            Method (CWAP, 1, NotSerialized)
            {
                WAPF |= Arg0 /* \_SB_.ATKD.WAPF */
                Return (One)
            }

            Method (DPWR, 0, NotSerialized)
            {
                Return (ODWR ())
            }

            Method (QDEV, 1, NotSerialized)
            {
                If ((Arg0 == One))
                {
                    Return (OQDC ())
                }

                If ((Arg0 == 0x02))
                {
                    Return (OQDG ())
                }

                If ((Arg0 == 0x04))
                {
                    Return (OQDS ())
                }

                If ((Arg0 == 0x08))
                {
                    Return (OQDM ())
                }

                Return (0x02)
            }

            Method (SDON, 1, NotSerialized)
            {
                If ((Arg0 == One))
                {
                    Return (ONDC ())
                }

                If ((Arg0 == 0x02))
                {
                    Return (ONDG ())
                }

                If ((Arg0 == 0x04))
                {
                    Return (ONDS ())
                }

                If ((Arg0 == 0x08))
                {
                    Return (ONDM ())
                }

                Return (Zero)
            }

            Method (SDOF, 1, NotSerialized)
            {
                If ((Arg0 == One))
                {
                    Return (OFDC ())
                }

                If ((Arg0 == 0x02))
                {
                    Return (OFDG ())
                }

                If ((Arg0 == 0x04))
                {
                    Return (OFDS ())
                }

                If ((Arg0 == 0x08))
                {
                    Return (OFDM ())
                }

                Return (Zero)
            }

            Method (QMOD, 1, NotSerialized)
            {
                If ((Arg0 == Zero))
                {
                    Return (One)
                }

                If ((Arg0 == One))
                {
                    Local0 = (QFAN << 0x10)
                    Local0 += 0x98B6
                    ECRW (Local0)
                }

                If ((Arg0 == 0x02))
                {
                    ECRW (0x00FF98B6)
                }

                Return (One)
            }

            Method (ANVI, 1, Serialized)
            {
                Local0 = ASMI (Arg0)
                Return (Local0)
            }

            Method (PSTC, 1, Serialized)
            {
                If ((Arg0 == Zero))
                {
                    Return (PSTN) /* \PSTN */
                }

                If (ACPF)
                {
                    Local0 = (PSTN >> 0x08)
                }
                Else
                {
                    Local0 = (PSTN & 0xFF)
                }

                If ((Arg0 > Local0))
                {
                    Return (Ones)
                }

                SLMT = Arg0
                If (CIST)
                {
                    Notify (\_PR.CPU0, 0x80) // Target object type does not support notifies
                    If ((CPUN >= 0x02))
                    {
                        Notify (\_PR.CPU1, 0x80) // Target object type does not support notifies
                    }
                }

                Return (Zero)
            }

            Method (HKEY, 0, NotSerialized)
            {
                Local0 = ^^PCI0.SBRG.EC0.CDT1 /* \_SB_.PCI0.SBRG.EC0_.CDT1 */
            }

            Method (KBFT, 1, NotSerialized)
            {
                ^^PCI0.SBRG.EC0.HKEN = Arg0
                Return (Zero)
            }

            Method (SMBB, 1, Serialized)
            {
                Local0 = (Arg0 >> 0x10)
                Local0 &= 0xFF
                Local1 = (Arg0 >> 0x18)
                Local2 = (Arg0 & 0xFF)
                If ((Local1 & One))
                {
                    Return (RBYT (Local1, Local0))
                }
                Else
                {
                    Return (WBYT (Local1, Local0, Local2))
                }
            }

            Method (SMBW, 1, Serialized)
            {
                Local0 = (Arg0 >> 0x10)
                Local0 &= 0xFF
                Local1 = (Arg0 >> 0x18)
                Local2 = (Arg0 & 0xFF)
                If ((Local1 & One))
                {
                    Return (RWRD (Local1, Local0))
                }
                Else
                {
                    Return (WWRD (Local1, Local0, Local2))
                }
            }

            Method (SMBK, 1, Serialized)
            {
                Local0 = (Arg0 >> 0x08)
                Local0 &= 0xFF
                If (Local0)
                {
                    Local0 = (Arg0 >> 0x10)
                    Local0 &= 0xFF
                    Local1 = (Arg0 >> 0x18)
                    Local1 &= 0xFF
                    Local3 = (Arg0 & 0x0F)
                    If ((Local1 & One))
                    {
                        RBLK (Local1, Local0, Local3)
                    }
                    Else
                    {
                        WBLK (Local1, Local0, Local3)
                    }

                    Return (Zero)
                }
                Else
                {
                    Local2 = (Arg0 >> 0x10)
                    Local2 &= 0xFF
                    Local1 = (Arg0 >> 0x18)
                    If ((Local1 & One))
                    {
                        Return (DerefOf (Index (RBUF, Local2)))
                    }
                    Else
                    {
                        Local1 = (Arg0 & 0xFF)
                        Index (RBUF, Local2) = Local1
                        Return (Zero)
                    }
                }
            }

            Method (ECRW, 1, Serialized)
            {
                Local0 = (Arg0 >> 0x18)
                Local0 &= 0xFF
                Local1 = (Arg0 >> 0x10)
                Local1 &= 0xFF
                Local2 = (Arg0 >> 0x08)
                Local2 &= 0xFF
                Local3 = (Arg0 & 0xFF)
                If (^^PCI0.SBRG.EC0.ECAV ())
                {
                    If ((Acquire (^^PCI0.SBRG.EC0.MUEC, 0xFFFF) != Zero))
                    {
                        Return (Ones)
                    }

                    ^^PCI0.SBRG.EC0.CDT3 = Local0
                    ^^PCI0.SBRG.EC0.CDT2 = Local1
                    ^^PCI0.SBRG.EC0.CDT1 = Local2
                    ^^PCI0.SBRG.EC0.CMD1 = Local3
                    Local0 = 0x05
                    While ((Local0 && ^^PCI0.SBRG.EC0.CMD1))
                    {
                        Sleep (One)
                        Local0--
                    }

                    Local0 = ^^PCI0.SBRG.EC0.CDT3 /* \_SB_.PCI0.SBRG.EC0_.CDT3 */
                    Local1 = ^^PCI0.SBRG.EC0.CDT2 /* \_SB_.PCI0.SBRG.EC0_.CDT2 */
                    Local2 = ^^PCI0.SBRG.EC0.CDT1 /* \_SB_.PCI0.SBRG.EC0_.CDT1 */
                    Local3 = ^^PCI0.SBRG.EC0.CMD1 /* \_SB_.PCI0.SBRG.EC0_.CMD1 */
                    Release (^^PCI0.SBRG.EC0.MUEC)
                }

                Local0 <<= 0x08
                Local0 |= Local1
                Local0 <<= 0x08
                Local0 |= Local2
                Local0 <<= 0x08
                Local0 |= Local3
                Return (Local0)
            }

            Method (CBIF, 1, Serialized)
            {
                If ((Arg0 < 0x03))
                {
                    DBR1 = Arg0
                    ALPR = 0x03
                    ISMI (0xA3)
                    Return (One)
                }
                Else
                {
                    Return (ENFN (Arg0))
                }
            }

            Method (CFIF, 1, Serialized)
            {
                DBR1 = Arg0
                ALPR = 0x04
                ISMI (0xA3)
                Return (One)
            }
        }
    }

    Scope (\)
    {
        Method (DIAG, 1, NotSerialized)
        {
            DBG8 = Arg0
        }

        OperationRegion (GPSC, SystemIO, 0xB2, 0x02)
        Field (GPSC, ByteAcc, NoLock, Preserve)
        {
            SMCM,   8, 
            SMST,   8
        }

        Method (ISMI, 1, Serialized)
        {
            SMCM = Arg0
        }

        Method (ASMI, 1, Serialized)
        {
            ALPR = Arg0
            SMCM = 0xA3
            Return (ALPR) /* \ALPR */
        }

        OperationRegion (ECMS, SystemIO, 0x72, 0x02)
        Field (ECMS, ByteAcc, Lock, Preserve)
        {
            EIND,   8, 
            EDAT,   8
        }

        IndexField (EIND, EDAT, ByteAcc, NoLock, Preserve)
        {
            Offset (0x48), 
            IKFG,   8, 
            FRPN,   16, 
            RAMB,   32, 
            AVOL,   8, 
            LBTN,   8, 
            ERRF,   8, 
            OCLK,   8, 
            WIDE,   1, 
            OVCK,   2, 
            SLPN,   3, 
            ACRD,   1, 
            VGAS,   1, 
            CPUR,   6, 
            CPUF,   2, 
            LBT2,   8, 
            PCMS,   8, 
            CLKS,   8, 
            CLKL,   8, 
            CLKD,   64, 
            ALSL,   8, 
            ALAE,   1, 
            ALDE,   1, 
            ALSP,   1, 
            Offset (0x63), 
            WLDP,   1, 
            BTDP,   1, 
            WRST,   1, 
            BRST,   1, 
            WRPS,   1, 
            BRPS,   1, 
            Offset (0x64), 
            SYNA,   1, 
            ALPS,   1, 
            ELAN,   1, 
            Offset (0x65), 
            IKF2,   8, 
            UHDB,   8, 
            OSPM,   8, 
            TCGF,   8, 
            PPIS,   8, 
            PPIR,   8, 
            OBMM,   8, 
            SIDE,   1, 
            PWBS,   1, 
                ,   3, 
            OCST,   3, 
            Offset (0x6E), 
                ,   3, 
            TRBR,   1, 
            LDFT,   1, 
            OCEN,   1, 
                ,   1, 
            CAPM,   1, 
            Offset (0x70), 
            Offset (0x71), 
            Offset (0x72), 
            Offset (0x73), 
            Offset (0x74), 
            TGDP,   1, 
            WMDP,   1, 
            TGST,   1, 
            WMST,   1, 
            TGPS,   1, 
            WMPS,   1, 
            Offset (0x75), 
            KBLV,   8, 
            FVGA,   1, 
            P4HN,   1, 
            Offset (0x77), 
            ESTF,   4, 
            EMNM,   4
        }

        OperationRegion (RAMW, SystemMemory, RAMB, 0x0100)
        Field (RAMW, AnyAcc, NoLock, Preserve)
        {
            TRTY,   8, 
            FSFN,   8, 
            FSTA,   16, 
            FADR,   32, 
            FSIZ,   16, 
            ACTD,   8, 
            AVLD,   8, 
            SETD,   8, 
            ACPF,   8, 
            DCPF,   8, 
            DCP2,   8, 
            DCTP,   8, 
            CTPY,   8, 
            PADL,   16, 
            CADL,   16, 
            CSTE,   16, 
            NSTE,   16, 
            SSTE,   16, 
            SFUN,   8, 
            TPSV,   8, 
            TAC0,   8, 
            TCRT,   8, 
            TDO1,   8, 
            TDO2,   8, 
            PPSV,   8, 
            PAC0,   8, 
            T0HL,   8, 
            T0LL,   8, 
            T0F1,   8, 
            T0F2,   8, 
            T1HL,   8, 
            T1LL,   8, 
            T1F1,   8, 
            T1F2,   8, 
            T2HL,   8, 
            T2LL,   8, 
            T2F1,   8, 
            T2F2,   8, 
            T3HL,   8, 
            T3LL,   8, 
            T3F1,   8, 
            T3F2,   8, 
            T4HL,   8, 
            T4LL,   8, 
            T4F1,   8, 
            T4F2,   8, 
            T5HL,   8, 
            T5LL,   8, 
            T5F1,   8, 
            T5F2,   8, 
            T6HL,   8, 
            T6LL,   8, 
            T6F1,   8, 
            T6F2,   8, 
            T7HL,   8, 
            T7LL,   8, 
            T7F1,   8, 
            T7F2,   8, 
            SLPT,   8, 
            AIBF,   8, 
            IDES,   8, 
            VGAF,   16, 
            C4CP,   8, 
            LUXS,   8, 
            LUXL,   8, 
            LUXH,   8, 
            LUXF,   8, 
            MNAM,   64, 
            DBR1,   32, 
            DBR2,   32, 
            DBR3,   32, 
            DBR4,   32, 
            LCDV,   32, 
            LCDR,   8, 
            PTIM,   8, 
            PTMP,   8, 
            QFAN,   8, 
            VBIF,   8, 
            BIPA,   32, 
            RTCW,   16, 
            CPUN,   8, 
            ALPR,   32, 
            CIST,   8, 
            GNBF,   32, 
            CPUP,   8, 
            PSTN,   16, 
            HDDF,   8, 
            SMEM,   32, 
            FEBL,   32, 
            LCDF,   16, 
            OCUC,   8, 
            ANCK,   8, 
            DSYN,   8, 
            TBOT,   16, 
            TRTC,   24, 
            FBFG,   8, 
            LKDV,   16
        }

        OperationRegion (DBGM, SystemMemory, 0x000D0000, 0x04)
        Field (DBGM, DWordAcc, NoLock, Preserve)
        {
            DBGG,   32
        }

        Name (OSFG, Zero)
        Name (OS9X, One)
        Name (OS98, 0x02)
        Name (OSME, 0x04)
        Name (OS2K, 0x08)
        Name (OSXP, 0x10)
        Name (OSVT, 0x20)
        Name (OSEG, 0x40)
        Name (OSW7, 0x80)
        Name (SLMT, Zero)
        Method (MSOS, 0, NotSerialized)
        {
            If (CondRefOf (_OSI, Local0))
            {
                If (_OSI ("Windows 2001"))
                {
                    OSFG = OSXP /* \OSXP */
                }

                If (_OSI ("Windows 2001 SP1"))
                {
                    OSFG = OSXP /* \OSXP */
                }

                If (_OSI ("Windows 2001 SP2"))
                {
                    OSFG = OSXP /* \OSXP */
                }

                If (_OSI ("Windows 2006"))
                {
                    OSFG = OSVT /* \OSVT */
                }

                If (_OSI ("Linux"))
                {
                    OSFG = OSEG /* \OSEG */
                }

                If (_OSI ("Windows 2009"))
                {
                    OSFG = OSW7 /* \OSW7 */
                }

                Return (OSFG) /* \OSFG */
            }
            Else
            {
                If (MCTH (_OS, "Microsoft Windows"))
                {
                    OSFG = OS98 /* \OS98 */
                }
                Else
                {
                    If (MCTH (_OS, "Microsoft WindowsME: Millennium Edition"))
                    {
                        OSFG = OSME /* \OSME */
                    }
                    Else
                    {
                        If (MCTH (_OS, "Microsoft Windows NT"))
                        {
                            OSFG = OS2K /* \OS2K */
                        }
                        Else
                        {
                            OSFG = OSXP /* \OSXP */
                        }
                    }
                }
            }

            Return (OSFG) /* \OSFG */
        }

        Method (DBGR, 4, NotSerialized)
        {
            DBR1 = Arg0
            DBR2 = Arg1
            DBR3 = Arg2
            DBR4 = Arg3
            ISMI (0x96)
        }

        Name (ONAM, "ASUSTEK")
        Method (ADVG, 0, NotSerialized)
        {
            If (\_SB.PCI0.VGA.PRST ())
            {
                Return (\_SB.PCI0.VGA.ADVD ())
            }

            If (\_SB.PCI0.P0P1.VGA.PRST ())
            {
                Return (\_SB.PCI0.P0P1.VGA.ADVD ())
            }

            Return (0x03)
        }

        Method (SWHG, 1, Serialized)
        {
            If (\_SB.PCI0.VGA.PRST ())
            {
                \_SB.PCI0.VGA.SWHD (Arg0)
                Return (One)
            }

            If (\_SB.PCI0.P0P1.VGA.PRST ())
            {
                \_SB.PCI0.P0P1.VGA.SWHD (Arg0)
                Return (One)
            }

            Return (Zero)
        }

        Method (GDOS, 0, NotSerialized)
        {
            If (\_SB.PCI0.VGA.PRST ())
            {
                Local0 = \_SB.PCI0.VGA.DOSF
                Return (Local0)
            }

            If (\_SB.PCI0.P0P1.VGA.PRST ())
            {
                Local0 = \_SB.PCI0.P0P1.VGA.DOSF
                Return (Local0)
            }

            Return (Zero)
        }

        Method (NVGA, 1, NotSerialized)
        {
            Local0 = Arg0
            If (\_SB.PCI0.VGA.PRST ())
            {
                Notify (\_SB.PCI0.VGA, Local0)
            }

            If (\_SB.PCI0.P0P1.VGA.PRST ())
            {
                Notify (\_SB.PCI0.P0P1.VGA, Local0)
            }
        }

        Method (NATK, 0, NotSerialized)
        {
            If (\_SB.PCI0.VGA.PRST ())
            {
                Return (\_SB.PCI0.VGA.NATK ())
            }

            If (\_SB.PCI0.P0P1.VGA.PRST ())
            {
                Return (\_SB.PCI0.P0P1.VGA.NATK ())
            }

            Return (One)
        }
    }

    Scope (_SB.PCI0)
    {
        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            OSPM = MSOS ()
            If (ACPF)
            {
                SLMT = (PSTN >> 0x08)
            }
            Else
            {
                SLMT = (PSTN & 0xFF)
            }
        }
    }

    Scope (_SB.PCI0)
    {
        Device (AC0)
        {
            Name (_HID, "ACPI0003" /* Power Source Device */)  // _HID: Hardware ID
            Method (_PSR, 0, NotSerialized)  // _PSR: Power Source
            {
                Return (^^SBRG.EC0.ACAP ())
            }

            Name (_PCL, Package (0x01)  // _PCL: Power Consumer List
            {
                PCI0
            })
        }
    }

    Scope (_SB.PCI0.SBRG.EC0)
    {
        Method (ACAP, 0, Serialized)
        {
            Return (ACPF) /* \ACPF */
        }

        Method (_QA0, 0, NotSerialized)  // _Qxx: EC Query
        {
            If (ACPS ())
            {
                ACPF = One
                Local0 = 0x58
                SLMT = (PSTN >> 0x08)
            }
            Else
            {
                ACPF = Zero
                Local0 = 0x57
                SLMT = (PSTN & 0xFF)
            }

            If ((OSFG <= OSXP))
            {
                STBR ()
            }

            Notify (AC0, 0x80) // Status Change
            If (ATKP)
            {
                Notify (ATKD, Local0)
            }

            Sleep (0x64)
            If (CIST)
            {
                Notify (\_PR.CPU0, 0x80) // Target object type does not support notifies
                If ((CPUN >= 0x02))
                {
                    Notify (\_PR.CPU1, 0x80) // Target object type does not support notifies
                }
            }

            Sleep (0x64)
            Notify (\_PR.CPU0, 0x81) // Target object type does not support notifies
            If ((CPUN >= 0x02))
            {
                Notify (\_PR.CPU1, 0x81) // Target object type does not support notifies
            }

            Sleep (0x0A)
            NBAT (0x80)
        }

        Method (_QDE, 0, NotSerialized)  // _Qxx: EC Query
        {
            Notify (ATKD, 0xC6) // Hardware-Specific
        }
    }

    Scope (_SB.PCI0)
    {
        Device (BAT0)
        {
            Name (_HID, EisaId ("PNP0C0A") /* Control Method Battery */)  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_PCL, Package (0x01)  // _PCL: Power Consumer List
            {
                PCI0
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (^^SBRG.EC0.BATP (Zero))
                {
                    Return (0x1F)
                }
                Else
                {
                    Return (0x0F)
                }
            }

            Name (LOW2, 0x012C)
            Name (DVOT, 0x0E)
            Name (PUNT, One)
            Name (LFCC, 0x1770)
            Name (NBIF, Package (0x0D)
            {
                Zero, 
                Ones, 
                Ones, 
                One, 
                Ones, 
                Ones, 
                Ones, 
                Ones, 
                Ones, 
                "", 
                "", 
                "", 
                ""
            })
            Name (PBIF, Package (0x0D)
            {
                One, 
                0x1770, 
                0x1770, 
                One, 
                0x39D0, 
                0x0258, 
                0x012C, 
                0x3C, 
                0x3C, 
                "M3N", 
                " ", 
                "LIon", 
                "ASUSTek"
            })
            Name (PBST, Package (0x04)
            {
                Zero, 
                Ones, 
                Ones, 
                Ones
            })
            Method (FBIF, 5, NotSerialized)
            {
                PUNT = Arg0
                Local1 = Arg1
                Local2 = Arg2
                If ((PUNT == Zero))
                {
                    Local1 *= 0x0A
                    Local2 *= 0x0A
                }

                Index (PBIF, Zero) = Arg0
                Index (PBIF, One) = Local1
                Index (PBIF, 0x02) = Local2
                LFCC = Local2
                Index (PBIF, 0x03) = Arg3
                Index (PBIF, 0x04) = Arg4
                Divide (Local1, 0x0A, Local3, Local5)
                Index (PBIF, 0x05) = Local5
                Divide (Local1, 0x64, Local3, Local6)
                Index (PBIF, 0x06) = Local6
                LOW2 = Local6
                Divide (Local1, 0x64, Local3, Local7)
                Index (PBIF, 0x07) = Local7
                Index (PBIF, 0x08) = Local7
            }

            Method (CBIF, 0, NotSerialized)
            {
                If (PUNT)
                {
                    Local0 = DerefOf (Index (PBIF, 0x04))
                    Local0 += 0x01F4
                    Divide (Local0, 0x03E8, Local1, DVOT) /* \_SB_.PCI0.BAT0.DVOT */
                    Index (PBIF, Zero) = Zero
                    Index (PBIF, One) = (DerefOf (Index (PBIF, One)) * DVOT) /* \_SB_.PCI0.BAT0.DVOT */
                    Index (PBIF, 0x02) = (DerefOf (Index (PBIF, 0x02)) * DVOT) /* \_SB_.PCI0.BAT0.DVOT */
                    Index (PBIF, 0x05) = (DerefOf (Index (PBIF, 0x05)) * DVOT) /* \_SB_.PCI0.BAT0.DVOT */
                    Index (PBIF, 0x06) = (DerefOf (Index (PBIF, 0x06)) * DVOT) /* \_SB_.PCI0.BAT0.DVOT */
                    Index (PBIF, 0x07) = (DerefOf (Index (PBIF, 0x07)) * DVOT) /* \_SB_.PCI0.BAT0.DVOT */
                    Index (PBIF, 0x08) = (DerefOf (Index (PBIF, 0x08)) * DVOT) /* \_SB_.PCI0.BAT0.DVOT */
                }
            }

            Method (_BIF, 0, NotSerialized)  // _BIF: Battery Information
            {
                If (!^^SBRG.EC0.BATP (Zero))
                {
                    Return (NBIF) /* \_SB_.PCI0.BAT0.NBIF */
                }

                If ((^^SBRG.EC0.GBTT (Zero) == 0xFF))
                {
                    Return (NBIF) /* \_SB_.PCI0.BAT0.NBIF */
                }

                BATO ()
                BATS (Zero)
                Index (PBIF, 0x09) = ^^SBRG.EC0.BIF9 ()
                Index (PBIF, 0x0C) = ONAM /* \ONAM */
                Local0 = ^^SBRG.EC0.BIF0 ()
                Local1 = ^^SBRG.EC0.BIF1 ()
                Local2 = ^^SBRG.EC0.BIF2 ()
                Local3 = ^^SBRG.EC0.BIF3 ()
                Local4 = ^^SBRG.EC0.BIF4 ()
                If ((Local0 != Ones))
                {
                    If ((Local1 != Ones))
                    {
                        If ((Local2 != Ones))
                        {
                            If ((Local3 != Ones))
                            {
                                If ((Local4 != Ones))
                                {
                                    FBIF (Local0, Local1, Local2, Local3, Local4)
                                    CBIF ()
                                }
                            }
                        }
                    }
                }

                If ((PUNT == Zero))
                {
                    Local2 *= 0x0A
                }

                LFCC = Local2
                BATR ()
                Return (PBIF) /* \_SB_.PCI0.BAT0.PBIF */
            }

            Method (FBST, 4, NotSerialized)
            {
                Local1 = (Arg1 & 0xFFFF)
                Local0 = Zero
                If (^^SBRG.EC0.ACAP ())
                {
                    Local0 = One
                }

                If (Local0)
                {
                    If (CHGS (Zero))
                    {
                        Local0 = 0x02
                    }
                    Else
                    {
                        Local0 = Zero
                    }
                }
                Else
                {
                    Local0 = One
                }

                If (LLOW)
                {
                    Local2 = (One << 0x02)
                    Local0 |= Local2
                }

                If ((^^SBRG.EC0.RRAM (0x03B0) <= One))
                {
                    Local2 = (One << 0x02)
                    Local0 |= Local2
                }

                If ((Local1 >= 0x8000))
                {
                    Local1 -= 0xFFFF
                }

                Local2 = Arg2
                If ((PUNT == Zero))
                {
                    Local1 *= DVOT /* \_SB_.PCI0.BAT0.DVOT */
                    Local2 *= 0x0A
                }

                Local3 = (Local0 & 0x02)
                If (!Local3)
                {
                    Local3 = (LFCC - Local2)
                    Divide (LFCC, 0xC8, Local4, Local5)
                    If ((Local3 < Local5))
                    {
                        Local2 = LFCC /* \_SB_.PCI0.BAT0.LFCC */
                    }
                }
                Else
                {
                    Divide (LFCC, 0xC8, Local4, Local5)
                    Local4 = (LFCC - Local5)
                    If ((Local2 > Local4))
                    {
                        Local2 = Local4
                    }
                }

                If (!^^SBRG.EC0.ACAP ())
                {
                    Divide (Local2, MBLF, Local3, Local4)
                    If ((Local1 < Local4))
                    {
                        Local1 = Local4
                    }
                }

                Index (PBST, Zero) = Local0
                Index (PBST, One) = Local1
                Index (PBST, 0x02) = Local2
                Index (PBST, 0x03) = Arg3
            }

            Method (CBST, 0, NotSerialized)
            {
                If (PUNT)
                {
                    Index (PBST, One) = (DerefOf (Index (PBST, One)) * DVOT) /* \_SB_.PCI0.BAT0.DVOT */
                    Index (PBST, 0x02) = (DerefOf (Index (PBST, 0x02)) * DVOT) /* \_SB_.PCI0.BAT0.DVOT */
                }
            }

            Method (_BST, 0, NotSerialized)  // _BST: Battery Status
            {
                Index (PBST, Zero) = Zero
                Index (PBST, One) = Ones
                Index (PBST, 0x02) = Ones
                Index (PBST, 0x03) = Ones
                If (!^^SBRG.EC0.BATP (Zero))
                {
                    Return (PBST) /* \_SB_.PCI0.BAT0.PBST */
                }

                If ((^^SBRG.EC0.GBTT (Zero) == 0xFF))
                {
                    Return (PBST) /* \_SB_.PCI0.BAT0.PBST */
                }

                If (MES4)
                {
                    MES4--
                    Return (PBST) /* \_SB_.PCI0.BAT0.PBST */
                }

                BATO ()
                BATS (Zero)
                Local0 = ^^SBRG.EC0.BSTS ()
                Local1 = ^^SBRG.EC0.BCRT ()
                Local2 = ^^SBRG.EC0.BRCP ()
                Local3 = ^^SBRG.EC0.BVOT ()
                If ((Local0 != Ones))
                {
                    If ((Local1 != Ones))
                    {
                        If ((Local2 != Ones))
                        {
                            If ((Local3 != Ones))
                            {
                                FBST (Local0, Local1, Local2, Local3)
                                CBST ()
                            }
                        }
                    }
                }

                BATR ()
                Return (PBST) /* \_SB_.PCI0.BAT0.PBST */
            }
        }
    }

    Scope (_SB.PCI0)
    {
        Name (B0CR, Zero)
        Name (B1CR, Zero)
        Method (GGCC, 1, Serialized)
        {
            BATO ()
            BATS (Arg0)
            Local0 = ^SBRG.EC0.BCRT ()
            BATR ()
            If ((Local0 == Ones))
            {
                If (Arg0)
                {
                    Local0 = B1CR /* \_SB_.PCI0.B1CR */
                }
                Else
                {
                    Local0 = B0CR /* \_SB_.PCI0.B0CR */
                }
            }

            Local1 = (Local0 & 0x8000)
            If (Local1)
            {
                Local0 = Zero
            }

            If (Arg0)
            {
                B1CR = Local0
            }
            Else
            {
                B0CR = Local0
            }

            Return (Local0)
        }
    }

    Scope (_SB.PCI0.SBRG.EC0)
    {
        Name (BADR, 0x0B)
        Name (CADR, 0x09)
        Name (SADR, 0x0A)
        Method (ALMH, 1, NotSerialized)
        {
            If ((Arg0 == BADR))
            {
                NBAT (0x80)
            }
        }

        Method (BIFW, 1, NotSerialized)
        {
            Local0 = SMBR (RDWD, BADR, Arg0)
            Local1 = DerefOf (Index (Local0, Zero))
            If (Local1)
            {
                Return (Ones)
            }
            Else
            {
                Return (DerefOf (Index (Local0, 0x02)))
            }
        }

        Method (BIF0, 0, NotSerialized)
        {
            If (ECAV ())
            {
                If (BSLF)
                {
                    Local0 = B1MD /* \_SB_.PCI0.SBRG.EC0_.B1MD */
                }
                Else
                {
                    Local0 = B0MD /* \_SB_.PCI0.SBRG.EC0_.B0MD */
                }

                If ((Local0 != 0xFFFF))
                {
                    Local1 = (Local0 >> 0x0F)
                    Local1 &= One
                    Local0 = (Local1 ^ One)
                }
            }
            Else
            {
                Local0 = Ones
            }

            Return (Local0)
        }

        Method (BIF1, 0, NotSerialized)
        {
            If (ECAV ())
            {
                If (BSLF)
                {
                    Local0 = B1DC /* \_SB_.PCI0.SBRG.EC0_.B1DC */
                }
                Else
                {
                    Local0 = B0DC /* \_SB_.PCI0.SBRG.EC0_.B0DC */
                }

                Local0 &= 0xFFFF
            }
            Else
            {
                Local0 = Ones
            }

            Return (Local0)
        }

        Method (BIF2, 0, NotSerialized)
        {
            If (ECAV ())
            {
                If (BSLF)
                {
                    Local0 = B1FC /* \_SB_.PCI0.SBRG.EC0_.B1FC */
                }
                Else
                {
                    Local0 = B0FC /* \_SB_.PCI0.SBRG.EC0_.B0FC */
                }

                Local0 &= 0xFFFF
            }
            Else
            {
                Local0 = Ones
            }

            Return (Local0)
        }

        Method (BIF3, 0, NotSerialized)
        {
            If (ECAV ())
            {
                If (BSLF)
                {
                    Local0 = B1MD /* \_SB_.PCI0.SBRG.EC0_.B1MD */
                }
                Else
                {
                    Local0 = B0MD /* \_SB_.PCI0.SBRG.EC0_.B0MD */
                }

                If ((Local0 != 0xFFFF))
                {
                    Local0 >>= 0x09
                    Local0 &= One
                    Local0 ^= One
                }
            }
            Else
            {
                Local0 = Ones
            }

            Return (Local0)
        }

        Method (BIF4, 0, NotSerialized)
        {
            If (ECAV ())
            {
                If (BSLF)
                {
                    Local0 = B1DV /* \_SB_.PCI0.SBRG.EC0_.B1DV */
                }
                Else
                {
                    Local0 = B0DV /* \_SB_.PCI0.SBRG.EC0_.B0DV */
                }
            }
            Else
            {
                Local0 = Ones
            }

            Return (Local0)
        }

        Method (BIF9, 0, NotSerialized)
        {
            Name (BSTR, Buffer (0x20) {})
            Local0 = SMBR (RDBL, BADR, 0x21)
            If ((DerefOf (Index (Local0, Zero)) != Zero))
            {
                BSTR = MNAM /* \MNAM */
                Index (BSTR, 0x04) = Zero
            }
            Else
            {
                BSTR = DerefOf (Index (Local0, 0x02))
                Index (BSTR, DerefOf (Index (Local0, One))) = Zero
            }

            Return (BSTR) /* \_SB_.PCI0.SBRG.EC0_.BIF9.BSTR */
        }

        Method (BIFA, 0, NotSerialized)
        {
            If (ECAV ())
            {
                If (BSLF)
                {
                    Local0 = B1SN /* \_SB_.PCI0.SBRG.EC0_.B1SN */
                }
                Else
                {
                    Local0 = B0SN /* \_SB_.PCI0.SBRG.EC0_.B0SN */
                }
            }
            Else
            {
                Local0 = Ones
            }

            Return (Local0)
        }

        Method (BSTS, 0, NotSerialized)
        {
            If (ECAV ())
            {
                If (BSLF)
                {
                    Local0 = B1ST /* \_SB_.PCI0.SBRG.EC0_.B1ST */
                }
                Else
                {
                    Local0 = B0ST /* \_SB_.PCI0.SBRG.EC0_.B0ST */
                }
            }
            Else
            {
                Local0 = Ones
            }

            Return (Local0)
        }

        Method (BCRT, 0, NotSerialized)
        {
            If (ECAV ())
            {
                If (BSLF)
                {
                    Local0 = B1CC /* \_SB_.PCI0.SBRG.EC0_.B1CC */
                }
                Else
                {
                    Local0 = B0CC /* \_SB_.PCI0.SBRG.EC0_.B0CC */
                }
            }
            Else
            {
                Local0 = Ones
            }

            Return (Local0)
        }

        Method (BRCP, 0, NotSerialized)
        {
            If (ECAV ())
            {
                If (BSLF)
                {
                    Local0 = B1RC /* \_SB_.PCI0.SBRG.EC0_.B1RC */
                }
                Else
                {
                    Local0 = B0RC /* \_SB_.PCI0.SBRG.EC0_.B0RC */
                }

                If ((Local0 == 0xFFFF))
                {
                    Local0 = Ones
                }
            }
            Else
            {
                Local0 = Ones
            }

            Return (Local0)
        }

        Method (BVOT, 0, NotSerialized)
        {
            If (ECAV ())
            {
                If (BSLF)
                {
                    Local0 = B1VL /* \_SB_.PCI0.SBRG.EC0_.B1VL */
                }
                Else
                {
                    Local0 = B0VL /* \_SB_.PCI0.SBRG.EC0_.B0VL */
                }
            }
            Else
            {
                Local0 = Ones
            }

            Return (Local0)
        }
    }

    Scope (\)
    {
        Method (CHGS, 1, Serialized)
        {
            Local0 = \_SB.PCI0.SBRG.EC0.BCHG (Arg0)
            Return (Local0)
        }

        Name (BSLF, Zero)
        Method (BATS, 1, Serialized)
        {
            If (Arg0)
            {
                BSLF = One
            }
            Else
            {
                BSLF = Zero
            }
        }

        Mutex (MMPX, 0x00)
        Method (BATO, 0, Serialized)
        {
            Acquire (MMPX, 0xFFFF)
        }

        Method (BATR, 0, Serialized)
        {
            Release (MMPX)
        }

        Name (LLOW, Zero)
    }

    Scope (_SB.PCI0.SBRG.EC0)
    {
        Method (_QA1, 0, NotSerialized)  // _Qxx: EC Query
        {
            DCPF = DCPS (Zero)
            If (DCPF)
            {
                Sleep (0x07D0)
            }

            Notify (BAT0, 0x80) // Status Change
            Notify (BAT0, 0x81) // Information Change
        }

        Method (_QA5, 0, NotSerialized)  // _Qxx: EC Query
        {
            LLOW = One
            If (ATKP)
            {
                Notify (ATKD, 0x6E) // Reserved
            }
            Else
            {
                If (BATP (Zero))
                {
                    Notify (BAT0, 0x80) // Status Change
                }
            }
        }

        Method (_QA3, 0, NotSerialized)  // _Qxx: EC Query
        {
            If (BATP (Zero))
            {
                Local0 = BCLE (Zero)
                If ((Local0 == Zero))
                {
                    Notify (BAT0, 0x80) // Status Change
                }
                Else
                {
                    Notify (BAT0, 0x81) // Information Change
                    Notify (AC0, 0x80) // Status Change
                }
            }
        }

        Method (BATP, 1, Serialized)
        {
            If (Arg0)
            {
                Return (DCP2) /* \DCP2 */
            }
            Else
            {
                Return (DCPF) /* \DCPF */
            }
        }

        Method (NBAT, 1, NotSerialized)
        {
            If (BATP (Zero))
            {
                Notify (BAT0, Arg0)
            }
        }
    }

    Scope (_SB)
    {
        Device (SLPB)
        {
            Name (_HID, EisaId ("PNP0C0E") /* Sleep Button Device */)  // _HID: Hardware ID
            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
            {
                Return (Package (0x02)
                {
                    0x0B, 
                    0x04
                })
            }
        }
    }

    Scope (\)
    {
        Name (MES4, Zero)
        Method (OEMS, 1, NotSerialized)
        {
            If ((FEBL & 0x0800))
            {
                If (!(FEBL & 0x0400))
                {
                    If ((Arg0 >= 0x03))
                    {
                        \_SB.PCI0.SBRG.EC0.ST87 (0x40, 0x02)
                    }
                }
            }

            \_SB.PCI0.SBRG.EC0.SPIN (0x19, Zero)
            If (\_SB.PCI0.SBRG.EC0.RPIN (0x1A))
            {
                \_SB.PCI0.SBRG.EC0.SPIN (0x1A, Zero)
            }

            If ((Arg0 == 0x03))
            {
                If ((OSFG <= OSME))
                {
                    WIDE = One
                }
                Else
                {
                    WIDE = Zero
                }
            }

            SBRS (Arg0)
            \_SB.PCI0.SBRG.EC0.EC0S (Arg0)
            SLPN = Arg0
            DIAG ((Arg0 + 0xD0))
            SLPT = Arg0
            If (Arg0)
            {
                STRP (One)
            }

            PRJS (Arg0)
            ISMI (0x9D)
        }

        Method (OEMW, 1, NotSerialized)
        {
            ISMI (0x9E)
            SLPT = Zero
            If ((Arg0 <= 0x04))
            {
                If (CIST)
                {
                    Notify (\_PR.CPU0, 0x80) // Target object type does not support notifies
                    If ((CPUN >= 0x02))
                    {
                        Notify (\_PR.CPU1, 0x80) // Target object type does not support notifies
                    }
                }

                Sleep (0x64)
                Notify (\_PR.CPU0, 0x81) // Target object type does not support notifies
                If ((CPUN >= 0x02))
                {
                    Notify (\_PR.CPU1, 0x81) // Target object type does not support notifies
                }
            }

            \_SB.PCI0.SBRG.EC0.EC0W (Arg0)
            If ((Arg0 == 0x04))
            {
                If ((OSFG <= OSME))
                {
                    MES4 = 0x02
                }
                Else
                {
                    MES4 = Zero
                }
            }

            If ((Arg0 == 0x03))
            {
                \_SB.PCI0.OSCW ()
            }

            SBRW (Arg0)
            If ((Arg0 == 0x04))
            {
                Notify (\_SB.SLPB, 0x02) // Device Wake
            }
            Else
            {
                If (PWBS)
                {
                    Notify (\_SB.SLPB, 0x02) // Device Wake
                    PWBS = Zero
                }
            }

            PRJW (Arg0)
            DIAG ((Arg0 + 0xF0))
        }
    }

    Scope (_SB.ATKD)
    {
        Method (FSMI, 1, NotSerialized)
        {
            FSFN = Arg0
            Local0 = (Arg0 | 0xA0)
            DIAG (Local0)
            ISMI (0x90)
            Return (FSTA) /* \FSTA */
        }

        Method (FLSH, 1, NotSerialized)
        {
            FSTA = Arg0
            FSMI (Zero)
        }

        Method (FINI, 1, NotSerialized)
        {
            FADR = Arg0
            Return (FSMI (One))
        }

        Method (FERS, 1, NotSerialized)
        {
            FSTA = Arg0
            Return (FSMI (0x02))
        }

        Method (FWRI, 1, NotSerialized)
        {
            FADR = Arg0
            FSIZ = 0x1000
            Return ((0x1000 - FSMI (0x03)))
        }

        Method (FWRP, 0, NotSerialized)
        {
            FSIZ = Zero
            Return ((0x1000 - FSMI (0x03)))
        }

        Method (FEBW, 1, NotSerialized)
        {
            FADR = Arg0
            Return (FSMI (0x04))
        }

        Method (FEBR, 1, NotSerialized)
        {
            FADR = Arg0
            Return (FSMI (0x05))
        }

        Method (FEDW, 0, NotSerialized)
        {
            Return (FSMI (0x06))
        }

        Method (ECSR, 1, NotSerialized)
        {
            FSTA = Arg0
            Return (FSMI (0x07))
        }
    }

    Scope (_SB.ATKD)
    {
        Method (AGFN, 1, Serialized)
        {
            If ((Arg0 == Zero))
            {
                Return (GNBF) /* \GNBF */
            }

            Local0 = Zero
            OperationRegion (\PARM, SystemMemory, Arg0, 0x08)
            Field (PARM, DWordAcc, NoLock, Preserve)
            {
                MFUN,   16, 
                SFUN,   16, 
                LEN,    16, 
                STAS,   8, 
                EROR,   8
            }

            EROR = Zero
            STAS = One
            If ((MFUN == 0x20))
            {
                BSMI (Arg0)
                STAS &= 0xFE
            }

            If ((MFUN == 0x02))
            {
                BSMI (Arg0)
                STAS &= 0xFE
            }

            Local1 = RGPL (0x26, One)
            Local2 = RGPL (0x27, One)
            If ((Local1 == Zero))
            {
                If ((MFUN == 0x41))
                {
                    MF41 (Arg0, SFUN, LEN)
                    STAS &= 0xFE
                }
            }

            If ((MFUN == 0x42))
            {
                MF42 (Arg0, SFUN, LEN)
                STAS &= 0xFE
            }

            Local0 = (MFUN & 0xF0)
            If ((Local0 == 0x10))
            {
                MF1X (Arg0, LEN, MFUN, SFUN)
            }

            If ((MFUN == 0x18))
            {
                STAS &= 0xFD
                EROR &= Zero
                If ((SFUN == 0x02))
                {
                    GDPS (Arg0)
                    EROR = Zero
                }
                Else
                {
                    BSMI (Arg0)
                }

                If ((SFUN == One)) {}
                If ((SFUN == 0x02)) {}
                If ((SFUN == 0x03))
                {
                    If ((FEBL & 0x80000000)) {}
                    Else
                    {
                        If ((FEBL & 0x40000000)) {}
                        Else
                        {
                            Notify (^^PCI0.IDE0.CHN1, Zero) // Bus Check
                            Sleep (0x03E8)
                            Notify (^^PCI0.IDE0.CHN1.DRV0, One) // Device Check
                        }

                        If ((FEBL & 0x20000000)) {}
                        Else
                        {
                            Notify (^^PCI0.P0P3, Zero) // Bus Check
                            Sleep (0x03E8)
                            Notify (^^PCI0.P0P3, One) // Device Check
                        }
                    }
                }

                STAS &= 0xFE
            }

            If ((MFUN == One))
            {
                GVER (Arg0, LEN)
                STAS &= 0xFE
            }

            If ((MFUN == 0x30))
            {
                MF30 (Arg0, SFUN, LEN)
                STAS &= 0xFE
            }

            AGLN (Arg0, MFUN, SFUN, LEN)
            If ((STAS == One))
            {
                EROR = One
                STAS |= 0x02
            }

            STAS &= 0xFE
            STAS |= 0x80
            Return (Zero)
        }

        Method (GVER, 2, NotSerialized)
        {
            OperationRegion (\FGVR, SystemMemory, Arg0, Arg1)
            Field (FGVR, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                APID,   16, 
                APRV,   32
            }

            Return (Zero)
        }

        Method (MF30, 3, NotSerialized)
        {
            OperationRegion (FM30, SystemMemory, Arg0, 0x08)
            Field (FM30, DWordAcc, NoLock, Preserve)
            {
                Offset (0x06), 
                SM30,   8, 
                EM30,   8
            }

            Local0 = One
            If ((Arg1 == Zero))
            {
                Local0 = G30V (Arg0, Arg2)
            }

            If ((Arg1 == One))
            {
                Local0 = EC01 (Arg0, Arg2)
            }

            If ((Arg1 == 0x02))
            {
                Local0 = EC02 (Arg0, Arg2)
            }

            If (Local0)
            {
                EM30 = Local0
                SM30 |= 0x02
            }

            SM30 |= 0x80
            Return (Zero)
        }

        Method (G30V, 2, NotSerialized)
        {
            If ((Arg1 < 0x0C))
            {
                Return (0x02)
            }

            OperationRegion (\F300, SystemMemory, Arg0, Arg1)
            Field (F300, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                SVER,   16, 
                MVER,   16
            }

            MVER = Zero
            SVER = Zero
            Return (Zero)
        }

        Method (EC01, 2, NotSerialized)
        {
            If ((Arg1 < 0x10))
            {
                Return (0x02)
            }

            OperationRegion (FEC1, SystemMemory, Arg0, Arg1)
            Field (FEC1, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                ECMD,   8, 
                EDA1,   8, 
                EDA2,   8, 
                EDA3,   8, 
                EDA4,   8, 
                EDA5,   8
            }

            Local0 = ^^PCI0.SBRG.EC0.ECXT (ECMD, EDA1, EDA2, EDA3, EDA4, EDA5)
            EDA1 = DerefOf (Index (Local0, One))
            EDA2 = DerefOf (Index (Local0, 0x02))
            EDA3 = DerefOf (Index (Local0, 0x03))
            EDA4 = DerefOf (Index (Local0, 0x04))
            EDA5 = DerefOf (Index (Local0, 0x05))
            Return (DerefOf (Index (Local0, Zero)))
        }

        Method (EC02, 2, NotSerialized)
        {
            If ((Arg1 < 0x30))
            {
                Return (0x02)
            }

            OperationRegion (FEC2, SystemMemory, Arg0, Arg1)
            Field (FEC2, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                BUSN,   8, 
                PROT,   8, 
                DADD,   8, 
                DREG,   8, 
                DAT0,   8, 
                DAT1,   8, 
                BLEN,   8, 
                REVB,   8, 
                BLK1,   32, 
                BLK2,   32, 
                BLK3,   32, 
                BLK4,   32, 
                BLK5,   32, 
                BLK6,   32, 
                BLK7,   32, 
                BLK8,   32
            }

            Local0 = ^^PCI0.SBRG.EC0.ECSB (BUSN, PROT, DADD, DREG, DAT0, DAT1)
            DAT0 = DerefOf (Index (Local0, One))
            DAT1 = DerefOf (Index (Local0, 0x02))
            BLEN = DerefOf (Index (Local0, 0x03))
            Name (BKUF, Buffer (0x20) {})
            CreateDWordField (BKUF, Zero, DD01)
            CreateDWordField (BKUF, 0x04, DD02)
            CreateDWordField (BKUF, 0x08, DD03)
            CreateDWordField (BKUF, 0x0C, DD04)
            CreateDWordField (BKUF, 0x10, DD05)
            CreateDWordField (BKUF, 0x14, DD06)
            CreateDWordField (BKUF, 0x18, DD07)
            CreateDWordField (BKUF, 0x1C, DD08)
            BKUF = DerefOf (Index (Local0, 0x04))
            BLK1 = DD01 /* \_SB_.ATKD.EC02.DD01 */
            BLK2 = DD02 /* \_SB_.ATKD.EC02.DD02 */
            BLK3 = DD03 /* \_SB_.ATKD.EC02.DD03 */
            BLK4 = DD04 /* \_SB_.ATKD.EC02.DD04 */
            BLK5 = DD05 /* \_SB_.ATKD.EC02.DD05 */
            BLK6 = DD06 /* \_SB_.ATKD.EC02.DD06 */
            BLK7 = DD07 /* \_SB_.ATKD.EC02.DD07 */
            BLK8 = DD08 /* \_SB_.ATKD.EC02.DD08 */
            Local2 = DerefOf (Index (Local0, Zero))
            Local2 &= 0x3F
            Return (Local2)
        }

        Method (GENW, 1, NotSerialized)
        {
            RTCW = Zero
        }
    }

    Method (BSMI, 1, Serialized)
    {
        BIPA = Arg0
        ISMI (0xA1)
    }

    Scope (_SB.ATKD)
    {
        Method (MF1X, 4, NotSerialized)
        {
            OperationRegion (FM1X, SystemMemory, Arg0, 0x08)
            Field (FM1X, DWordAcc, NoLock, Preserve)
            {
                Offset (0x06), 
                SM1X,   8, 
                EM1X,   8
            }

            Local0 = One
            If ((Arg2 == 0x10))
            {
                Local0 = MF10 (Arg0, Arg1, Arg3)
            }

            If ((Arg2 == 0x11))
            {
                Local0 = MF11 (Arg0, Arg1, Arg3)
            }

            If ((Arg2 == 0x12))
            {
                Local0 = MF12 (Arg0, Arg1, Arg3)
            }

            If ((Arg2 == 0x13))
            {
                Local0 = MF13 (Arg0, Arg1, Arg3)
            }

            If ((Arg2 == 0x14))
            {
                Local0 = MF14 (Arg0, Arg1, Arg3)
            }

            If ((Arg2 == 0x15))
            {
                Local0 = MF15 (Arg0, Arg1, Arg3)
            }

            If ((Arg2 == 0x16))
            {
                Local0 = MF16 (Arg0, Arg1, Arg3)
            }

            If ((Arg2 == 0x17))
            {
                Local0 = MF17 (Arg0, Arg1, Arg3)
            }

            If ((Arg2 == 0x19))
            {
                Local0 = MF19 (Arg0, Arg1, Arg3)
            }

            SM1X &= 0xFE
            If (Local0)
            {
                EM1X = Local0
                SM1X |= 0x02
            }

            SM1X |= 0x80
        }

        Method (MF10, 3, NotSerialized)
        {
            Local0 = One
            If ((Arg2 == Zero))
            {
                Local0 = G10V (Arg0, Arg1)
            }

            If ((Arg2 == One))
            {
                Local0 = SRTC (Arg0, Arg1)
            }

            Return (Local0)
        }

        Method (G10V, 2, NotSerialized)
        {
            If ((Arg1 < 0x0C))
            {
                Return (0x02)
            }

            OperationRegion (\F100, SystemMemory, Arg0, Arg1)
            Field (F100, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                SVER,   16, 
                MVER,   16
            }

            MVER = Zero
            SVER = Zero
            Return (Zero)
        }

        Method (SRTC, 2, NotSerialized)
        {
            If ((Arg1 < 0x0C))
            {
                Return (0x02)
            }

            OperationRegion (\F101, SystemMemory, Arg0, Arg1)
            Field (F101, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                DLTM,   16
            }

            RTCW = DLTM /* \_SB_.ATKD.SRTC.DLTM */
            Return (Zero)
        }

        Method (MF11, 3, NotSerialized)
        {
            Local0 = One
            If ((Arg2 == Zero))
            {
                Local0 = G11V (Arg0, Arg1)
            }

            If ((Arg2 == One))
            {
                Local0 = GBAT (Arg0, Arg1)
            }

            If ((Arg2 == 0x02))
            {
                Local0 = ASBR (Arg0, Arg1)
            }

            If ((Arg2 == 0x03))
            {
                Local0 = ASBE (Arg0, Arg1)
            }

            If ((Arg2 == 0x04))
            {
                Local0 = BTCR (Arg0, Arg1)
            }

            Return (Local0)
        }

        Method (G11V, 2, NotSerialized)
        {
            If ((Arg1 < 0x0C))
            {
                Return (0x02)
            }

            OperationRegion (\F110, SystemMemory, Arg0, Arg1)
            Field (F100, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                SVER,   16, 
                MVER,   16
            }

            MVER = Zero
            SVER = Zero
            Return (Zero)
        }

        Method (GBAT, 2, NotSerialized)
        {
            If ((Arg1 < 0x0A))
            {
                Return (0x02)
            }

            OperationRegion (\F111, SystemMemory, Arg0, Arg1)
            Field (F111, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                BTNM,   8, 
                BTTP,   8
            }

            BTNM = One
            BTTP = Zero
            Return (Zero)
        }

        Method (ASBR, 2, NotSerialized)
        {
            If ((Arg1 < 0x30))
            {
                Return (0x02)
            }

            OperationRegion (\F112, SystemMemory, Arg0, Arg1)
            Field (F112, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                BATN,   8, 
                BATA,   8, 
                REGS,   8, 
                BDAT,   16, 
                BLEN,   8, 
                BREV,   16, 
                BLK1,   32, 
                BLK2,   32, 
                BLK3,   32, 
                BLK4,   32, 
                BLK5,   32, 
                BLK6,   32, 
                BLK7,   32, 
                BLK8,   32
            }

            If ((BATN >= One))
            {
                Return (0x11)
            }

            If ((BATA == Zero))
            {
                Local0 = ^^PCI0.SBRG.EC0.SMBR (^^PCI0.SBRG.EC0.RDWD, ^^PCI0.SBRG.EC0.BADR, REGS)
                BDAT = DerefOf (Index (Local0, 0x02))
                Local2 = DerefOf (Index (Local0, Zero))
                Local2 &= 0x1F
                If (Local2)
                {
                    Local2 += 0x10
                }

                Return (Local2)
            }

            If ((BATA == One))
            {
                Local0 = ^^PCI0.SBRG.EC0.SMBW (^^PCI0.SBRG.EC0.WRWD, ^^PCI0.SBRG.EC0.BADR, REGS, 0x02, BDAT)
                Local2 = DerefOf (Index (Local0, Zero))
                Local2 &= 0x1F
                If (Local2)
                {
                    Local2 += 0x10
                }

                Return (Local2)
            }

            If ((BATA == 0x02))
            {
                Local0 = ^^PCI0.SBRG.EC0.SMBR (^^PCI0.SBRG.EC0.RDBL, ^^PCI0.SBRG.EC0.BADR, REGS)
                Name (BKUF, Buffer (0x20) {})
                CreateDWordField (BKUF, Zero, DAT1)
                CreateDWordField (BKUF, 0x04, DAT2)
                CreateDWordField (BKUF, 0x08, DAT3)
                CreateDWordField (BKUF, 0x0C, DAT4)
                CreateDWordField (BKUF, 0x10, DAT5)
                CreateDWordField (BKUF, 0x14, DAT6)
                CreateDWordField (BKUF, 0x18, DAT7)
                CreateDWordField (BKUF, 0x1C, DAT8)
                BKUF = DerefOf (Index (Local0, 0x02))
                BLK1 = DAT1 /* \_SB_.ATKD.ASBR.DAT1 */
                BLK2 = DAT2 /* \_SB_.ATKD.ASBR.DAT2 */
                BLK3 = DAT3 /* \_SB_.ATKD.ASBR.DAT3 */
                BLK4 = DAT4 /* \_SB_.ATKD.ASBR.DAT4 */
                BLK5 = DAT5 /* \_SB_.ATKD.ASBR.DAT5 */
                BLK6 = DAT6 /* \_SB_.ATKD.ASBR.DAT6 */
                BLK7 = DAT7 /* \_SB_.ATKD.ASBR.DAT7 */
                BLK8 = DAT8 /* \_SB_.ATKD.ASBR.DAT8 */
                BLEN = DerefOf (Index (Local0, One))
                Local2 = DerefOf (Index (Local0, Zero))
                Local2 &= 0x1F
                If (Local2)
                {
                    Local2 += 0x10
                }

                Return (Local2)
            }

            Return (0x10)
        }

        Method (ASBE, 2, Serialized)
        {
            If ((Arg1 < 0x0C))
            {
                Return (0x02)
            }

            OperationRegion (\F113, SystemMemory, Arg0, Arg1)
            Field (F113, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                BATN,   8, 
                BATA,   8, 
                REGS,   8, 
                BDAT,   8
            }

            If ((BATN > One))
            {
                Return (0x11)
            }

            If ((BATA == Zero))
            {
                Local2 = ^^PCI0.SBRG.EC0.RBEP (REGS)
                Local3 = (Local2 & 0xFF)
                BDAT = Local3
                Local2 >>= 0x08
                Local2 &= 0x1F
                If (Local2)
                {
                    Local2 += 0x10
                }

                Return (Local2)
            }

            If ((BATA == One))
            {
                Local2 = ^^PCI0.SBRG.EC0.WBEP (REGS, BDAT)
                Local2 &= 0x1F
                If (Local2)
                {
                    Local2 += 0x10
                }

                Return (Local2)
            }

            Return (0x10)
        }

        Method (BTCR, 2, NotSerialized)
        {
            If ((Arg1 < 0x09))
            {
                Return (0x02)
            }

            OperationRegion (\F114, SystemMemory, Arg0, Arg1)
            Field (F114, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                BCDC,   8
            }

            SBTL (BCDC)
            Return (Zero)
        }

        Method (MF12, 3, NotSerialized)
        {
            Local0 = One
            If ((Arg2 == Zero))
            {
                Local0 = G12V (Arg0, Arg1)
            }

            If ((Arg2 == One))
            {
                Local0 = GLDI (Arg0, Arg1)
            }

            If ((Arg2 == 0x02))
            {
                Local0 = LDCR (Arg0, Arg1)
            }

            Return (Local0)
        }

        Method (G12V, 2, NotSerialized)
        {
            If ((Arg1 < 0x0C))
            {
                Return (0x02)
            }

            OperationRegion (\F120, SystemMemory, Arg0, Arg1)
            Field (F120, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                SVER,   16, 
                MVER,   16
            }

            MVER = Zero
            SVER = Zero
            Return (Zero)
        }

        Method (GLDI, 2, NotSerialized)
        {
            If ((Arg1 < 0x10))
            {
                Return (0x02)
            }

            OperationRegion (\F121, SystemMemory, Arg0, Arg1)
            Field (F121, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                LDI0,   32, 
                LDI1,   32
            }

            Local0 = Zero
            Local0 |= 0x10
            Local0 |= 0x20
            LDI0 = Local0
            Return (Zero)
        }

        Method (LDCR, 2, NotSerialized)
        {
            If ((Arg1 < 0x0A))
            {
                Return (0x02)
            }

            OperationRegion (\F122, SystemMemory, Arg0, Arg1)
            Field (F122, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                LDNM,   8, 
                LCRT,   8
            }

            If ((LDNM == 0x04))
            {
                WLED (LCRT)
                Return (Zero)
            }

            If ((LDNM == 0x05))
            {
                BLED (LCRT)
                Return (Zero)
            }

            Return (0x10)
        }

        Method (MF13, 3, NotSerialized)
        {
            Local0 = One
            If ((Arg2 == Zero))
            {
                Local0 = G13V (Arg0, Arg1)
            }

            If ((Arg2 == One))
            {
                Local0 = GTSI (Arg0, Arg1)
            }

            If ((Arg2 == 0x02))
            {
                Local0 = GTSV (Arg0, Arg1)
            }

            If ((Arg2 == 0x03))
            {
                Local0 = GVSN (Arg0, Arg1)
            }

            If ((Arg2 == 0x04))
            {
                Local0 = GVSV (Arg0, Arg1)
            }

            If ((Arg2 == 0x05))
            {
                Local0 = GFNN (Arg0, Arg1)
            }

            If ((Arg2 == 0x06))
            {
                Local0 = GFNS (Arg0, Arg1)
            }

            If ((Arg2 == 0x07))
            {
                Local0 = SFNS (Arg0, Arg1)
            }

            Return (Local0)
        }

        Method (G13V, 2, NotSerialized)
        {
            If ((Arg1 < 0x0C))
            {
                Return (0x02)
            }

            OperationRegion (\F130, SystemMemory, Arg0, Arg1)
            Field (F130, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                SVER,   16, 
                MVER,   16
            }

            MVER = Zero
            SVER = Zero
            Return (Zero)
        }

        Method (GTSI, 2, NotSerialized)
        {
            If ((Arg1 < 0x0C))
            {
                Return (0x02)
            }

            OperationRegion (\F131, SystemMemory, Arg0, Arg1)
            Field (F131, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                THRI,   32
            }

            THRI = 0x0301
            Return (Zero)
        }

        Method (GTSV, 2, NotSerialized)
        {
            If ((Arg1 < 0x0A))
            {
                Return (0x02)
            }

            OperationRegion (\F132, SystemMemory, Arg0, Arg1)
            Field (F132, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                TSNM,   8, 
                TSVL,   8, 
                TSST,   8
            }

            TSST = Zero
            If ((TSNM == Zero))
            {
                TSVL = \_TZ.RTMP ()
                Return (Zero)
            }

            If ((TSNM == 0x08))
            {
                BSMI (Arg0)
                Return (Zero)
            }

            If ((TSNM == 0x09))
            {
                BSMI (Arg0)
                Return (Zero)
            }

            Return (0x10)
        }

        Method (GVSN, 2, NotSerialized)
        {
            If ((Arg1 < 0x09))
            {
                Return (0x02)
            }

            OperationRegion (\F133, SystemMemory, Arg0, Arg1)
            Field (F133, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                NMVS,   8
            }

            NMVS = Zero
            Return (Zero)
        }

        Method (GVSV, 2, NotSerialized)
        {
            If ((Arg1 < 0x0B))
            {
                Return (0x02)
            }

            OperationRegion (\F134, SystemMemory, Arg0, Arg1)
            Field (F134, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                VSNM,   8, 
                VSVL,   16
            }

            If ((VSNM > Zero))
            {
                Return (0x10)
            }

            Return (Zero)
        }

        Method (GFNN, 2, NotSerialized)
        {
            If ((Arg1 < 0x09))
            {
                Return (0x02)
            }

            OperationRegion (\F135, SystemMemory, Arg0, Arg1)
            Field (F135, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                NMFN,   32
            }

            NMFN = One
            Return (Zero)
        }

        Method (GFNS, 2, NotSerialized)
        {
            If ((Arg1 < 0x0D))
            {
                Return (0x02)
            }

            OperationRegion (\F136, SystemMemory, Arg0, Arg1)
            Field (F136, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                FNNM,   8, 
                GFNS,   32
            }

            If (((FNNM == Zero) | (FNNM > One)))
            {
                Return (0x10)
            }

            Local0 = FNNM /* \_SB_.ATKD.GFNS.FNNM */
            GFNS = \_TZ.RFAN (Local0--)
            Return (Zero)
        }

        Method (SFNS, 2, NotSerialized)
        {
            If ((Arg1 < 0x0A))
            {
                Return (0x02)
            }

            OperationRegion (\F137, SystemMemory, Arg0, Arg1)
            Field (F137, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                FNNB,   8, 
                FNSP,   8
            }

            If ((FNNB > One))
            {
                Return (0x10)
            }

            ^^PCI0.SBRG.EC0.SFNV (FNNB, FNSP)
            Return (Zero)
        }

        Method (MF14, 3, NotSerialized)
        {
            Local0 = One
            If ((Arg2 == Zero))
            {
                Local0 = G14V (Arg0, Arg1)
            }

            If ((Arg2 == One))
            {
                Local0 = GNBT (Arg0, Arg1)
            }

            If ((Arg2 == 0x02))
            {
                Local0 = GBTS (Arg0, Arg1)
            }

            Return (Local0)
        }

        Method (G14V, 2, NotSerialized)
        {
            If ((Arg1 < 0x0C))
            {
                Return (0x02)
            }

            OperationRegion (\F140, SystemMemory, Arg0, Arg1)
            Field (F140, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                SVER,   16, 
                MVER,   16
            }

            MVER = Zero
            SVER = Zero
            Return (Zero)
        }

        Method (GNBT, 2, NotSerialized)
        {
            If ((Arg1 < 0x09))
            {
                Return (0x02)
            }

            OperationRegion (\F141, SystemMemory, Arg0, Arg1)
            Field (F141, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                NBBT,   8
            }

            NBBT = 0x05
            Return (Zero)
        }

        Method (GBTS, 2, NotSerialized)
        {
            If ((Arg1 < 0x0A))
            {
                Return (0x02)
            }

            OperationRegion (\F142, SystemMemory, Arg0, Arg1)
            Field (F142, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                BTNM,   8, 
                BTST,   8
            }

            Name (BTTB, Package (0x05)
            {
                Package (0x03)
                {
                    0x0C, 
                    Zero, 
                    Zero
                }, 

                Package (0x03)
                {
                    0x0D, 
                    Zero, 
                    Zero
                }, 

                Package (0x03)
                {
                    0x0E, 
                    Zero, 
                    Zero
                }, 

                Package (0x03)
                {
                    0x0F, 
                    Zero, 
                    Zero
                }, 

                Package (0x03)
                {
                    0x15, 
                    Zero, 
                    Zero
                }
            })
            If ((BTNM > 0x05))
            {
                Return (0x10)
            }

            Local0 = BTNM /* \_SB_.ATKD.GBTS.BTNM */
            Local0--
            Local1 = DerefOf (Index (BTTB, Local0))
            If ((DerefOf (Index (Local1, One)) == Zero))
            {
                Local2 = ^^PCI0.SBRG.EC0.RPIN (DerefOf (Index (Local1, Zero)))
            }

            If ((DerefOf (Index (Local1, One)) == One))
            {
                Local2 = RGPL (DerefOf (Index (Local1, Zero)), One)
            }

            If ((DerefOf (Index (Local1, One)) == 0x03)) {}
            If ((DerefOf (Index (Local1, 0x02)) == Local2))
            {
                BTST = Zero
            }
            Else
            {
                BTST = One
            }

            Return (Zero)
        }

        Method (MF15, 3, NotSerialized)
        {
            Local0 = One
            If ((Arg2 == Zero))
            {
                Local0 = G15V (Arg0, Arg1)
            }

            If ((Arg2 == One))
            {
                Local0 = GLDB (Arg0, Arg1)
            }

            If ((Arg2 == 0x02))
            {
                Local0 = SLDB (Arg0, Arg1)
            }

            If ((Arg2 == 0x03))
            {
                Local0 = GDPI (Arg0, Arg1)
            }

            If ((Arg2 == 0x04))
            {
                Local0 = SODP (Arg0, Arg1)
            }

            Return (Local0)
        }

        Method (G15V, 2, NotSerialized)
        {
            If ((Arg1 < 0x0C))
            {
                Return (0x02)
            }

            OperationRegion (\F150, SystemMemory, Arg0, Arg1)
            Field (F150, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                SVER,   16, 
                MVER,   16
            }

            MVER = Zero
            SVER = Zero
            Return (Zero)
        }

        Method (GLDB, 2, NotSerialized)
        {
            If ((Arg1 < 0x0A))
            {
                Return (0x02)
            }

            OperationRegion (\F151, SystemMemory, Arg0, Arg1)
            Field (F151, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                LCDB,   8, 
                MLDB,   8
            }

            LCDB = GPLV ()
            MLDB = 0x0F
            Return (Zero)
        }

        Method (SLDB, 2, NotSerialized)
        {
            If ((Arg1 < 0x0A))
            {
                Return (0x02)
            }

            OperationRegion (\F152, SystemMemory, Arg0, Arg1)
            Field (F152, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                LCDL,   8, 
                LTPE,   8
            }

            If ((LTPE == Zero))
            {
                If ((LCDL > 0x0F))
                {
                    Return (0x10)
                }

                SPLV (LCDL)
                Return (Zero)
            }

            If ((LTPE == One))
            {
                ^^PCI0.SBRG.EC0.SBRV (LCDL)
                Return (Zero)
            }

            Return (0x11)
        }

        Method (GDPI, 2, NotSerialized)
        {
            If ((Arg1 < 0x10))
            {
                Return (0x02)
            }

            OperationRegion (\F153, SystemMemory, Arg0, Arg1)
            Field (F153, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                ODPI,   32, 
                ODPC,   8
            }

            ODPI = 0x07
            BSMI (Arg0)
            Return (Zero)
        }

        Method (SODP, 2, NotSerialized)
        {
            If ((Arg1 < 0x0C))
            {
                Return (0x02)
            }

            OperationRegion (\F154, SystemMemory, Arg0, Arg1)
            Field (F154, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                ODPM,   32
            }

            Local0 = (ODPM & 0x07)
            If ((Local0 == ODPM))
            {
                SDSP (ODPM)
                Return (Zero)
            }

            Return (0x10)
        }

        Method (MF16, 3, NotSerialized)
        {
            Local0 = One
            If ((Arg2 == Zero))
            {
                Local0 = G16V (Arg0, Arg1)
            }

            If ((Arg2 == One))
            {
                Local0 = SFBD (Arg0, Arg1)
            }

            If ((Arg2 == 0x02))
            {
                Local0 = LCMD (Arg0, Arg1)
            }

            Return (Local0)
        }

        Method (G16V, 2, NotSerialized)
        {
            If ((Arg1 < 0x0C))
            {
                Return (0x02)
            }

            OperationRegion (\F160, SystemMemory, Arg0, Arg1)
            Field (F160, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                SVER,   16, 
                MVER,   16
            }

            MVER = Zero
            SVER = Zero
            Return (Zero)
        }

        Method (SFBD, 2, NotSerialized)
        {
            If ((Arg1 < 0x0A))
            {
                Return (0x02)
            }

            OperationRegion (\F161, SystemMemory, Arg0, Arg1)
            Field (F161, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                NXBD,   8
            }

            If (OFBD (NXBD))
            {
                UHDB = NXBD /* \_SB_.ATKD.SFBD.NXBD */
                Return (Zero)
            }
            Else
            {
                Return (0x10)
            }
        }

        Method (LCMD, 2, NotSerialized)
        {
            If ((Arg1 < 0x0A))
            {
                Return (0x02)
            }

            BSMI (Arg0)
            FRPN = 0xAA55
            Return (Zero)
        }

        Method (MF17, 3, NotSerialized)
        {
            Local0 = One
            If ((Arg2 == Zero))
            {
                Local0 = G17V (Arg0, Arg1)
            }

            If ((Arg2 == One))
            {
                Local0 = GMDL (Arg0, Arg1)
            }

            If ((Arg2 == 0x02))
            {
                Local0 = GBSI (Arg0, Arg1)
            }

            If ((Arg2 == 0x03))
            {
                Local0 = GECI (Arg0, Arg1)
            }

            Return (Local0)
        }

        Method (G17V, 2, NotSerialized)
        {
            If ((Arg1 < 0x0C))
            {
                Return (0x02)
            }

            OperationRegion (\F170, SystemMemory, Arg0, Arg1)
            Field (F170, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                SVER,   16, 
                MVER,   16
            }

            MVER = Zero
            SVER = Zero
            Return (Zero)
        }

        Method (GMDL, 2, NotSerialized)
        {
            If ((Arg1 < 0x19))
            {
                Return (0x02)
            }

            OperationRegion (\F171, SystemMemory, Arg0, Arg1)
            Field (F171, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                MLEN,   8, 
                MDL1,   32, 
                MDL2,   32, 
                MDL3,   32, 
                MDL4,   32
            }

            MDL1 = Zero
            MDL2 = Zero
            MDL3 = Zero
            MDL4 = Zero
            BSMI (Arg0)
            Return (Zero)
        }

        Method (GBSI, 2, NotSerialized)
        {
            If ((Arg1 < 0x19))
            {
                Return (0x02)
            }

            OperationRegion (\F172, SystemMemory, Arg0, Arg1)
            Field (F172, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                BLEN,   8, 
                BDL1,   32, 
                BDL2,   32, 
                BDL3,   32, 
                BDL4,   32
            }

            BDL1 = Zero
            BDL2 = Zero
            BDL3 = Zero
            BDL4 = Zero
            Name (BBUF, Buffer (0x10) {})
            CreateDWordField (BBUF, Zero, DAT1)
            CreateDWordField (BBUF, 0x04, DAT2)
            CreateDWordField (BBUF, 0x08, DAT3)
            CreateDWordField (BBUF, 0x0C, DAT4)
            Local0 = "214"
            BLEN = SizeOf (Local0)
            BBUF = "214"
            BDL1 = DAT1 /* \_SB_.ATKD.GBSI.DAT1 */
            BDL2 = DAT2 /* \_SB_.ATKD.GBSI.DAT2 */
            BDL3 = DAT3 /* \_SB_.ATKD.GBSI.DAT3 */
            BDL4 = DAT4 /* \_SB_.ATKD.GBSI.DAT4 */
            Return (Zero)
        }

        Method (GECI, 2, NotSerialized)
        {
            If ((Arg1 < 0x19))
            {
                Return (0x02)
            }

            OperationRegion (\F173, SystemMemory, Arg0, Arg1)
            Field (F173, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                ELEN,   8, 
                EDL1,   32, 
                EDL2,   32, 
                EDL3,   32, 
                EDL4,   32
            }

            EDL1 = Zero
            EDL2 = Zero
            EDL3 = Zero
            EDL4 = Zero
            BSMI (Arg0)
            Return (Zero)
        }

        Method (MF18, 3, NotSerialized)
        {
            Local0 = One
            If ((Arg2 == Zero))
            {
                Local0 = G18V (Arg0, Arg1)
            }

            If ((Arg2 == One))
            {
                Local0 = GDVI (Arg0, Arg1)
            }

            If ((Arg2 == 0x02))
            {
                Local0 = GDVS (Arg0, Arg1)
            }

            If ((Arg2 == 0x03))
            {
                Local0 = SDPW (Arg0, Arg1)
            }

            Return (Local0)
        }

        Method (G18V, 2, NotSerialized)
        {
            If ((Arg1 < 0x0C))
            {
                Return (0x02)
            }

            OperationRegion (\F180, SystemMemory, Arg0, Arg1)
            Field (F180, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                SVER,   16, 
                MVER,   16
            }

            MVER = Zero
            SVER = Zero
            Return (Zero)
        }

        Method (GDVI, 2, NotSerialized)
        {
            If ((Arg1 < 0x18))
            {
                Return (0x02)
            }

            OperationRegion (\F181, SystemMemory, Arg0, Arg1)
            Field (F181, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                LDI0,   32, 
                LDI1,   32
            }

            LDI0 = Zero
            Return (Zero)
        }

        Method (GDVS, 2, NotSerialized)
        {
            If ((Arg1 < 0x0A))
            {
                Return (0x02)
            }

            OperationRegion (\F182, SystemMemory, Arg0, Arg1)
            Field (F182, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                DNUM,   8, 
                DSTS,   8
            }

            Local0 = (One << DNUM) /* \_SB_.ATKD.GDVS.DNUM */
            If (((Local0 & Zero) == Zero))
            {
                Return (0x10)
            }

            Return (Zero)
        }

        Method (SDPW, 2, NotSerialized)
        {
            If ((Arg1 < 0x0A))
            {
                Return (0x02)
            }

            OperationRegion (\F183, SystemMemory, Arg0, Arg1)
            Field (F183, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                DNUM,   8, 
                DCTR,   8
            }

            Local0 = (One << DNUM) /* \_SB_.ATKD.SDPW.DNUM */
            If (((Local0 & Zero) == Zero))
            {
                Return (0x10)
            }

            If ((DCTR > One))
            {
                Return (0x11)
            }

            Return (Zero)
        }

        Method (MF19, 3, NotSerialized)
        {
            Local0 = One
            If ((Arg2 == Zero))
            {
                Local0 = G19V (Arg0, Arg1)
            }

            If ((Arg2 == One))
            {
                Local0 = ACMS (Arg0, Arg1)
            }

            Return (Local0)
        }

        Method (G19V, 2, NotSerialized)
        {
            If ((Arg1 < 0x0C))
            {
                Return (0x02)
            }

            OperationRegion (\F190, SystemMemory, Arg0, Arg1)
            Field (F190, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                SVER,   16, 
                MVER,   16
            }

            MVER = Zero
            SVER = Zero
            Return (Zero)
        }

        Method (ACMS, 2, NotSerialized)
        {
            BSMI (Arg0)
            Return (Zero)
        }
    }

    Scope (_SB.ATKD)
    {
        Method (OFBD, 1, NotSerialized)
        {
            Name (FBDT, Package (0x04)
            {
                0xF1, 
                0xF2, 
                0xF3, 
                0xF6
            })
            Local0 = Match (FBDT, MEQ, Arg0, MTR, Zero, Zero)
            Local0++
            Return (Local0)
        }

        Method (MF41, 3, NotSerialized)
        {
            OperationRegion (FM41, SystemMemory, Arg0, 0x08)
            Field (FM41, DWordAcc, NoLock, Preserve)
            {
                Offset (0x06), 
                SM41,   8, 
                EM41,   8
            }

            Local0 = One
            If ((Arg1 == 0x03))
            {
                Local0 = GOCI (Arg0, Arg2)
            }

            If ((Arg1 == 0x04))
            {
                Local0 = SOCK (Arg0, Arg2)
            }

            If ((Arg1 == 0x07))
            {
                Local0 = Zero
                GOCK (Arg0)
            }

            If ((Arg1 == 0x0B))
            {
                Local0 = Zero
                GOCT (Arg0)
            }

            If (Local0)
            {
                EM41 = Local0
                SM41 |= 0x02
            }

            SM41 |= 0x80
            Return (Zero)
        }

        Method (GOCI, 2, NotSerialized)
        {
            OperationRegion (\F413, SystemMemory, Arg0, Arg1)
            Field (F413, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                EXCS,   8, 
                CCRS,   8, 
                EXCP,   8, 
                CCRP,   8, 
                TAPS,   8, 
                AP1I,   8, 
                AP2I,   8, 
                AP3I,   8, 
                ASSS,   8, 
                ARST,   8, 
                AP4I,   8, 
                AP5I,   8
            }

            EXCS = 0x03
            CCRS = Zero
            EXCP = OCST /* \OCST */
            CCRP = Zero
            TAPS = 0x05
            AP1I = One
            AP2I = 0x02
            AP3I = Zero
            Local0 = Zero
            If (Ones)
            {
                Local0 |= 0x02
            }

            If (Ones)
            {
                Local0 |= 0x04
            }

            If (Zero)
            {
                Local0 |= 0x08
            }

            If (Ones)
            {
                Local0 |= 0x10
            }

            If (Ones)
            {
                Local0 |= 0x20
            }

            ASSS = Local0
            ARST = 0x06
            AP4I = 0x04
            AP5I = 0x05
            Return (Zero)
        }

        Name (RFQ0, Package (0x07)
        {
            0x3320, 
            0x23EE, 
            0x23BC, 
            0x238A, 
            0x236A, 
            0x233A, 
            0x231C
        })
        Name (RFID, Package (0x06)
        {
            Zero, 
            0x236A, 
            0x3320, 
            Zero, 
            0x231C, 
            Zero
        })
        Name (IFEQ, Package (0x07)
        {
            0x0428, 
            0x03E8, 
            0x03A4, 
            0x0360, 
            0x0338, 
            0x02F8, 
            0x02D0
        })
        Name (IFID, Package (0x06)
        {
            Zero, 
            0x0338, 
            0x0428, 
            Zero, 
            0x02D0, 
            Zero
        })
        Name (FOUC, Zero)
        Method (SOCK, 2, NotSerialized)
        {
            OperationRegion (\F414, SystemMemory, Arg0, Arg1)
            Field (F414, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                SAPS,   8
            }

            If ((SAPS == OCST))
            {
                Return (Zero)
            }
            Else
            {
                OCST = SAPS /* \_SB_.ATKD.SOCK.SAPS */
                P4HN = One
                TRBR = One
            }

            Local0 = SAPS /* \_SB_.ATKD.SOCK.SAPS */
            OCST = SAPS /* \_SB_.ATKD.SOCK.SAPS */
            P4HN = One
            Return (Zero)
        }

        Method (RDWM, 1, NotSerialized)
        {
            Local0 = Arg0
            RBLK (0xD2, Zero, 0x15)
            Local4 = DerefOf (Index (RBUF, 0x05))
            Local4 |= 0x80
            Index (RBUF, 0x05) = Local4
            WBLK (0xD2, Zero, 0x15)
            Sleep (0x64)
            If ((Local0 == Zero))
            {
                Local0 = One
            }

            If ((Local0 == One))
            {
                Local1 = 0x23
                Local2 = 0x58
            }
            Else
            {
                If ((Local0 == 0x02))
                {
                    Local1 = 0x23
                    Local2 = 0xB2
                }
                Else
                {
                    If ((Local0 == 0x03))
                    {
                        Local1 = 0x23
                        Local2 = 0xD0
                    }
                    Else
                    {
                        If ((Local0 == 0x04))
                        {
                            Local1 = 0x23
                            Local2 = 0x3A
                        }
                        Else
                        {
                            If ((Local0 == 0x05))
                            {
                                Local1 = 0x23
                                Local2 = 0x1C
                            }
                            Else
                            {
                                Return (0x11)
                            }
                        }
                    }
                }
            }

            RBLK (0xD2, Zero, 0x20)
            Index (RBUF, 0x13) = Local1
            Index (RBUF, 0x11) = Local2
            WBLK (0xD2, Zero, 0x20)
            Sleep (0x64)
            RBLK (0xD2, Zero, 0x20)
            Local4 = DerefOf (Index (RBUF, 0x1F))
            Local4 |= 0x51
            Index (RBUF, 0x1F) = Local4
            WBLK (0xD2, Zero, 0x20)
            Sleep (0x64)
            RBLK (0xD2, Zero, 0x15)
            Local4 = DerefOf (Index (RBUF, 0x05))
            Local4 &= 0x7F
            Index (RBUF, 0x05) = Local4
            WBLK (0xD2, Zero, 0x15)
            Sleep (0x64)
            Return (Zero)
        }

        Method (IDWM, 1, NotSerialized)
        {
            Local0 = Arg0
            If ((Local0 == Zero))
            {
                Local0 = One
            }

            If ((Local0 == One))
            {
                Local1 = 0x03
                Local2 = 0x20
            }
            Else
            {
                If ((Local0 == 0x02))
                {
                    Local1 = 0x03
                    Local2 = 0x98
                }
                Else
                {
                    If ((Local0 == 0x03))
                    {
                        Local1 = 0x03
                        Local2 = 0xC0
                    }
                    Else
                    {
                        If ((Local0 == 0x04))
                        {
                            Local1 = 0x02
                            Local2 = 0xF8
                        }
                        Else
                        {
                            If ((Local0 == 0x05))
                            {
                                Local1 = 0x02
                                Local2 = 0xD0
                            }
                            Else
                            {
                                Return (0x11)
                            }
                        }
                    }
                }
            }

            RBLK (0xD2, Zero, 0x20)
            Index (RBUF, 0x11) = Local1
            Index (RBUF, 0x10) = Local2
            Local4 = DerefOf (Index (RBUF, Zero))
            Local4 |= 0x40
            Index (RBUF, Zero) = Local4
            WBLK (0xD2, Zero, 0x20)
            Sleep (0x64)
            Return (Zero)
        }

        Method (GOCK, 1, NotSerialized)
        {
            OperationRegion (\F417, SystemMemory, Arg0, 0x10)
            Field (F417, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                CAPS,   8, 
                Offset (0x10)
            }

            CAPS = Zero
            If ((P4HN == Zero))
            {
                CAPS = 0x02
                Return (Zero)
            }

            CAPS = OCST /* \OCST */
            Return (Zero)
        }

        Method (GOCT, 1, NotSerialized)
        {
            OperationRegion (\F411, SystemMemory, Arg0, 0x10)
            Field (F411, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                OCTP,   8, 
                Offset (0x10)
            }

            OCTP = 0x03
        }

        Method (MF42, 3, NotSerialized)
        {
            OperationRegion (FM42, SystemMemory, Arg0, 0x08)
            Field (FM42, DWordAcc, NoLock, Preserve)
            {
                Offset (0x06), 
                SM42,   8, 
                EM42,   8
            }

            Local0 = One
            If ((Arg1 == One))
            {
                Local0 = SFBO (Arg0, Arg2)
            }

            If ((Arg1 == 0x02))
            {
                Local0 = SAOC (Arg0, Arg2)
            }

            If ((Arg1 == 0x03))
            {
                Local0 = GBST (Arg0, Arg2)
            }

            If (Local0)
            {
                EM42 = Local0
                SM42 |= 0x02
            }

            SM42 |= 0x80
            Return (Zero)
        }

        Method (SFBO, 2, NotSerialized)
        {
            OperationRegion (\F421, SystemMemory, Arg0, Arg1)
            Field (F421, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                SOPT,   8
            }

            Return (Zero)
        }

        Method (SAOC, 2, NotSerialized)
        {
            OperationRegion (\F422, SystemMemory, Arg0, Arg1)
            Field (F422, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                CNTF,   8
            }

            If ((CNTF == Zero))
            {
                OCEN = Zero
            }
            Else
            {
                If ((CNTF == One))
                {
                    OCEN = One
                }
                Else
                {
                    If ((CNTF == 0x02)) {}
                }
            }

            Return (Zero)
        }

        Method (GBST, 2, NotSerialized)
        {
            OperationRegion (\F423, SystemMemory, Arg0, Arg1)
            Field (F423, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                BOT1,   64, 
                BOT2,   64
            }

            BOT1 = TBOT /* \TBOT */
            BOT2 = TRTC /* \TRTC */
            Return (Zero)
        }
    }

    Scope (_SB.ATKD)
    {
        Method (AGLN, 4, NotSerialized)
        {
            PRCT (Arg0, Arg1, Arg2, Arg3)
        }
    }

    Scope (_SB.ATKD)
    {
        Method (PRCT, 4, NotSerialized)
        {
            If ((Arg1 != 0x31))
            {
                Return (0xFF)
            }

            OperationRegion (FM31, SystemMemory, Arg0, 0x08)
            Field (FM31, DWordAcc, NoLock, Preserve)
            {
                Offset (0x06), 
                SM31,   8, 
                EM31,   8
            }

            Local0 = One
            If ((Arg2 == Zero))
            {
                Local0 = G31V (Arg0, Arg3)
            }

            If ((Arg2 == One))
            {
                Local0 = PDMK (Arg0, Arg3)
            }

            If (Local0)
            {
                EM31 = Local0
                SM31 |= 0x02
            }

            SM31 |= 0x80
            Return (Zero)
        }

        Method (G31V, 2, NotSerialized)
        {
            If ((Arg1 < 0x0C))
            {
                Return (0x02)
            }

            OperationRegion (\F310, SystemMemory, Arg0, Arg1)
            Field (F310, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                SVER,   16, 
                MVER,   16
            }

            MVER = Zero
            SVER = Zero
            Return (Zero)
        }

        Method (PDMK, 2, NotSerialized)
        {
            OperationRegion (\F301, SystemMemory, Arg0, Arg1)
            Field (F301, DWordAcc, NoLock, Preserve)
            {
                Offset (0x06), 
                SF31,   8, 
                EF31,   8
            }

            SF31 = One
            BSMI (Arg0)
            If ((SF31 == One))
            {
                EF31 = One
                SF31 = 0x82
            }

            Return (Zero)
        }
    }

    Scope (\)
    {
        Name (HPWR, Zero)
        Name (HPOK, Zero)
        Name (HGDP, Zero)
        Name (HGAP, Zero)
        Name (HPLG, Zero)
        Name (HPEJ, Zero)
        Name (HPLE, Zero)
        Name (HLMX, Zero)
        Name (HLMM, Zero)
        Name (HCMX, Zero)
        Name (HCMM, Zero)
        Name (HDMX, Zero)
        Name (HDMM, Zero)
        Name (HHMX, Zero)
        Name (HHMM, Zero)
        Name (HPMX, Zero)
        Name (HPMM, Zero)
        Name (HVGF, Zero)
    }

    Scope (_SB.PCI0)
    {
        OperationRegion (HOSG, PCI_Config, Zero, 0x0100)
        Field (HOSG, ByteAcc, NoLock, Preserve)
        {
            REG0,   32, 
            REG1,   32, 
            REG2,   32, 
            Offset (0x54), 
                ,   1, 
            D1EN,   1
        }

        OperationRegion (MCHB, SystemMemory, 0xFED10000, 0x4000)
        Field (MCHB, DWordAcc, Lock, Preserve)
        {
            Offset (0xC14), 
            CLKD,   6
        }
    }

    Scope (_SB.PCI0)
    {
        Device (WMI1)
        {
            Name (_HID, "pnp0c14")  // _HID: Hardware ID
            Name (_UID, "MXM2")  // _UID: Unique ID
            Name (_WDG, Buffer (0xA0)
            {
                /* 0000 */  0x3C, 0x5C, 0xCB, 0xF6, 0xAE, 0x9C, 0xBD, 0x4E,  /* <\.....N */
                /* 0008 */  0xB5, 0x77, 0x93, 0x1E, 0xA3, 0x2A, 0x2C, 0xC0,  /* .w...*,. */
                /* 0010 */  0x4D, 0x58, 0x01, 0x02, 0x40, 0x2F, 0x1A, 0x92,  /* MX..@/.. */
                /* 0018 */  0xC4, 0x0D, 0x2D, 0x40, 0xAC, 0x18, 0xB4, 0x84,  /* ..-@.... */
                /* 0020 */  0x44, 0xEF, 0x9E, 0xD2, 0xD0, 0x00, 0x01, 0x08,  /* D....... */
                /* 0028 */  0x61, 0xD3, 0x2A, 0xC1, 0xA9, 0x9F, 0x74, 0x4C,  /* a.*...tL */
                /* 0030 */  0x90, 0x1F, 0x95, 0xCB, 0x09, 0x45, 0xCF, 0x3E,  /* .....E.> */
                /* 0038 */  0xD9, 0x00, 0x01, 0x08, 0x64, 0x35, 0x4F, 0xEF,  /* ....d5O. */
                /* 0040 */  0xC8, 0x48, 0x94, 0x48, 0x85, 0xC8, 0xB4, 0x6C,  /* .H.H...l */
                /* 0048 */  0x26, 0xB8, 0x42, 0xC0, 0xDA, 0x00, 0x01, 0x08,  /* &.B..... */
                /* 0050 */  0x06, 0x80, 0x84, 0x42, 0x86, 0x88, 0x0E, 0x49,  /* ...B...I */
                /* 0058 */  0x8C, 0x72, 0x2B, 0xDC, 0xA9, 0x3A, 0x8A, 0x09,  /* .r+..:.. */
                /* 0060 */  0xDB, 0x00, 0x01, 0x08, 0x62, 0xDE, 0x6B, 0xE0,  /* ....b.k. */
                /* 0068 */  0x75, 0xEE, 0xF4, 0x48, 0xA5, 0x83, 0xB2, 0x3E,  /* u..H...> */
                /* 0070 */  0x69, 0xAB, 0xF8, 0x91, 0x80, 0x00, 0x01, 0x08,  /* i....... */
                /* 0078 */  0x0F, 0xBD, 0xDE, 0x3A, 0x5F, 0x0C, 0xED, 0x46,  /* ...:_..F */
                /* 0080 */  0xAB, 0x2E, 0x04, 0x96, 0x2B, 0x4F, 0xDC, 0xBC,  /* ....+O.. */
                /* 0088 */  0x81, 0x00, 0x01, 0x08, 0x21, 0x12, 0x90, 0x05,  /* ....!... */
                /* 0090 */  0x66, 0xD5, 0xD1, 0x11, 0xB2, 0xF0, 0x00, 0xA0,  /* f....... */
                /* 0098 */  0xC9, 0x06, 0x29, 0x10, 0x58, 0x4D, 0x01, 0x00   /* ..).XM.. */
            })
            Method (WMMX, 3, NotSerialized)
            {
                If ((SizeOf (Arg2) >= 0x04))
                {
                    CreateDWordField (Arg2, Zero, FUNC)
                    CreateDWordField (Arg2, 0x04, ARGS)
                    CreateDWordField (Arg2, 0x08, XARG)
                    If ((FUNC == 0x444F445F))
                    {
                        If ((Arg1 == 0x10))
                        {
                            Return (^^VGA._DOD ())
                        }
                        Else
                        {
                            Return (^^P0P1.VGA._DOD ())
                        }
                    }
                    Else
                    {
                        If ((FUNC == 0x5343445F))
                        {
                            If ((SizeOf (Arg2) >= 0x08))
                            {
                                If ((ARGS == 0x0100))
                                {
                                    If ((Arg1 == 0x10))
                                    {
                                        Return (^^VGA.CRTD._DCS ())
                                    }
                                    Else
                                    {
                                        Return (^^P0P1.VGA.CRTD._DCS ())
                                    }
                                }
                                Else
                                {
                                    If ((ARGS == 0x0110))
                                    {
                                        If ((Arg1 == 0x10))
                                        {
                                            Return (^^VGA.LCDD._DCS ())
                                        }
                                        Else
                                        {
                                            Return (^^P0P1.VGA.LCDD._DCS ())
                                        }
                                    }
                                    Else
                                    {
                                        If ((ARGS == 0x7330))
                                        {
                                            If ((Arg1 != 0x10))
                                            {
                                                Return (^^P0P1.VGA.HDMI._DCS ())
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        Else
                        {
                            If ((FUNC == 0x534F525F))
                            {
                                If ((SizeOf (Arg2) >= 0x08))
                                {
                                    If ((Arg1 != 0x10))
                                    {
                                        Return (^^P0P1.VGA._ROM (ARGS, XARG))
                                    }
                                }
                            }
                            Else
                            {
                                If ((FUNC == 0x4D53445F))
                                {
                                    If ((SizeOf (Arg2) >= 0x18))
                                    {
                                        CreateField (Arg2, Zero, 0x80, MUID)
                                        CreateDWordField (Arg2, 0x10, REVI)
                                        CreateDWordField (Arg2, 0x14, SFNC)
                                        CreateDWordField (Arg2, 0x18, SARG)
                                        If ((Arg1 != 0x10))
                                        {
                                            Return (^^VGA._DSM (MUID, REVI, SFNC, SARG))
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                Return (Zero)
            }

            Name (WQXM, Buffer (0x029C)
            {
                /* 0000 */  0x46, 0x4F, 0x4D, 0x42, 0x01, 0x00, 0x00, 0x00,  /* FOMB.... */
                /* 0008 */  0x8B, 0x02, 0x00, 0x00, 0x0C, 0x08, 0x00, 0x00,  /* ........ */
                /* 0010 */  0x44, 0x53, 0x00, 0x01, 0x1A, 0x7D, 0xDA, 0x54,  /* DS...}.T */
                /* 0018 */  0x18, 0xD2, 0x83, 0x00, 0x01, 0x06, 0x18, 0x42,  /* .......B */
                /* 0020 */  0x10, 0x05, 0x10, 0x8A, 0xE6, 0x80, 0x42, 0x04,  /* ......B. */
                /* 0028 */  0x92, 0x43, 0xA4, 0x30, 0x30, 0x28, 0x0B, 0x20,  /* .C.00(.  */
                /* 0030 */  0x86, 0x90, 0x0B, 0x26, 0x26, 0x40, 0x04, 0x84,  /* ...&&@.. */
                /* 0038 */  0xBC, 0x0A, 0xB0, 0x29, 0xC0, 0x24, 0x88, 0xFA,  /* ...).$.. */
                /* 0040 */  0xF7, 0x87, 0x28, 0x09, 0x0E, 0x25, 0x04, 0x42,  /* ..(..%.B */
                /* 0048 */  0x12, 0x05, 0x98, 0x17, 0xA0, 0x5B, 0x80, 0x61,  /* .....[.a */
                /* 0050 */  0x01, 0xB6, 0x05, 0x98, 0x16, 0xE0, 0x18, 0x92,  /* ........ */
                /* 0058 */  0x4A, 0x03, 0xA7, 0x04, 0x96, 0x02, 0x21, 0xA1,  /* J.....!. */
                /* 0060 */  0x02, 0x94, 0x0B, 0xF0, 0x2D, 0x40, 0x3B, 0xA2,  /* ....-@;. */
                /* 0068 */  0x24, 0x0B, 0xB0, 0x0C, 0x23, 0x02, 0x8F, 0x82,  /* $...#... */
                /* 0070 */  0xA1, 0x71, 0x68, 0xEC, 0x30, 0x2C, 0x13, 0x4C,  /* .qh.0,.L */
                /* 0078 */  0x83, 0x38, 0x8C, 0xB2, 0x91, 0x45, 0x60, 0xDC,  /* .8...E`. */
                /* 0080 */  0x4E, 0x05, 0xC8, 0x15, 0x20, 0x4C, 0x80, 0x78,  /* N... L.x */
                /* 0088 */  0x54, 0x61, 0x34, 0x07, 0x45, 0xE0, 0x42, 0x63,  /* Ta4.E.Bc */
                /* 0090 */  0x64, 0x40, 0xC8, 0xA3, 0x00, 0xAB, 0xA3, 0xD0,  /* d@...... */
                /* 0098 */  0xA4, 0x12, 0xD8, 0xBD, 0x00, 0x8D, 0x02, 0xB4,  /* ........ */
                /* 00A0 */  0x09, 0x70, 0x28, 0x40, 0xA1, 0x00, 0x6B, 0x18,  /* .p(@..k. */
                /* 00A8 */  0x72, 0x06, 0x21, 0x5B, 0xD8, 0xC2, 0x68, 0x50,  /* r.![..hP */
                /* 00B0 */  0x80, 0x45, 0x14, 0x8D, 0xE0, 0x2C, 0x2A, 0x9E,  /* .E...,*. */
                /* 00B8 */  0x93, 0x50, 0x02, 0xDA, 0x1B, 0x82, 0xF0, 0x8C,  /* .P...... */
                /* 00C0 */  0xD9, 0x18, 0x9E, 0x10, 0x83, 0x54, 0x86, 0x21,  /* .....T.! */
                /* 00C8 */  0x88, 0xB8, 0x11, 0x8E, 0xA5, 0xFD, 0x41, 0x10,  /* ......A. */
                /* 00D0 */  0xF9, 0xAB, 0xD7, 0xB8, 0x1D, 0x69, 0x34, 0xA8,  /* .....i4. */
                /* 00D8 */  0xB1, 0x26, 0x38, 0x76, 0x8F, 0xE6, 0x84, 0x3B,  /* .&8v...; */
                /* 00E0 */  0x17, 0x20, 0x7D, 0x6E, 0x02, 0x39, 0xBA, 0xD3,  /* . }n.9.. */
                /* 00E8 */  0xA8, 0x73, 0xD0, 0x64, 0x78, 0x0C, 0x2B, 0xC1,  /* .s.dx.+. */
                /* 00F0 */  0x7F, 0x80, 0x4F, 0x01, 0x78, 0xD7, 0x80, 0x9A,  /* ..O.x... */
                /* 00F8 */  0xFE, 0xC1, 0x33, 0x41, 0x70, 0xA8, 0x21, 0x7A,  /* ..3Ap.!z */
                /* 0100 */  0xD4, 0xE1, 0x4E, 0xE0, 0xBC, 0x8E, 0x84, 0x41,  /* ..N....A */
                /* 0108 */  0x1C, 0xD1, 0x71, 0x63, 0x67, 0x75, 0x32, 0x07,  /* ..qcgu2. */
                /* 0110 */  0x5D, 0xAA, 0x00, 0xB3, 0x07, 0x00, 0x0D, 0x2E,  /* ]....... */
                /* 0118 */  0xC1, 0x69, 0x9F, 0x49, 0xE8, 0xF7, 0x80, 0xF3,  /* .i.I.... */
                /* 0120 */  0xE9, 0x79, 0x6C, 0x6C, 0x10, 0xA8, 0x91, 0xF9,  /* .yll.... */
                /* 0128 */  0xFF, 0x0F, 0xED, 0x41, 0x9E, 0x56, 0xCC, 0x90,  /* ...A.V.. */
                /* 0130 */  0xCF, 0x02, 0x87, 0xC5, 0xC4, 0x1E, 0x19, 0xE8,  /* ........ */
                /* 0138 */  0x78, 0xC0, 0x7F, 0x00, 0x78, 0x34, 0x88, 0xF0,  /* x...x4.. */
                /* 0140 */  0x66, 0xE0, 0xF9, 0x9A, 0x60, 0x50, 0x08, 0x39,  /* f...`P.9 */
                /* 0148 */  0x19, 0x0F, 0x4A, 0xCC, 0xF9, 0x80, 0xCC, 0x25,  /* ..J....% */
                /* 0150 */  0xC4, 0x43, 0xC0, 0x31, 0xC4, 0x08, 0x7A, 0x46,  /* .C.1..zF */
                /* 0158 */  0x45, 0x23, 0x6B, 0x22, 0x3E, 0x03, 0x78, 0xDC,  /* E#k">.x. */
                /* 0160 */  0x96, 0x05, 0x42, 0x09, 0x0C, 0xEC, 0x73, 0xC3,  /* ..B...s. */
                /* 0168 */  0x3B, 0x84, 0x61, 0x71, 0xA3, 0x09, 0xEC, 0xF3,  /* ;.aq.... */
                /* 0170 */  0x85, 0x05, 0x0E, 0x0A, 0x05, 0xEB, 0xBB, 0x42,  /* .......B */
                /* 0178 */  0xCC, 0xE7, 0x81, 0xE3, 0x3C, 0x60, 0x0B, 0x9F,  /* ....<`.. */
                /* 0180 */  0x28, 0x01, 0x3E, 0x24, 0x8F, 0x06, 0xDE, 0x20,  /* (.>$...  */
                /* 0188 */  0xE1, 0x5B, 0x3F, 0x02, 0x10, 0xE0, 0x27, 0x06,  /* .[?...'. */
                /* 0190 */  0x13, 0x58, 0x1E, 0x30, 0x7A, 0x94, 0xF6, 0x2B,  /* .X.0z..+ */
                /* 0198 */  0x00, 0x21, 0xF8, 0x8B, 0xC5, 0x53, 0xC0, 0xEB,  /* .!...S.. */
                /* 01A0 */  0x40, 0x84, 0x63, 0x81, 0x29, 0x72, 0x6C, 0x68,  /* @.c.)rlh */
                /* 01A8 */  0x78, 0x7E, 0x70, 0x88, 0x1E, 0xF5, 0x5C, 0xC2,  /* x~p...\. */
                /* 01B0 */  0x1F, 0x4D, 0x94, 0x53, 0x38, 0x1C, 0x1F, 0x39,  /* .M.S8..9 */
                /* 01B8 */  0x8C, 0x10, 0xFE, 0x49, 0xE3, 0xC9, 0xC3, 0x9A,  /* ...I.... */
                /* 01C0 */  0xEF, 0x00, 0x9A, 0xD2, 0x5B, 0xC0, 0xFB, 0x83,  /* ....[... */
                /* 01C8 */  0x47, 0x80, 0x11, 0x20, 0xE1, 0x68, 0x82, 0x89,  /* G.. .h.. */
                /* 01D0 */  0x7C, 0x3A, 0x01, 0xD5, 0xFF, 0xFF, 0x74, 0x02,  /* |:....t. */
                /* 01D8 */  0xB8, 0xBA, 0x01, 0x14, 0x37, 0x6A, 0x9D, 0x49,  /* ....7j.I */
                /* 01E0 */  0x7C, 0x2C, 0xF1, 0xAD, 0xE4, 0xBC, 0x43, 0xC5,  /* |,....C. */
                /* 01E8 */  0x7F, 0x93, 0x78, 0x3A, 0xF1, 0x34, 0x1E, 0x4C,  /* ..x:.4.L */
                /* 01F0 */  0x42, 0x44, 0x89, 0x18, 0x21, 0xA2, 0xEF, 0x27,  /* BD..!..' */
                /* 01F8 */  0x46, 0x08, 0x15, 0x31, 0x6C, 0xA4, 0x37, 0x80,  /* F..1l.7. */
                /* 0200 */  0xE7, 0x13, 0xE3, 0x84, 0x08, 0xF4, 0x74, 0xC2,  /* ......t. */
                /* 0208 */  0x42, 0x3E, 0x34, 0xA4, 0xE1, 0x74, 0x02, 0x50,  /* B>4..t.P */
                /* 0210 */  0xE0, 0xFF, 0x7F, 0x3A, 0x81, 0x1F, 0xF5, 0x74,  /* ...:...t */
                /* 0218 */  0x82, 0x1E, 0xAE, 0x4F, 0x19, 0x18, 0xE4, 0x03,  /* ...O.... */
                /* 0220 */  0xF2, 0xA9, 0xC3, 0xF7, 0x1F, 0x13, 0xF8, 0x78,  /* .......x */
                /* 0228 */  0xC2, 0x45, 0x1D, 0x4F, 0x50, 0xA7, 0x07, 0x1F,  /* .E.OP... */
                /* 0230 */  0x4F, 0xD8, 0x19, 0xE1, 0x2C, 0x1E, 0x03, 0x7C,  /* O...,..| */
                /* 0238 */  0x3A, 0xC1, 0xDC, 0x13, 0x7C, 0x3A, 0x01, 0xDB,  /* :...|:.. */
                /* 0240 */  0x68, 0x60, 0x1C, 0x4F, 0xC0, 0x77, 0x74, 0xC1,  /* h`.O.wt. */
                /* 0248 */  0x1D, 0x4F, 0xC0, 0x30, 0x18, 0x18, 0xE7, 0x13,  /* .O.0.... */
                /* 0250 */  0xE0, 0x31, 0x5E, 0xDC, 0x31, 0xC0, 0x43, 0xE0,  /* .1^.1.C. */
                /* 0258 */  0x03, 0x78, 0xDC, 0x38, 0x3D, 0x2B, 0x9D, 0x14,  /* .x.8=+.. */
                /* 0260 */  0xF2, 0x24, 0xC2, 0x07, 0x85, 0x39, 0xB0, 0xE0,  /* .$...9.. */
                /* 0268 */  0x14, 0xDA, 0xF4, 0xA9, 0xD1, 0xA8, 0x55, 0x83,  /* ......U. */
                /* 0270 */  0x32, 0x35, 0xCA, 0x34, 0xA8, 0xD5, 0xA7, 0x52,  /* 25.4...R */
                /* 0278 */  0x63, 0xC6, 0xCE, 0x19, 0x0E, 0xF8, 0x10, 0xD0,  /* c....... */
                /* 0280 */  0x89, 0xC0, 0xF2, 0x9E, 0x0D, 0x02, 0xB1, 0x0C,  /* ........ */
                /* 0288 */  0x0A, 0x81, 0x58, 0xFA, 0xAB, 0x45, 0x20, 0x0E,  /* ..X..E . */
                /* 0290 */  0x0E, 0xA2, 0xFF, 0x3F, 0x88, 0x23, 0xD2, 0x0A,  /* ...?.#.. */
                /* 0298 */  0xC4, 0xFF, 0x7F, 0x7F                           /* .... */
            })
        }
    }

    Scope (_SB.PCI0.SBRG.EC0)
    {
        Method (EVD0, 0, NotSerialized)
        {
            Notify (VGA, 0xD0) // Hardware-Specific
            Notify (WMI1, 0xD0) // Hardware-Specific
        }

        Method (EVD9, 0, NotSerialized)
        {
            Notify (VGA, 0xD9) // Hardware-Specific
            Notify (WMI1, 0xD9) // Hardware-Specific
        }

        Method (EVDA, 0, NotSerialized)
        {
            Notify (VGA, 0xDA) // Hardware-Specific
            Notify (WMI1, 0xDA) // Hardware-Specific
        }

        Method (EV80, 0, NotSerialized)
        {
            Notify (VGA, 0x80) // Status Change
            Notify (WMI1, 0x80) // Status Change
        }

        Method (EV81, 0, NotSerialized)
        {
            Notify (VGA, 0x81) // Information Change
            Notify (WMI1, 0x81) // Information Change
        }
    }

    Scope (_GPE)
    {
        Method (_L16, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
        {
            TGPP (0x06)
            DBG8 = 0x60
        }
    }

    Scope (_SB.PCI0.VGA)
    {
        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            HPWR = One
            HPOK = One
            HGDP = Zero
            HGAP = One
            HPLG = Zero
            HPEJ = Zero
            HPLE = One
            HLMX = Zero
            HLMM = Zero
            HCMX = Zero
            HCMM = Zero
            HDMX = Zero
            HDMM = Zero
            HHMX = Zero
            HHMM = Zero
            SAVO ()
        }

        Method (ASP1, 0, Serialized)
        {
            Local0 = (0xC0008000 + 0xB0)
            OperationRegion (PEGM, SystemMemory, Local0, One)
            Field (PEGM, ByteAcc, NoLock, Preserve)
            {
                ASPC,   2
            }

            Local1 = (0xC0100000 + 0x88)
            OperationRegion (ASPR, SystemMemory, Local1, One)
            Field (ASPR, ByteAcc, NoLock, Preserve)
            {
                ASP2,   2
            }

            ASPC = 0x03
            ASP2 = 0x03
        }

        Method (ASP0, 0, Serialized)
        {
            Local0 = (0xC0008000 + 0xB0)
            OperationRegion (PEGM, SystemMemory, Local0, One)
            Field (PEGM, ByteAcc, NoLock, Preserve)
            {
                ASPC,   2
            }

            Local1 = (0xC0100000 + 0x88)
            OperationRegion (ASPR, SystemMemory, Local1, One)
            Field (ASPR, ByteAcc, NoLock, Preserve)
            {
                ASP2,   2
            }

            ASPC = Zero
            ASP2 = Zero
        }

        Name (BOTF, Zero)
        Name (DONE, Zero)
        Name (CMO1, Zero)
        Name (TLST, One)
        Name (DSM2, Zero)
        Name (DSM5, Zero)
        Name (QATH, Zero)
        Name (HGDD, One)
        Name (TMP0, Zero)
        Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
        {
            If ((Arg0 == ToUUID ("9d95a0a0-0060-4d48-b34d-7e5fea129fd4")))
            {
                Local0 = Zero
                Local0 = (DerefOf (Index (Arg3, 0x03)) << 0x18)
                Local0 += (DerefOf (Index (Arg3, 0x02)) << 0x10)
                Local0 += (DerefOf (Index (Arg3, One)) << 0x08)
                Local0 += (DerefOf (Index (Arg3, Zero)) << Zero)
                Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
                _T_0 = Arg2
                If ((_T_0 == Zero))
                {
                    Name (HYBS, 0x403F)
                    Return (HYBS) /* \_SB_.PCI0.VGA_._DSM.HYBS */
                }
                Else
                {
                    If ((_T_0 == One))
                    {
                        Return (Buffer (0x04)
                        {
                             0x01, 0x30, 0x00, 0x07                           /* .0.. */
                        })
                    }
                    Else
                    {
                        If ((_T_0 == 0x02))
                        {
                            If ((Local0 & 0x10))
                            {
                                Local1 = (Local0 & 0x0F)
                                ^^SBRG.EC0.EVD9 ()
                                HGAP = Local1
                                If ((RGPL (0x34, One) == One))
                                {
                                    ^^SBRG.EC0.SPIN (0x1F, Zero)
                                }
                                Else
                                {
                                    ^^SBRG.EC0.SPIN (0x1F, One)
                                }

                                ^^SBRG.EC0.SPIN (0x11, One)
                            }

                            DSM2 |= 0x10
                            Return (DSM2) /* \_SB_.PCI0.VGA_.DSM2 */
                        }
                        Else
                        {
                            If ((_T_0 == 0x03))
                            {
                                If ((Local0 == One))
                                {
                                    ^^P0P1.VGA._ON ()
                                    Return (One)
                                }
                                Else
                                {
                                    If ((Local0 == 0x02))
                                    {
                                        ^^P0P1.VGA._OFF ()
                                        Return (Zero)
                                    }
                                    Else
                                    {
                                        Return (^^P0P1.VGA._STA ())
                                    }
                                }

                                Return (One)
                            }
                            Else
                            {
                                If ((_T_0 == 0x04))
                                {
                                    Name (NFBU, Buffer (0x04)
                                    {
                                         0x00, 0x90, 0x10, 0x04                           /* .... */
                                    })
                                    Name (HBDP, Zero)
                                    CreateField (NFBU, Zero, 0x0C, BDRF)
                                    CreateField (NFBU, 0x0C, One, BDOF)
                                    CreateField (NFBU, 0x0D, 0x02, PSRF)
                                    CreateField (NFBU, 0x0F, One, PSOF)
                                    CreateField (NFBU, 0x10, 0x04, PTVF)
                                    CreateField (NFBU, 0x14, One, PTVO)
                                    CreateField (NFBU, 0x15, 0x05, TVFF)
                                    CreateField (NFBU, 0x1A, One, TVOF)
                                    Name (_T_1, Zero)  // _T_x: Emitted by ASL Compiler
                                    _T_1 = HBDP /* \_SB_.PCI0.VGA_._DSM.HBDP */
                                    If ((_T_1 == 0x07))
                                    {
                                        Index (NFBU, Zero) = 0x10
                                    }
                                    Else
                                    {
                                        If ((_T_1 == 0x0B))
                                        {
                                            Index (NFBU, Zero) = 0x11
                                        }
                                        Else
                                        {
                                            If ((_T_1 == 0x0D))
                                            {
                                                Index (NFBU, Zero) = 0x12
                                            }
                                            Else
                                            {
                                                If ((_T_1 == 0x0E))
                                                {
                                                    Index (NFBU, Zero) = 0x14
                                                }
                                                Else
                                                {
                                                    If ((_T_1 == 0x0F))
                                                    {
                                                        Index (NFBU, Zero) = 0x18
                                                    }
                                                    Else
                                                    {
                                                        Index (NFBU, Zero) = HBDP /* \_SB_.PCI0.VGA_._DSM.HBDP */
                                                    }
                                                }
                                            }
                                        }
                                    }

                                    Return (NFBU) /* \_SB_.PCI0.VGA_._DSM.NFBU */
                                }
                                Else
                                {
                                    If ((_T_0 == 0x05))
                                    {
                                        \CADL = Local0
                                        CSTE = (Local0 >> 0x0C)
                                        If ((QATH == One))
                                        {
                                            QATH = Zero
                                            Return (Zero)
                                        }

                                        Local1 = Local0
                                        If ((Local1 & 0x01000000))
                                        {
                                            If ((TLST > 0x06))
                                            {
                                                TLST = One
                                            }

                                            Local0 = TLST /* \_SB_.PCI0.VGA_.TLST */
                                            Local1 = (Local0 << 0x08)
                                            Local1 |= One
                                            DBG8 = TLST /* \_SB_.PCI0.VGA_.TLST */
                                            Return (Local1)
                                        }
                                        Else
                                        {
                                            If ((Local1 == Zero))
                                            {
                                                Local0 = DSM5 /* \_SB_.PCI0.VGA_.DSM5 */
                                                Return (Local0)
                                            }
                                        }
                                    }
                                    Else
                                    {
                                        If ((_T_0 == 0x06))
                                        {
                                            Return (Package (0x0F)
                                            {
                                                0x0110, 
                                                0x2C, 
                                                0x80000100, 
                                                0x2C, 
                                                0x0110, 
                                                0x80000100, 
                                                0x2C, 
                                                0x80087330, 
                                                0x2C, 
                                                0x0110, 
                                                0x80087330, 
                                                0x2C, 
                                                0x80000100, 
                                                0x80087330, 
                                                0x2C
                                            })
                                        }
                                        Else
                                        {
                                            If ((_T_0 == 0x0C)) {}
                                            Else
                                            {
                                                If ((_T_0 == 0x0D)) {}
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                Return (Zero)
            }
        }

        Method (HDVG, 0, NotSerialized)
        {
            If ((HGAP == One))
            {
                HGCA ()
                HGCD ()
                \CADL |= One
                \CADL &= 0xFF
                CSTE &= 0xFF
            }
            Else
            {
                QATH = One
                ^^SBRG.EC0.EV80 ()
                Local0 = 0x01F4
                While (Local0)
                {
                    If (QATH)
                    {
                        Sleep (0x0A)
                        Local0--
                    }
                    Else
                    {
                        Local0 = Zero
                    }
                }
            }

            \CADL &= 0x0FFF
            CSTE &= 0x0FFF
            If (UPDN)
            {
                NXTD = MD2A (CSTE)
                UPDN = Zero
            }

            Local1 = MD2A (\CADL)
            Local0 = Zero
            While ((NXTD != Local0))
            {
                NXTD++
                If ((NXTD == 0x0B))
                {
                    NXTD++
                }

                If ((NXTD == 0x13))
                {
                    NXTD++
                }

                If ((NXTD > 0x18))
                {
                    NXTD = One
                }

                Local0 = (NXTD & Local1)
            }

            Return (NXTD) /* \_SB_.PCI0.VGA_.NXTD */
        }

        Name (AWHG, Package (0x13)
        {
            Zero, 
            One, 
            0x02, 
            0x03, 
            0x04, 
            0x05, 
            0x06, 
            0x07, 
            0x04, 
            0x05, 
            0x06, 
            0x0B, 
            0x0C, 
            0x0D, 
            0x0E, 
            0x0F, 
            0x04, 
            0x05, 
            0x06
        })
        Method (HWHG, 1, Serialized)
        {
            Local0 = MA2D (NXTD)
            UPDN = One
            Local1 = DerefOf (Index (AWHG, Arg0))
            If ((HGAP == One))
            {
                DBG8 = 0x55
                If ((Local0 & HDIM))
                {
                    TGPU (0x02)
                    Sleep (0x2AF8)
                }
            }

            DONE = Zero
            TLST = Local1
            ^^SBRG.EC0.EV80 ()
            Local0 = 0x01F4
            While (Local0)
            {
                If (DONE)
                {
                    Local0 = Zero
                }
                Else
                {
                    Sleep (0x0A)
                    Local0--
                }
            }

            Sleep (0x64)
        }

        Method (RSTO, 0, NotSerialized)
        {
            OperationRegion (PEGR, SystemMemory, 0xC0008000, 0x0100)
            Field (PEGR, ByteAcc, NoLock, Preserve)
            {
                PREG,   2048
            }

            Local0 = RAMB /* \RAMB */
            Local0 += 0x0200
            OperationRegion (PEGS, SystemMemory, Local0, 0x0100)
            Field (PEGS, ByteAcc, NoLock, Preserve)
            {
                PSAR,   2048
            }

            PREG = PSAR /* \_SB_.PCI0.VGA_.RSTO.PSAR */
            Sleep (0xC8)
            OperationRegion (VGAR, SystemMemory, 0xC0100000, 0x0100)
            Field (VGAR, ByteAcc, NoLock, Preserve)
            {
                VREG,   2048
            }

            Local0 = RAMB /* \RAMB */
            Local0 += 0x0300
            OperationRegion (VGAS, SystemMemory, Local0, 0x0100)
            Field (VGAS, ByteAcc, NoLock, Preserve)
            {
                VSAR,   2048
            }

            VREG = VSAR /* \_SB_.PCI0.VGA_.RSTO.VSAR */
            OperationRegion (HDAR, SystemMemory, 0xC0101000, 0x0100)
            Field (HDAR, ByteAcc, NoLock, Preserve)
            {
                HREG,   2048
            }

            Local0 = RAMB /* \RAMB */
            Local0 += 0x0400
            OperationRegion (HDAS, SystemMemory, Local0, 0x0100)
            Field (HDAS, ByteAcc, NoLock, Preserve)
            {
                HSAR,   2048
            }

            HREG = HSAR /* \_SB_.PCI0.VGA_.RSTO.HSAR */
        }

        Method (SAVO, 0, NotSerialized)
        {
            OperationRegion (PEGR, SystemMemory, 0xC0008000, 0x0100)
            Field (PEGR, ByteAcc, NoLock, Preserve)
            {
                PREG,   2048
            }

            Local0 = RAMB /* \RAMB */
            Local0 += 0x0200
            OperationRegion (PEGS, SystemMemory, Local0, 0x0100)
            Field (PEGS, ByteAcc, NoLock, Preserve)
            {
                PSAR,   2048
            }

            PSAR = PREG /* \_SB_.PCI0.VGA_.SAVO.PREG */
            OperationRegion (VGAR, SystemMemory, 0xC0100000, 0x0100)
            Field (VGAR, ByteAcc, NoLock, Preserve)
            {
                VREG,   2048
            }

            Local0 = RAMB /* \RAMB */
            Local0 += 0x0300
            OperationRegion (VGAS, SystemMemory, Local0, 0x0100)
            Field (VGAS, ByteAcc, NoLock, Preserve)
            {
                VSAR,   2048
            }

            VSAR = VREG /* \_SB_.PCI0.VGA_.SAVO.VREG */
            OperationRegion (HDAR, SystemMemory, 0xC0101000, 0x0100)
            Field (HDAR, ByteAcc, NoLock, Preserve)
            {
                HREG,   2048
            }

            Local0 = RAMB /* \RAMB */
            Local0 += 0x0400
            OperationRegion (HDAS, SystemMemory, Local0, 0x0100)
            Field (HDAS, ByteAcc, NoLock, Preserve)
            {
                HSAR,   2048
            }

            HSAR = HREG /* \_SB_.PCI0.VGA_.SAVO.HREG */
        }

        OperationRegion (VSID, PCI_Config, Zero, 0x04)
        Field (VSID, ByteAcc, NoLock, Preserve)
        {
            REG0,   32
        }

        Name (BLAC, Package (0x10) {})
        OperationRegion (IGDM, SystemMemory, 0xBDD820E4, 0x2000)
        Field (IGDM, AnyAcc, NoLock, Preserve)
        {
            SIGN,   128, 
            SIZE,   32, 
            OVER,   32, 
            SVER,   256, 
            VVER,   128, 
            GVER,   128, 
            MBOX,   32, 
            Offset (0xF0), 
            IBTT,   4, 
            IPSC,   2, 
            IPAT,   4, 
            IBIA,   3, 
            IBLC,   2, 
            Offset (0xF2), 
            ITVF,   4, 
            ITVM,   4, 
                ,   1, 
            IDVS,   2, 
            ISSC,   1, 
            Offset (0xF4), 
            Offset (0xFC), 
            SBUD,   1, 
            Offset (0x100), 
            DRDY,   32, 
            CSTS,   32, 
            CEVT,   32, 
            Offset (0x120), 
            DIDL,   32, 
            DDL2,   32, 
            DDL3,   32, 
            DDL4,   32, 
            DDL5,   32, 
            DDL6,   32, 
            DDL7,   32, 
            DDL8,   32, 
            CPDL,   32, 
            CPL2,   32, 
            CPL3,   32, 
            CPL4,   32, 
            CPL5,   32, 
            CPL6,   32, 
            CPL7,   32, 
            CPL8,   32, 
            CADL,   32, 
            CAL2,   32, 
            CAL3,   32, 
            CAL4,   32, 
            CAL5,   32, 
            CAL6,   32, 
            CAL7,   32, 
            CAL8,   32, 
            NADL,   32, 
            NDL2,   32, 
            NDL3,   32, 
            NDL4,   32, 
            NDL5,   32, 
            NDL6,   32, 
            NDL7,   32, 
            NDL8,   32, 
            ASLP,   32, 
            TIDX,   32, 
            CHPD,   32, 
            CLID,   32, 
            CDCK,   32, 
            SXSW,   32, 
            EVTS,   32, 
            CNOT,   32, 
            NRDY,   32, 
            Offset (0x200), 
            SCIE,   1, 
            GEFC,   4, 
            GXFC,   3, 
            GESF,   8, 
            SCIC,   16, 
            PARM,   32, 
            DSLP,   32, 
            Offset (0x300), 
            ARDY,   32, 
            ASLC,   32, 
            TCHE,   32, 
            ALSI,   32, 
            BCLP,   32, 
            PFIT,   32, 
            CBLV,   32, 
            BCLM,   320, 
            CPFM,   32, 
            EPFM,   32, 
            Offset (0x400), 
            GVD1,   57344
        }

        OperationRegion (TCOI, SystemIO, TOBS, 0x08)
        Field (TCOI, WordAcc, NoLock, Preserve)
        {
            Offset (0x04), 
                ,   9, 
            SCIS,   1, 
            Offset (0x06)
        }

        Name (DBTB, Package (0x15)
        {
            Zero, 
            0x07, 
            0x38, 
            0x01C0, 
            0x0E00, 
            0x3F, 
            0x01C7, 
            0x0E07, 
            0x01F8, 
            0x0E38, 
            0x0FC0, 
            Zero, 
            Zero, 
            Zero, 
            Zero, 
            Zero, 
            0x7000, 
            0x7007, 
            0x7038, 
            0x71C0, 
            0x7E00
        })
        Method (GSCI, 0, NotSerialized)
        {
            If ((GEFC == 0x04))
            {
                GXFC = GBDA ()
            }

            If ((GEFC == 0x06))
            {
                GXFC = SBCB ()
            }

            SCIS = One
            GEFC = Zero
            GSSE = Zero
            SCIE = Zero
            Return (Zero)
        }

        Name (OPBS, 0xFFFFFF00)
        Method (OPTS, 1, NotSerialized)
        {
            If ((VGAF & One))
            {
                If ((Arg0 == 0x03))
                {
                    OPBS = ASLS /* \_SB_.PCI0.VGA_.ASLS */
                }
            }
        }

        Method (OWAK, 1, NotSerialized)
        {
            If ((VGAF & One))
            {
                If ((Arg0 == 0x03))
                {
                    ASLS = OPBS /* \_SB_.PCI0.VGA_.OPBS */
                    GSES = One
                }

                CLID = One
            }
        }

        Method (OGCD, 0, NotSerialized)
        {
            If ((CADL == Zero))
            {
                CSTE = 0x0808
                Return (Zero)
            }

            CSTE = OA2D (CADL)
            If ((CAL2 == Zero))
            {
                Return (Zero)
            }

            CSTE |= OA2D (CAL2) /* \CSTE */
            If ((CAL3 == Zero))
            {
                Return (Zero)
            }

            CSTE |= OA2D (CAL3) /* \CSTE */
            If ((CAL4 == Zero))
            {
                Return (Zero)
            }

            CSTE |= OA2D (CAL4) /* \CSTE */
            If ((CAL5 == Zero))
            {
                Return (Zero)
            }

            CSTE |= OA2D (CAL5) /* \CSTE */
            If ((CAL6 == Zero))
            {
                Return (Zero)
            }

            CSTE |= OA2D (CAL6) /* \CSTE */
            If ((CAL7 == Zero))
            {
                Return (Zero)
            }

            CSTE |= OA2D (CAL7) /* \CSTE */
            If ((CAL8 == Zero))
            {
                Return (Zero)
            }

            CSTE |= OA2D (CAL8) /* \CSTE */
        }

        Method (OGCA, 0, NotSerialized)
        {
            If ((CPDL == Zero))
            {
                \CADL = 0x0808
                Return (Zero)
            }

            \CADL = OA2D (CPDL)
            If ((CPL2 == Zero))
            {
                Return (Zero)
            }

            \CADL |= OA2D (CPL2)
            If ((CPL3 == Zero))
            {
                Return (Zero)
            }

            \CADL |= OA2D (CPL3)
            If ((CPL4 == Zero))
            {
                Return (Zero)
            }

            \CADL |= OA2D (CPL4)
            If ((CPL5 == Zero))
            {
                Return (Zero)
            }

            \CADL |= OA2D (CPL5)
            If ((CPL6 == Zero))
            {
                Return (Zero)
            }

            \CADL |= OA2D (CPL6)
            If ((CPL7 == Zero))
            {
                Return (Zero)
            }

            \CADL |= OA2D (CPL7)
            If ((CPL8 == Zero))
            {
                Return (Zero)
            }

            \CADL |= OA2D (CPL8)
        }

        Method (OA2D, 1, NotSerialized)
        {
            Local0 = Zero
            If ((Arg0 == 0x0410))
            {
                Local0 |= LCDM /* \_SB_.PCI0.VGA_.LCDM */
            }

            If ((Arg0 == 0x0100))
            {
                Local0 |= CRTM /* \_SB_.PCI0.VGA_.CRTM */
            }

            If ((Arg0 == 0x0240))
            {
                Local0 |= TVOM /* \_SB_.PCI0.VGA_.TVOM */
            }

            If ((Arg0 == 0x7320))
            {
                Local0 |= HDMM /* \HDMM */
            }

            If ((Arg0 == 0x8320))
            {
                Local0 |= HDMM /* \HDMM */
            }

            If ((Arg0 == 0x0321))
            {
                Local0 |= DVIM /* \_SB_.PCI0.VGA_.DVIM */
            }

            Return (Local0)
        }

        Name (LIDF, Zero)
        Method (LIDE, 1, NotSerialized)
        {
            If ((DRDY != Zero))
            {
                CLID = Arg0
                LIDF = Zero
            }
            Else
            {
                LIDF = One
            }

            Return (GNOT (0x02, Zero))
        }

        Method (GBDA, 0, NotSerialized)
        {
            If ((GESF == Zero))
            {
                PARM = 0x0279
                GESF = Zero
                Return (SUCC) /* \SUCC */
            }

            If ((GESF == One))
            {
                PARM = 0x0240
                GESF = Zero
                Return (SUCC) /* \SUCC */
            }

            If ((GESF == 0x04))
            {
                PARM &= 0xEFFF0000
                PARM &= (DerefOf (Index (DBTB, IBTT)) << 0x10)
                PARM |= IBTT /* \_SB_.PCI0.VGA_.PARM */
                GESF = Zero
                Return (SUCC) /* \SUCC */
            }

            If ((GESF == 0x05))
            {
                PARM = IPSC /* \_SB_.PCI0.VGA_.IPSC */
                PARM |= (IPAT << 0x08)
                PARM += 0x0100
                If (CLID)
                {
                    PARM |= 0x00020000
                }
                Else
                {
                    PARM |= 0x00010000
                }

                PARM |= (IBIA << 0x14)
                GESF = Zero
                Return (SUCC) /* \SUCC */
            }

            If ((GESF == 0x06))
            {
                PARM = ITVF /* \_SB_.PCI0.VGA_.ITVF */
                PARM |= (ITVM << 0x04)
                GESF = Zero
                Return (SUCC) /* \SUCC */
            }

            If ((GESF == 0x07))
            {
                Name (MEMS, 0x11)
                PARM = GIVD /* \_SB_.PCI0.VGA_.GIVD */
                PARM ^= One
                PARM |= (GMFN << One)
                PARM |= 0x1800
                PARM |= (CDCT << 0x15) /* \_SB_.PCI0.VGA_.PARM */
                If ((TASM <= M512))
                {
                    IDVS = One
                }
                Else
                {
                    If ((TASM <= M1GB))
                    {
                        IDVS = One
                    }
                    Else
                    {
                        If ((TASM <= 0x18))
                        {
                            If ((IDVS == 0x03))
                            {
                                IDVS = 0x02
                            }
                        }
                    }
                }

                PARM |= (IDVS << MEMS)
                GESF = One
                Return (SUCC) /* \SUCC */
            }

            If ((GESF == 0x0A))
            {
                PARM = Zero
                If (ISSC)
                {
                    PARM |= 0x03
                }

                GESF = Zero
                Return (SUCC) /* \SUCC */
            }

            GESF = Zero
            Return (CRIT) /* \CRIT */
        }

        Method (SBCB, 0, NotSerialized)
        {
            If ((GESF == Zero))
            {
                PARM = 0x60
                GESF = Zero
                Return (SUCC) /* \SUCC */
            }

            If ((GESF == One))
            {
                GESF = Zero
                PARM = Zero
                Return (SUCC) /* \SUCC */
            }

            If ((GESF == 0x03))
            {
                GESF = Zero
                PARM = Zero
                Return (SUCC) /* \SUCC */
            }

            If ((GESF == 0x04))
            {
                GESF = Zero
                PARM = Zero
                Return (SUCC) /* \SUCC */
            }

            If ((GESF == 0x05))
            {
                GESF = Zero
                PARM = Zero
                Return (SUCC) /* \SUCC */
            }

            If ((GESF == 0x06))
            {
                Local0 = (PARM >> 0x1C)
                If ((Local0 == Zero))
                {
                    ITVF = (PARM & 0x0F)
                    ITVM = (PARM & 0xF0)
                }

                SBUD = One
                GESF = Zero
                PARM = Zero
                Return (SUCC) /* \SUCC */
            }

            If ((GESF == 0x07))
            {
                If ((LIDF != Zero))
                {
                    Local0 = GLID ()
                    LIDE (Local0)
                    LIDF = Zero
                }

                SCIC &= 0x03FE
                GESF = Zero
                PARM = Zero
                Return (SUCC) /* \SUCC */
            }

            If ((GESF == 0x08))
            {
                GESF = Zero
                PARM = Zero
                Return (SUCC) /* \SUCC */
            }

            If ((GESF == 0x09))
            {
                IBTT = (PARM & 0xFF)
                GESF = Zero
                PARM = Zero
                Return (SUCC) /* \SUCC */
            }

            If ((GESF == 0x0A))
            {
                Local0 = (PARM >> 0x1C)
                If ((Local0 == Zero))
                {
                    IPSC = (PARM & 0xFF)
                    IPAT = (((PARM >> 0x08) & 0xFF) - One)
                    IBLC = ((PARM >> 0x12) & 0x03)
                    IBIA = ((PARM >> 0x14) & 0x07)
                }

                GESF = Zero
                PARM = Zero
                Return (SUCC) /* \SUCC */
            }

            If ((GESF == 0x0B))
            {
                If ((((PARM >> 0x0B) & 0x03) == 0x02))
                {
                    Local0 = ((PARM >> 0x11) & 0x0F)
                    If (Local0)
                    {
                        IDVS = Local0
                    }
                }

                GESF = Zero
                PARM = Zero
                Return (SUCC) /* \SUCC */
            }

            If ((GESF == 0x10))
            {
                GESF = Zero
                PARM = Zero
                Return (SUCC) /* \SUCC */
            }

            If ((GESF == 0x11))
            {
                PARM = (LIDS << 0x08)
                PARM += 0x0100
                GESF = Zero
                Return (SUCC) /* \SUCC */
            }

            If ((GESF == 0x12))
            {
                If ((PARM & One))
                {
                    If (((PARM >> One) == One))
                    {
                        ISSC = One
                    }
                    Else
                    {
                        GESF = Zero
                        Return (CRIT) /* \CRIT */
                    }
                }
                Else
                {
                    ISSC = Zero
                }

                GESF = Zero
                PARM = Zero
                Return (SUCC) /* \SUCC */
            }

            If ((GESF == 0x13))
            {
                GESF = Zero
                PARM = Zero
                Return (SUCC) /* \SUCC */
            }

            GESF = Zero
            Return (SUCC) /* \SUCC */
        }

        Scope (^^PCI0)
        {
            OperationRegion (MCHP, PCI_Config, 0x40, 0xC0)
            Field (MCHP, AnyAcc, NoLock, Preserve)
            {
                Offset (0x60), 
                TASM,   10, 
                Offset (0x62)
            }
        }

        OperationRegion (IGDP, PCI_Config, 0x40, 0xC0)
        Field (IGDP, AnyAcc, NoLock, Preserve)
        {
            Offset (0x12), 
                ,   1, 
            GIVD,   1, 
                ,   2, 
            GUMA,   3, 
            Offset (0x14), 
                ,   4, 
            GMFN,   1, 
            Offset (0x18), 
            Offset (0x8C), 
            CDCT,   10, 
            Offset (0x8E), 
            Offset (0xA4), 
            ASLE,   8, 
            Offset (0xA8), 
            GSSE,   1, 
            GSSB,   14, 
            GSES,   1, 
            Offset (0xB5), 
            LBPC,   8, 
            Offset (0xBC), 
            ASLS,   32
        }

        Name (M512, 0x04)
        Name (M1GB, 0x08)
        Method (PDRD, 0, NotSerialized)
        {
            If (!DRDY)
            {
                Sleep (ASLP)
            }

            Return (!DRDY)
        }

        Method (PSTS, 0, NotSerialized)
        {
            If ((CSTS > 0x02))
            {
                Sleep (ASLP)
            }

            Return ((CSTS == 0x03))
        }

        Method (OSYS, 0, NotSerialized)
        {
            Local1 = 0x07D0
            If (CondRefOf (_OSI, Local0))
            {
                If (_OSI ("Linux"))
                {
                    Local1 = One
                }

                If (_OSI ("Windows 2001"))
                {
                    Local1 = 0x07D1
                }

                If (_OSI ("Windows 2001 SP1"))
                {
                    Local1 = 0x07D1
                }

                If (_OSI ("Windows 2001 SP2"))
                {
                    Local1 = 0x07D2
                }

                If (_OSI ("Windows 2006"))
                {
                    Local1 = 0x07D6
                }
            }

            Return (Local1)
        }

        Method (GNOT, 2, NotSerialized)
        {
            If (PDRD ())
            {
                Return (One)
            }

            CEVT = Arg0
            CSTS = 0x03
            If (((CHPD == Zero) && (Arg1 == Zero)))
            {
                If (((OSYS () > 0x07D0) || (OSYS () < 0x07D6)))
                {
                    Notify (PCI0, Arg1)
                }
                Else
                {
                    Notify (VGA, Arg1)
                }
            }

            Notify (VGA, 0x80) // Status Change
            Return (Zero)
        }

        Method (GHDS, 1, NotSerialized)
        {
            TIDX = Arg0
            Return (GNOT (One, Zero))
        }

        Method (GDCK, 1, NotSerialized)
        {
            CDCK = Arg0
            Return (GNOT (0x04, Zero))
        }

        Method (PARD, 0, NotSerialized)
        {
            If (!ARDY)
            {
                Sleep (ASLP)
            }

            Return (!ARDY)
        }

        Method (AINT, 2, NotSerialized)
        {
            If (!(TCHE & (One << Arg0)))
            {
                Return (One)
            }

            If (PARD ())
            {
                Return (One)
            }

            If ((Arg0 == 0x02))
            {
                If (CPFM)
                {
                    Local0 = (CPFM & 0x0F)
                    Local1 = (EPFM & 0x0F)
                    If ((Local0 == One))
                    {
                        If ((Local1 & 0x06))
                        {
                            PFIT = 0x06
                        }
                        Else
                        {
                            If ((Local1 & 0x08))
                            {
                                PFIT = 0x08
                            }
                            Else
                            {
                                PFIT = One
                            }
                        }
                    }

                    If ((Local0 == 0x06))
                    {
                        If ((Local1 & 0x08))
                        {
                            PFIT = 0x08
                        }
                        Else
                        {
                            If ((Local1 & One))
                            {
                                PFIT = One
                            }
                            Else
                            {
                                PFIT = 0x06
                            }
                        }
                    }

                    If ((Local0 == 0x08))
                    {
                        If ((Local1 & One))
                        {
                            PFIT = One
                        }
                        Else
                        {
                            If ((Local1 & 0x06))
                            {
                                PFIT = 0x06
                            }
                            Else
                            {
                                PFIT = 0x08
                            }
                        }
                    }
                }
                Else
                {
                    PFIT ^= 0x07
                }

                PFIT |= 0x80000000
                ASLC = 0x04
            }
            Else
            {
                If ((Arg0 == One))
                {
                    BCLP = ((Arg1 * 0xFF) / 0x64)
                    BCLP |= 0x80000000
                    ASLC = 0x02
                }
                Else
                {
                    If ((Arg0 == Zero))
                    {
                        ALSI = Arg1
                        ASLC = One
                    }
                    Else
                    {
                        Return (One)
                    }
                }
            }

            LBPC = Zero
            Return (Zero)
        }

        Scope (\_GPE)
        {
            Method (_L06, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
            {
                \_SB.PCI0.VGA.GSCI ()
            }
        }

        Method (PRST, 0, NotSerialized)
        {
            If ((REG0 == Ones))
            {
                Return (Zero)
            }
            Else
            {
                Return (One)
            }
        }

        Name (LCDM, 0x0101)
        Name (CRTM, 0x0202)
        Name (TVOM, 0x0808)
        Name (DVIM, 0x4040)
        Name (HDIM, 0x0404)
        Name (DOSF, One)
        Name (BRNC, Zero)
        Name (UPDN, One)
        Name (NXTD, One)
        Method (MD2A, 1, NotSerialized)
        {
            Local0 = Zero
            If ((Arg0 & LCDM))
            {
                Local0 |= One
            }

            If ((Arg0 & CRTM))
            {
                Local0 |= 0x02
            }

            If ((Arg0 & TVOM))
            {
                Local0 |= 0x04
            }

            If ((Arg0 & DVIM))
            {
                Local0 |= 0x10
            }

            If ((Arg0 & HDIM))
            {
                Local0 |= 0x08
            }

            If (!Local0)
            {
                Return (NXTD) /* \_SB_.PCI0.VGA_.NXTD */
            }

            Return (Local0)
        }

        Method (MA2D, 1, NotSerialized)
        {
            Local0 = Zero
            If ((Arg0 & One))
            {
                Local0 |= LCDM /* \_SB_.PCI0.VGA_.LCDM */
            }

            If ((Arg0 & 0x02))
            {
                Local0 |= CRTM /* \_SB_.PCI0.VGA_.CRTM */
            }

            If ((Arg0 & 0x04))
            {
                Local0 |= TVOM /* \_SB_.PCI0.VGA_.TVOM */
            }

            If ((Arg0 & 0x10))
            {
                Local0 |= DVIM /* \_SB_.PCI0.VGA_.DVIM */
            }

            If ((Arg0 & 0x08))
            {
                Local0 |= HDIM /* \_SB_.PCI0.VGA_.HDIM */
            }

            If (!Local0)
            {
                Return (LCDM) /* \_SB_.PCI0.VGA_.LCDM */
            }

            Return (Local0)
        }

        Method (_DOS, 1, NotSerialized)  // _DOS: Disable Output Switching
        {
            DOSF = (Arg0 & 0x03)
            BRNC = (Arg0 >> 0x02)
            BRNC &= One
        }

        Method (_DOD, 0, NotSerialized)  // _DOD: Display Output Devices
        {
            Return (Package (0x03)
            {
                0x0110, 
                0x80000100, 
                0x80087330
            })
        }

        Device (CRTD)
        {
            Name (_ADR, 0x0100)  // _ADR: Address
            Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
            {
                Return (One)
            }

            Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
            {
                HGAP = One
                DONE = One
            }
        }

        Method (MXDS, 1, NotSerialized)
        {
            If ((Arg0 & Zero))
            {
                Return (!HLMX)
            }
            Else
            {
                HLMX = Zero
                HCMX = Zero
                SGPL (0x34, One, One)
                ^^SBRG.EC0.SPIN (0x1F, Zero)
                Sleep (0x64)
            }
        }

        Method (MXMX, 1, NotSerialized)
        {
            HLMM = One
            HCMM = One
            HDMM = One
            HHMM = One
            HLMX = Zero
            HCMX = Zero
            HDMX = Zero
            HHMX = Zero
            SGPL (0x07, One, One)
            Return (One)
        }

        Device (LCDD)
        {
            Name (_ADR, 0x0110)  // _ADR: Address
            Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
            {
                Return (One)
            }

            Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
            {
                HGAP = One
                DONE = One
                ^^^SBRG.EC0.SPIN (0x11, One)
                If ((RGPL (0x34, One) == One))
                {
                    ^^^SBRG.EC0.SPIN (0x1F, Zero)
                }
                Else
                {
                    ^^^SBRG.EC0.SPIN (0x1F, One)
                }
            }

            Method (_BCL, 0, NotSerialized)  // _BCL: Brightness Control Levels
            {
                Local0 = Zero
                While ((Local0 <= 0x0F))
                {
                    Local3 = (0x0F - Local0)
                    Local1 = DerefOf (Index (^^^SBRG.EC0.PWAC, Local3))
                    Local2 = ((Local1 * 0x64) / 0xFF)
                    Index (BLAC, Local0) = Local2
                    Local3 = DerefOf (Index (BLAC, Local0))
                    Local0++
                }

                Return (BLAC) /* \_SB_.PCI0.VGA_.BLAC */
            }

            Name (BCBH, Zero)
            Name (OSDD, One)
            Method (_BCM, 1, NotSerialized)  // _BCM: Brightness Control Method
            {
                BCMD = One
                Local0 = GCBL (Arg0)
                LBTN = (0x0F - Local0)
                ^^^SBRG.EC0.STBR ()
                If (ATKP)
                {
                    If ((BCBH == One))
                    {
                        Notify (ATKD, (LBTN + 0x10))
                    }

                    If ((BCBH == 0x02))
                    {
                        Notify (ATKD, (LBTN + 0x20))
                    }
                }

                BCBH = Zero
            }

            Method (_BQC, 0, NotSerialized)  // _BQC: Brightness Query Current
            {
                Return (LBTN) /* \LBTN */
            }
        }

        Method (GCBL, 1, NotSerialized)
        {
            Local0 = Zero
            Arg0 &= 0x7FFFFFFF
            While ((Local0 < 0x0F))
            {
                Local1 = DerefOf (Index (BLAC, Local0))
                If ((Local1 == Arg0))
                {
                    Break
                }

                Local0++
            }

            Return (Local0)
        }

        Device (HDMI)
        {
            Method (_ADR, 0, NotSerialized)  // _ADR: Address
            {
                Return (0x7330)
            }

            Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
            {
                Return (One)
            }

            Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
            {
                HGAP = One
                DONE = One
            }
        }

        Method (SWHD, 1, Serialized)
        {
            HWHG (Arg0)
        }

        Method (ADVD, 0, NotSerialized)
        {
            Return (One)
        }

        Name (BCMD, Zero)
        Method (UPBL, 0, NotSerialized)
        {
            If ((HGAP == One))
            {
                If ((LBTN < 0x0F))
                {
                    LBTN++
                }
                Else
                {
                    LBTN = 0x0F
                }

                If ((OSFG == OSEG))
                {
                    BCMM (LBTN)
                }
                Else
                {
                    Notify (LCDD, 0x86) // Device-Specific
                }

                If (ATKP)
                {
                    Notify (ATKD, (LBTN + 0x10))
                }
            }
        }

        Method (DWBL, 0, NotSerialized)
        {
            If ((HGAP == One))
            {
                If ((LBTN > Zero))
                {
                    LBTN--
                }

                If ((LBTN > 0x0F))
                {
                    LBTN = 0x0F
                }

                If ((OSFG == OSEG))
                {
                    BCMM (LBTN)
                }
                Else
                {
                    Notify (LCDD, 0x87) // Device-Specific
                }

                If (ATKP)
                {
                    Notify (ATKD, (LBTN + 0x20))
                }
            }
        }

        Method (BCMM, 1, NotSerialized)
        {
            If ((OSFG >= OSVT))
            {
                If ((Arg0 < 0x10))
                {
                    LBTN = (Arg0 & 0x0F)
                }

                ^^SBRG.EC0.STBR ()
                If (ATKP)
                {
                    If ((^LCDD.OSDD == One))
                    {
                        If ((^LCDD.BCBH == One))
                        {
                            Notify (ATKD, (LBTN + 0x10))
                        }

                        If ((^LCDD.BCBH == 0x02))
                        {
                            Notify (ATKD, (LBTN + 0x20))
                        }
                    }
                }

                ^LCDD.BCBH = Zero
            }
        }

        Method (HGCD, 0, NotSerialized)
        {
            If ((CADL == Zero))
            {
                CSTE = 0x0101
                Return (Zero)
            }

            CSTE = HA2D (CADL)
            If ((CAL2 == Zero))
            {
                Return (Zero)
            }

            CSTE |= HA2D (CAL2) /* \CSTE */
            If ((CAL3 == Zero))
            {
                Return (Zero)
            }

            CSTE |= HA2D (CAL3) /* \CSTE */
            If ((CAL4 == Zero))
            {
                Return (Zero)
            }

            CSTE |= HA2D (CAL4) /* \CSTE */
            If ((CAL5 == Zero))
            {
                Return (Zero)
            }

            CSTE |= HA2D (CAL5) /* \CSTE */
            If ((CAL6 == Zero))
            {
                Return (Zero)
            }

            CSTE |= HA2D (CAL6) /* \CSTE */
            If ((CAL7 == Zero))
            {
                Return (Zero)
            }

            CSTE |= HA2D (CAL7) /* \CSTE */
            If ((CAL8 == Zero))
            {
                Return (Zero)
            }

            CSTE |= HA2D (CAL8) /* \CSTE */
        }

        Method (HGCA, 0, NotSerialized)
        {
            If ((CPDL == Zero))
            {
                \CADL = 0x0101
                Return (Zero)
            }

            \CADL = HA2D (CPDL)
            If ((CPL2 == Zero))
            {
                Return (Zero)
            }

            \CADL |= HA2D (CPL2)
            If ((CPL3 == Zero))
            {
                Return (Zero)
            }

            \CADL |= HA2D (CPL3)
            If ((CPL4 == Zero))
            {
                Return (Zero)
            }

            \CADL |= HA2D (CPL4)
            If ((CPL5 == Zero))
            {
                Return (Zero)
            }

            \CADL |= HA2D (CPL5)
            If ((CPL6 == Zero))
            {
                Return (Zero)
            }

            \CADL |= HA2D (CPL6)
            If ((CPL7 == Zero))
            {
                Return (Zero)
            }

            \CADL |= HA2D (CPL7)
            If ((CPL8 == Zero))
            {
                Return (Zero)
            }

            \CADL |= HA2D (CPL8)
        }

        Method (HA2D, 1, NotSerialized)
        {
            Local0 = Zero
            If ((Arg0 == 0x0110))
            {
                Local0 |= LCDM /* \_SB_.PCI0.VGA_.LCDM */
            }

            If ((Arg0 == 0x0100))
            {
                Local0 |= CRTM /* \_SB_.PCI0.VGA_.CRTM */
            }

            Return (Local0)
        }
    }

    Scope (_SB.PCI0.VGA)
    {
        Method (NATK, 0, NotSerialized)
        {
            Return (One)
        }

        Name (HHKM, One)
        Method (HHKW, 0, Serialized)
        {
            While (!HHKM)
            {
                Sleep (0x64)
            }

            HHKM = Zero
        }

        Method (HHKS, 0, Serialized)
        {
            HHKM = One
        }

        Method (TGPU, 1, NotSerialized)
        {
            HHKW ()
            HGDP = Arg0
            Local0 = Zero
            Local0 += Arg0
            DSM2 = Local0
            Notify (VGA, 0xD0) // Hardware-Specific
            Local0 = 0x1E
            While (Local0)
            {
                DBG8 = Local0
                If ((HGAP != Arg0))
                {
                    Sleep (0x01F4)
                    Local0--
                }
                Else
                {
                    Local0 = Zero
                }
            }

            DSM2 = Zero
            HHKS ()
        }
    }

    Scope (_SB.PCI0.P0P1)
    {
        Method (_STA, 0, Serialized)  // _STA: Status
        {
            If ((D1EN == One))
            {
                Return (0x0F)
            }

            Return (Zero)
        }

        Method (DEJ0, 0, Serialized)
        {
            ^^VGA.ASP0 ()
            CLKD |= 0x21
            LCRB = One
            DQDA = One
            LCRB = Zero
            Local0 = 0x64
            While (Local0)
            {
                Sleep (0x0A)
                Local0--
                If ((LNKS == Zero))
                {
                    Local0 = Zero
                }
            }

            SGPL (0x14, One, Zero)
            Sleep (0x0A)
            SGPL (0x22, One, One)
            Sleep (0x32)
            D1EN = Zero
            Notify (P0P1, Zero) // Bus Check
        }

        OperationRegion (PEGM, SystemMemory, 0xC0008000, 0x0300)
        Field (PEGM, ByteAcc, NoLock, Preserve)
        {
            REG0,   32, 
            REG1,   32, 
            REG2,   32, 
            Offset (0x19), 
            RE19,   8, 
            RE1A,   8, 
            Offset (0x3E), 
            RE3E,   8, 
            Offset (0x84), 
            PWST,   2, 
            Offset (0xB0), 
                ,   4, 
            GRRL,   1, 
            Offset (0xB2), 
            Offset (0xB3), 
                ,   3, 
            LTST,   1, 
            RSCC,   1, 
            Offset (0xB4), 
                ,   6, 
            HPCP,   1, 
            SPLV,   8, 
            SPLS,   2, 
                ,   2, 
            PHSN,   13, 
            Offset (0x114), 
            T0V0,   1, 
            TV0M,   7, 
            Offset (0x201), 
                ,   5, 
            CGEL,   2, 
                ,   3, 
            LCRB,   1, 
            Offset (0x204), 
            RETO,   10, 
            Offset (0x214), 
            Offset (0x216), 
            LNKS,   4, 
            Offset (0x220), 
            R220,   32, 
            Offset (0x225), 
            DQDA,   1, 
            Offset (0x226), 
            R224,   32
        }
    }

    Scope (_SB.PCI0.P0P1.VGA)
    {
        Name (LCDM, One)
        Name (CRTM, 0x02)
        Name (HDMM, 0x08)
        Method (_ROM, 2, NotSerialized)  // _ROM: Read-Only Memory
        {
            Local0 = (Arg0 + RAMB) /* \RAMB */
            Local0 += 0x0500
            Local1 = (Arg1 << 0x03)
            Name (VBUF, Buffer (Arg1) {})
            OperationRegion (VROM, SystemMemory, Local0, Local1)
            Field (VROM, ByteAcc, NoLock, Preserve)
            {
                ROMI,   65536
            }

            VBUF = ROMI /* \_SB_.PCI0.P0P1.VGA_._ROM.ROMI */
            Return (VBUF) /* \_SB_.PCI0.P0P1.VGA_._ROM.VBUF */
        }

        Method (_ON, 0, NotSerialized)  // _ON_: Power On
        {
            If ((D1EN == Zero))
            {
                D1EN = One
                RE19 = Zero
                RE1A = Zero
                PWST = Zero
                SGPL (0x14, One, Zero)
                Sleep (0x64)
                SGPL (0x22, One, Zero)
                Sleep (0x6E)
                SGPL (0x14, One, One)
                Sleep (0x64)
                ^^^SBRG.EC0.SPIN (0x11, One)
                DQDA = Zero
                ^^^VGA.ASP0 ()
                Sleep (0x64)
                Local1 = 0x03
                While (Local1)
                {
                    Local1--
                    If ((LNKS == 0x07))
                    {
                        Local1 = Zero
                    }
                    Else
                    {
                        Local0 = 0x64
                        While (Local0)
                        {
                            Sleep (0x0A)
                            Local0--
                            If ((LNKS == 0x07))
                            {
                                Local0 = Zero
                            }
                        }

                        If ((Local1 && (LNKS != 0x07)))
                        {
                            GRRL = One
                            Sleep (0x6E)
                        }
                    }
                }

                If ((LNKS != 0x07))
                {
                    DBG8 = 0xEA
                }

                Sleep (0x64)
                ^^^VGA.RSTO ()
                ISMI (0xAB)
                T0V0 = ^^T0V0 /* \_SB_.PCI0.P0P1.T0V0 */
                TV0M = ^^TV0M /* \_SB_.PCI0.P0P1.TV0M */
                Sleep (0x64)
                HPWR = One
                Notify (P0P1, Zero) // Bus Check
            }
        }

        Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
        {
            DEJ0 ()
            HPWR = Zero
        }

        Method (_STA, 0, Serialized)  // _STA: Status
        {
            If ((REG0 != Ones))
            {
                Return (0x0F)
            }

            Return (Zero)
        }

        Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
        {
            Return (^^^VGA._DSM (Arg0, Arg1, Arg2, Arg3))
        }

        OperationRegion (VSID, PCI_Config, Zero, 0x0100)
        Field (VSID, ByteAcc, NoLock, Preserve)
        {
            REG0,   32, 
            REG1,   32, 
            REG2,   32, 
            REG3,   32, 
            REG4,   32, 
            REG5,   32, 
            REG6,   32, 
            REG7,   32, 
            REG8,   32, 
            REG9,   32, 
            REGA,   32, 
            REGB,   32, 
            REGC,   32, 
            REGD,   32, 
            REGE,   32, 
            REGF,   32, 
            REGG,   32
        }

        OperationRegion (VVID, SystemMemory, 0xE0100114, 0x10)
        Field (VVID, ByteAcc, NoLock, Preserve)
        {
            T0V0,   1, 
            TV0M,   7
        }

        Name (BLAC, Package (0x10) {})
        Method (PRST, 0, NotSerialized)
        {
            If ((REG0 == Ones))
            {
                Return (Zero)
            }
            Else
            {
                Return (One)
            }
        }

        Name (UPDN, One)
        Name (NXTD, One)
        Name (DONE, Zero)
        Name (DOSF, One)
        Name (BRNC, Zero)
        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
        }

        Method (_DOS, 1, NotSerialized)  // _DOS: Disable Output Switching
        {
            DOSF = (Arg0 & 0x03)
            BRNC = (Arg0 >> 0x02)
            BRNC &= One
        }

        Method (_DOD, 0, NotSerialized)  // _DOD: Display Output Devices
        {
            Return (Package (0x03)
            {
                0x80087330, 
                0x0110, 
                0x80000100
            })
        }

        Method (MXDS, 1, NotSerialized)
        {
            If ((Arg0 & Zero))
            {
                Return (HLMX) /* \HLMX */
            }
            Else
            {
                HLMX = One
                HCMX = One
                SGPL (0x34, One, Zero)
                Sleep (0x64)
                ^^^SBRG.EC0.SPIN (0x1F, One)
            }
        }

        Method (MXMX, 1, NotSerialized)
        {
            HLMM = One
            HCMM = One
            \HDMM = One
            HHMM = One
            HLMX = One
            HCMX = One
            HDMX = One
            HHMX = One
            SGPL (0x07, One, Zero)
            Return (One)
        }

        Device (LCDD)
        {
            Method (_ADR, 0, NotSerialized)  // _ADR: Address
            {
                Return (0x0110)
            }

            Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
            {
                If (((OSFG == OSVT) || (OSFG == OSW7)))
                {
                    Return (One)
                }
                Else
                {
                    Local0 = AVLD /* \AVLD */
                    If (Local0)
                    {
                        If ((Local0 & LCDM))
                        {
                            Return (0x1F)
                        }
                    }

                    Return (0x1D)
                }
            }

            Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
            {
                Local0 = (NXTD & LCDM) /* \_SB_.PCI0.P0P1.VGA_.LCDM */
                If (Local0)
                {
                    Return (One)
                }

                Return (Zero)
            }

            Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
            {
                If (((OSFG == OSVT) || (OSFG == OSW7)))
                {
                    HGAP = 0x02
                    DONE = One
                    If ((RGPL (0x34, One) == One))
                    {
                        ^^^^SBRG.EC0.SPIN (0x1F, Zero)
                    }
                    Else
                    {
                        ^^^^SBRG.EC0.SPIN (0x1F, One)
                    }
                }
                Else
                {
                    If ((Arg0 & 0x40000000))
                    {
                        If ((Arg0 & 0x80000000))
                        {
                            DONE = One
                        }
                    }
                }
            }

            Method (_BCL, 0, NotSerialized)  // _BCL: Brightness Control Levels
            {
                Local0 = Zero
                While ((Local0 <= 0x0F))
                {
                    Local3 = (0x0F - Local0)
                    Local1 = DerefOf (Index (^^^^SBRG.EC0.PWAC, Local3))
                    Local2 = ((Local1 * 0x64) / 0xFF)
                    Index (BLAC, Local0) = Local2
                    Local3 = DerefOf (Index (BLAC, Local0))
                    Local0++
                }

                Return (BLAC) /* \_SB_.PCI0.P0P1.VGA_.BLAC */
            }

            Name (BCBH, Zero)
            Name (OSDD, One)
            Method (_BCM, 1, NotSerialized)  // _BCM: Brightness Control Method
            {
                If ((OSFG >= OSVT))
                {
                    Local0 = GCBL (Arg0)
                    LBTN = (0x0F - Local0)
                    ^^^^SBRG.EC0.STBR ()
                    If (ATKP)
                    {
                        If ((OSDD == One))
                        {
                            If ((BCBH == One))
                            {
                                Notify (ATKD, (LBTN + 0x10))
                            }

                            If ((BCBH == 0x02))
                            {
                                Notify (ATKD, (LBTN + 0x20))
                            }
                        }
                    }

                    BCBH = Zero
                }
            }

            Method (_BQC, 0, NotSerialized)  // _BQC: Brightness Query Current
            {
                Return (LBTN) /* \LBTN */
            }
        }

        Method (GCBL, 1, NotSerialized)
        {
            Local0 = Zero
            Arg0 &= 0x7FFFFFFF
            While ((Local0 < 0x0F))
            {
                Local1 = DerefOf (Index (BLAC, Local0))
                If ((Local1 == Arg0))
                {
                    Break
                }

                Local0++
            }

            Return (Local0)
        }

        Device (CRTD)
        {
            Name (_ADR, 0x0100)  // _ADR: Address
            Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
            {
                If (((OSFG == OSVT) || (OSFG == OSW7)))
                {
                    Return (One)
                }
                Else
                {
                    Local0 = AVLD /* \AVLD */
                    If (Local0)
                    {
                        If ((Local0 & CRTM))
                        {
                            Return (0x1F)
                        }
                    }

                    Return (0x1D)
                }
            }

            Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
            {
                Local0 = (NXTD & CRTM) /* \_SB_.PCI0.P0P1.VGA_.CRTM */
                If (Local0)
                {
                    Return (One)
                }

                Return (Zero)
            }

            Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
            {
                If (((OSFG == OSVT) || (OSFG == OSW7)))
                {
                    HGAP = 0x02
                    DONE = One
                }
                Else
                {
                    If ((Arg0 & 0x40000000))
                    {
                        If ((Arg0 & 0x80000000))
                        {
                            DONE = One
                        }
                    }
                }
            }
        }

        Device (HDMI)
        {
            Method (_ADR, 0, NotSerialized)  // _ADR: Address
            {
                Return (0x7330)
            }

            Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
            {
                If (((OSFG == OSVT) || (OSFG == OSW7)))
                {
                    Return (One)
                }
                Else
                {
                    Local0 = AVLD /* \AVLD */
                    If (Local0)
                    {
                        If ((Local0 & HDMM))
                        {
                            Return (0x1F)
                        }
                    }

                    Return (0x1D)
                }
            }

            Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
            {
                Local0 = (NXTD & HDMM) /* \_SB_.PCI0.P0P1.VGA_.HDMM */
                If (Local0)
                {
                    Return (One)
                }

                Return (Zero)
            }

            Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
            {
                If (((OSFG == OSVT) || (OSFG == OSW7)))
                {
                    HGAP = 0x02
                    DONE = One
                }
                Else
                {
                    If ((Arg0 & 0x40000000))
                    {
                        If ((Arg0 & 0x80000000))
                        {
                            DONE = One
                        }
                    }
                }
            }
        }

        Method (SWHD, 1, Serialized)
        {
            UPDN = One
            If ((DOSF == One))
            {
                SETD = Arg0
                ISMI (0x94)
            }
            Else
            {
                If (((OSFG == OSVT) || (OSFG == OSW7)))
                {
                    ^^^VGA.HWHG (Arg0)
                }
                Else
                {
                    NXTD = Arg0
                    SETD = Arg0
                    DONE = Zero
                    Notify (VGA, 0x80) // Status Change
                    Local0 = 0x01F4
                    While (Local0)
                    {
                        If (DONE)
                        {
                            Local0 = Zero
                        }
                        Else
                        {
                            Sleep (0x0A)
                            Local0--
                        }
                    }
                }
            }
        }

        Method (ADVD, 0, NotSerialized)
        {
            If (((OSFG == OSEG) || (OSFG == OSW7)))
            {
                Return (Zero)
            }
            Else
            {
                If (UPDN)
                {
                    ISMI (0x95)
                    SETD = ACTD /* \ACTD */
                    UPDN = Zero
                }

                ISMI (0xA0)
                NXTD = SETD /* \SETD */
                Return (SETD) /* \SETD */
            }
        }

        Method (UPBL, 0, NotSerialized)
        {
            If ((HGAP == One))
            {
                If ((OSFG != OSEG))
                {
                    Notify (^^^VGA.LCDD, 0x86) // Device-Specific
                }
            }
            Else
            {
                If ((HGAP == 0x02))
                {
                    Notify (LCDD, 0x86) // Device-Specific
                }
            }
        }

        Method (DWBL, 0, NotSerialized)
        {
            If ((HGAP == One))
            {
                If ((OSFG != OSEG))
                {
                    Notify (^^^VGA.LCDD, 0x87) // Device-Specific
                }
            }
            Else
            {
                If ((HGAP == 0x02))
                {
                    Notify (LCDD, 0x87) // Device-Specific
                }
            }
        }

        Method (NATK, 0, NotSerialized)
        {
            Return (One)
        }
    }

    Scope (_SB)
    {
        Device (LID)
        {
            Name (_HID, EisaId ("PNP0C0D") /* Lid Device */)  // _HID: Hardware ID
            Method (_LID, 0, NotSerialized)  // _LID: Lid Status
            {
                Local0 = One
                Local0 = ^^PCI0.SBRG.EC0.RPIN (0x06)
                If ((Local0 == Ones))
                {
                    Local0 = One
                }

                Return (Local0)
            }
        }
    }

    Scope (_GPE)
    {
    }

    Scope (_SB.PCI0.SBRG.EC0)
    {
        Method (_Q83, 0, NotSerialized)  // _Qxx: EC Query
        {
            Notify (LID, 0x80) // Status Change
            If ((VGAF & One))
            {
                Local0 = GLID ()
                ^^^VGA.LIDE (Local0)
            }

            If (^^^VGA.PRST ())
            {
                ^^^VGA.LCDD.BCBH = Zero
            }

            If (^^^P0P1.VGA.PRST ())
            {
                ^^^P0P1.VGA.LCDD.BCBH = Zero
            }
        }
    }

    Scope (\)
    {
        Method (ENFN, 1, Serialized)
        {
            Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
            _T_0 = Arg0
            If ((_T_0 == 0x0D))
            {
                If ((LKDV & One))
                {
                    Return (Zero)
                }

                \_SB.PCI0.SBRG.EC0.ST87 (0x40, 0x03)
                Return (One)
            }
            Else
            {
                If ((_T_0 == 0x0F))
                {
                    If ((LKDV & 0x02))
                    {
                        Return (Zero)
                    }

                    Local0 = 0x15
                    FDRT = (FDRT & ~(One << Local0))
                    Return (One)
                }
                Else
                {
                    If ((_T_0 == 0x11))
                    {
                        If ((LKDV & 0x04))
                        {
                            Return (Zero)
                        }

                        Local0 = 0x11
                        FDRT = (FDRT & ~(One << Local0))
                        Return (One)
                    }
                    Else
                    {
                        If ((_T_0 == 0x13))
                        {
                            If ((LKDV & 0x08))
                            {
                                Return (Zero)
                            }

                            Local0 = 0x04
                            FDRT = (FDRT & ~(One << Local0))
                            Return (One)
                        }
                        Else
                        {
                            If ((_T_0 == 0x15))
                            {
                                If ((LKDV & 0x10))
                                {
                                    Return (Zero)
                                }

                                PRWE = One
                                Local0 = 0x0A
                                UPDO = (UPDO & ~(One << Local0))
                                PRWE = Zero
                                Return (One)
                            }
                            Else
                            {
                                If ((_T_0 == 0x17))
                                {
                                    If ((LKDV & 0x20))
                                    {
                                        Return (Zero)
                                    }

                                    PRWE = One
                                    Local0 = 0x06
                                    UPDO = (UPDO & ~(One << Local0))
                                    PRWE = Zero
                                    Return (One)
                                }
                                Else
                                {
                                    If ((_T_0 == 0x19))
                                    {
                                        If ((LKDV & 0x40))
                                        {
                                            Return (Zero)
                                        }

                                        Return (0x02)
                                    }
                                    Else
                                    {
                                        If ((_T_0 == 0x1B))
                                        {
                                            If ((LKDV & 0x80))
                                            {
                                                Return (Zero)
                                            }

                                            Return (0x02)
                                        }
                                        Else
                                        {
                                            If ((_T_0 == 0x1D))
                                            {
                                                If ((LKDV & 0x0100))
                                                {
                                                    Return (Zero)
                                                }

                                                Return (0x02)
                                            }
                                            Else
                                            {
                                                If ((_T_0 == 0x1F))
                                                {
                                                    If ((LKDV & 0x0200))
                                                    {
                                                        Return (Zero)
                                                    }

                                                    Return (0x02)
                                                }
                                                Else
                                                {
                                                    If ((_T_0 == 0x21))
                                                    {
                                                        If ((LKDV & 0x0400))
                                                        {
                                                            Return (Zero)
                                                        }

                                                        Return (0x02)
                                                    }
                                                    Else
                                                    {
                                                        If ((_T_0 == 0x37))
                                                        {
                                                            Notify (\_SB.PCI0, Zero) // Bus Check
                                                            Return (One)
                                                        }
                                                        Else
                                                        {
                                                            If ((_T_0 == 0x80))
                                                            {
                                                                If (LDFT)
                                                                {
                                                                    Return (Zero)
                                                                }
                                                                Else
                                                                {
                                                                    Return (One)
                                                                }
                                                            }
                                                            Else
                                                            {
                                                                If ((_T_0 == 0xFD))
                                                                {
                                                                    ESTF = Zero
                                                                    Return (One)
                                                                }
                                                                Else
                                                                {
                                                                    If ((_T_0 == 0xFE))
                                                                    {
                                                                        ESTF = 0x05
                                                                        Return (One)
                                                                    }
                                                                    Else
                                                                    {
                                                                        If ((_T_0 == 0xFF))
                                                                        {
                                                                            ESTF = 0x05
                                                                            EMNM = FBFG /* \FBFG */
                                                                            FBFG |= 0x10
                                                                            Return (One)
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Return (Zero)
        }

        Method (ACPS, 0, Serialized)
        {
            Local0 = \_SB.PCI0.SBRG.EC0.RPIN (0x03)
            Local0 ^= One
            Return (Local0)
        }

        Name (LCDB, Zero)
        Name (GPA6, Zero)
        Method (PRJS, 1, Serialized)
        {
            If ((Arg0 >= 0x03))
            {
                GPA6 = \_SB.PCI0.SBRG.EC0.RPIN (0x1F)
                \_SB.PCI0.SBRG.EC0.SPIN (0x1F, Zero)
            }

            If (((Arg0 == 0x03) && TRBR))
            {
                \_SB.PCI0.SBRG.EC0.WKTM (One)
                \_SB.PCI0.SBRG.EC0.WKFG (0x02)
                Local0 = \_SB.PCI0.SBRG.EC0.RPIN (0x1C)
                Local0 = !Local0
                \_SB.PCI0.SBRG.EC0.SPIN (0x1C, Local0)
                If (!Local0)
                {
                    OCST = One
                }
                Else
                {
                    OCST = 0x02
                    \_SB.PCI0.SBRG.EC0.ST87 (0x20, 0x71)
                    \_SB.PCI0.SBRG.EC0.ST87 (0x20, 0x60)
                    \_SB.PCI0.SBRG.EC0.ST87 (0x40, 0x73)
                }
            }
        }

        Method (PRJW, 1, Serialized)
        {
            If (((Arg0 == 0x03) && TRBR))
            {
                Local0 = \_SB.PCI0.SBRG.EC0.RPIN (0x1C)
                If (!Local0)
                {
                    \_SB.PCI0.SBRG.EC0.ST87 (0x40, 0x12)
                    \_SB.PCI0.SBRG.EC0.ST87 (0x40, 0x71)
                    \_SB.PCI0.SBRG.EC0.ST87 (0x40, 0x60)
                    \_SB.PCI0.SBRG.EC0.ST87 (0x40, 0x73)
                }
                Else
                {
                }

                TRBR = Zero
            }

            If ((Arg0 == 0x03))
            {
                \_SB.PCI0.SBRG.EC0.SPIN (0x1F, GPA6)
            }

            \_SB.PCI0.SBRG.EC0.STBR ()
            \_SB.PCI0.SBRG.EC0.SPIN (0x12, One)
        }

        Method (GLID, 0, Serialized)
        {
            Return (\_SB.PCI0.SBRG.EC0.RPIN (0x06))
        }

        Method (TLID, 0, Serialized)
        {
        }

        Method (TGAC, 0, Serialized)
        {
        }

        Method (TGDC, 1, Serialized)
        {
        }

        Method (FCTR, 3, Serialized)
        {
        }

        Method (OWLD, 1, Serialized)
        {
            WRST = Arg0
            If (WMDP)
            {
                If (Arg0)
                {
                    SGPL (0x11, One, Arg0)
                }
                Else
                {
                    If (WMST) {}
                    Else
                    {
                        SGPL (0x11, One, Arg0)
                    }
                }
            }
            Else
            {
                SGPL (0x11, One, Arg0)
            }

            If (((\_SB.ATKD.WAPF && 0x05) == Zero))
            {
                SGPL (0x2E, One, Arg0)
            }
        }

        Method (OBTD, 1, Serialized)
        {
            BRST = Arg0
            SGPL (0x1B, One, Arg0)
            SGPL (0x1C, One, Arg0)
        }

        Method (OTGD, 1, Serialized)
        {
            TGST = Arg0
            If (Arg0)
            {
                Local0 = \_SB.PCI0.SBRG.EC0.ST87 (0x40, 0xFF)
            }
            Else
            {
                Local0 = \_SB.PCI0.SBRG.EC0.ST87 (0x20, 0xFF)
            }

            Return (One)
        }

        Method (OWMD, 1, Serialized)
        {
            WMST = Arg0
            If (Arg0)
            {
                SGPL (0x11, One, Arg0)
            }
            Else
            {
                If (WRST) {}
                Else
                {
                    SGPL (0x11, One, Arg0)
                }
            }

            Return (One)
        }

        Method (OHWR, 0, Serialized)
        {
            Local0 = Zero
            If (\_SB.PCI0.P0P3.WLAN.MPDP ())
            {
                Local0 |= 0x80
            }

            If (BTDP)
            {
                Local0 |= 0x0100
            }

            If (TGDP)
            {
                Local0 |= 0x40
            }

            If (WMDP)
            {
                Local0 |= 0x10
            }

            Return (Local0)
        }

        Method (ORST, 0, Serialized)
        {
            Local0 = Zero
            If (WLDP)
            {
                If (WRST)
                {
                    Local0 |= One
                }
            }

            If (BTDP)
            {
                If (BRST)
                {
                    Local0 |= 0x02
                }
            }

            If (TGDP)
            {
                If (TGST)
                {
                    Local0 |= 0x20
                }
            }

            If (WMDP)
            {
                If (WMST)
                {
                    Local0 |= 0x08
                }
            }

            Return (Local0)
        }

        Method (ODWR, 0, Serialized)
        {
            Local0 = Zero
            Local0 |= 0x08
            Return (Local0)
        }

        Method (OQDC, 0, Serialized)
        {
            Local0 = 0x02
            Return (Local0)
        }

        Method (OQDG, 0, Serialized)
        {
            Local0 = 0x02
            Return (Local0)
        }

        Method (OQDS, 0, Serialized)
        {
            Local0 = 0x02
            Return (Local0)
        }

        Method (OQDM, 0, Serialized)
        {
            Local0 = 0x02
            If (\_SB.PCI0.SBRG.EC0.RPIN (0x1B))
            {
                Local0 = Zero
            }
            Else
            {
                Local0 = One
            }

            Return (Local0)
        }

        Method (ONDC, 0, Serialized)
        {
            Return (Zero)
        }

        Method (ONDG, 0, Serialized)
        {
            Return (Zero)
        }

        Method (ONDS, 0, Serialized)
        {
            Return (Zero)
        }

        Method (ONDM, 0, Serialized)
        {
            \_SB.PCI0.SBRG.EC0.SPIN (0x1B, Zero)
            Return (One)
        }

        Method (OFDC, 0, Serialized)
        {
            Return (Zero)
        }

        Method (OFDG, 0, Serialized)
        {
            Return (Zero)
        }

        Method (OFDS, 0, Serialized)
        {
            Return (Zero)
        }

        Method (OFDM, 0, Serialized)
        {
            \_SB.PCI0.SBRG.EC0.SPIN (0x1B, One)
            Return (One)
        }

        Method (GBTL, 0, Serialized)
        {
            Return (\_SB.PCI0.SBRG.EC0.RPIN (0x02))
        }

        Method (SBTL, 1, Serialized)
        {
            \_SB.PCI0.SBRG.EC0.SPIN (0x02, Arg0)
        }

        Method (BL2C, 0, NotSerialized)
        {
            Return (Zero)
        }

        Method (STCF, 1, Serialized)
        {
            If ((Arg0 == One))
            {
                \_SB.PCI0.SBRG.EC0.FNCT (0x84, Zero)
            }
        }

        Method (OTGB, 0, Serialized)
        {
            Local0 = One
            Return (Local0)
        }

        Method (ODTS, 0, Serialized)
        {
            Local0 = DTS1 /* \DTS1 */
            If ((DTS2 > Local0))
            {
                Local0 = DTS2 /* \DTS2 */
            }

            Local1 = \_TZ.RTMP ()
            Local2 = \_SB.PCI0.SBRG.EC0.RRAM (0x0509)
            Local3 = (Local0 - Local1)
            If ((Local3 > 0x0F00))
            {
                Local4 = Zero
                Local4 -= 0x05
                If ((Local3 < Local4))
                {
                    Local3 = Local4
                }
            }
            Else
            {
                If ((Local3 > 0x05))
                {
                    Local3 = 0x05
                }
            }

            Local2 += Local3
            Local2 &= 0xFF
            \_SB.PCI0.SBRG.EC0.WRAM (0x0509, Local2)
            Sleep (0x0190)
        }

        Method (OBID, 0, Serialized)
        {
            Local0 = Zero
            Return (Local0)
        }

        Name (DP87, Package (0x07)
        {
            0xFF, 
            0xFF, 
            0xFF, 
            0xFF, 
            0xFF, 
            0x03, 
            0xFF
        })
        Method (GDPS, 1, Serialized)
        {
            OperationRegion (\M182, SystemMemory, Arg0, 0x10)
            Field (M182, DWordAcc, NoLock, Preserve)
            {
                Offset (0x08), 
                DNUM,   8, 
                DSTS,   8
            }

            Local0 = DerefOf (Index (DP87, DNUM))
            Local0 = \_SB.PCI0.SBRG.EC0.ST87 (Zero, Local0)
            If ((Local0 == Zero))
            {
                DSTS = One
            }
            Else
            {
                DSTS = Zero
            }
        }
    }

    Scope (_GPE)
    {
        Method (_L0B, 0, Serialized)  // _Lxx: Level-Triggered GPE
        {
            If (PMEW)
            {
                Notify (\_SB.PCI0.P0P8, 0x02) // Device Wake
                Notify (\_SB.PCI0.P0P3, 0x02) // Device Wake
                PMEW = Zero
            }
            Else
            {
            }

            If (\_SB.PCI0.P0P8.GLAN.PMES)
            {
                Notify (\_SB.PCI0.P0P8.GLAN, 0x02) // Device Wake
                \_SB.PCI0.P0P8.GLAN.PMES = One
            }
        }
    }

    Scope (_SB.PCI0.SBRG.EC0)
    {
    }

    Scope (\)
    {
        Name (CNTB, Buffer (0x0C)
        {
            /* 0000 */  0xFF, 0x00, 0xFF, 0x00, 0xFF, 0xFF, 0xFF, 0x00,  /* ........ */
            /* 0008 */  0xFF, 0x00, 0xFF, 0x00                           /* .... */
        })
        Name (VISB, Buffer (0x0C)
        {
            /* 0000 */  0x01, 0x00, 0x01, 0x00, 0x01, 0x01, 0x00, 0x00,  /* ........ */
            /* 0008 */  0x00, 0x00, 0x00, 0x00                           /* .... */
        })
        Name (SHPB, Buffer (0x0C)
        {
            /* 0000 */  0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07,  /* ........ */
            /* 0008 */  0x07, 0x07, 0x07, 0x07                           /* .... */
        })
        Name (BUPC, Package (0x04)
        {
            0xFF, 
            Zero, 
            Zero, 
            Zero
        })
        Name (BPLD, Buffer (0x10)
        {
             0x81, 0x00, 0x31, 0x00                           /* ..1. */
        })
        Method (OUPC, 1, Serialized)
        {
            Local0 = DerefOf (Index (CNTB, Arg0))
            Index (BUPC, Zero) = Local0
        }

        Method (OPLD, 1, Serialized)
        {
            Local0 = DerefOf (Index (VISB, Arg0))
            Local1 = DerefOf (Index (BPLD, 0x08))
            Local1 &= 0xFE
            Local1 |= Local0
            Index (BPLD, 0x08) = Local1
            Local0 = DerefOf (Index (SHPB, Arg0))
            Local1 = DerefOf (Index (BPLD, 0x09))
            Local1 &= 0xC3
            Local1 |= Local0
            Index (BPLD, 0x09) = Local1
        }
    }

    Scope (_SB.PCI0.EUSB)
    {
        Device (RHUB)
        {
            Name (_ADR, Zero)  // _ADR: Address
            Device (PRT0)
            {
                Name (_ADR, One)  // _ADR: Address
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    OUPC (Zero)
                    Return (BUPC) /* \BUPC */
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    OPLD (Zero)
                    Return (BPLD) /* \BPLD */
                }
            }

            Device (PRT1)
            {
                Name (_ADR, 0x02)  // _ADR: Address
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    OUPC (One)
                    Return (BUPC) /* \BUPC */
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    OPLD (One)
                    Return (BPLD) /* \BPLD */
                }
            }

            Device (PRT2)
            {
                Name (_ADR, 0x03)  // _ADR: Address
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    OUPC (0x02)
                    Return (BUPC) /* \BUPC */
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    OPLD (0x02)
                    Return (BPLD) /* \BPLD */
                }
            }

            Device (PRT3)
            {
                Name (_ADR, 0x04)  // _ADR: Address
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    OUPC (0x03)
                    Return (BUPC) /* \BUPC */
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    OPLD (0x03)
                    Return (BPLD) /* \BPLD */
                }
            }

            Device (PRT4)
            {
                Name (_ADR, 0x05)  // _ADR: Address
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    OUPC (0x04)
                    Return (BUPC) /* \BUPC */
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    OPLD (0x04)
                    Return (BPLD) /* \BPLD */
                }
            }

            Device (PRT5)
            {
                Name (_ADR, 0x06)  // _ADR: Address
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    OUPC (0x05)
                    Return (BUPC) /* \BUPC */
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    OPLD (0x05)
                    Return (BPLD) /* \BPLD */
                }
            }
        }
    }

    Scope (_SB.PCI0.USBE)
    {
        Device (RHUB)
        {
            Name (_ADR, Zero)  // _ADR: Address
            Device (PRT0)
            {
                Name (_ADR, One)  // _ADR: Address
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    OUPC (0x06)
                    Return (BUPC) /* \BUPC */
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    OPLD (0x06)
                    Return (BPLD) /* \BPLD */
                }
            }

            Device (PRT1)
            {
                Name (_ADR, 0x02)  // _ADR: Address
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    OUPC (0x07)
                    Return (BUPC) /* \BUPC */
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    OPLD (0x07)
                    Return (BPLD) /* \BPLD */
                }
            }

            Device (PRT2)
            {
                Name (_ADR, 0x03)  // _ADR: Address
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    OUPC (0x08)
                    Return (BUPC) /* \BUPC */
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    OPLD (0x08)
                    Return (BPLD) /* \BPLD */
                }
            }

            Device (PRT3)
            {
                Name (_ADR, 0x04)  // _ADR: Address
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    OUPC (0x09)
                    Return (BUPC) /* \BUPC */
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    OPLD (0x09)
                    Return (BPLD) /* \BPLD */
                }
            }

            Device (PRT4)
            {
                Name (_ADR, 0x05)  // _ADR: Address
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    OUPC (0x0A)
                    Return (BUPC) /* \BUPC */
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    OPLD (0x0A)
                    Return (BPLD) /* \BPLD */
                }
            }

            Device (PRT5)
            {
                Name (_ADR, 0x06)  // _ADR: Address
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    OUPC (0x0B)
                    Return (BUPC) /* \BUPC */
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    OPLD (0x0B)
                    Return (BPLD) /* \BPLD */
                }
            }
        }
    }

    Scope (_SB.PCI0.USB0)
    {
        Device (RHUB)
        {
            Name (_ADR, Zero)  // _ADR: Address
            Device (PRT0)
            {
                Name (_ADR, One)  // _ADR: Address
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    OUPC (Zero)
                    Return (BUPC) /* \BUPC */
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    OPLD (Zero)
                    Return (BPLD) /* \BPLD */
                }
            }

            Device (PRT1)
            {
                Name (_ADR, 0x02)  // _ADR: Address
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    OUPC (One)
                    Return (BUPC) /* \BUPC */
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    OPLD (One)
                    Return (BPLD) /* \BPLD */
                }
            }
        }
    }

    Scope (_SB.PCI0.USB1)
    {
        Device (RHUB)
        {
            Name (_ADR, Zero)  // _ADR: Address
            Device (PRT0)
            {
                Name (_ADR, One)  // _ADR: Address
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    OUPC (0x02)
                    Return (BUPC) /* \BUPC */
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    OPLD (0x02)
                    Return (BPLD) /* \BPLD */
                }
            }

            Device (PRT1)
            {
                Name (_ADR, 0x02)  // _ADR: Address
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    OUPC (0x03)
                    Return (BUPC) /* \BUPC */
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    OPLD (0x03)
                    Return (BPLD) /* \BPLD */
                }
            }
        }
    }

    Scope (_SB.PCI0.USB2)
    {
        Device (RHUB)
        {
            Name (_ADR, Zero)  // _ADR: Address
            Device (PRT0)
            {
                Name (_ADR, One)  // _ADR: Address
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    OUPC (0x04)
                    Return (BUPC) /* \BUPC */
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    OPLD (0x04)
                    Return (BPLD) /* \BPLD */
                }
            }

            Device (PRT1)
            {
                Name (_ADR, 0x02)  // _ADR: Address
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    OUPC (0x05)
                    Return (BUPC) /* \BUPC */
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    OPLD (0x05)
                    Return (BPLD) /* \BPLD */
                }
            }
        }
    }

    Scope (_SB.PCI0.USB3)
    {
        Device (RHUB)
        {
            Name (_ADR, Zero)  // _ADR: Address
            Device (PRT0)
            {
                Name (_ADR, One)  // _ADR: Address
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    OUPC (0x06)
                    Return (BUPC) /* \BUPC */
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    OPLD (0x06)
                    Return (BPLD) /* \BPLD */
                }
            }

            Device (PRT1)
            {
                Name (_ADR, 0x02)  // _ADR: Address
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    OUPC (0x07)
                    Return (BUPC) /* \BUPC */
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    OPLD (0x07)
                    Return (BPLD) /* \BPLD */
                }
            }
        }
    }

    Scope (_SB.PCI0.USB4)
    {
        Device (RHUB)
        {
            Name (_ADR, Zero)  // _ADR: Address
            Device (PRT0)
            {
                Name (_ADR, One)  // _ADR: Address
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    OUPC (0x08)
                    Return (BUPC) /* \BUPC */
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    OPLD (0x08)
                    Return (BPLD) /* \BPLD */
                }
            }

            Device (PRT1)
            {
                Name (_ADR, 0x02)  // _ADR: Address
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    OUPC (0x09)
                    Return (BUPC) /* \BUPC */
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    OPLD (0x09)
                    Return (BPLD) /* \BPLD */
                }
            }
        }
    }

    Scope (_SB.PCI0.USB6)
    {
        Device (RHUB)
        {
            Name (_ADR, Zero)  // _ADR: Address
            Device (PRT0)
            {
                Name (_ADR, One)  // _ADR: Address
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    OUPC (0x0A)
                    Return (BUPC) /* \BUPC */
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    OPLD (0x0A)
                    Return (BPLD) /* \BPLD */
                }
            }

            Device (PRT1)
            {
                Name (_ADR, 0x02)  // _ADR: Address
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    OUPC (0x0B)
                    Return (BUPC) /* \BUPC */
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    OPLD (0x0B)
                    Return (BPLD) /* \BPLD */
                }
            }
        }
    }

    Scope (_SB)
    {
        Scope (PCI0)
        {
            Name (CRS, ResourceTemplate ()
            {
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                    0x0000,             // Granularity
                    0x0000,             // Range Minimum
                    0x00FF,             // Range Maximum
                    0x0000,             // Translation Offset
                    0x0100,             // Length
                    ,, )
                IO (Decode16,
                    0x0CF8,             // Range Minimum
                    0x0CF8,             // Range Maximum
                    0x01,               // Alignment
                    0x08,               // Length
                    )
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000,             // Granularity
                    0x0000,             // Range Minimum
                    0x0CF7,             // Range Maximum
                    0x0000,             // Translation Offset
                    0x0CF8,             // Length
                    ,, , TypeStatic)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000,             // Granularity
                    0x0D00,             // Range Minimum
                    0xFFFF,             // Range Maximum
                    0x0000,             // Translation Offset
                    0xF300,             // Length
                    ,, , TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000A0000,         // Range Minimum
                    0x000BFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00020000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000C0000,         // Range Minimum
                    0x000DFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00020000,         // Length
                    ,, _Y0F, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x00000000,         // Range Minimum
                    0x00000000,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00000000,         // Length
                    ,, _Y10, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x00000000,         // Range Minimum
                    0x00000000,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00000000,         // Length
                    ,, _Y11, AddressRangeMemory, TypeStatic)
            })
            CreateDWordField (CRS, \_SB.PCI0._Y0F._MIN, MIN5)  // _MIN: Minimum Base Address
            CreateDWordField (CRS, \_SB.PCI0._Y0F._MAX, MAX5)  // _MAX: Maximum Base Address
            CreateDWordField (CRS, \_SB.PCI0._Y0F._LEN, LEN5)  // _LEN: Length
            CreateDWordField (CRS, \_SB.PCI0._Y10._MIN, MIN6)  // _MIN: Minimum Base Address
            CreateDWordField (CRS, \_SB.PCI0._Y10._MAX, MAX6)  // _MAX: Maximum Base Address
            CreateDWordField (CRS, \_SB.PCI0._Y10._LEN, LEN6)  // _LEN: Length
            CreateDWordField (CRS, \_SB.PCI0._Y11._MIN, MIN7)  // _MIN: Minimum Base Address
            CreateDWordField (CRS, \_SB.PCI0._Y11._MAX, MAX7)  // _MAX: Maximum Base Address
            CreateDWordField (CRS, \_SB.PCI0._Y11._LEN, LEN7)  // _LEN: Length
            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Local0 = MG1L /* \MG1L */
                If (Local0)
                {
                    MIN5 = MG1B /* \MG1B */
                    LEN5 = MG1L /* \MG1L */
                    MAX5 = (MIN5 + Local0--)
                }

                MIN6 = MG2B /* \MG2B */
                LEN6 = MG2L /* \MG2L */
                Local0 = MG2L /* \MG2L */
                MAX6 = (MIN6 + Local0--)
                MIN7 = MG3B /* \MG3B */
                LEN7 = MG3L /* \MG3L */
                Local0 = MG3L /* \MG3L */
                MAX7 = (MIN7 + Local0--)
                Return (CRS) /* \_SB_.PCI0.CRS_ */
            }
        }
    }

    Name (WOTB, Zero)
    Name (WSSB, Zero)
    Name (WAXB, Zero)
    Method (_PTS, 1, NotSerialized)  // _PTS: Prepare To Sleep
    {
        DIAG (Arg0)
        PTS (Arg0)
        Index (WAKP, Zero) = Zero
        Index (WAKP, One) = Zero
        If (((Arg0 == 0x04) && (OSFL () == 0x02)))
        {
            Sleep (0x0BB8)
        }

        WSSB = ASSB /* \ASSB */
        WOTB = AOTB /* \AOTB */
        WAXB = AAXB /* \AAXB */
        ASSB = Arg0
        AOTB = OSFL ()
        AAXB = Zero
    }

    Method (_WAK, 1, NotSerialized)  // _WAK: Wake
    {
        DBG8 = (Arg0 << 0x04)
        WAK (Arg0)
        If (ASSB)
        {
            ASSB = WSSB /* \WSSB */
            AOTB = WOTB /* \WOTB */
            AAXB = WAXB /* \WAXB */
        }

        If (DerefOf (Index (WAKP, Zero)))
        {
            Index (WAKP, One) = Zero
        }
        Else
        {
            Index (WAKP, One) = Arg0
        }

        Return (WAKP) /* \WAKP */
    }

    Device (_SB.PCI0.SBRG.TPM)
    {
        Method (_HID, 0, NotSerialized)  // _HID: Hardware ID
        {
            Return (OTID ())
        }

        Name (_CID, EisaId ("PNP0C31"))  // _CID: Compatible ID
        Name (_UID, One)  // _UID: Unique ID
        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            IO (Decode16,
                0x0254,             // Range Minimum
                0x0254,             // Range Maximum
                0x01,               // Alignment
                0x02,               // Length
                )
            IO (Decode16,
                0x4700,             // Range Minimum
                0x4700,             // Range Maximum
                0x01,               // Alignment
                0x00,               // Length
                )
            Memory32Fixed (ReadWrite,
                0xFED40000,         // Address Base
                0x00005000,         // Address Length
                )
        })
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (TPMF)
            {
                Return (0x0F)
            }
            Else
            {
                Return (Zero)
            }
        }

        OperationRegion (\TCMM, SystemMemory, 0xFED40000, 0x5000)
        Field (TCMM, ByteAcc, NoLock, Preserve)
        {
            ACCS,   8, 
            Offset (0xF00), 
            VDID,   32
        }

        Method (OTID, 0, NotSerialized)
        {
            Local0 = ACCS /* \_SB_.PCI0.SBRG.TPM_.ACCS */
            If ((Local0 != 0xFF))
            {
                If ((VDID == 0x687119FA))
                {
                    Return (0x0435CF4D)
                }
                Else
                {
                    If ((VDID == 0x000B15D1))
                    {
                        Return (0x0201D824)
                    }
                    Else
                    {
                        If ((VDID == 0x10208086))
                        {
                            Return ("INTC0102")
                        }
                        Else
                        {
                            Return (0x310CD041)
                        }
                    }
                }
            }
            Else
            {
                Return (0x310CD041)
            }
        }
    }

    Scope (_SB.PCI0.SBRG.TPM)
    {
        Name (TAAX, Zero)
        OperationRegion (MIPT, SystemIO, SMIT, One)
        Field (MIPT, ByteAcc, NoLock, Preserve)
        {
            PSMI,   8
        }

        Name (PPI1, Package (0x02)
        {
            Zero, 
            Zero
        })
        Name (PPI2, Package (0x03)
        {
            Zero, 
            Zero, 
            Zero
        })
        Name (MBUF, Buffer (0x04) {})
        CreateByteField (MBUF, Zero, BUF0)
        CreateByteField (MBUF, One, BUF1)
        CreateByteField (MBUF, 0x02, BUF2)
        CreateByteField (MBUF, 0x03, BUF3)
        Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
        {
            If ((Arg0 == ToUUID ("3dddfaa6-361b-4eb4-a424-8d10089d1653") /* Physical Presence Interface */))
            {
                Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
                _T_0 = ToInteger (Arg2)
                If ((_T_0 == Zero))
                {
                    Return (Buffer (One)
                    {
                         0x7F                                             /* . */
                    })
                }
                Else
                {
                    If ((_T_0 == One))
                    {
                        Return ("1.0")
                    }
                    Else
                    {
                        If ((_T_0 == 0x02))
                        {
                            TAAX = AAXB /* \AAXB */
                            BUF0 = CMRQ /* \CMRQ */
                            BUF1 = 0xF0
                            BUF2 = ToInteger (DerefOf (Index (Arg3, Zero)))
                            BUF3 = One
                            AAXB = MBUF /* \_SB_.PCI0.SBRG.TPM_.MBUF */
                            PSMI = 0xFB
                            Sleep (0x03E8)
                            AAXB = TAAX /* \_SB_.PCI0.SBRG.TPM_.TAAX */
                            Return (Zero)
                        }
                        Else
                        {
                            If ((_T_0 == 0x03))
                            {
                                TAAX = AAXB /* \AAXB */
                                BUF0 = CMRQ /* \CMRQ */
                                BUF1 = 0x0F
                                BUF2 = Zero
                                BUF3 = Zero
                                AAXB = MBUF /* \_SB_.PCI0.SBRG.TPM_.MBUF */
                                PSMI = 0xFB
                                Sleep (0x03E8)
                                MBUF = AAXB /* \AAXB */
                                Local3 = BUF2 /* \_SB_.PCI0.SBRG.TPM_.BUF2 */
                                Index (PPI1, Zero) = Zero
                                Index (PPI1, One) = Local3
                                AAXB = TAAX /* \_SB_.PCI0.SBRG.TPM_.TAAX */
                                Return (PPI1) /* \_SB_.PCI0.SBRG.TPM_.PPI1 */
                            }
                            Else
                            {
                                If ((_T_0 == 0x04))
                                {
                                    Return (0x02)
                                }
                                Else
                                {
                                    If ((_T_0 == 0x05))
                                    {
                                        TAAX = AAXB /* \AAXB */
                                        BUF0 = CMRQ /* \CMRQ */
                                        BUF1 = 0xF0
                                        BUF2 = Zero
                                        BUF3 = Zero
                                        AAXB = MBUF /* \_SB_.PCI0.SBRG.TPM_.MBUF */
                                        PSMI = 0xFB
                                        Sleep (0x03E8)
                                        MBUF = AAXB /* \AAXB */
                                        Local3 = (BUF2 >> 0x04)
                                        BUF0 = CMER /* \CMER */
                                        BUF1 = 0xFF
                                        BUF2 = Zero
                                        BUF3 = Zero
                                        AAXB = MBUF /* \_SB_.PCI0.SBRG.TPM_.MBUF */
                                        PSMI = 0xFB
                                        Sleep (0x03E8)
                                        MBUF = AAXB /* \AAXB */
                                        Local6 = BUF2 /* \_SB_.PCI0.SBRG.TPM_.BUF2 */
                                        Local4 = (CMER + One)
                                        BUF0 = Local4
                                        BUF1 = 0xFF
                                        BUF2 = Zero
                                        BUF3 = Zero
                                        AAXB = MBUF /* \_SB_.PCI0.SBRG.TPM_.MBUF */
                                        PSMI = 0xFB
                                        Sleep (0x03E8)
                                        MBUF = AAXB /* \AAXB */
                                        Local7 = BUF2 /* \_SB_.PCI0.SBRG.TPM_.BUF2 */
                                        Local2 = (Local7 * 0x0100)
                                        Local2 += Local6
                                        Index (PPI2, Zero) = Zero
                                        Index (PPI2, One) = Local3
                                        If ((Local2 == 0xFFF0))
                                        {
                                            Index (PPI2, 0x02) = 0xFFFFFFF0
                                        }
                                        Else
                                        {
                                            If ((Local2 == 0xFFF1))
                                            {
                                                Index (PPI2, 0x02) = 0xFFFFFFF1
                                            }
                                            Else
                                            {
                                                Index (PPI2, 0x02) = Local2
                                            }
                                        }

                                        AAXB = TAAX /* \_SB_.PCI0.SBRG.TPM_.TAAX */
                                        Return (PPI2) /* \_SB_.PCI0.SBRG.TPM_.PPI2 */
                                    }
                                    Else
                                    {
                                        If ((_T_0 == 0x06))
                                        {
                                            Return (Zero)
                                        }
                                        Else
                                        {
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            Else
            {
                If ((Arg0 == ToUUID ("376054ed-cc13-4675-901c-4756d7f2d45d")))
                {
                    Name (_T_1, Zero)  // _T_x: Emitted by ASL Compiler
                    _T_1 = ToInteger (Arg2)
                    If ((_T_1 == Zero))
                    {
                        Return (Buffer (One)
                        {
                             0x03                                             /* . */
                        })
                    }
                    Else
                    {
                        If ((_T_1 == One))
                        {
                            TAAX = AAXB /* \AAXB */
                            BUF0 = CMOR /* \CMOR */
                            BUF1 = 0xFE
                            BUF2 = ToInteger (DerefOf (Index (Arg3, Zero)))
                            BUF3 = One
                            AAXB = MBUF /* \_SB_.PCI0.SBRG.TPM_.MBUF */
                            PSMI = 0xFB
                            Sleep (0x0BB8)
                            AAXB = TAAX /* \_SB_.PCI0.SBRG.TPM_.TAAX */
                            Return (Zero)
                        }
                        Else
                        {
                        }
                    }
                }
            }

            Return (Buffer (One)
            {
                 0x00                                             /* . */
            })
        }
    }

    Name (_S0, Package (0x04)  // _S0_: S0 System State
    {
        Zero, 
        Zero, 
        Zero, 
        Zero
    })
    If (SS1)
    {
        Name (_S1, Package (0x04)  // _S1_: S1 System State
        {
            One, 
            Zero, 
            Zero, 
            Zero
        })
    }

    If (SS3)
    {
        Name (_S3, Package (0x04)  // _S3_: S3 System State
        {
            0x05, 
            Zero, 
            Zero, 
            Zero
        })
    }

    If (SS4)
    {
        Name (_S4, Package (0x04)  // _S4_: S4 System State
        {
            0x06, 
            Zero, 
            Zero, 
            Zero
        })
    }

    Name (_S5, Package (0x04)  // _S5_: S5 System State
    {
        0x07, 
        Zero, 
        Zero, 
        Zero
    })
    Method (PTS, 1, NotSerialized)
    {
        If (Arg0)
        {
            \_SB.PCI0.NPTS (Arg0)
            \_SB.PCI0.SBRG.SPTS (Arg0)
            \_SB.PCI0.VGA.OPTS (Arg0)
            OEMS (Arg0)
        }
    }

    Method (WAK, 1, NotSerialized)
    {
        WDTS (Arg0)
        \_SB.PCI0.NWAK (Arg0)
        \_SB.PCI0.SBRG.SWAK (Arg0)
        \_SB.PCI0.VGA.OWAK (Arg0)
        OEMW (Arg0)
        \_SB.ATKD.GENW (Arg0)
    }
}

