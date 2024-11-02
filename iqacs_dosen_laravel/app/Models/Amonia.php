<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Amonia extends Model
{
    protected $table = 'amonia';

    protected $fillable = ['id_alat', 'nilai_amonia'];
}
