<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MonitoringResultRoundRobin extends Model
{
    use HasFactory;
    protected $fillable = [
        'name_process',
        'method',
        'burst_time',
        'waiting_time',
        'turn_around_time',
    ];
}
