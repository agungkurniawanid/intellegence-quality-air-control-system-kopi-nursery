<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class NonRoundRobinMonitoring extends Model
{
    use HasFactory;
    protected $fillable = [
        'id_monitoring',
        'id_temperature',
        'id_humidity',
        'waiting_time',
        'turn_around_time',
    ];
}
