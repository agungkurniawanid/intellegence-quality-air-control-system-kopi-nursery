import { NextRequest, NextResponse } from 'next/server';
import prisma from '@/lib/prisma';

interface SchedulingResult {
    waitingTimes: number[];
    turnAroundTimes: number[];
    avgWaitingTime: number;
    avgTurnAroundTime: number;
}

// Round Robin Algorithm
function roundRobin(processes: string[], burstTimes: number[], timeQuantum: number): SchedulingResult {
    const n = processes.length;
    const remainingTimes = [...burstTimes];
    const waitingTimes = new Array(n).fill(0);
    const turnAroundTimes = new Array(n).fill(0);
    let time = 0;

    while (true) {
        let done = true;

        for (let i = 0; i < n; i++) {
            if (remainingTimes[i] > 0) {
                done = false;
                if (remainingTimes[i] > timeQuantum) {
                    time += timeQuantum;
                    remainingTimes[i] -= timeQuantum;
                } else {
                    time += remainingTimes[i];
                    waitingTimes[i] = time - burstTimes[i];
                    remainingTimes[i] = 0;
                }
            }
        }
        if (done) break;
    }

    for (let i = 0; i < n; i++) {
        turnAroundTimes[i] = burstTimes[i] + waitingTimes[i];
    }

    const avgWaitingTime = waitingTimes.reduce((a, b) => a + b, 0) / n;
    const avgTurnAroundTime = turnAroundTimes.reduce((a, b) => a + b, 0) / n;

    return {
        waitingTimes,
        turnAroundTimes,
        avgWaitingTime,
        avgTurnAroundTime
    };
}

function firstComeFirstServe(processes: string[], burstTimes: number[]): SchedulingResult {
    const n = processes.length;
    const waitingTimes = new Array(n).fill(0);
    const turnAroundTimes = new Array(n).fill(0);
    
    waitingTimes[0] = 0;
    
    for (let i = 1; i < n; i++) {
        waitingTimes[i] = waitingTimes[i-1] + burstTimes[i-1];
    }
    
    for (let i = 0; i < n; i++) {
        turnAroundTimes[i] = waitingTimes[i] + burstTimes[i];
    }
    
    const avgWaitingTime = waitingTimes.reduce((a, b) => a + b, 0) / n;
    const avgTurnAroundTime = turnAroundTimes.reduce((a, b) => a + b, 0) / n;
    
    return {
        waitingTimes,
        turnAroundTimes,
        avgWaitingTime,
        avgTurnAroundTime
    };
}

export async function POST(request: NextRequest) {
    try {
        const body = await request.json();
        const { dataEntries, method } = body;

        if (!dataEntries || !Array.isArray(dataEntries) || dataEntries.length === 0 || !method) {
            return NextResponse.json({ 
                error: 'Missing required fields',
                required: ['dataEntries', 'method']
            }, { status: 400 });
        }

        const processes: string[] = [];
        const burstTimes: number[] = [];
        
        for (const entry of dataEntries) {
            const { humidity, temperature } = entry;
            if (typeof humidity !== 'number' || typeof temperature !== 'number') {
                return NextResponse.json({ 
                    error: 'Invalid input types for humidity or temperature',
                    expected: {
                        humidity: 'number',
                        temperature: 'number'
                    }
                }, { status: 400 });
            }
            processes.push(`Humidity ${humidity}`, `Temperature ${temperature}`);
            burstTimes.push(humidity, temperature);
        }

        let schedulingResult;
        if (method === 'Round_Robin') {
            const timeQuantum = 4; // Set the time quantum for Round Robin
            schedulingResult = roundRobin(processes, burstTimes, timeQuantum);
        } else {
            schedulingResult = firstComeFirstServe(processes, burstTimes);
        }

        // Prepare monitoring result with average values for the entire batch
        const monitoringResult = await prisma.monitoring_result_round_robins.create({
            data: {
                name_process: 'Monitoring Process',
                method: method,
                burst_time: Math.round(burstTimes.reduce((a, b) => a + b, 0)),
                waiting_time: Math.round(schedulingResult.waitingTimes.reduce((a, b) => a + b, 0)),
                turn_around_time: Math.round(schedulingResult.turnAroundTimes.reduce((a, b) => a + b, 0)),
                created_at: new Date(),
                updated_at: new Date()
            }
        });

        for (const entry of dataEntries) {
            const { humidity, temperature } = entry;

            const temperatureEntry = await prisma.temperature.create({
                data: {
                    nilai_temperature: temperature,
                    created_at: new Date(),
                    updated_at: new Date()
                }
            });

            const humidityEntry = await prisma.humidity.create({
                data: {
                    nilai_humidity: humidity,
                    created_at: new Date(),
                    updated_at: new Date()
                }
            });

            // Ambil waktu tunggu dan waktu putar pertama
            const waitingTimeForEntry = schedulingResult.waitingTimes.shift() || 0; 
            const turnAroundTimeForEntry = schedulingResult.turnAroundTimes.shift() || 0;

            const monitoringData = {
                id_monitoring: monitoringResult.id,
                id_temperature: temperatureEntry.id,
                id_humidity: humidityEntry.id,
                waiting_time: waitingTimeForEntry,
                turn_around_time: turnAroundTimeForEntry,
                created_at: new Date(),
                updated_at: new Date()
            };

            if (method === 'Round_Robin') {
                await prisma.round_robin_monitorings.create({ data: monitoringData });
            } else {
                await prisma.non_round_robin_monitorings.create({ data: monitoringData });
            }
        }

        const response = {
            message: 'Data berhasil disimpan',
            data: {
                monitoring: {
                    ...monitoringResult,
                    id: Number(monitoringResult.id),
                },
                calculations: {
                    waitingTimes: schedulingResult.waitingTimes,
                    turnAroundTimes: schedulingResult.turnAroundTimes,
                    avgWaitingTime: schedulingResult.avgWaitingTime,
                    avgTurnAroundTime: schedulingResult.avgTurnAroundTime
                }
            }
        };

        return NextResponse.json(response, { status: 201 });
    } catch (error) {
        console.error('API Error:', error);
        return NextResponse.json({ 
            error: 'Internal server error',
            message: error instanceof Error ? error.message : 'Unknown error occurred'
        }, { status: 500 });
    }
}