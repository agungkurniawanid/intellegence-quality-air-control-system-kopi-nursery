<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Humidity extends Model
{
    use HasFactory;

    protected $table = 'humidity';

    protected $fillable = ['id_alat', 'nilai_humidity'];
}
